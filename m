Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF44F1B91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380183AbiDDVVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379144AbiDDQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:37:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210DE094;
        Mon,  4 Apr 2022 09:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90681B81857;
        Mon,  4 Apr 2022 16:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952ACC34114;
        Mon,  4 Apr 2022 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649090135;
        bh=n3Wkk5bm16a05lN7V/okcIiS7mgAL2qB7YWgC48E5A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQa8RgE/Wpy5P1VNso6g/dWmEeVxk0r29TV+jZ0mxz3wEb0OBhQeJOr2GKs8vdKjg
         H8tpMF9KgbUNjIZNQIW8uPXBAd5lJY8v/sy+y2X47qBOn2DFWcm26QLt0pLxbTBR5i
         x5BpEGfwaAWrEII+aiJ6chPNg7GKbM9NnnbssBcZGqMtkaFNYMJ/vhdJZF7GjFDYoo
         T7mjc6eHKj54Aq09FN1cYAgF0J5hY+dF685OcMX40/fZ7siePYIL73fpblc/0VYTJ+
         V1Y/W3YRVmRdztqLdcFWQI4lTUZ0ghqFeltdGAvqeGDw6diUs4S2l9CkJ7jDkh/EPz
         XqopggPDVqW8A==
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
Subject: [PATCH v6 10/14] drm/msm/disp/dpu1: Add support for DSC in topology
Date:   Mon,  4 Apr 2022 22:04:32 +0530
Message-Id: <20220404163436.956875-11-vkoul@kernel.org>
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

For DSC to work we typically need a 2,2,1 configuration. This should
suffice for resolutions up to 4k. For more resolutions like 8k this won't
work.

Also, it is better to use 2 LMs and DSC instances as half width results
in lesser power consumption as compared to single LM, DSC at full width.

The panel has been tested only with 2,2,1 configuration, so for
now we blindly create 2,2,1 topology when DSC is enabled

Co-developed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 +++++++++++++
 drivers/gpu/drm/msm/msm_drv.h               |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 95d1588f3bb6..51f24ba68375 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -567,8 +567,21 @@ static struct msm_display_topology dpu_encoder_get_topology(
 	topology.num_enc = 0;
 	topology.num_intf = intf_count;
 
+	if (dpu_enc->dsc) {
+		/* In case of Display Stream Compression (DSC), we would use
+		 * 2 encoders, 2 layer mixers and 1 interface
+		 * this is power optimal and can drive up to (including) 4k
+		 * screens
+		 */
+		topology.num_enc = 2;
+		topology.num_dsc = 2;
+		topology.num_intf = 1;
+		topology.num_lm = 2;
+	}
+
 	return topology;
 }
+
 static int dpu_encoder_virt_atomic_check(
 		struct drm_encoder *drm_enc,
 		struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index bf2ccff97562..0ace9b0549a4 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -103,12 +103,14 @@ enum msm_event_wait {
  * @num_enc:      number of compression encoder blocks used
  * @num_intf:     number of interfaces the panel is mounted on
  * @num_dspp:     number of dspp blocks used
+ * @num_dsc:      number of Display Stream Compression (DSC) blocks used
  */
 struct msm_display_topology {
 	u32 num_lm;
 	u32 num_enc;
 	u32 num_intf;
 	u32 num_dspp;
+	u32 num_dsc;
 };
 
 /* Commit/Event thread specific structure */
-- 
2.34.1

