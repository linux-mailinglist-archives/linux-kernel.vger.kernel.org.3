Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D585A5E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiH3IiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3IiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:38:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E3C57A1;
        Tue, 30 Aug 2022 01:38:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so8567153plb.2;
        Tue, 30 Aug 2022 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OKt0SaKYUFDPM64A6Cn07/EmVIDe8Wy7GwAmvsBeu9o=;
        b=fIvvSYlkOcHjJ41suOSaXMb/7pHUjt+uhtz2UaP1To0OmhrCnIDAWSygWg7+pG3Da1
         0+AOjaky2e834aVf0fXw4e0UfyNGMq2mHlU6XyR6PCgQ8VxtTYuVcTYiiyMiSxHqenlU
         dC5cKOhE7Mj/3Dt9axxG3TvhQVhUuhLMPvSvZEVYv86HGlbkx75BBM14hM0qH8UWUJX+
         UPU63JHPFC0Zd0iLci0J3kib6h7C9bMZmziEPkWJRrH4z1+RAnONSL5I06jM5j2OtR/x
         c8LTtOfxN49StTslBBxb6DT1OGQJA2KZ6LI2fTUPeKzqddGPLKks7HKJCxQA+XNdW/xG
         zuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OKt0SaKYUFDPM64A6Cn07/EmVIDe8Wy7GwAmvsBeu9o=;
        b=hNkI4m97qiEhO4cHXnXaWstNyHSBczkkvlgS8V+6ISeMus6WYrLeCHlx7iSd454EU4
         aFmBIjsRlFilDwcL8WEKcwFl40qOsfKjGamVz2B+6WFQJPy09nLUlty7nuux/kqLdmrq
         AEZjmQJKSD07kBz5mhuU4Bgn/UgoLX1ZBI/RxYUEnS0+zX4scfSMmmHCgpw5PuW8bBwE
         ZUfGBw09M8fMIvjsn5R4HTbtwefUJJWLjTKh7UqVfoOAl/JEKENJARcvwOBeSiIYSIdi
         20fcLol7bcYVQaY3yUNGLOop4188Q/3BmPfS1oziJPipr0nGQWDCU4ENTGW/H7yoKrAT
         PhOA==
X-Gm-Message-State: ACgBeo32WK9MiT9VmDboGD5KFIi9Geqwhm0UHq2OY9smxP3ntiLycRXt
        Ij+t0j6j1Gw8w/+kgvM4dREgfLAqLXU=
X-Google-Smtp-Source: AA6agR6vJqU1pWfRwxp3epkBabnDXJzQtRQDUQRGVlNPFO/iYEB67Ck5rDWQ9BP1GHsPomNF7O12bQ==
X-Received: by 2002:a17:90a:318f:b0:1fa:a374:f565 with SMTP id j15-20020a17090a318f00b001faa374f565mr22667328pjb.146.1661848681621;
        Tue, 30 Aug 2022 01:38:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d26-20020aa797ba000000b0053668f17a23sm8507946pfq.220.2022.08.30.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:38:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mchehab@kernel.org
Cc:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] media: venus: hfi: Remove the unneeded result variable
Date:   Tue, 30 Aug 2022 08:37:53 +0000
Message-Id: <20220830083753.276861-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value venus_hfi_create() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/media/platform/qcom/venus/hfi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 1968f09ad177..e00aedb41d16 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -569,8 +569,6 @@ irqreturn_t hfi_isr(int irq, void *dev)
 
 int hfi_create(struct venus_core *core, const struct hfi_core_ops *ops)
 {
-	int ret;
-
 	if (!ops)
 		return -EINVAL;
 
@@ -579,9 +577,8 @@ int hfi_create(struct venus_core *core, const struct hfi_core_ops *ops)
 	core->state = CORE_UNINIT;
 	init_completion(&core->done);
 	pkt_set_version(core->res->hfi_version);
-	ret = venus_hfi_create(core);
 
-	return ret;
+	return venus_hfi_create(core);
 }
 
 void hfi_destroy(struct venus_core *core)
-- 
2.25.1
