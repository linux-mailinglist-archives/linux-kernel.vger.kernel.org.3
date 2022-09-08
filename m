Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6995B159A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIHH0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiIHH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:26:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA537AB4F7;
        Thu,  8 Sep 2022 00:26:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2885oaOd013439;
        Thu, 8 Sep 2022 07:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=peU2kOufsbu5SBls6JVPvgET4EJbYt9FkY4Sr3YPXAA=;
 b=IrLj9+BQoce3YIaTrqTlkA+tfc5FWMo2098H3Ae6piajcjQIsZRarOs+QAs7OGniLWjU
 QxPt9DMDDRDaaKjJVFWXTIVnCSnPc0gcL8eQmIjTaNowCeAXY6ddCcDY5Cx3SaORvcDa
 CpaY1ymBBhS9G+y93sx6WD5OgBJrVRob1HsdKxkrDg9mNeVCAeTjXNsDb02VvalKteE9
 p+eXCWMVI09kl8XmBqDJr3wasZY2bl1rs7hGsdHL+HFTKuYzrN2D93LJxB69vplv3y8L
 8Z3rktai8qqOpw7ARRkTxaPUYYBd07FvbwYwqeLEsv2Lbk5eFvVLCDSVvtMN/DksrzFM AA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1sws74t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 07:26:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2887QU5o010240;
        Thu, 8 Sep 2022 07:26:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3jc00kafvj-1;
        Thu, 08 Sep 2022 07:26:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2887QURG010233;
        Thu, 8 Sep 2022 07:26:30 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2887QUOi010217;
        Thu, 08 Sep 2022 07:26:30 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 7C06E462C; Thu,  8 Sep 2022 00:26:29 -0700 (PDT)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [v4] drm/msm/disp/dpu1: add support for dspp sub block flush in sc7280
Date:   Thu,  8 Sep 2022 00:26:28 -0700
Message-Id: <1662621988-6873-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <y>
References: <y>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m_Ez0RETrxV4Wb_AHOjX3BAFlY5R7l_G
X-Proofpoint-ORIG-GUID: m_Ez0RETrxV4Wb_AHOjX3BAFlY5R7l_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_05,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080026
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flush mechanism for DSPP blocks has changed in sc7280 family, it
allows individual sub blocks to be flushed in coordination with
master flush control.

Representation: master_flush && (PCC_flush | IGC_flush .. etc )

This change adds necessary support for the above design.

Changes in v1:
- Few nits (Doug, Dmitry)
- Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)

Changes in v2:
- Move the address offset to flush macro (Dmitry)
- Seperate ops for the sub block flush (Dmitry)

