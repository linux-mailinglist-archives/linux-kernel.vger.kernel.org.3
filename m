Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59CD468BF8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhLEPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37902 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbhLEPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D22B80E1A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF74C341C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718967;
        bh=c5vXV39ulf58Fl2rwiZEuoRQCYd8DeIQh75ar1VToDc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M8K6TVUl1OfqpmhaH5L+GEkdyFy7NFp/k4oOa+gHi8ofUpLBSst3eKssAGXrgMxA3
         uvARSC9/CkrLEOUDmAdyaICsRoEUoTTRLfdy7LlXXPPYDoDPu3cIAeynsyzLvpMWqI
         F1s/N69Nx3rfD3VrZMq69liTNbCMAvxccgGNqzWnvk3YIMAopUa/nKb6EYggxitRTB
         v/WU/1pB7UKNnbvFZv5kfa/H33/IisBxQIMKe9Ee25lbS6F2D/0+qN/O5jSZLebA8b
         IonEFWl/e8l2WtNhsywGsC+KO5xN+m2NvO8o40QQfoe8DGE6OJSctDwv1TrtS7SY66
         7KGqSUbpoBidg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] habanalabs: fix etr asid configuration
Date:   Sun,  5 Dec 2021 17:42:33 +0200
Message-Id: <20211205154236.2198481-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the user's context pointer into the etr configuration function
to extract its ASID.

Using the compute_ctx pointer is an error as it is just an indication
of whether a user has opened the compute device.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c          |  2 +-
 drivers/misc/habanalabs/common/device.c           |  4 ++--
 drivers/misc/habanalabs/common/habanalabs.h       |  6 +++---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 13 +++++++------
 drivers/misc/habanalabs/gaudi/gaudiP.h            |  4 ++--
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c   |  4 ++--
 drivers/misc/habanalabs/goya/goyaP.h              |  4 ++--
 drivers/misc/habanalabs/goya/goya_coresight.c     |  4 ++--
 8 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 8291151948ef..8de1217b2ed2 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -99,7 +99,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		 * related to the stopped engines. Hence stop it explicitly.
 		 */
 		if (hdev->in_debug)
-			hl_device_set_debug_mode(hdev, false);
+			hl_device_set_debug_mode(hdev, ctx, false);
 
 		hdev->asic_funcs->ctx_fini(ctx);
 		hl_cb_va_pool_fini(ctx);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index db4168f35c18..bc5736ae6b70 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -622,7 +622,7 @@ int hl_device_utilization(struct hl_device *hdev, u32 *utilization)
 	return 0;
 }
 
-int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
+int hl_device_set_debug_mode(struct hl_device *hdev, struct hl_ctx *ctx, bool enable)
 {
 	int rc = 0;
 
@@ -637,7 +637,7 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 		}
 
 		if (!hdev->hard_reset_pending)
-			hdev->asic_funcs->halt_coresight(hdev);
+			hdev->asic_funcs->halt_coresight(hdev, ctx);
 
 		hdev->in_debug = 0;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0ad08fdc89ea..670fad9b4ca0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1288,7 +1288,7 @@ struct hl_asic_funcs {
 	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*set_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
-	int (*debug_coresight)(struct hl_device *hdev, void *data);
+	int (*debug_coresight)(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
 					u8 mask_len, struct seq_file *s);
 	int (*non_hard_reset_late_init)(struct hl_device *hdev);
@@ -1303,7 +1303,7 @@ struct hl_asic_funcs {
 	int (*init_iatu)(struct hl_device *hdev);
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
-	void (*halt_coresight)(struct hl_device *hdev);
+	void (*halt_coresight)(struct hl_device *hdev, struct hl_ctx *ctx);
 	int (*ctx_init)(struct hl_ctx *ctx);
 	void (*ctx_fini)(struct hl_ctx *ctx);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
@@ -2867,7 +2867,7 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp);
 bool hl_device_operational(struct hl_device *hdev,
 		enum hl_device_status *status);
 enum hl_device_status hl_device_status(struct hl_device *hdev);
-int hl_device_set_debug_mode(struct hl_device *hdev, bool enable);
+int hl_device_set_debug_mode(struct hl_device *hdev, struct hl_ctx *ctx, bool enable);
 int hl_hw_queues_create(struct hl_device *hdev);
 void hl_hw_queues_destroy(struct hl_device *hdev);
 int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 6c7339978bae..9210114beefe 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -158,7 +158,7 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
 }
 
