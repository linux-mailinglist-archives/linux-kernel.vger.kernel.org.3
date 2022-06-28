Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66E55D12C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiF1AwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiF1AwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:52:19 -0400
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F5389
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:52:18 -0700 (PDT)
Received: by mail-pl1-f193.google.com with SMTP id r1so9647508plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MxFLykTwoVQ3UQOo8TuHdysXUGeMP/aljqZIpHUoMrs=;
        b=5QhyTM0xmkLixfWxNJGeRT7VNfNHLuOs940iTV+sfIuRLxZOjDV55plJyjd7eWLBMy
         GQpwTl9BJVZgFwxXdF4zqO8KQq4G0inuA5F/XrHB8KTda7CNIxqJKwbPSWo+ditUXL8S
         RH09uTn0+cow+9/vDPNVuaRI9OkRUDMtx6xzJi/LToF7YDzD0DtsZ0gDjvMA95u7vyAQ
         6PMUmtc2kKu18TJbLaNNZWqqSNKj4LKsUFM6wwysUxGXdeZ7hBq0mCGZQZIWTQ8A2deA
         MJIw+T1GUeWfz6mswsqZRAYEpzD2NXF8+5nATezAmUEP3FnQaj51khVfs2b9mqKqCudh
         Tm3A==
X-Gm-Message-State: AJIora+8PtSqIgT9aXKjshJpn6rTGRmO8XX15sVNSQPNLBVXWW3Xcx3i
        VWpiV/Bt/46Klf6Ds9UV2w==
X-Google-Smtp-Source: AGRyM1ssFSnRV6rkpTstqoArtoFLNo0LWpcH0QBqlwfzE/NlvUxFtp1emTZ6QD9qEpht3qK43SlmFQ==
X-Received: by 2002:a17:902:8e86:b0:168:d6d6:660f with SMTP id bg6-20020a1709028e8600b00168d6d6660fmr930658plb.35.1656377537962;
        Mon, 27 Jun 2022 17:52:17 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id u27-20020a62d45b000000b0050dc7628148sm7961421pfl.34.2022.06.27.17.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:52:17 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dan.carpenter@oracle.com, kelulanainsley@gmail.com,
        sunliming@kylinos.cn, kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] drm/msm/dpu: Fix variable dereferenced before check
Date:   Tue, 28 Jun 2022 08:52:04 +0800
Message-Id: <20220628005204.838739-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following smatch warning:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:261
dpu_encoder_phys_wb_atomic_check() warn: variable dereferenced before check 'conn_state'

Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 59da348ff339..0ec809ab06e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -252,11 +252,6 @@ static int dpu_encoder_phys_wb_atomic_check(
 	DPU_DEBUG("[atomic_check:%d, \"%s\",%d,%d]\n",
 			phys_enc->wb_idx, mode->name, mode->hdisplay, mode->vdisplay);
 
-	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
-		return 0;
-
-	fb = conn_state->writeback_job->fb;
-
 	if (!conn_state || !conn_state->connector) {
 		DPU_ERROR("invalid connector state\n");
 		return -EINVAL;
@@ -267,6 +262,11 @@ static int dpu_encoder_phys_wb_atomic_check(
 		return -EINVAL;
 	}
 
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
+		return 0;
+
+	fb = conn_state->writeback_job->fb;
+
 	DPU_DEBUG("[fb_id:%u][fb:%u,%u]\n", fb->base.id,
 			fb->width, fb->height);
 
-- 
2.25.1

