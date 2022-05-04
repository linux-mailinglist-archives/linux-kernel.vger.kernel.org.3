Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBB51AC3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376664AbiEDSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377152AbiEDSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:09:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64F5A08F;
        Wed,  4 May 2022 10:25:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so4039659pjb.1;
        Wed, 04 May 2022 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cDOk25/RnzvpMlR1XeGM1YdGyH6P//mosNWBwa+h7uM=;
        b=jxTTz++iwQNoh0+k+5pH/mXQf/2Y595qewvSJ6w+4c0UQN9HYm/Zqcvr0ZtZutf+kX
         1Slrx3gM8oljrdRhY1TBBmUMFgbJdF99iMIuV8ExnL9mK2V8EaJgVNPbaePQ3f6nMaj8
         0geSNvNsp1Vp7kp1Bm1BMvdnM54EiDJ4GVTDq0X9IMsim7UqBYzsVmcTSyyCE5myk6lS
         FnXeEI8UhQfUVohijp1weu6PPjFajnLQz5GFow2PyhVjzhyZx/tGcVdSc3omMGNq/+tW
         0aqlQWWvln9KCc10wIy6mxxsar71tLKJpR53XZI93sz12a5eMeAivGdxTx5UlS/G7FGf
         h5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cDOk25/RnzvpMlR1XeGM1YdGyH6P//mosNWBwa+h7uM=;
        b=lW64ylKe/Pq000FedfIJbVVU/JAAuU6rfQGprjXVuiSo0ZQ+n+7D1X57UBSFTKrfwK
         rlQXXGog14eVj/Ln+nbfh3VrhhlPnGKphaztSLGX7W5YP0bgQvy7ULSvZuBs8vTt5ccz
         nDFhfihIk+0En+rfKdjSQoVzpejKgVcRpytHzKCPMenBhQZXW9EmA5FmExJHctaqskzH
         P/JheFNOnyoDCtesmOlcCqskrwa0Gkids0d+wOZxvdLhs5TzwGN8b2+gFfp+N3Ll299V
         fpeyHYjZolvV+G/s+TZpt0tHucAmNl2+P7QI1cEIcuDL8b3U2tZ2o0Ynl64LRh1Ul8NL
         izGg==
X-Gm-Message-State: AOAM533Ol3F9cBeDezeI92TuYtL7BbcAyXM/hS4brC30nJzXWAUYTu6M
        bt6eETJp2FIaNJDrbOqv++A=
X-Google-Smtp-Source: ABdhPJwMza6K7r7p2J+zzvPSl9Hp4FbT4yvxLeHa3BImAwliGyBaxPrr/mcFAGyn7F+1STb6iJ0Aog==
X-Received: by 2002:a17:902:f70c:b0:14e:f1a4:d894 with SMTP id h12-20020a170902f70c00b0014ef1a4d894mr22863739plo.65.1651685109888;
        Wed, 04 May 2022 10:25:09 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0050dc76281b7sm8772104pfm.145.2022.05.04.10.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 10:25:09 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 1/2] gpio: pca953xx: Add support for pca6408
Date:   Wed,  4 May 2022 10:24:59 -0700
Message-Id: <1651685100-44687-2-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651685100-44687-1-git-send-email-justinpopo6@gmail.com>
References: <1651685100-44687-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pca6408 which is the 8-bit version of the pca6416.

https://www.nxp.com/docs/en/data-sheet/PCA6408A.pdf

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2fe76f..2d0b080 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -71,6 +71,7 @@
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
+	{ "pca6408", 8  | PCA953x_TYPE | PCA_INT, },
 	{ "pca6416", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "pca9505", 40 | PCA953X_TYPE | PCA_INT, },
 	{ "pca9506", 40 | PCA953X_TYPE | PCA_INT, },
@@ -1198,6 +1199,7 @@ static int pca953x_resume(struct device *dev)
 #define OF_957X(__nrgpio, __int) (void *)(__nrgpio | PCA957X_TYPE | __int)
 
 static const struct of_device_id pca953x_dt_ids[] = {
+	{ .compatible = "nxp,pca6408", .data = OF_953X(8, PCA_INT), },
 	{ .compatible = "nxp,pca6416", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9505", .data = OF_953X(40, PCA_INT), },
 	{ .compatible = "nxp,pca9506", .data = OF_953X(40, PCA_INT), },
-- 
2.7.4

