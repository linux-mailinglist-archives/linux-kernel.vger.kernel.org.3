Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EDC50696D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350840AbiDSLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349191AbiDSLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:08:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B2112095
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:05:25 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a10so12800635qvm.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WypoIbYzDM3SGYr1aowM73aDQH7Omrk2x+2YoRxyVaU=;
        b=a6OraGettVpXcTIsVDJpQy7a4jQLUXhbFvesUjA7jmnSNd85IR4GKqgvqZNABHG0m9
         hn1WoKmmxl3+lDodvIJ9YsE/4OcAUL6hN4h7mGB559d3pQd6rFnx29F1T+IcdPn+ERad
         pfNzxbsxXX4w0fZcIlmfWn6bKAuypvSukcL9ecHM+dRn7sxAcw/8LzT1mxm0EOr60k1o
         sOR/yvTL/5ICWHcIzcRXoRtz5j3k2xyHwAwCS3+rH032Rpk6IeYoj0UrnIMy2fcBUcza
         Tf9AU//r0dC1atNVpXt7xovE6CWTGQO7krq/Uwo6E7Flge3UBfFXTTmWGlv95GWIyZb/
         Vcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WypoIbYzDM3SGYr1aowM73aDQH7Omrk2x+2YoRxyVaU=;
        b=G7xJ+DIOm+vsSrVkYh+YUGuEoy+IjPOnPb4lgPkle9GGvSwB/mkMvLfN70aEcddtcg
         F0opX13KgcX9LQ79K7WwydmR6miGtxxC2oE0mDrSD2HM3wh3tFIB3iImmFyvvjm438D4
         schWLOstViCJIedc65WUypWoCLx2f0oOeYRfhQrtfbOpvZShMi0FbEZqNxi8Y6RQayca
         JfQOftsmqnY8MtMGQebJuMpswmVrinwAH2Rud47iUwXMdqwvs9l3AndCRCWcwWFKqMob
         MRhcV4H6iXfVc5QYguaVvhzdPDqCtdpkNjdwwsZ4cJAtYh210YW4+1OgFSPJ9JXQUaVs
         Isqw==
X-Gm-Message-State: AOAM532eXX9QHysQ61DAKn9+uZtIaxp7/aCqYldWTSSB1Evs1D3SgCG5
        KdkFG+MeHN5OTfrkp2f4Ghk=
X-Google-Smtp-Source: ABdhPJw71zFUJUfEaL8h4nWaMzHBhFcHvhWClsius2kORwDAEjXL2UUVo6ziMXBa9ls10KuXylePWg==
X-Received: by 2002:a05:6214:2309:b0:435:374d:4bbb with SMTP id gc9-20020a056214230900b00435374d4bbbmr10758363qvb.105.1650366324179;
        Tue, 19 Apr 2022 04:05:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a099600b0069e5db6be55sm6041254qkx.36.2022.04.19.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:05:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     l.stach@pengutronix.de
Cc:     linux+etnaviv@armlinux.org.uk, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/etnaviv: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 19 Apr 2022 11:05:18 +0000
Message-Id: <20220419110518.2574486-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37018bc55810..4ac009a1c4c0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1342,11 +1342,9 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 	int ret;
 
 	if (!submit->runtime_resumed) {
-		ret = pm_runtime_get_sync(gpu->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(gpu->dev);
+		ret = pm_runtime_resume_and_get(gpu->dev);
+		if (ret < 0)
 			return NULL;
-		}
 		submit->runtime_resumed = true;
 	}
 
-- 
2.25.1

