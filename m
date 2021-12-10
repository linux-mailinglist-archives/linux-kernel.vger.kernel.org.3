Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537B647056B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbhLJQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:20:32 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:48201 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240454AbhLJQUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:20:31 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1639153012;
        bh=6N0R6c6LwC+AWv0lWKTKcB5B1ixiC/Tv3M/4jyRgeuU=;
        h=From:To:Cc:Subject:Date:From;
        b=WLsG75n4hXuFHBHv3PhO3mhgU/7o9hXHWtrT6qDXA5hrkl3DTOQ3WrxKCiny+5QSv
         iXjmjXbD6h8WbQ0KhKBRHsV931dEfOKvHJdsKlNdevwP/HXE5WCh9WOxot0gWqjpTR
         ko94KIS7gJELFV5kpMY/Q35iDjQWIUVlAVUgqmS4=
To:     Hemant Kumar <hemantk@codeaurora.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Richard Hughes <hughsient@gmail.com>
Subject: [RFC] bus: mhi: core: Load firmware asynchronous
Date:   Fri, 10 Dec 2021 17:16:45 +0100
Message-Id: <20211210161645.10925-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1639153004; l=7911; s=20211113; h=from:subject; bh=6N0R6c6LwC+AWv0lWKTKcB5B1ixiC/Tv3M/4jyRgeuU=; b=nptClPiq3GvLpkwP8BeCSza3cWCueEFBy5VQWkc95v39AZVZkzCPN5uWYRKd+PQheJpveD00C/Xx TLZeLYOmCUw+PGRWz8wMlCwqZnOYUIdzIYGCRtCFeSndEZmHBJ9w
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gives userspace the possibility to provide the firehose bootloader
via the sysfs-firmware-API instead of having to modify the global
firmware loadpath.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Please note that this is not tested yet, as I don't have access to a matching
firmware file.
This submission is to gather general feedback from the maintainers and then
Richard will do the actual testing, while I'll do the development.

This patch is should not have any impact beyond moving from request_firmware()
to request_firmware_nowait() and the involved code reshuffle.

---
 drivers/bus/mhi/core/boot.c | 159 +++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 58 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 74295d3cc662..b0576ffc69c6 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -18,6 +18,17 @@
 #include <linux/wait.h>
 #include "internal.h"
 
+struct mhi_fw_load_callback_ctx {
+	const char *fw_name;
+	struct mhi_controller *mhi_cntrl;
+};
+
+enum mhi_fw_load_status {
+	MHI_FW_LOAD_READY_STATE,
+	MHI_FW_ERROR_READY_STATE,
+	MHI_FW_ERROR_FW_LOAD,
+};
+
 /* Setup RDDM vector table for RDDM transfer and program RXVEC */
 void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      struct image_info *img_info)
@@ -386,55 +397,53 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	}
 }
 
-void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
+static void mhi_fw_load_finish(struct mhi_controller *mhi_cntrl, enum mhi_fw_load_status status)
 {
-	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	const char *fw_name;
-	void *buf;
-	dma_addr_t dma_addr;
-	size_t size;
-	int i, ret;
+	int ret;
 
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device MHI is not in valid state\n");
-		return;
+	switch (status) {
+	case MHI_FW_LOAD_READY_STATE:
+		break;
+	case MHI_FW_ERROR_READY_STATE:
+		goto error_ready_state;
+	case MHI_FW_ERROR_FW_LOAD:
+		goto error_fw_load;
 	}
 
-	/* save hardware info from BHI */
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
-			   &mhi_cntrl->serial_number);
-	if (ret)
-		dev_err(dev, "Could not capture serial number via BHI\n");
-
-	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
-				   &mhi_cntrl->oem_pk_hash[i]);
-		if (ret) {
-			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
-			break;
-		}
+	/* Transitioning into MHI RESET->READY state */
+	ret = mhi_ready_state_transition(mhi_cntrl);
+	if (ret) {
+		dev_err(dev, "MHI did not enter READY state\n");
+		goto error_ready_state;
 	}
 
-	/* wait for ready on pass through or any other execution environment */
-	if (!MHI_FW_LOAD_CAPABLE(mhi_cntrl->ee))
-		goto fw_load_ready_state;
-
-	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
-		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+	dev_info(dev, "Wait for device to enter SBL or Mission mode\n");
+	return;
 
-	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
-						     !mhi_cntrl->seg_len))) {
-		dev_err(dev,
-			"No firmware image defined or !sbl_size || !seg_len\n");
-		goto error_fw_load;
+error_ready_state:
+	if (mhi_cntrl->fbc_download) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+		mhi_cntrl->fbc_image = NULL;
 	}
 
