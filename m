Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0D4F1E31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379796AbiDDV66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379137AbiDDQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:37:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97AE094;
        Mon,  4 Apr 2022 09:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D288CB8185A;
        Mon,  4 Apr 2022 16:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01641C340EE;
        Mon,  4 Apr 2022 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649090118;
        bh=t1R7yY7ERx45DK/Kh01d2HvOQlzbGo2a7CpMAwLKtzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIbYevOXpAE5cWe8PHnRfvfbi/ss6FsOa+tFMHytERdciuYr8Jsl2e+29uATUUgZc
         O094MyF1ENciMCi6csVSV4IaQZ9JjAVLEd7FVjAaiU3DOU2ZdR4WWcmNPyBDo5LGrX
         4WLitQWjC04enQ++V97VGzOP6CbsG9YPZRll2OZrQWXmS6x/PBJhRVXIu6UdcVXM7a
         IUUlWcU9puBkM0mwraQw0V8itW/vzu/316k0MpYlKEwxZDc8K5acul3MNITcFs5qFm
         FG7xqnREInseFwgUth5m43LGmcLJ7Vg8kjDye6hMgemQi11zFVBcz1z2nXSRkaChkY
         IcZ+LffLiTImw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v6 06/14] drm/msm/disp/dpu1: Add DSC support in hw_ctl
Date:   Mon,  4 Apr 2022 22:04:28 +0530
Message-Id: <20220404163436.956875-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220404163436.956875-1-vkoul@kernel.org>
References: <20220404163436.956875-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later gens of hardware have DSC bits moved to hw_ctl, so configure these
bits so that DSC would work there as well

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 11 ++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 3584f5ee6bb3..dc27579bb5f6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -25,6 +25,8 @@
 #define   CTL_MERGE_3D_ACTIVE           0x0E4
 #define   CTL_INTF_ACTIVE               0x0F4
 #define   CTL_MERGE_3D_FLUSH            0x100
+#define   CTL_DSC_ACTIVE                0x0E8
+#define   CTL_DSC_FLUSH                0x104
 #define   CTL_INTF_FLUSH                0x110
 #define   CTL_INTF_MASTER               0x134
 #define   CTL_FETCH_PIPE_ACTIVE         0x0FC
@@ -34,6 +36,7 @@
 
 #define DPU_REG_RESET_TIMEOUT_US        2000
 #define  MERGE_3D_IDX   23
+#define  DSC_IDX        22
 #define  INTF_IDX       31
 #define CTL_INVALID_BIT                 0xffff
 #define CTL_DEFAULT_GROUP_ID		0xf
@@ -126,7 +129,6 @@ static u32 dpu_hw_ctl_get_pending_flush(struct dpu_hw_ctl *ctx)
 
 static inline void dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
 {
-
 	if (ctx->pending_flush_mask & BIT(MERGE_3D_IDX))
 		DPU_REG_WRITE(&ctx->hw, CTL_MERGE_3D_FLUSH,
 				ctx->pending_merge_3d_flush_mask);
@@ -511,6 +513,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))
 		mode_sel = CTL_DEFAULT_GROUP_ID  << 28;
 
+	if (cfg->dsc)
+		DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH, cfg->dsc);
+
 	if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
 		mode_sel |= BIT(17);
 
@@ -522,6 +527,10 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	if (cfg->merge_3d)
 		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
 			      BIT(cfg->merge_3d - MERGE_3D_0));
+	if (cfg->dsc) {
+		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
+		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
+	}
 }
 
 static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index ac1544474022..97f326dff0af 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -40,6 +40,7 @@ struct dpu_hw_stage_cfg {
  * @merge_3d:              3d merge block used
  * @intf_mode_sel:         Interface mode, cmd / vid
  * @stream_sel:            Stream selection for multi-stream interfaces
+ * @dsc:                   DSC BIT masks used
  */
 struct dpu_hw_intf_cfg {
 	enum dpu_intf intf;
@@ -47,6 +48,7 @@ struct dpu_hw_intf_cfg {
 	enum dpu_merge_3d merge_3d;
 	enum dpu_ctl_mode_sel intf_mode_sel;
 	int stream_sel;
+	unsigned int dsc;
 };
 
 /**
-- 
2.34.1

