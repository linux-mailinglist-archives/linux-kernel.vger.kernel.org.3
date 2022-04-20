Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA05084EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbiDTJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377176AbiDTJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:27:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C66332;
        Wed, 20 Apr 2022 02:25:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0434D1F752;
        Wed, 20 Apr 2022 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650446707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAfNb+rzirjhSwl4ClW1FKJTnvu8cALY2TvN6HT931g=;
        b=ZQy+kpryquGdTyAVd7Fk4MNIeKP+LpZmDiZBt5LpHx/c4DmT/Fs1UZOcSNZb1v97Ec0kG4
        0IIPWpejvrN/+Ez0IEXPa1FxYFgNClgZft+LDYvJwmwScbmFTcXj9kliJa22SAP7H6J/dw
        GqGeOF30KSlNvhnI2hior/hjkZsMtBs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDDE413A30;
        Wed, 20 Apr 2022 09:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mJcbLXLRX2J1EAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 09:25:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4/4] xen/scsifront: harden driver against malicious backend
Date:   Wed, 20 Apr 2022 11:25:03 +0200
Message-Id: <20220420092503.11123-5-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420092503.11123-1-jgross@suse.com>
References: <20220420092503.11123-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on a well behaved PV scsi backend verify all meta
data received from the backend and avoid multiple reads of the same
data from the shared ring page.

In case any illegal data from the backend is detected switch the
PV device to a new "error" state and deactivate it for further use.