-	ret = request_firmware(&firmware, fw_name, dev);
-	if (ret) {
-		dev_err(dev, "Error loading firmware: %d\n", ret);
-		goto error_fw_load;
-	}
+error_fw_load:
+	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
+	wake_up_all(&mhi_cntrl->state_event);
+}
+
+static void mhi_fw_load_callback(const struct firmware *firmware, void *context)
+{
+	struct mhi_fw_load_callback_ctx *ctx = context;
+	const char *fw_name = ctx->fw_name;
+	struct mhi_controller *mhi_cntrl = ctx->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	dma_addr_t dma_addr;
+	size_t size;
+	void *buf;
+	int ret;
+
+	kfree(context);
 
 	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
 
@@ -446,7 +455,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 				 GFP_KERNEL);
 	if (!buf) {
 		release_firmware(firmware);
-		goto error_fw_load;
+		mhi_fw_load_finish(mhi_cntrl, MHI_FW_ERROR_FW_LOAD);
 	}
 
 	/* Download image using BHI */
@@ -458,13 +467,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	if (ret) {
 		dev_err(dev, "MHI did not load image over BHI, ret: %d\n", ret);
 		release_firmware(firmware);
-		goto error_fw_load;
+		mhi_fw_load_finish(mhi_cntrl, MHI_FW_ERROR_FW_LOAD);
 	}
 
 	/* Wait for ready since EDL image was loaded */
 	if (fw_name == mhi_cntrl->edl_image) {
 		release_firmware(firmware);
-		goto fw_load_ready_state;
+		mhi_fw_load_finish(mhi_cntrl, MHI_FW_LOAD_READY_STATE);
 	}
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
@@ -480,7 +489,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 					   firmware->size);
 		if (ret) {
 			release_firmware(firmware);
-			goto error_fw_load;
+			mhi_fw_load_finish(mhi_cntrl, MHI_FW_ERROR_FW_LOAD);
 		}
 
 		/* Load the firmware into BHIE vec table */
@@ -489,26 +498,60 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 
 	release_firmware(firmware);
 
-fw_load_ready_state:
-	/* Transitioning into MHI RESET->READY state */
-	ret = mhi_ready_state_transition(mhi_cntrl);
-	if (ret) {
-		dev_err(dev, "MHI did not enter READY state\n");
-		goto error_ready_state;
+	mhi_fw_load_finish(mhi_cntrl, MHI_FW_LOAD_READY_STATE);
+}
+
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_fw_load_callback_ctx *cb_ctx;
+	const char *fw_name;
+	int i, ret;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device MHI is not in valid state\n");
+		return;
 	}
 
-	dev_info(dev, "Wait for device to enter SBL or Mission mode\n");
-	return;
+	/* save hardware info from BHI */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
+			   &mhi_cntrl->serial_number);
+	if (ret)
+		dev_err(dev, "Could not capture serial number via BHI\n");
 
-error_ready_state:
-	if (mhi_cntrl->fbc_download) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-		mhi_cntrl->fbc_image = NULL;
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
+				   &mhi_cntrl->oem_pk_hash[i]);
+		if (ret) {
+			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
+			break;
+		}
 	}
 
-error_fw_load:
-	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-	wake_up_all(&mhi_cntrl->state_event);
+	/* wait for ready on pass through or any other execution environment */
+	if (!MHI_FW_LOAD_CAPABLE(mhi_cntrl->ee))
+		mhi_fw_load_finish(mhi_cntrl, MHI_FW_LOAD_READY_STATE);
+
+	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
+		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+
+	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
+						     !mhi_cntrl->seg_len))) {
+		dev_err(dev,
+			"No firmware image defined or !sbl_size || !seg_len\n");
+		mhi_fw_load_finish(mhi_cntrl, MHI_FW_ERROR_FW_LOAD);
+	}
+
+	cb_ctx = kzalloc(sizeof(*cb_ctx), GFP_KERNEL);
+	if (!cb_ctx)
+		return;
+
+	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, dev, GFP_KERNEL, cb_ctx,
+				      mhi_fw_load_callback);
+	if (ret) {
+		dev_err(dev, "Error loading firmware: %d\n", ret);
+		mhi_fw_load_finish(mhi_cntrl, MHI_FW_ERROR_FW_LOAD);
+	}
 }
 
 int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)

base-commit: 622e96fb58d63985b028abc2cb9a873124bdac1e
-- 
2.34.1

