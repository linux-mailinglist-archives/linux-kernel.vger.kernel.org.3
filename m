Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6E556FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiFWB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiFWB1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:27:18 -0400
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC4942A08
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:27:16 -0700 (PDT)
Received: by mail-pg1-f196.google.com with SMTP id a14so8072181pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNPzzADt89xo5zs6PZNoGyHBhvApF8RGasyMsX1K6+Q=;
        b=wMY07f2TdHjD25Yeiv4irGcdgqd3acmP05ALs1upIPKvFYlM+3z+RpfQ0m1OUC7QBt
         +SUDvT2tzgk/SC17KD+4QjUwam3MSBXqmxUy7c6ryrzKa/Yu53T+19KL7UbSwUMcaEvE
         QJ28bIdznf4Qu5biYWZ7kr0fxzf8zF5ubqKj7MdI3R3b6VSY7zoB5aSB5LHzlddSczPz
         ThP8AGN0unN9RY6JZZI5SzUFo71gl8+Niu+MaZcJ0OOYEOmPFUHBaxShXOPALQzaLmFa
         KmZuQMibiirqQI6cJqNt/1ZfoQo8BsBDuaZCEqVHpVOBalSfg+4oIwPHTDBYbysbUGLb
         b7wg==
X-Gm-Message-State: AJIora+LbgULiCalhMOjCk5EOjJku3uQ7Xt8vylmOxHvkmuFjsA9+D/K
        Bap2EaEg8mqAlvR9inlLOQ==
X-Google-Smtp-Source: AGRyM1slyIMjS+dECh4SopuEF2n3vHBOXmq2DPnk2fOXCjRzZuZeUYSXEtu0dJzsatkcU1zoVwBIlQ==
X-Received: by 2002:a63:1846:0:b0:3fd:dd12:ffa8 with SMTP id 6-20020a631846000000b003fddd12ffa8mr5339853pgy.337.1655947635915;
        Wed, 22 Jun 2022 18:27:15 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0016a4a57a25asm2255342plf.152.2022.06.22.18.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 18:27:15 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, freedreno@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH RESEND] drm/msm/dpu: Fix variable dereferenced before check
Date:   Thu, 23 Jun 2022 09:27:07 +0800
Message-Id: <20220623012707.453972-1-sunliming@kylinos.cn>
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

Signed-off-by: sunliming <sunliming@kylinos.cn>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
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

