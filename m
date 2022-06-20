Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD16551F92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbiFTO7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiFTO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:59:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5041D14000;
        Mon, 20 Jun 2022 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1655735049;
        bh=mqwk42X40zW8zNvpTM2nfy3vsakf+Ef44fCi2/yrgPo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=ANGxP0uZ+kjJmFpcesOLQyw/wxuxlRjdbs7Om23fTujlpM3YZhWlk52tDJxrVeKij
         vv6IJBEAqb+Su6mLiKPKfxHWkcAqhluMVPw5IIRcc18Tng38x2/0wiJ4ujnufRHETG
         BDTh3J/4gXJEW4QvV8tpku7ETFKbV1tY2sgpYlOw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0EC5E128692D;
        Mon, 20 Jun 2022 10:24:09 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ER6VUdcEzv1q; Mon, 20 Jun 2022 10:24:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1655735048;
        bh=mqwk42X40zW8zNvpTM2nfy3vsakf+Ef44fCi2/yrgPo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=NaqFKCdvaHVohJ77IHEvLFOOXoLRP99AbZovwK1mNJWCyqbRrrd6GpJ/I37Or/K/W
         IjzPmNoIo9hD6MhJ7JBbGX5fn/8MYRrxBJFynTQ6RJY3nE6cN5hBcwTkWVi/xnyM5y
         0E+RrnxA8hrUiDhq36XSTzqqPeLJ7jV1dM4vFYWU=
Received: from lingrow.int.hansenpartnership.com (c-67-166-174-65.hsd1.va.comcast.net [67.166.174.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2E514128691A;
        Mon, 20 Jun 2022 10:24:08 -0400 (EDT)
Message-ID: <151c2749ac4ca8ca853d36f0f6899b009c1db518.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.19-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Jun 2022 10:24:06 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eight fixes, all in drivers (ufs, scsi_debug, storvsc, iscsi, ibmvfc). 
Apart from the ufs command clearing updates, these are mostly minor and
obvious fixes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (3):
      scsi: ufs: Fix a race between the interrupt handler and the reset handler
      scsi: ufs: Support clearing multiple commands at once
      scsi: ufs: Simplify ufshcd_clear_cmd()

Damien Le Moal (1):
      scsi: scsi_debug: Fix zone transition to full condition

Saurabh Sengar (1):
      scsi: storvsc: Correct reporting of Hyper-V I/O size limits

Sergey Gorenko (1):
      scsi: iscsi: Exclude zero from the endpoint ID range

Tyrel Datwyler (2):
      scsi: ibmvfc: Store vhost pointer during subcrq allocation
      scsi: ibmvfc: Allocate/free queue resource only during probe/remove

And the diffstat:

 drivers/scsi/ibmvscsi/ibmvfc.c      | 82 +++++++++++++++++++++++++++++--------
 drivers/scsi/ibmvscsi/ibmvfc.h      |  2 +-
 drivers/scsi/scsi_debug.c           | 22 +++++++++-
 drivers/scsi/scsi_transport_iscsi.c |  7 +++-
 drivers/scsi/storvsc_drv.c          | 27 +++++++++---
 drivers/ufs/core/ufshcd.c           | 76 +++++++++++++++++++++-------------
 6 files changed, 161 insertions(+), 55 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index d0eab5700dc5..00684e11976b 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -160,8 +160,8 @@ static void ibmvfc_npiv_logout(struct ibmvfc_host *);
 static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *);
 static void ibmvfc_tgt_move_login(struct ibmvfc_target *);
 
-static void ibmvfc_release_sub_crqs(struct ibmvfc_host *);
-static void ibmvfc_init_sub_crqs(struct ibmvfc_host *);
+static void ibmvfc_dereg_sub_crqs(struct ibmvfc_host *);
+static void ibmvfc_reg_sub_crqs(struct ibmvfc_host *);
 
 static const char *unknown_error = "unknown error";
 
@@ -917,7 +917,7 @@ static int ibmvfc_reenable_crq_queue(struct ibmvfc_host *vhost)
 	struct vio_dev *vdev = to_vio_dev(vhost->dev);
 	unsigned long flags;
 
-	ibmvfc_release_sub_crqs(vhost);
+	ibmvfc_dereg_sub_crqs(vhost);
 
 	/* Re-enable the CRQ */
 	do {
@@ -936,7 +936,7 @@ static int ibmvfc_reenable_crq_queue(struct ibmvfc_host *vhost)
 	spin_unlock(vhost->crq.q_lock);
 	spin_unlock_irqrestore(vhost->host->host_lock, flags);
 
-	ibmvfc_init_sub_crqs(vhost);
+	ibmvfc_reg_sub_crqs(vhost);
 
 	return rc;
 }
@@ -955,7 +955,7 @@ static int ibmvfc_reset_crq(struct ibmvfc_host *vhost)
 	struct vio_dev *vdev = to_vio_dev(vhost->dev);
 	struct ibmvfc_queue *crq = &vhost->crq;
 
-	ibmvfc_release_sub_crqs(vhost);
+	ibmvfc_dereg_sub_crqs(vhost);
 
 	/* Close the CRQ */
 	do {
@@ -988,7 +988,7 @@ static int ibmvfc_reset_crq(struct ibmvfc_host *vhost)
 	spin_unlock(vhost->crq.q_lock);
 	spin_unlock_irqrestore(vhost->host->host_lock, flags);
 
-	ibmvfc_init_sub_crqs(vhost);
+	ibmvfc_reg_sub_crqs(vhost);
 
 	return rc;
 }
@@ -5682,6 +5682,8 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 	queue->cur = 0;
 	queue->fmt = fmt;
 	queue->size = PAGE_SIZE / fmt_size;
+
+	queue->vhost = vhost;
 	return 0;
 }
 
