Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C594D5FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbiCKKgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348015AbiCKKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:36:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5F1BD988;
        Fri, 11 Mar 2022 02:35:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39DE021900;
        Fri, 11 Mar 2022 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646994911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3mp/NTfr1ZRQi2cvIw2K8ve4TPHKPxpsioOPY6Gm7jc=;
        b=jEF0gJQKcwhTeagwgBdvSlHK36VYwwKZUbqR5ce0nf5w8NliamXW+5XJYokUtbuWWuhBgB
        8rKEt/xFMtHs84cFx6WEQp8PD/IfplRPiesklbTvPESwhZqVNC6NFBDRQiZfIVwtX1gnKU
        r4JvdzxW9L6tOjbi2UUDEDb/R5Qt3hA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D8A613A85;
        Fri, 11 Mar 2022 10:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hhYYAt8lK2JRdgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 11 Mar 2022 10:35:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] xen/usb: harden xen_hcd against malicious backends
Date:   Fri, 11 Mar 2022 11:35:09 +0100
Message-Id: <20220311103509.12908-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure a malicious backend can't cause any harm other than wrong
I/O data.

Missing are verification of the request id in a response, sanitizing
the reported actual I/O length, and protection against interrupt storms
from the backend.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/usb/host/xen-hcd.c | 57 ++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 01db5c767251..3e487baf8422 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -51,6 +51,7 @@ struct vdevice_status {
 struct usb_shadow {
 	struct xenusb_urb_request req;
 	struct urb *urb;
+	bool in_flight;
 };
 
 struct xenhcd_info {
@@ -720,6 +721,12 @@ static void xenhcd_gnttab_done(struct xenhcd_info *info, unsigned int id)
 	int nr_segs = 0;
 	int i;
 
+	if (!shadow->in_flight) {
+		xenhcd_set_error(info, "Illegal request id");
+		return;
+	}
+	shadow->in_flight = false;
+
 	nr_segs = shadow->req.nr_buffer_segs;
 
 	if (xenusb_pipeisoc(shadow->req.pipe))
@@ -803,6 +810,7 @@ static int xenhcd_do_request(struct xenhcd_info *info, struct urb_priv *urbp)
 
 	info->urb_ring.req_prod_pvt++;
 	info->shadow[id].urb = urb;
+	info->shadow[id].in_flight = true;
 
 	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(&info->urb_ring, notify);
 	if (notify)
@@ -931,10 +939,27 @@ static int xenhcd_unlink_urb(struct xenhcd_info *info, struct urb_priv *urbp)
 	return ret;
 }
 
-static int xenhcd_urb_request_done(struct xenhcd_info *info)
+static void xenhcd_res_to_urb(struct xenhcd_info *info,
+			      struct xenusb_urb_response *res, struct urb *urb)
+{
+	if (unlikely(!urb))
+		return;
+
+	if (res->actual_length > urb->transfer_buffer_length)
+		urb->actual_length = urb->transfer_buffer_length;
+	else if (res->actual_length < 0)
+		urb->actual_length = 0;
+	else
+		urb->actual_length = res->actual_length;
+	urb->error_count = res->error_count;
+	urb->start_frame = res->start_frame;
+	xenhcd_giveback_urb(info, urb, res->status);
+}
+
+static int xenhcd_urb_request_done(struct xenhcd_info *info,
+				   unsigned int *eoiflag)
 {
 	struct xenusb_urb_response res;
-	struct urb *urb;
 	RING_IDX i, rp;
 	__u16 id;
 	int more_to_do = 0;
@@ -961,16 +986,12 @@ static int xenhcd_urb_request_done(struct xenhcd_info *info)
 			xenhcd_gnttab_done(info, id);
 			if (info->error)
 				goto err;
-			urb = info->shadow[id].urb;
-			if (likely(urb)) {
-				urb->actual_length = res.actual_length;
-				urb->error_count = res.error_count;
-				urb->start_frame = res.start_frame;
-				xenhcd_giveback_urb(info, urb, res.status);
-			}
+			xenhcd_res_to_urb(info, &res, info->shadow[id].urb);
 		}
 
 		xenhcd_add_id_to_freelist(info, id);
+
+		*eoiflag = 0;
 	}
 	info->urb_ring.rsp_cons = i;
 
@@ -988,7 +1009,7 @@ static int xenhcd_urb_request_done(struct xenhcd_info *info)
 	return 0;
 }
 
-static int xenhcd_conn_notify(struct xenhcd_info *info)
+static int xenhcd_conn_notify(struct xenhcd_info *info, unsigned int *eoiflag)
 {
 	struct xenusb_conn_response res;
 	struct xenusb_conn_request *req;
@@ -1033,6 +1054,8 @@ static int xenhcd_conn_notify(struct xenhcd_info *info)
 				       info->conn_ring.req_prod_pvt);
 		req->id = id;
 		info->conn_ring.req_prod_pvt++;
+
+		*eoiflag = 0;
 	}
 
 	if (rc != info->conn_ring.req_prod_pvt)
@@ -1055,14 +1078,19 @@ static int xenhcd_conn_notify(struct xenhcd_info *info)
 static irqreturn_t xenhcd_int(int irq, void *dev_id)
 {
 	struct xenhcd_info *info = (struct xenhcd_info *)dev_id;
+	unsigned int eoiflag = XEN_EOI_FLAG_SPURIOUS;
 
-	if (unlikely(info->error))
+	if (unlikely(info->error)) {
+		xen_irq_lateeoi(irq, XEN_EOI_FLAG_SPURIOUS);
 		return IRQ_HANDLED;
+	}
 
-	while (xenhcd_urb_request_done(info) | xenhcd_conn_notify(info))
+	while (xenhcd_urb_request_done(info, &eoiflag) |
+	       xenhcd_conn_notify(info, &eoiflag))
 		/* Yield point for this unbounded loop. */
 		cond_resched();
 
+	xen_irq_lateeoi(irq, eoiflag);
 	return IRQ_HANDLED;
 }
 
@@ -1139,9 +1167,9 @@ static int xenhcd_setup_rings(struct xenbus_device *dev,
 		goto fail;
 	}
 
-	err = bind_evtchn_to_irq(info->evtchn);
+	err = bind_evtchn_to_irq_lateeoi(info->evtchn);
 	if (err <= 0) {
-		xenbus_dev_fatal(dev, err, "bind_evtchn_to_irq");
+		xenbus_dev_fatal(dev, err, "bind_evtchn_to_irq_lateeoi");
 		goto fail;
 	}
 
@@ -1494,6 +1522,7 @@ static struct usb_hcd *xenhcd_create_hcd(struct xenbus_device *dev)
 	for (i = 0; i < XENUSB_URB_RING_SIZE; i++) {
 		info->shadow[i].req.id = i + 1;
 		info->shadow[i].urb = NULL;
+		info->shadow[i].in_flight = false;
 	}
 	info->shadow[XENUSB_URB_RING_SIZE - 1].req.id = 0x0fff;
 
-- 
2.34.1