Changes in v3:
- Reuse the DPU_DSPP_xx enum instead of a new one (Dmitry)
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  5 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 35 ++++++++++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     | 10 ++++++--
 5 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 601d687..4170fbe 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -766,7 +766,7 @@ static void _dpu_crtc_setup_cp_blocks(struct drm_crtc *crtc)
 
 		/* stage config flush mask */
 		ctl->ops.update_pending_flush_dspp(ctl,
-			mixer[i].hw_dspp->idx);
+			mixer[i].hw_dspp->idx, DPU_DSPP_PCC);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 27f029f..0eecb2f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -65,7 +65,10 @@
 	(PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
 
 #define CTL_SC7280_MASK \
-	(BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG))
+	(BIT(DPU_CTL_ACTIVE_CFG) | \
+	 BIT(DPU_CTL_FETCH_ACTIVE) | \
+	 BIT(DPU_CTL_VM_CFG) | \
+	 BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
 
 #define MERGE_3D_SM8150_MASK (0)
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 38aa38a..8148e91 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -161,10 +161,12 @@ enum {
  * DSPP sub-blocks
  * @DPU_DSPP_PCC             Panel color correction block
  * @DPU_DSPP_GC              Gamma correction block
+ * @DPU_DSPP_IGC             Inverse Gamma correction block
  */
 enum {
 	DPU_DSPP_PCC = 0x1,
 	DPU_DSPP_GC,
+	DPU_DSPP_IGC,
 	DPU_DSPP_MAX
 };
 
@@ -191,6 +193,7 @@ enum {
  * @DPU_CTL_SPLIT_DISPLAY:	CTL supports video mode split display
  * @DPU_CTL_FETCH_ACTIVE:	Active CTL for fetch HW (SSPPs)
  * @DPU_CTL_VM_CFG:		CTL config to support multiple VMs
+ * @DPU_CTL_DSPP_BLOCK_FLUSH: CTL config to support dspp sub-block flush
  * @DPU_CTL_MAX
  */
 enum {
@@ -198,6 +201,7 @@ enum {
 	DPU_CTL_ACTIVE_CFG,
 	DPU_CTL_FETCH_ACTIVE,
 	DPU_CTL_VM_CFG,
+	DPU_CTL_DSPP_SUB_BLOCK_FLUSH,
 	DPU_CTL_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index a35ecb6..bbda09a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -33,6 +33,7 @@
 #define   CTL_INTF_FLUSH                0x110
 #define   CTL_INTF_MASTER               0x134
 #define   CTL_FETCH_PIPE_ACTIVE         0x0FC
+#define   CTL_DSPP_n_FLUSH(n)		((0x13C) + ((n - 1) * 4))
 
 #define CTL_MIXER_BORDER_OUT            BIT(24)
 #define CTL_FLUSH_MASK_CTL              BIT(17)
@@ -287,8 +288,9 @@ static void dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
 }
 
 static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
-	enum dpu_dspp dspp)
+	enum dpu_dspp dspp, u32 dspp_sub_blk)
 {
+
 	switch (dspp) {
 	case DSPP_0:
 		ctx->pending_flush_mask |= BIT(13);
@@ -307,6 +309,31 @@ static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
 	}
 }
 
+static void dpu_hw_ctl_update_pending_flush_dspp_subblocks(
+	struct dpu_hw_ctl *ctx,	enum dpu_dspp dspp, u32 dspp_sub_blk)
+{
+	uint32_t flushbits = 0, active;
+
+	switch (dspp_sub_blk) {
+	case DPU_DSPP_IGC:
+		flushbits = BIT(2);
+		break;
+	case DPU_DSPP_PCC:
+		flushbits = BIT(4);
+		break;
+	case DPU_DSPP_GC:
+		flushbits = BIT(5);
+		break;
+	default:
+		return;
+	}
+
+	active = DPU_REG_READ(&ctx->hw, CTL_DSPP_n_FLUSH(dspp));
+	DPU_REG_WRITE(&ctx->hw, CTL_DSPP_n_FLUSH(dspp), active | flushbits);
+
+	ctx->pending_flush_mask |= BIT(29);
+}
+
 static u32 dpu_hw_ctl_poll_reset_status(struct dpu_hw_ctl *ctx, u32 timeout_us)
 {
 	struct dpu_hw_blk_reg_map *c = &ctx->hw;
@@ -675,7 +702,11 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops *ops,
 	ops->setup_blendstage = dpu_hw_ctl_setup_blendstage;
 	ops->update_pending_flush_sspp = dpu_hw_ctl_update_pending_flush_sspp;
 	ops->update_pending_flush_mixer = dpu_hw_ctl_update_pending_flush_mixer;
-	ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
+	if (cap & BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
+		ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp_subblocks;
+	else
+		ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
+
 	if (cap & BIT(DPU_CTL_FETCH_ACTIVE))
 		ops->set_active_pipes = dpu_hw_ctl_set_fetch_pipe_active;
 };
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index 96c012e..1743572 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -149,12 +149,18 @@ struct dpu_hw_ctl_ops {
 
 	/**
 	 * OR in the given flushbits to the cached pending_flush_mask
-	 * No effect on hardware
+	 *
+	 * If the hardware supports dspp sub block flush, then sub-block
+	 * flushes are written to the hardware and main dspp flush will
+	 * be cached in the pending_flush_mask.
+	 *
 	 * @ctx       : ctl path ctx pointer
 	 * @blk       : DSPP block index
+	 * @dspp_sub_blk : DSPP sub-block index
 	 */
 	void (*update_pending_flush_dspp)(struct dpu_hw_ctl *ctx,
-		enum dpu_dspp blk);
+		enum dpu_dspp blk,  u32 dspp_sub_blk);
+
 	/**
 	 * Write the value of the pending_flush_mask to hardware
 	 * @ctx       : ctl path ctx pointer
-- 
2.7.4