Use the "lateeoi" variant for the event channel in order to avoid
event storms blocking the guest.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/scsi/xen-scsifront.c | 104 +++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 8511bfc62963..761c9c463ecd 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -83,6 +83,8 @@ struct vscsifrnt_shadow {
 	uint16_t rqid;
 	uint16_t ref_rqid;
 
+	bool inflight;
+
 	unsigned int nr_grants;		/* number of grants in gref[] */
 	struct scsiif_request_segment *sg;	/* scatter/gather elements */
 	struct scsiif_request_segment seg[VSCSIIF_SG_TABLESIZE];
@@ -104,7 +106,11 @@ struct vscsifrnt_info {
 	struct xenbus_device *dev;
 
 	struct Scsi_Host *host;
-	int host_active;
+	enum {
+		STATE_INACTIVE,
+		STATE_ACTIVE,
+		STATE_ERROR
+	}  host_active;
 
 	unsigned int evtchn;
 	unsigned int irq;
@@ -217,6 +223,8 @@ static int scsifront_do_request(struct vscsifrnt_info *info,
 	for (i = 0; i < (shadow->nr_segments & ~VSCSIIF_SG_GRANT); i++)
 		ring_req->seg[i] = shadow->seg[i];
 
+	shadow->inflight = true;
+
 	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(ring, notify);
 	if (notify)
 		notify_remote_via_irq(info->irq);
@@ -224,6 +232,13 @@ static int scsifront_do_request(struct vscsifrnt_info *info,
 	return 0;
 }
 
+static void scsifront_set_error(struct vscsifrnt_info *info, const char *msg)
+{
+	shost_printk(KERN_ERR, info->host, KBUILD_MODNAME "%s\n"
+		     "Disabling device for further use\n", msg);
+	info->host_active = STATE_ERROR;
+}
+
 static void scsifront_gnttab_done(struct vscsifrnt_info *info,
 				  struct vscsifrnt_shadow *shadow)
 {
@@ -234,9 +249,8 @@ static void scsifront_gnttab_done(struct vscsifrnt_info *info,
 
 	for (i = 0; i < shadow->nr_grants; i++) {
 		if (unlikely(!gnttab_try_end_foreign_access(shadow->gref[i]))) {
-			shost_printk(KERN_ALERT, info->host, KBUILD_MODNAME
-				     "grant still in use by backend\n");
-			BUG();
+			scsifront_set_error(info, "grant still in use by backend");
+			return;
 		}
 	}
 
@@ -308,6 +322,8 @@ static void scsifront_cdb_cmd_done(struct vscsifrnt_info *info,
 	BUG_ON(sc == NULL);
 
 	scsifront_gnttab_done(info, shadow);
+	if (info->host_active == STATE_ERROR)
+		return;
 	scsifront_put_rqid(info, id);
 
 	set_host_byte(sc, scsifront_host_byte(ring_rsp->rslt));
@@ -348,9 +364,7 @@ static void scsifront_sync_cmd_done(struct vscsifrnt_info *info,
 			scsifront_wake_up(info);
 		return;
 	default:
-		shost_printk(KERN_ERR, info->host, KBUILD_MODNAME
-			     "bad reset state %d, possibly leaking %u\n",
-			     shadow->rslt_reset, id);
+		scsifront_set_error(info, "bad reset state");
 		break;
 	}
 	spin_unlock_irqrestore(&info->shadow_lock, flags);
@@ -361,28 +375,41 @@ static void scsifront_sync_cmd_done(struct vscsifrnt_info *info,
 static void scsifront_do_response(struct vscsifrnt_info *info,
 				  struct vscsiif_response *ring_rsp)
 {
-	if (WARN(ring_rsp->rqid >= VSCSIIF_MAX_REQS ||
-		 test_bit(ring_rsp->rqid, info->shadow_free_bitmap),
-		 "illegal rqid %u returned by backend!\n", ring_rsp->rqid))
+	struct vscsifrnt_shadow *shadow;
+
+	if (ring_rsp->rqid >= VSCSIIF_MAX_REQS ||
+	    !info->shadow[ring_rsp->rqid]->inflight) {
+		scsifront_set_error(info, "illegal rqid returned by backend!");
 		return;
+	}
+	shadow = info->shadow[ring_rsp->rqid];
+	shadow->inflight = false;
 
-	if (info->shadow[ring_rsp->rqid]->act == VSCSIIF_ACT_SCSI_CDB)
+	if (shadow->act == VSCSIIF_ACT_SCSI_CDB)
 		scsifront_cdb_cmd_done(info, ring_rsp);
 	else
 		scsifront_sync_cmd_done(info, ring_rsp);
 }
 
-static int scsifront_ring_drain(struct vscsifrnt_info *info)
+static int scsifront_ring_drain(struct vscsifrnt_info *info,
+				unsigned int *eoiflag)
 {
-	struct vscsiif_response *ring_rsp;
+	struct vscsiif_response ring_rsp;
 	RING_IDX i, rp;
 	int more_to_do = 0;
 
-	rp = info->ring.sring->rsp_prod;
-	rmb();	/* ordering required respective to dom0 */
+	rp = READ_ONCE(info->ring.sring->rsp_prod);
+	virt_rmb();	/* ordering required respective to backend */
+	if (RING_RESPONSE_PROD_OVERFLOW(&info->ring, rp)) {
+		scsifront_set_error(info, "illegal number of responses");
+		return 0;
+	}
 	for (i = info->ring.rsp_cons; i != rp; i++) {
-		ring_rsp = RING_GET_RESPONSE(&info->ring, i);
-		scsifront_do_response(info, ring_rsp);
+		RING_COPY_RESPONSE(&info->ring, i, &ring_rsp);
+		scsifront_do_response(info, &ring_rsp);
+		if (info->host_active == STATE_ERROR)
+			return 0;
+		*eoiflag = 0;
 	}
 
 	info->ring.rsp_cons = i;
@@ -395,14 +422,15 @@ static int scsifront_ring_drain(struct vscsifrnt_info *info)
 	return more_to_do;
 }
 
-static int scsifront_cmd_done(struct vscsifrnt_info *info)
+static int scsifront_cmd_done(struct vscsifrnt_info *info,
+			      unsigned int *eoiflag)
 {
 	int more_to_do;
 	unsigned long flags;
 
 	spin_lock_irqsave(info->host->host_lock, flags);
 
-	more_to_do = scsifront_ring_drain(info);
+	more_to_do = scsifront_ring_drain(info, eoiflag);
 
 	info->wait_ring_available = 0;
 
@@ -416,20 +444,28 @@ static int scsifront_cmd_done(struct vscsifrnt_info *info)
 static irqreturn_t scsifront_irq_fn(int irq, void *dev_id)
 {
 	struct vscsifrnt_info *info = dev_id;
+	unsigned int eoiflag = XEN_EOI_FLAG_SPURIOUS;
+
+	if (info->host_active == STATE_ERROR) {
+		xen_irq_lateeoi(irq, XEN_EOI_FLAG_SPURIOUS);
+		return IRQ_HANDLED;
+	}
 
-	while (scsifront_cmd_done(info))
+	while (scsifront_cmd_done(info, &eoiflag))
 		/* Yield point for this unbounded loop. */
 		cond_resched();
 
+	xen_irq_lateeoi(irq, eoiflag);
+
 	return IRQ_HANDLED;
 }
 
 static void scsifront_finish_all(struct vscsifrnt_info *info)
 {
-	unsigned i;
+	unsigned int i, dummy;
 	struct vscsiif_response resp;
 
-	scsifront_ring_drain(info);
+	scsifront_ring_drain(info, &dummy);
 
 	for (i = 0; i < VSCSIIF_MAX_REQS; i++) {
 		if (test_bit(i, info->shadow_free_bitmap))
@@ -586,6 +622,9 @@ static int scsifront_queuecommand(struct Scsi_Host *shost,
 	unsigned long flags;
 	int err;
 
+	if (info->host_active == STATE_ERROR)
+		return SCSI_MLQUEUE_HOST_BUSY;
+
 	sc->result = 0;
 
 	shadow->sc  = sc;
@@ -638,6 +677,9 @@ static int scsifront_action_handler(struct scsi_cmnd *sc, uint8_t act)
 	struct vscsifrnt_shadow *shadow, *s = scsi_cmd_priv(sc);
 	int err = 0;
 
+	if (info->host_active == STATE_ERROR)
+		return FAILED;
+
 	shadow = kzalloc(sizeof(*shadow), GFP_NOIO);
 	if (!shadow)
 		return FAILED;
@@ -709,6 +751,9 @@ static int scsifront_sdev_configure(struct scsi_device *sdev)
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
 	int err;
 
+	if (info->host_active == STATE_ERROR)
+		return -EIO;
+
 	if (info && current == info->curr) {
 		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateConnected);
@@ -784,7 +829,7 @@ static int scsifront_alloc_ring(struct vscsifrnt_info *info)
 		goto free_gnttab;
 	}
 
-	err = bind_evtchn_to_irq(info->evtchn);
+	err = bind_evtchn_to_irq_lateeoi(info->evtchn);
 	if (err <= 0) {
 		xenbus_dev_fatal(dev, err, "bind_evtchn_to_irq");
 		goto free_gnttab;
@@ -914,7 +959,7 @@ static int scsifront_probe(struct xenbus_device *dev,
 		goto free_sring;
 	}
 	info->host = host;
-	info->host_active = 1;
+	info->host_active = STATE_ACTIVE;
 
 	xenbus_switch_state(dev, XenbusStateInitialised);
 
@@ -982,10 +1027,10 @@ static int scsifront_remove(struct xenbus_device *dev)
 	pr_debug("%s: %s removed\n", __func__, dev->nodename);
 
 	mutex_lock(&scsifront_mutex);
-	if (info->host_active) {
+	if (info->host_active != STATE_INACTIVE) {
 		/* Scsi_host not yet removed */
 		scsi_remove_host(info->host);
-		info->host_active = 0;
+		info->host_active = STATE_INACTIVE;
 	}
 	mutex_unlock(&scsifront_mutex);
 
@@ -1009,9 +1054,9 @@ static void scsifront_disconnect(struct vscsifrnt_info *info)
 	 */
 
 	mutex_lock(&scsifront_mutex);
-	if (info->host_active) {
+	if (info->host_active != STATE_INACTIVE) {
 		scsi_remove_host(host);
-		info->host_active = 0;
+		info->host_active = STATE_INACTIVE;
 	}
 	mutex_unlock(&scsifront_mutex);
 
@@ -1029,6 +1074,9 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
 	unsigned int hst, chn, tgt, lun;
 	struct scsi_device *sdev;
 
+	if (info->host_active == STATE_ERROR)
+		return;
+
 	dir = xenbus_directory(XBT_NIL, dev->otherend, "vscsi-devs", &dir_n);
 	if (IS_ERR(dir))
 		return;
-- 
2.34.1

