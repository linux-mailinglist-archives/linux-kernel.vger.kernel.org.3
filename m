Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520464B0AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiBJKfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:35:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiBJKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:35:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A771022;
        Thu, 10 Feb 2022 02:35:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAE1DB8243C;
        Thu, 10 Feb 2022 10:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C13C004E1;
        Thu, 10 Feb 2022 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644489306;
        bh=+uSJgpPgVwRknOJakx0hYRG2KS47RZ7WM5XC1poqiXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBX/BHfqKRYHB5+5vLVptqJ9fQR9KWHvaI5SxbOxNUc2bnMOZRqcWrxtJEqCgSif0
         WrJkJWUytflwm+aVZbURR1YE76DAdfW5GqavVe1q3eY1YBFh6Wf9EXeSEOgBCfJ82h
         yt2nV/idILVoia3d1wkMltM3BoHthW5RJssgw5PE7Ywxi4eAyGaELMP5P2GZDHZnwX
         ai/Cy0RqTZZ4adJFv59XH8JStLaIFF5qBsS4nVmcj74QtxCkrkwcE4EboenpzNSgG7
         L7WEdur9NpF+rKxc84MP5cd8AULvHxuNJduZTQ8KB9l4jd0RnuWmFkA7lTcO0pBVw0
         RwvmmNVhzKhYg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [REPOST PATCH v4 08/13] drm/msm/disp/dpu1: Don't use DSC with mode_3d
Date:   Thu, 10 Feb 2022 16:04:18 +0530
Message-Id: <20220210103423.271016-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220210103423.271016-1-vkoul@kernel.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
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

We cannot enable mode_3d when we are using the DSC. So pass
configuration to detect DSC is enabled and not enable mode_3d
when we are using DSC

We add a helper dpu_encoder_helper_get_dsc() to detect dsc
enabled and pass this to .setup_intf_cfg()

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 4 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 4 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c           | 7 ++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 34a6940d12c5..ed37a4c21596 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -70,6 +70,10 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_CMD;
 	intf_cfg.stream_sel = cmd_enc->stream_sel;
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
+	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
+	if (intf_cfg.dsc)
+		intf_cfg.mode_3d = 0;
+
 	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index ddd9d89cd456..218009855fca 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -284,6 +284,10 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_VID;
 	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
 	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
+	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
+	if (intf_cfg.dsc)
+		intf_cfg.mode_3d = 0;
+
 	if (phys_enc->hw_pp->merge_3d)
 		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 49659165cea8..6d5268b7da90 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -536,7 +536,12 @@ static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
 
 	intf_cfg |= (cfg->intf & 0xF) << 4;
 
-	if (cfg->mode_3d) {
+	/* In DSC we can't set merge, so check for dsc and complain */
+	if (cfg->mode_3d && cfg->dsc)
+		pr_err("DPU1: DSC and Merge 3D both are set!! it may not work\n");
+
+	/* set merge only when dsc is not set */
+	if (cfg->mode_3d && !cfg->dsc) {
 		intf_cfg |= BIT(19);
 		intf_cfg |= (cfg->mode_3d - 0x1) << 20;
 	}
-- 
2.31.1

