Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0249A4E71FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbiCYLIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354595AbiCYLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:08:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBAC74B9;
        Fri, 25 Mar 2022 04:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B0DB82821;
        Fri, 25 Mar 2022 11:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E73EC340F6;
        Fri, 25 Mar 2022 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648206403;
        bh=m9uDaZs40dXiLu/aeYvytz24S479ppbAhHOMj7/1BsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPNra0ChE9Uqy1yzMSziLPPgviDZs+u5d5Dfi+MwD4tMCYg7vBXTYxbCfM3cZ9Uq9
         8BfxVRI8ZkXvztG/IAqTPUZ/6Q2xgHv3CJW0eJswq0FQ8YXtx38QNCyC24l5nG8VW+
         xunacqDXJwIVz9xKuoe1diuPvYuMS144yD8eJsOms/Z/NV3YoFxYPBngKgdxPTKOWw
         ie0aUyHwrm56SgJi8tigs2uMzyUJwyOtldn4el7lUHgbQme1R2JTZgxXo31BDZ4hQc
         +u9WXdINoD67zx/8S2sTF+nGYZal0n2jYUgyx3BsOGZMEWQy+TlAR/82tKPzK8/27v
         N0guLc5sYf9pA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 08/13] drm/msm/dpu: don't use merge_3d if DSC merge topology is used
Date:   Fri, 25 Mar 2022 16:35:51 +0530
Message-Id: <20220325110556.275490-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325110556.275490-1-vkoul@kernel.org>
References: <20220325110556.275490-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

DPU supports different topologies for the case when multiple INTFs are
being driven by the single phys_enc. The driver defaults to using 3DMux
in such cases. Don't use it if DSC merge is used instead.

Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 16 ++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h      |  6 ++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  4 +++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 2219dbfa5ee7..a672c91dbb8b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -534,6 +534,22 @@ void dpu_encoder_helper_split_config(
 	}
 }
 
+bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
+{
+	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
+	int i, intf_count = 0, num_dsc = 0;
+
+	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
+		if (dpu_enc->phys_encs[i])
+			intf_count++;
+
+	/* See dpu_encoder_get_topology, we only support 2:2:1 topology */
+	if (dpu_enc->dsc)
+		num_dsc = 2;
+
+	return (num_dsc > 0) && (num_dsc > intf_count);
+}
+
 static struct msm_display_topology dpu_encoder_get_topology(
 			struct dpu_encoder_virt *dpu_enc,
 			struct dpu_kms *dpu_kms,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index e241914a9677..76fd48c0b17c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -168,4 +168,10 @@ int dpu_encoder_get_linecount(struct drm_encoder *drm_enc);
  */
 int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
 
+/**
+ * dpu_encoder_use_dsc_merge - returns true if the encoder uses DSC merge topology.
+ * @drm_enc:    Pointer to previously created drm encoder structure
+ */
+bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc);
+
 #endif /* __DPU_ENCODER_H__ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 7b90d644a41b..a19140590eaa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -325,8 +325,10 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 
 	dpu_cstate = to_dpu_crtc_state(phys_enc->parent->crtc->state);
 
+	/* Use merge_3d unless DSC MERGE topology is used */
 	if (phys_enc->split_role == ENC_ROLE_SOLO &&
-	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS)
+	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
+	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
 		return BLEND_3D_H_ROW_INT;
 
 	return BLEND_3D_NONE;
-- 
2.34.1

