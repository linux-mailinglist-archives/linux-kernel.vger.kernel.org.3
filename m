Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385D8558CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiFXBHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:07:17 -0400
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F15DF1E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:07:15 -0700 (PDT)
Received: by mail-pj1-f66.google.com with SMTP id p5so1274543pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrOfsAJIfOET38Ruitzwe8COyB98R63F6lwvMnTddZg=;
        b=HvpBEdB8Tzf4OZs5OaBRBngFYTrAv0hKpB1bVhQfqI4BAGuBg3Rim7FjPwP4w5jtve
         7nviG8VxirmCDGyAiLSmu9e9hIoWTUm7ERVfVieUdibazZvKzmU56L3KVEQdcUWi4xn9
         ZBMVwqLvh13u7Zn1n35IwfvufiIWBnQzYzNAmb2tBDaEVNufEa+VSsMvV75mvsk59yaY
         v1BYRz8tm+tJ8tLF5NFnrqGW51dTgh9J3YGknn0N5xs8J81EpGT7FZTcjsexENomRyZm
         4xyJA8/k+eYdjh3n6RODfu/2u8OPPbWu88gHU7zQO9Wb+hnlIkeAL3rXZYlNgxHZt6yV
         xfQg==
X-Gm-Message-State: AJIora+Aaxb1lyoKOy9B6ODS9k1nnhosl6oQ+6zQHlCDyrB5Z2rY2YUm
        byukE+fZchZcd6sW6TqKUg==
X-Google-Smtp-Source: AGRyM1ufQ4kmgn4lrWcEKwVDEb3ZW2Hpq6oqy5hDNX+3qcqD4dTRjm5nSUsdiBekVKlLSKxa6s5paw==
X-Received: by 2002:a17:902:e1d1:b0:16a:1748:19a8 with SMTP id t17-20020a170902e1d100b0016a174819a8mr27925718pla.80.1656032835351;
        Thu, 23 Jun 2022 18:07:15 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a620542000000b0051be7ecd733sm32620pff.16.2022.06.23.18.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 18:07:14 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        kelulanainsley@gmail.com, sunliming@kylinos.cn,
        dan.carpenter@oracle.com, kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] drm/msm/dpu: Fix variable dereferenced before check
Date:   Fri, 24 Jun 2022 09:07:03 +0800
Message-Id: <20220624010703.541191-1-sunliming@kylinos.cn>
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

