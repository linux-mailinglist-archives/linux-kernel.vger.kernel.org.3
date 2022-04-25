Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C88450D782
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiDYDaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiDYDaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:30:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54A240A4;
        Sun, 24 Apr 2022 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650857232; x=1682393232;
  h=from:to:cc:subject:date:message-id;
  bh=YjOcgIOFXyRnwECVbo7xYwtnF1RAoHpr1cKLFYwgHuA=;
  b=fcDVdDpI2jjjtmSVq9sH1GKF7KwWrK3e1bPXrjlo5XpHXD0F2WUyOUuE
   Y3+ms09O6hgJLkPWgUusegJ4stwhl4y4Dpy+4n/2ijMa3eBKX1/9d62nJ
   6sme/Yw3rtP1Lu9bgbFDBE44ci7vQ0XN1rCs8CA6Wc0YESPEfjDnrNu6p
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Apr 2022 20:27:11 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Apr 2022 20:27:10 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Apr 2022 08:56:56 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 0A71255BD; Mon, 25 Apr 2022 08:56:55 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH] drm/msm/disp/dpu1: set vbif hw config to NULL to avoid use after memory free during pm runtime resume
Date:   Mon, 25 Apr 2022 08:56:53 +0530
Message-Id: <1650857213-30075-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: Unable to handle kernel paging request at virtual address 006b6b6b6b6b6be3

Call trace:
  dpu_vbif_init_memtypes+0x40/0xb8
  dpu_runtime_resume+0xcc/0x1c0
  pm_generic_runtime_resume+0x30/0x44
  __genpd_runtime_resume+0x68/0x7c
  genpd_runtime_resume+0x134/0x258
  __rpm_callback+0x98/0x138
  rpm_callback+0x30/0x88
  rpm_resume+0x36c/0x49c
  __pm_runtime_resume+0x80/0xb0
  dpu_core_irq_uninstall+0x30/0xb0
  dpu_irq_uninstall+0x18/0x24
  msm_drm_uninit+0xd8/0x16c

Fixes: 25fdd5933e4 ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 9c346ce..59982d3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -793,8 +793,10 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 		for (i = 0; i < dpu_kms->catalog->vbif_count; i++) {
 			u32 vbif_idx = dpu_kms->catalog->vbif[i].id;
 
-			if ((vbif_idx < VBIF_MAX) && dpu_kms->hw_vbif[vbif_idx])
+			if ((vbif_idx < VBIF_MAX) && dpu_kms->hw_vbif[vbif_idx]) {
 				dpu_hw_vbif_destroy(dpu_kms->hw_vbif[vbif_idx]);
+				dpu_kms->hw_vbif[vbif_idx] = NULL;
+			}
 		}
 	}
 
-- 
2.7.4

