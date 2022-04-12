Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4E4FDAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359665AbiDLJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356953AbiDLHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9158289B2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:10:37 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c1so1692839qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oakkso+e+qhsN2ZmTPlz+KXAhhWn3wzRJANvdCpqxYk=;
        b=Q+HOoAU3/nLyYd9yfYUohPKt65udJu10tbdVwUJryH80QoNi65kxmmTeCr9w9bzzlw
         9+CcPTMIxqaDMabg2+1y9dXeGATDuh201jif5CmGHIeqDdX0cH6DbiImoYLmwC/lc2jl
         R/wSyhKXfQMCMUFavhPHAShEs055XqvOqGD0YXq3jA8L/pEcv1WjVETenvk1nthFTAUo
         zismcqyOqf+cfe2yh4uTtdBlq9bnut9NBhOM0DBK2RoAZzSFxc8remZ/aznsK0JCKl+g
         Hv/5GL8gyYCqSaLkH6Qn8hXutJ7r2UL3WIOaOwPf0iu26PdDdkLhXONNAT/cCLc8y1B8
         p1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oakkso+e+qhsN2ZmTPlz+KXAhhWn3wzRJANvdCpqxYk=;
        b=knnvF+T5uExi8fcuaDBdWNgLYR5p1Za5kyCmriZniZIEuhV5mZ1gT2SuNdie2guF7/
         DESEXCw6yzFybdQiXDqeIkV+wrGxK07akXhqELsKQ4fJrKMSX7B9z052hy3/rnowzYSy
         zh8baw1ilXIPu4GWkrpW/N8SWOnwcfpiRB5dl/PEmxdnG7b5tMVnNZKrxcNx1J4w40NX
         qFYubAJyyyYybMk9gfCpfou/TqzUKhPN65fMe+Fy9uVxBJbigqPtPxAW0dTWcb1aspqd
         IirxRlWAp33Rj8QpJSWVfs8rttWyCZk0BdOIYWRGF8NYF3C5bcycpEf0n1IWq1uCA52/
         D5RA==
X-Gm-Message-State: AOAM532Msf537ChEXVrLeYCLKTYawbTt1UNfpek9ya+cBOuQ0nc1CkK0
        +0O8YfP1U3E5snRSaPCIazs=
X-Google-Smtp-Source: ABdhPJz9HpruIk48ZvRlIQ4rkcyvLj2AR76zs2UjUSXZUe6ZnqXu1WL6aSY3Fc6MNlZTyztR5C57zw==
X-Received: by 2002:a05:620a:2848:b0:67d:35de:bb5b with SMTP id h8-20020a05620a284800b0067d35debb5bmr2092273qkp.499.1649747436883;
        Tue, 12 Apr 2022 00:10:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f6-20020ac859c6000000b002ee0948f1aesm4653771qtf.72.2022.04.12.00.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:10:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] regulator: stm32-vrefbuf: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 07:10:30 +0000
Message-Id: <20220412071030.2532230-1-chi.minghao@zte.com.cn>
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
 drivers/regulator/stm32-vrefbuf.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 161622ea7259..30ea3bc8ca19 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -44,11 +44,9 @@ static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 	u32 val;
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	val = (val & ~STM32_HIZ) | STM32_ENVR;
@@ -81,11 +79,9 @@ static int stm32_vrefbuf_disable(struct regulator_dev *rdev)
 	u32 val;
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	val &= ~STM32_ENVR;
@@ -102,11 +98,9 @@ static int stm32_vrefbuf_is_enabled(struct regulator_dev *rdev)
 	struct stm32_vrefbuf *priv = rdev_get_drvdata(rdev);
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = readl_relaxed(priv->base + STM32_VREFBUF_CSR) & STM32_ENVR;
 
@@ -123,11 +117,9 @@ static int stm32_vrefbuf_set_voltage_sel(struct regulator_dev *rdev,
 	u32 val;
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	val = (val & ~STM32_VRS) | FIELD_PREP(STM32_VRS, sel);
@@ -145,11 +137,9 @@ static int stm32_vrefbuf_get_voltage_sel(struct regulator_dev *rdev)
 	u32 val;
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
 	ret = FIELD_GET(STM32_VRS, val);
-- 
2.25.1

