Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54800553072
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348640AbiFULGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiFULGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:06:44 -0400
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FA29C87
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:06:43 -0700 (PDT)
Received: by mail-pl1-f194.google.com with SMTP id k7so12202595plg.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=womC/be6OksJ07JVvS178BAU4AIaext+3ynvpTRikio=;
        b=bgeazasa10h17+JOaEjiEoYzW6baZaurdTaSQ0GJICkhrTUiyjxJmMB0/ZiGNXzgLn
         vS98Y0o6NZFuDRG1GsD7zQvpqwP4W4cgAUG4JTswK1wcchwYcEO7Mv/qazkfUv9wuo8n
         zqsJcZE6VDCysfAb1NUPKWd2XsBWArM90zLBQ9NAYzZ/ZtkjV0rc1Dmrz7t6/sOkuYIj
         cHv0PdSJ/QXVn025lbLim3lL3S1JB/Zmo/mVG19XntHyCfA1kjpQbhZe11nwsgbfJ2am
         ChkIoKBaRRlnv4uuFekI87CYvLEwvYrM0rtwR/2wypv4BF5VZqNOY5VgNTJ/hKV0/Dpq
         +lww==
X-Gm-Message-State: AJIora8jQWCMcMeeL3vMNOBjB9V/PjMXFTZZb1Tg2Erbn4Ka9y0sa3mk
        ftOy8ZBEk7mvu0HyxyJdtg==
X-Google-Smtp-Source: AGRyM1tr7WvZy6G8nzBUNCoo/gq6WqTSZhIDTWhkfc/VyfwOGjEGv6Kk+PF36juah20dM3DdQTvT8w==
X-Received: by 2002:a17:90a:e503:b0:1ec:84b2:6404 with SMTP id t3-20020a17090ae50300b001ec84b26404mr21133920pjy.169.1655809602698;
        Tue, 21 Jun 2022 04:06:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id j1-20020aa783c1000000b0051be585ab1dsm10833535pfn.200.2022.06.21.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 04:06:42 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/msm/dpu: Fix variable dereferenced before check
Date:   Tue, 21 Jun 2022 19:06:34 +0800
Message-Id: <20220621110634.368913-1-sunliming@kylinos.cn>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
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

