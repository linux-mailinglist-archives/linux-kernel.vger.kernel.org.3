Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92053514509
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356229AbiD2JGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiD2JGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:06:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A150C44EC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:02:44 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o18so5254000qtk.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+89oAO86ydiGvNRr1qXWqQmX8G4rgyRzRmQYlJDSQoA=;
        b=ZcnXwo5//6N+ci+nwO9q5ypjPV7l4e8pTAmI/Nq4g1mbnh67hm6vSaKJ5N32g054oq
         S+norkfORNSyzH3+Kkp6DZJbPDLHbu3Tfv1BfyEqEhGKDItjU1hWsID6fuMHWi7OBSX5
         F6jl4Rp+/eokugIe8+0MxkogWj/TNCQ32fjjnjDmTDBWMiPWbGANhh0/8qeTnU4c4BBD
         ssQ4gJz5DSCfCGwdXPuJte64Akr5593hqBQNldjyn2VfHA+Be65sk/XnRaiFjvsukpPL
         bgLJPNK8J/Y/hJM1GXPfI2Zn5nIOmuqkbYqf2t+56JMuEl7sBVELqf++ZVtFCFXF68xS
         fCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+89oAO86ydiGvNRr1qXWqQmX8G4rgyRzRmQYlJDSQoA=;
        b=yM2HIUDvAEpGuiXWY6cMiz83bYxuliBG9f+H04Pu1TF4Fp1a8tfQU/09uXOkgelQ7t
         jZ97Mj32Q6wDOcpD0jVt6W1C/9oBeUBTK9JSJIt69y577uxtQuSR1HJJxUeds5oVJeII
         42IUjbfmG3lYC1HgKYP4VoNFwfmvVgrCNlo+tXq4/T3DqMhIyHUnJplrtEt6aVK4DFOx
         MxQp3LXNpXIvuz2sJYWeAH/zjk8uopJhcA5SZsi3I7wVglX3xv2S/RW0sIfOHUdtv5c+
         Jnc4NhbTeWoGloSI4hmnWMx9lQksi0ZNGVoHeTTMjldjgnizq5/O3/npmIayD1Fzlcj+
         TDfw==
X-Gm-Message-State: AOAM532GyKL250dDM9QSgrUU/UAzCFxdGdmWRVLd1tZlwqPZAwmQ59VA
        KdSDRRYO4menlKkYNJWu7uI=
X-Google-Smtp-Source: ABdhPJynceQU4nOjvDSdCTj0nX15G3svB7MoLxViEaLi23HhcHfplcwlFq24cdyu7s5htm2/AdsXtw==
X-Received: by 2002:a05:622a:2c4:b0:2f3:8743:6fc7 with SMTP id a4-20020a05622a02c400b002f387436fc7mr7208668qtx.187.1651222963712;
        Fri, 29 Apr 2022 02:02:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a271c00b0069f52b96667sm1188580qkp.53.2022.04.29.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:02:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tomba@kernel.org
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm: omapdrm: simplify the return expression of dss_setup_default_clock()
Date:   Fri, 29 Apr 2022 09:02:38 +0000
Message-Id: <20220429090238.3852941-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/omapdrm/dss/dss.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 0399f3390a0a..2f13805d85ba 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -672,7 +672,6 @@ static int dss_setup_default_clock(struct dss_device *dss)
 	unsigned long max_dss_fck, prate;
 	unsigned long fck;
 	unsigned int fck_div;
-	int r;
 
 	max_dss_fck = dss->feat->fck_freq_max;
 
@@ -687,11 +686,7 @@ static int dss_setup_default_clock(struct dss_device *dss)
 		    * dss->feat->dss_fck_multiplier;
 	}
 
-	r = dss_set_fck_rate(dss, fck);
-	if (r)
-		return r;
-
-	return 0;
+	return dss_set_fck_rate(dss, fck);
 }
 
 void dss_set_venc_output(struct dss_device *dss, enum omap_dss_venc_type type)
-- 
2.25.1


