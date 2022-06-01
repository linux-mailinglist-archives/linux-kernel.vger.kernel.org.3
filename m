Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64137539E48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350351AbiFAHf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350342AbiFAHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:35:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE9719C3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:35:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B2AE68AFE; Wed,  1 Jun 2022 09:35:06 +0200 (CEST)
Date:   Wed, 1 Jun 2022 09:35:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        caroline.subramoney@microsoft.com, riwurd@microsoft.com,
        nathan.obr@microsoft.com
Subject: Re: [PATCH 2/2] nvme-pci: handle persistent internal error AER
 from NVMe controller
Message-ID: <20220601073505.GA24875@lst.de>
References: <1654056747-40143-1-git-send-email-mikelley@microsoft.com> <1654056747-40143-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654056747-40143-2-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This really belongs into common code.  See the untested patch below
of how I'd do it.  The nvme_should_reset would be a separate prep
patch again.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72f7c955c7078..b8b8e9ee04120 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -171,6 +171,24 @@ static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 }
 
+bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts)
+{
+	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
+	switch (ctrl->state) {
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	default:
+		break;
+	}
+
+	/*
+	 * We shouldn't reset unless the controller is on fatal error state or
+	 * if we lost the communication with it.
+	 */
+	return (csts & NVME_CSTS_CFS) ||
+		(ctrl->subsystem && (csts & NVME_CSTS_NSSRO));
+}
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -4537,24 +4555,41 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aen_persistent_error(struct nvme_ctrl *ctrl)
+{
+	u32 csts;
+
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) < 0 ||
+	    nvme_should_reset(ctrl, csts)) {
+		dev_warn(ctrl->device, "resetting due to AEN\n");
+		nvme_reset_ctrl(ctrl);
+	}
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	u32 aer_type = result & 0x07;
+	u32 aen_type = result & 0x07;
+	u32 aen_subtype = (result & 0xff00) >> 8;
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
-	switch (aer_type) {
+	switch (aen_type) {
 	case NVME_AER_NOTICE:
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		if (aen_subtype == NVME_AER_ERROR_PERSIST_INT_ERR) {
+			nvme_handle_aen_persistent_error(ctrl);
+			break;
+		}
+		fallthrough;
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
+		trace_nvme_async_event(ctrl, aen_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c9..0d7e9ac52d25a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -762,6 +762,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
+bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7de09642..c57023d98f8f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1293,31 +1293,6 @@ static void abort_endio(struct request *req, blk_status_t error)
 	blk_mq_free_request(req);
 }
 
-static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
-{
-	/* If true, indicates loss of adapter communication, possibly by a
-	 * NVMe Subsystem reset.
-	 */
-	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
-
-	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
-	switch (dev->ctrl.state) {
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	default:
-		break;
-	}
-
-	/* We shouldn't reset unless the controller is on fatal error state
-	 * _or_ if we lost the communication with it.
-	 */
-	if (!(csts & NVME_CSTS_CFS) && !nssro)
-		return false;
-
-	return true;
-}
-
 static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 {
 	/* Read a config register to help see what died. */
@@ -1355,7 +1330,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Reset immediately if the controller is failed
 	 */
-	if (nvme_should_reset(dev, csts)) {
+	if (nvme_should_reset(&dev->ctrl, csts)) {
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3481ff6..8ced2439f1f34 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -711,6 +711,10 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
+enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
