Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190E4509AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386802AbiDUIrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiDUIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:47:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EC1183BF;
        Thu, 21 Apr 2022 01:44:20 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id fu34so2762737qtb.8;
        Thu, 21 Apr 2022 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R0CH1Evld8HOQJZRIBGp4ICwl2H4Qn/SiHpW53g4anA=;
        b=dyqFh3cLLvYBsbeeoUA1jYq+gKW2g+cohG6mSxt60xHBf73Rv9yg/stwYRuqxLLt4n
         vfInvkFFsYEgZKp2ec70FK2o3yNh2sMXAj+MPVGVZxbkH9i3uEEPfkFBs9p6yYLcJqJ5
         YKeltbgO2VNFu8XDUJaRuGgHaZE3TNIHk/YOs8KmTpc6JaBfI/9uetWl0LDbqXzORfKl
         027aGJa5w4yUi8kGs/gIYchNNQMXUaTOGPcnNALl54OAd+Q3fu+Ave4IKO29UvCMugqI
         JgLYg4+0TEuB4y1lEvZgTcMTCN8spMVc+NLt/XF1aMir+K/AglGNrnXfZz5ihFURCva4
         q68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R0CH1Evld8HOQJZRIBGp4ICwl2H4Qn/SiHpW53g4anA=;
        b=kAYY/Vl4rDBlD6bysRvLKgLVQwaYQSGD0GFAWErRJSoesqq44d2S+RViRC6FfJtdGo
         O9qef3x3kH0w8vdydhDysPZbSpfPYR4J7z3h8b1ncREnTZZVQrPEzLKAECSl/RH4cavI
         uEHDQ53+CNmIVGMCLmLlPkZROCm+pOroQzIK8uMTuTBY7V4sM/rgHhT2vGQkTJb25SvS
         9mCI9aI96pSGiU6RL5dQ3VJRWRw1+TUr4eTqdU1HWtO5/z9Y9ZVLRDXIEQKGVrzgCo9b
         MpAXnuuNsacaz63vB3Zi1W+l1atIIEkNCd1WhcU70Pk2YW10dO6WrGoLapl+vEz2gZ13
         cOww==
X-Gm-Message-State: AOAM531QeXrwxK+QsNUY74jNXTeBHMy2+syBU3gQvZubyi723yFmeaoN
        zMfmvOXW8a0iPwnz1qeVHn8svpTnbMc=
X-Google-Smtp-Source: ABdhPJxAHXEn4TzgTnmqUB3vImqCTD+QIjmk4AuzhppJDBu/lz49sPKpFmQY17iGK1x75OwdvZMmgA==
X-Received: by 2002:ac8:5d89:0:b0:2e2:74e:f1bb with SMTP id d9-20020ac85d89000000b002e2074ef1bbmr16538786qtx.219.1650530659026;
        Thu, 21 Apr 2022 01:44:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c13-20020a37e10d000000b0069c268c37f1sm2646557qkm.23.2022.04.21.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:44:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     linus.walleij@linaro.org, damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ata: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu, 21 Apr 2022 08:44:12 +0000
Message-Id: <20220421084412.2615081-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/ata/sata_gemini.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 00e1c7941d0e..b729e9919bb0 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -318,7 +318,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct sata_gemini *sg;
 	struct regmap *map;
-	struct resource *res;
 	enum gemini_muxmode muxmode;
 	u32 gmode;
 	u32 gmask;
@@ -329,11 +328,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	sg->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	sg->base = devm_ioremap_resource(dev, res);
+	sg->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sg->base))
 		return PTR_ERR(sg->base);
 
-- 
2.25.1

