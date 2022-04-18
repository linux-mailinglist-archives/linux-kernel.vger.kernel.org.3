Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC489504CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiDRGdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiDRGdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:33:11 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3AAE0EA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:30:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b68so5809192qkc.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVaaBNdrNxG0FAO3FoTmoqGayjGdNzZY67wQGwdDXok=;
        b=pe4beUvara/Wo3a2oBoCfK1QaI2iQ+igDsERHY41U2XjQdXa49u8FlO1+Jc5okqU9F
         QFxYz6ZZ81qbuIsjNJF9nj2yqmuv5gh/MO9k8DHHkcga2/s2ZoJlX0nM145dS0CU/PE5
         bs9qavEBVVnsWGAdLL69j4MsJNB6DaIWAxpgMUHGysJAadacneozw+kQJWYqDllF6d12
         JftfrLJTl0qy95kdrvoHFadQzfJxtryW/UZfvMGFfkrbmlosFWeF/3cjdw5ehepkiyG0
         G7A+BBYyNWd3Zvujw4CjVMEhGMDlTKlURt+HMrfizZwwgdyNFICpecvS6Lp6ldU6AIXF
         V03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVaaBNdrNxG0FAO3FoTmoqGayjGdNzZY67wQGwdDXok=;
        b=6ZaFAHXMGfqcJtlo/HZybJBc/8z1OyM/gz5C7ZlODpcxomY3w3kYY70SGhGNwsyDHy
         JnWOHWMvXMZzZmIMb5C/dl+hDHr1qWsYxXtybTw45EzJW+8WBQTqTLMHUi5H86aIfEVi
         rSiNmXc8zKAZsOfoqvssg2B7tQuoSu67x6M7+r02nZ83yPuiGHBZ/rRJSUjr5fHOyWSE
         bfAVJB61F4W2gtfosXPqa/to07+5LV8V3waHLiR3vFBpg9ebggmEKh0nuKiNUbBZTbf3
         Vefurf6rhNA5Gp4a7XmPeb0ZT+6p3/GJc8nnBSBOH8/DS9rf6zYky0ZhnqJsN5o2NJ5G
         OnGA==
X-Gm-Message-State: AOAM531bzCUnG6jtyylVt5u8d6d8543Cp5H2xxOSmAmv5mUr/2emXMgN
        tAm8JVnHSwCsGqOpY7LANIF9D878G28=
X-Google-Smtp-Source: ABdhPJwXHEWHoJmunN0Y8U29PAyxCXcpqWGoHUMT+1SbPLai4ZP3FRJHPW4Lc1012/b4ri1M21+KoQ==
X-Received: by 2002:a37:8641:0:b0:67e:85d1:f5e9 with SMTP id i62-20020a378641000000b0067e85d1f5e9mr5944934qkd.128.1650263432264;
        Sun, 17 Apr 2022 23:30:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g17-20020a05620a279100b0069c29caf433sm6406069qkp.73.2022.04.17.23.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 23:30:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: imx: gpcv2: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 06:30:26 +0000
Message-Id: <20220418063026.2558012-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/soc/imx/gpcv2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 3cb123016b3e..4f445889a9e8 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -224,11 +224,9 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	u32 reg_val, pgc;
 	int ret;
 
-	ret = pm_runtime_get_sync(domain->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(domain->dev);
+	ret = pm_runtime_resume_and_get(domain->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
@@ -987,11 +985,9 @@ static int imx_pgc_domain_suspend(struct device *dev)
 	 * after resume, without tripping over our usage of runtime PM to
 	 * power up/down the nested domains.
 	 */
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.25.1