-static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
+static int debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, struct hl_debug_args *args)
 {
 	struct hl_debug_params *params;
 	void *input = NULL, *output = NULL;
@@ -200,7 +200,7 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
 		params->output_size = args->output_size;
 	}
 
-	rc = hdev->asic_funcs->debug_coresight(hdev, params);
+	rc = hdev->asic_funcs->debug_coresight(hdev, ctx, params);
 	if (rc) {
 		dev_err(hdev->dev,
 			"debug coresight operation failed %d\n", rc);
@@ -738,13 +738,14 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 				"Rejecting debug configuration request because device not in debug mode\n");
 			return -EFAULT;
 		}
-		args->input_size =
-			min(args->input_size, hl_debug_struct_size[args->op]);
-		rc = debug_coresight(hdev, args);
+		args->input_size = min(args->input_size, hl_debug_struct_size[args->op]);
+		rc = debug_coresight(hdev, hpriv->ctx, args);
 		break;
+
 	case HL_DEBUG_OP_SET_MODE:
-		rc = hl_device_set_debug_mode(hdev, (bool) args->enable);
+		rc = hl_device_set_debug_mode(hdev, hpriv->ctx, (bool) args->enable);
 		break;
+
 	default:
 		dev_err(hdev->dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index f325e36a71e6..8ac16a9b7d15 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -357,8 +357,8 @@ void gaudi_init_security(struct hl_device *hdev);
 void gaudi_ack_protection_bits_errors(struct hl_device *hdev);
 void gaudi_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
-int gaudi_debug_coresight(struct hl_device *hdev, void *data);
-void gaudi_halt_coresight(struct hl_device *hdev);
+int gaudi_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
+void gaudi_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx);
 void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid);
 
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 5349c1be13f9..08108f5fed67 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -848,7 +848,7 @@ static int gaudi_config_spmu(struct hl_device *hdev,
 	return 0;
 }
 
-int gaudi_debug_coresight(struct hl_device *hdev, void *data)
+int gaudi_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data)
 {
 	struct hl_debug_params *params = data;
 	int rc = 0;
@@ -887,7 +887,7 @@ int gaudi_debug_coresight(struct hl_device *hdev, void *data)
 	return rc;
 }
 
-void gaudi_halt_coresight(struct hl_device *hdev)
+void gaudi_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx)
 {
 	struct hl_debug_params params = {};
 	int i, rc;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index f0c3c6df04d5..3740fd25bf84 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -220,8 +220,8 @@ void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void goya_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 int goya_cpucp_info_get(struct hl_device *hdev);
-int goya_debug_coresight(struct hl_device *hdev, void *data);
-void goya_halt_coresight(struct hl_device *hdev);
+int goya_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
+void goya_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx);
 
 int goya_suspend(struct hl_device *hdev);
 int goya_resume(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index c55c100fdd24..2c5133cfae65 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -652,7 +652,7 @@ static int goya_config_spmu(struct hl_device *hdev,
 	return 0;
 }
 
-int goya_debug_coresight(struct hl_device *hdev, void *data)
+int goya_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data)
 {
 	struct hl_debug_params *params = data;
 	int rc = 0;
@@ -691,7 +691,7 @@ int goya_debug_coresight(struct hl_device *hdev, void *data)
 	return rc;
 }
 
-void goya_halt_coresight(struct hl_device *hdev)
+void goya_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx)
 {
 	struct hl_debug_params params = {};
 	int i, rc;
-- 
2.25.1