@@ -5757,9 +5759,6 @@ static int ibmvfc_register_scsi_channel(struct ibmvfc_host *vhost,
 
 	ENTER;
 
-	if (ibmvfc_alloc_queue(vhost, scrq, IBMVFC_SUB_CRQ_FMT))
-		return -ENOMEM;
-
 	rc = h_reg_sub_crq(vdev->unit_address, scrq->msg_token, PAGE_SIZE,
 			   &scrq->cookie, &scrq->hw_irq);
 
@@ -5790,7 +5789,6 @@ static int ibmvfc_register_scsi_channel(struct ibmvfc_host *vhost,
 	}
 
 	scrq->hwq_id = index;
-	scrq->vhost = vhost;
 
 	LEAVE;
 	return 0;
@@ -5800,7 +5798,6 @@ static int ibmvfc_register_scsi_channel(struct ibmvfc_host *vhost,
 		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
 	} while (rtas_busy_delay(rc));
 reg_failed:
-	ibmvfc_free_queue(vhost, scrq);
 	LEAVE;
 	return rc;
 }
@@ -5826,12 +5823,50 @@ static void ibmvfc_deregister_scsi_channel(struct ibmvfc_host *vhost, int index)
 	if (rc)
 		dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n", index, rc);
 
-	ibmvfc_free_queue(vhost, scrq);
+	/* Clean out the queue */
+	memset(scrq->msgs.crq, 0, PAGE_SIZE);
+	scrq->cur = 0;
+
+	LEAVE;
+}
+
+static void ibmvfc_reg_sub_crqs(struct ibmvfc_host *vhost)
+{
+	int i, j;
+
+	ENTER;
+	if (!vhost->mq_enabled || !vhost->scsi_scrqs.scrqs)
+		return;
+
+	for (i = 0; i < nr_scsi_hw_queues; i++) {
+		if (ibmvfc_register_scsi_channel(vhost, i)) {
+			for (j = i; j > 0; j--)
+				ibmvfc_deregister_scsi_channel(vhost, j - 1);
+			vhost->do_enquiry = 0;
+			return;
+		}
+	}
+
+	LEAVE;
+}
+
+static void ibmvfc_dereg_sub_crqs(struct ibmvfc_host *vhost)
+{
+	int i;
+
+	ENTER;
+	if (!vhost->mq_enabled || !vhost->scsi_scrqs.scrqs)
+		return;
+
+	for (i = 0; i < nr_scsi_hw_queues; i++)
+		ibmvfc_deregister_scsi_channel(vhost, i);
+
 	LEAVE;
 }
 
 static void ibmvfc_init_sub_crqs(struct ibmvfc_host *vhost)
 {
+	struct ibmvfc_queue *scrq;
 	int i, j;
 
 	ENTER;
@@ -5847,30 +5882,41 @@ static void ibmvfc_init_sub_crqs(struct ibmvfc_host *vhost)
 	}
 
 	for (i = 0; i < nr_scsi_hw_queues; i++) {
-		if (ibmvfc_register_scsi_channel(vhost, i)) {
-			for (j = i; j > 0; j--)
-				ibmvfc_deregister_scsi_channel(vhost, j - 1);
+		scrq = &vhost->scsi_scrqs.scrqs[i];
+		if (ibmvfc_alloc_queue(vhost, scrq, IBMVFC_SUB_CRQ_FMT)) {
+			for (j = i; j > 0; j--) {
+				scrq = &vhost->scsi_scrqs.scrqs[j - 1];
+				ibmvfc_free_queue(vhost, scrq);
+			}
 			kfree(vhost->scsi_scrqs.scrqs);
 			vhost->scsi_scrqs.scrqs = NULL;
 			vhost->scsi_scrqs.active_queues = 0;
 			vhost->do_enquiry = 0;
-			break;
+			vhost->mq_enabled = 0;
+			return;
 		}
 	}
 
+	ibmvfc_reg_sub_crqs(vhost);
+
 	LEAVE;
 }
 
 static void ibmvfc_release_sub_crqs(struct ibmvfc_host *vhost)
 {
+	struct ibmvfc_queue *scrq;
 	int i;
 
 	ENTER;
 	if (!vhost->scsi_scrqs.scrqs)
 		return;
 
-	for (i = 0; i < nr_scsi_hw_queues; i++)
-		ibmvfc_deregister_scsi_channel(vhost, i);
+	ibmvfc_dereg_sub_crqs(vhost);
+
+	for (i = 0; i < nr_scsi_hw_queues; i++) {
+		scrq = &vhost->scsi_scrqs.scrqs[i];
+		ibmvfc_free_queue(vhost, scrq);
+	}
 
 	kfree(vhost->scsi_scrqs.scrqs);
 	vhost->scsi_scrqs.scrqs = NULL;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 3718406e0988..c39a245f43d0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -789,6 +789,7 @@ struct ibmvfc_queue {
 	spinlock_t _lock;
 	spinlock_t *q_lock;
 
+	struct ibmvfc_host *vhost;
 	struct ibmvfc_event_pool evt_pool;
 	struct list_head sent;
 	struct list_head free;
@@ -797,7 +798,6 @@ struct ibmvfc_queue {
 	union ibmvfc_iu cancel_rsp;
 
 	/* Sub-CRQ fields */
-	struct ibmvfc_host *vhost;
 	unsigned long cookie;
 	unsigned long vios_cookie;
 	unsigned long hw_irq;
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1f423f723d06..b8a76b89f85a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2826,6 +2826,24 @@ static void zbc_open_zone(struct sdebug_dev_info *devip,
 	}
 }
 
+static inline void zbc_set_zone_full(struct sdebug_dev_info *devip,
+				     struct sdeb_zone_state *zsp)
+{
+	switch (zsp->z_cond) {
+	case ZC2_IMPLICIT_OPEN:
+		devip->nr_imp_open--;
+		break;
+	case ZC3_EXPLICIT_OPEN:
+		devip->nr_exp_open--;
+		break;
+	default:
+		WARN_ONCE(true, "Invalid zone %llu condition %x\n",
+			  zsp->z_start, zsp->z_cond);
+		break;
+	}
+	zsp->z_cond = ZC5_FULL;
+}
+
 static void zbc_inc_wp(struct sdebug_dev_info *devip,
 		       unsigned long long lba, unsigned int num)
 {
@@ -2838,7 +2856,7 @@ static void zbc_inc_wp(struct sdebug_dev_info *devip,
 	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		zsp->z_wp += num;
 		if (zsp->z_wp >= zend)
-			zsp->z_cond = ZC5_FULL;
+			zbc_set_zone_full(devip, zsp);
 		return;
 	}
 
@@ -2857,7 +2875,7 @@ static void zbc_inc_wp(struct sdebug_dev_info *devip,
 			n = num;
 		}
 		if (zsp->z_wp >= zend)
-			zsp->z_cond = ZC5_FULL;
+			zbc_set_zone_full(devip, zsp);
 
 		num -= n;
 		lba += n;
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 2c0dd64159b0..5d21f07456c6 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -212,7 +212,12 @@ iscsi_create_endpoint(int dd_size)
 		return NULL;
 
 	mutex_lock(&iscsi_ep_idr_mutex);
-	id = idr_alloc(&iscsi_ep_idr, ep, 0, -1, GFP_NOIO);
+
+	/*
+	 * First endpoint id should be 1 to comply with user space
+	 * applications (iscsid).
+	 */
+	id = idr_alloc(&iscsi_ep_idr, ep, 1, -1, GFP_NOIO);
 	if (id < 0) {
 		mutex_unlock(&iscsi_ep_idr_mutex);
 		printk(KERN_ERR "Could not allocate endpoint ID. Error %d.\n",
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ca3530982e52..fe000da11332 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1844,7 +1844,7 @@ static struct scsi_host_template scsi_driver = {
 	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	/* Ensure there are no gaps in presented sgls */
-	.virt_boundary_mask =	PAGE_SIZE-1,
+	.virt_boundary_mask =	HV_HYP_PAGE_SIZE - 1,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 	.change_queue_depth =	storvsc_change_queue_depth,
@@ -1895,6 +1895,7 @@ static int storvsc_probe(struct hv_device *device,
 	int target = 0;
 	struct storvsc_device *stor_device;
 	int max_sub_channels = 0;
+	u32 max_xfer_bytes;
 
 	/*
 	 * We support sub-channels for storage on SCSI and FC controllers.
@@ -1968,12 +1969,28 @@ static int storvsc_probe(struct hv_device *device,
 	}
 	/* max cmd length */
 	host->max_cmd_len = STORVSC_MAX_CMD_LEN;
-
 	/*
-	 * set the table size based on the info we got
-	 * from the host.
+	 * Any reasonable Hyper-V configuration should provide
+	 * max_transfer_bytes value aligning to HV_HYP_PAGE_SIZE,
+	 * protecting it from any weird value.
+	 */
+	max_xfer_bytes = round_down(stor_device->max_transfer_bytes, HV_HYP_PAGE_SIZE);
+	/* max_hw_sectors_kb */
+	host->max_sectors = max_xfer_bytes >> 9;
+	/*
+	 * There are 2 requirements for Hyper-V storvsc sgl segments,
+	 * based on which the below calculation for max segments is
+	 * done:
+	 *
+	 * 1. Except for the first and last sgl segment, all sgl segments
+	 *    should be align to HV_HYP_PAGE_SIZE, that also means the
+	 *    maximum number of segments in a sgl can be calculated by
+	 *    dividing the total max transfer length by HV_HYP_PAGE_SIZE.
+	 *
+	 * 2. Except for the first and last, each entry in the SGL must
+	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
 	 */
-	host->sg_tablesize = (stor_device->max_transfer_bytes >> PAGE_SHIFT);
+	host->sg_tablesize = (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
 	/*
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 01fb4bad86be..ce86d1b790c0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -748,17 +748,28 @@ static enum utp_ocs ufshcd_get_tr_ocs(struct ufshcd_lrb *lrbp)
 }
 
 /**
- * ufshcd_utrl_clear - Clear a bit in UTRLCLR register
+ * ufshcd_utrl_clear() - Clear requests from the controller request list.
  * @hba: per adapter instance
- * @pos: position of the bit to be cleared
+ * @mask: mask with one bit set for each request to be cleared
  */
-static inline void ufshcd_utrl_clear(struct ufs_hba *hba, u32 pos)
+static inline void ufshcd_utrl_clear(struct ufs_hba *hba, u32 mask)
 {
 	if (hba->quirks & UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR)
-		ufshcd_writel(hba, (1 << pos), REG_UTP_TRANSFER_REQ_LIST_CLEAR);
-	else
-		ufshcd_writel(hba, ~(1 << pos),
-				REG_UTP_TRANSFER_REQ_LIST_CLEAR);
+		mask = ~mask;
+	/*
+	 * From the UFSHCI specification: "UTP Transfer Request List CLear
+	 * Register (UTRLCLR): This field is bit significant. Each bit
+	 * corresponds to a slot in the UTP Transfer Request List, where bit 0
+	 * corresponds to request slot 0. A bit in this field is set to ‘0’
+	 * by host software to indicate to the host controller that a transfer
+	 * request slot is cleared. The host controller
+	 * shall free up any resources associated to the request slot
+	 * immediately, and shall set the associated bit in UTRLDBR to ‘0’. The
+	 * host software indicates no change to request slots by setting the
+	 * associated bits in this field to ‘1’. Bits in this field shall only
+	 * be set ‘1’ or ‘0’ by host software when UTRLRSR is set to ‘1’."
+	 */
+	ufshcd_writel(hba, ~mask, REG_UTP_TRANSFER_REQ_LIST_CLEAR);
 }
 
 /**
@@ -2863,27 +2874,26 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
 	return ufshcd_compose_devman_upiu(hba, lrbp);
 }
 
-static int
-ufshcd_clear_cmd(struct ufs_hba *hba, int tag)
+/*
+ * Clear all the requests from the controller for which a bit has been set in
+ * @mask and wait until the controller confirms that these requests have been
+ * cleared.
+ */
+static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
 {
-	int err = 0;
 	unsigned long flags;
-	u32 mask = 1 << tag;
 
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
-	ufshcd_utrl_clear(hba, tag);
+	ufshcd_utrl_clear(hba, mask);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
 	/*
 	 * wait for h/w to clear corresponding bit in door-bell.
 	 * max. wait is 1 sec.
 	 */
-	err = ufshcd_wait_for_register(hba,
-			REG_UTP_TRANSFER_REQ_DOOR_BELL,
-			mask, ~mask, 1000, 1000);
-
-	return err;
+	return ufshcd_wait_for_register(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL,
+					mask, ~mask, 1000, 1000);
 }
 
 static int
@@ -2963,7 +2973,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
-		if (!ufshcd_clear_cmd(hba, lrbp->task_tag))
+		if (!ufshcd_clear_cmds(hba, 1U << lrbp->task_tag))
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
 		/*
@@ -6958,14 +6968,14 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 }
 
 /**
- * ufshcd_eh_device_reset_handler - device reset handler registered to
- *                                    scsi layer.
+ * ufshcd_eh_device_reset_handler() - Reset a single logical unit.
  * @cmd: SCSI command pointer
  *
  * Returns SUCCESS/FAILED
  */
 static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 {
+	unsigned long flags, pending_reqs = 0, not_cleared = 0;
 	struct Scsi_Host *host;
 	struct ufs_hba *hba;
 	u32 pos;
@@ -6984,14 +6994,24 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	}
 
 	/* clear the commands that were pending for corresponding LUN */
-	for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs) {
-		if (hba->lrb[pos].lun == lun) {
-			err = ufshcd_clear_cmd(hba, pos);
-			if (err)
-				break;
-			__ufshcd_transfer_req_compl(hba, 1U << pos);
-		}
+	spin_lock_irqsave(&hba->outstanding_lock, flags);
+	for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs)
+		if (hba->lrb[pos].lun == lun)
+			__set_bit(pos, &pending_reqs);
+	hba->outstanding_reqs &= ~pending_reqs;
+	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+
+	if (ufshcd_clear_cmds(hba, pending_reqs) < 0) {
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		not_cleared = pending_reqs &
+			ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
+		hba->outstanding_reqs |= not_cleared;
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+
+		dev_err(hba->dev, "%s: failed to clear requests %#lx\n",
+			__func__, not_cleared);
 	}
+	__ufshcd_transfer_req_compl(hba, pending_reqs & ~not_cleared);
 
 out:
 	hba->req_abort_count = 0;
@@ -7088,7 +7108,7 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
 		goto out;
 	}
 
-	err = ufshcd_clear_cmd(hba, tag);
+	err = ufshcd_clear_cmds(hba, 1U << tag);
 	if (err)
 		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
 			__func__, tag, err);


