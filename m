Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6104F5F39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiDFNIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiDFNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBA2CCCD3;
        Wed,  6 Apr 2022 02:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D0761501;
        Wed,  6 Apr 2022 09:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0117C385A9;
        Wed,  6 Apr 2022 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649238074;
        bh=97AuxegGoUll1qcITUP5BRc/wzaj9s6TR3mxBS6KHjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0WNCskYa42HqXSBMwB9n6XnQvThqbJBCGze1lA31QGBJb/ou62WfPCCLgj8ZmBIO
         JuX2JtaQU6FdkW4PGFhjhEuhDzEVnd5QzUg4FdwWdZhZKikqfxfbSReGq1ftGd7WNV
         h/IkejQuTuhcXqnHZ87yyqKYYh7ZJeYgim+Ozk6iTfJHqhX0YntblgSL/BKe3lAlxN
         qgO6Nn13S3iFf7yXlefKhmIvL3NnCA23V6L6s9Jaqrw5eRBtB1sauOHgInbM7mzRVB
         krVPyCPFm+LLfkDyHshMsloPHNxrJa7VNoHYlGPr8fprCZdzr/nNnZR6QCTAM4gX0g
         irVZTmHEJar2g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 08/14] drm/msm/dpu: don't use merge_3d if DSC merge topology is used
Date:   Wed,  6 Apr 2022 15:10:25 +0530
Message-Id: <20220406094031.1027376-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406094031.1027376-1-vkoul@kernel.org>
References: <20220406094031.1027376-1-vkoul@kernel.org>
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
index 4052486f19d8..95d1588f3bb6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -511,6 +511,22 @@ void dpu_encoder_helper_split_config(
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
index ef873e5285a0..084c5265d7e5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -172,4 +172,10 @@ int dpu_encoder_get_linecount(struct drm_encoder *drm_enc);
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
index 4842070fdfa8..b5ad43b8a19b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -314,8 +314,10 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 
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

