Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258DE4D77A4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiCMTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiCMTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B754BBAB;
        Sun, 13 Mar 2022 12:05:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so29628843ejb.2;
        Sun, 13 Mar 2022 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=mNHZ2HwvOU0rfN62Ty/YCb8SbLQ6QuDavrDPDiTkmFYkV4/JnHmHB7Or51GDN5+pT0
         sGf3y7gY8ZM0aQCWBiZjUmoEglvaRmnGKmHqjlO+h44R/UGT7/15ftGEqNJMlpDMGedv
         MrbI+avm5+dToHe7WADil4FPPKqKcnLmG5QZSaPRTi9Y8vW97M1rrSFhPqT54ShkQffM
         qXfEJBanjpqpP4w8XOMNkEIkGzh3CYkacd7GQ6Y0it53u1YvA8Bf6QjO/jAn6kOW0WrP
         3n5Aj7hgh8BNSMnmJEcF30r7R2nEY6BjVsnztuP+Nts75MGQkuJvYWpyCf3RGUmaXcCD
         dvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=UYEoYMuwotcEAVRUIElTkEnhSblYpolD4UPUBezOTOhEXcVHuWDYvoZhsAwa/V/3RR
         yoEaEWeAcCYctJqUnD+WAzZkT1N7QCMdeKEpOduJxJc8ge8QRnnUTSIL9TgupXVs6KAh
         SnG6bRj3QCV8hJmIAuqdzF8jBnkNZoxEFe0AJabrKAYaF7v+6ZrCE7k5nHbH/1M25DSl
         UUh1ZbxjCRh/HfA69QS2nBf1rM9/kZt9KZrSQNG3xC1HzpXLEiKW7xN1DVWbKsuqL/1M
         s4Bx/GXvlscj8yjSC38yLvX6XBEkHaBibQTc9E6ZmGEPhYOOT6wSMxCDNJFcX6ZoZR46
         H3SQ==
X-Gm-Message-State: AOAM531lyU+Yd5qEmrqXf6wOuwQtgdUFKX8xVnrnPygpL/CAy67zkBB0
        qGgpdZstPK0hAfpT+9PMhLtQAGDrF9U=
X-Google-Smtp-Source: ABdhPJz5jVjxW9w997O8Vre9I2Mw79xpEHQfkAKrTiTOdLWduAIIPD3FmQ/hxHT56jQl/yzN44QvgQ==
X-Received: by 2002:a17:906:5d0f:b0:6da:bb7a:4da with SMTP id g15-20020a1709065d0f00b006dabb7a04damr13484301ejt.183.1647198303261;
        Sun, 13 Mar 2022 12:05:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:02 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 02/16] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
Date:   Sun, 13 Mar 2022 20:04:05 +0100
Message-Id: <20220313190419.2207-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

Skip pxo/cxo clock registration if they are already defined in DTS as fixed
clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index d6b7adb4be38..27f6d7626abb 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -3061,15 +3062,22 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
+	struct clk *clk;
 	int ret;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
-	if (ret)
-		return ret;
+	clk = clk_get(dev, "cxo");
+	if (IS_ERR(clk)) {
+		ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
+		if (ret)
+			return ret;
+	}
 
-	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
-	if (ret)
-		return ret;
+	clk = clk_get(dev, "pxo");
+	if (IS_ERR(clk)) {
+		ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
+		if (ret)
+			return ret;
+	}
 
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
-- 
2.34.1

