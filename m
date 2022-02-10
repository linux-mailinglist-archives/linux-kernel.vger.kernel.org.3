Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ACB4B0AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiBJKfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:35:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiBJKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:35:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67FEFF4;
        Thu, 10 Feb 2022 02:35:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 678B4B824AB;
        Thu, 10 Feb 2022 10:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9099CC004E1;
        Thu, 10 Feb 2022 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644489319;
        bh=k5D32G5ixKYN4bBUiBY8pnqwXqXFp8NFaHmFL6/PAOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfvGotceV6tNx5N6iJiWydfwxZVt2rR2dp8jwgLCX+WIRUtg6jBgZjZqgIWTwt9oZ
         s4xsxbFH8T00zIi8CKRVlhMb6x/0APEXa3OoZ6N+umiD3LEni2Q9YmbcL2geuY5Rk8
         lmeO0k62dGQUjEvetg6ddPQrvsR4IL4uCBPeRP9hdmCSt+ptUjsb8xaVkioT4jC2ha
         8lbSTaYFLr2PT3f5JtQSgEqg/d8wDb5Rg6txD3SXuoo4OUqUwAlKfjZI+UmyJM8Bsi
         SruIiT/2l6Ym8HUbPQL+MBZk85ClptU1EDj2h5+JPA+oLUKRpm5zdr9wtZ7TTS3Hq7
         WDreGun26inlA==
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
Subject: [REPOST PATCH v4 11/13] drm/msm/disp/dpu1: Add DSC support in RM
Date:   Thu, 10 Feb 2022 16:04:21 +0530
Message-Id: <20220210103423.271016-12-vkoul@kernel.org>
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

This add the bits in RM to enable the DSC blocks

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c  | 56 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h  |  1 +
 3 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 2d385b4b7f5e..8f2fb667b05c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -146,6 +146,7 @@ struct dpu_global_state {
 	uint32_t ctl_to_enc_id[CTL_MAX - CTL_0];
 	uint32_t intf_to_enc_id[INTF_MAX - INTF_0];
 	uint32_t dspp_to_enc_id[DSPP_MAX - DSPP_0];
+	uint32_t dsc_to_enc_id[DSC_MAX - DSC_0];
 };
 
 struct dpu_global_state
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index f9c83d6e427a..fbb24bb2b998 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -11,6 +11,7 @@
 #include "dpu_hw_intf.h"
 #include "dpu_hw_dspp.h"
 #include "dpu_hw_merge3d.h"
+#include "dpu_hw_dsc.h"
 #include "dpu_encoder.h"
 #include "dpu_trace.h"
 
@@ -75,6 +76,14 @@ int dpu_rm_destroy(struct dpu_rm *rm)
 			dpu_hw_intf_destroy(hw);
 		}
 	}
+	for (i = 0; i < ARRAY_SIZE(rm->dsc_blks); i++) {
+		struct dpu_hw_dsc *hw;
+
+		if (rm->dsc_blks[i]) {
+			hw = to_dpu_hw_dsc(rm->dsc_blks[i]);
+			dpu_hw_dsc_destroy(hw);
+		}
+	}
 
 	return 0;
 }
@@ -221,6 +230,19 @@ int dpu_rm_init(struct dpu_rm *rm,
 		rm->dspp_blks[dspp->id - DSPP_0] = &hw->base;
 	}
 
+	for (i = 0; i < cat->dsc_count; i++) {
+		struct dpu_hw_dsc *hw;
+		const struct dpu_dsc_cfg *dsc = &cat->dsc[i];
+
+		hw = dpu_hw_dsc_init(dsc->id, mmio, cat);
+		if (IS_ERR_OR_NULL(hw)) {
+			rc = PTR_ERR(hw);
+			DPU_ERROR("failed dsc object creation: err %d\n", rc);
+			goto fail;
+		}
+		rm->dsc_blks[dsc->id - DSC_0] = &hw->base;
+	}
+
 	return 0;
 
 fail:
@@ -476,6 +498,7 @@ static int _dpu_rm_reserve_intf(
 	}
 
 	global_state->intf_to_enc_id[idx] = enc_id;
+
 	return 0;
 }
 
@@ -500,6 +523,28 @@ static int _dpu_rm_reserve_intf_related_hw(
 	return ret;
 }
 
+static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
+			       struct dpu_global_state *global_state,
+			       struct drm_encoder *enc,
+			       const struct msm_display_topology *top)
+{
+	int num_dsc = top->num_dsc;
+	int i;
+
+	/* check if DSC required are allocated or not */
+	for (i = 0; i < num_dsc; i++) {
+		if (global_state->dsc_to_enc_id[i]) {
+			DPU_ERROR("DSC %d is already allocated\n", i);
+			return -EIO;
+		}
+	}
+
+	for (i = 0; i < num_dsc; i++)
+		global_state->dsc_to_enc_id[i] = enc->base.id;
+
+	return 0;
+}
+
 static int _dpu_rm_make_reservation(
 		struct dpu_rm *rm,
 		struct dpu_global_state *global_state,
@@ -526,6 +571,10 @@ static int _dpu_rm_make_reservation(
 	if (ret)
 		return ret;
 
+	ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, &reqs->topology);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -567,6 +616,8 @@ void dpu_rm_release(struct dpu_global_state *global_state,
 		ARRAY_SIZE(global_state->ctl_to_enc_id), enc->base.id);
 	_dpu_rm_clear_mapping(global_state->intf_to_enc_id,
 		ARRAY_SIZE(global_state->intf_to_enc_id), enc->base.id);
+	_dpu_rm_clear_mapping(global_state->dsc_to_enc_id,
+		ARRAY_SIZE(global_state->dsc_to_enc_id), enc->base.id);
 }
 
 int dpu_rm_reserve(
@@ -640,6 +691,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 		hw_to_enc_id = global_state->dspp_to_enc_id;
 		max_blks = ARRAY_SIZE(rm->dspp_blks);
 		break;
+	case DPU_HW_BLK_DSC:
+		hw_blks = rm->dsc_blks;
+		hw_to_enc_id = global_state->dsc_to_enc_id;
+		max_blks = ARRAY_SIZE(rm->dsc_blks);
+		break;
 	default:
 		DPU_ERROR("blk type %d not managed by rm\n", type);
 		return 0;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index 1f12c8d5b8aa..278d2a510b80 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -30,6 +30,7 @@ struct dpu_rm {
 	struct dpu_hw_blk *intf_blks[INTF_MAX - INTF_0];
 	struct dpu_hw_blk *dspp_blks[DSPP_MAX - DSPP_0];
 	struct dpu_hw_blk *merge_3d_blks[MERGE_3D_MAX - MERGE_3D_0];
+	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
 
 	uint32_t lm_max_width;
 };
-- 
2.31.1

