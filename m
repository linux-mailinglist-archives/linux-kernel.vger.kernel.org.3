Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28714956DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378345AbiATXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378170AbiATXUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B24C061574;
        Thu, 20 Jan 2022 15:20:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18so14857715wmg.4;
        Thu, 20 Jan 2022 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RtUb0uNm8GCwaxKxVgq9cIPVLkXV4oSCeOPZFznLHNM=;
        b=oTuNnF35NC7w8bS04lrj9HtubZs9Sr2TqHrBkbDLNnJ95VCmFn9b+gvlWdv0pLkKwC
         HIZNl4g0ZOdlrQ/w0WjAYYm902HtrWQMxhDUii0EkVXCzBrgTAcA+8khRY2HasZn09Ve
         zm8Mp2n+gMpDPw1LRGDXlSAuH6UQeX9m8bwpJkPraeIRO5uTjCiDEZkS0QNjGZmUvC1U
         ZPoTOiBnCJW8K+zC1aLCarQcVELMnbXAxveggtn4NPg2njSBYnSgDXyl9UMB7BBTtxqA
         i2do9JWT6YPI8z9WF5+XO9dRF5mJIaq+DIMTUlaqo1SBSTOl3U8lOoH8iCAVj9W8Iy1h
         vpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtUb0uNm8GCwaxKxVgq9cIPVLkXV4oSCeOPZFznLHNM=;
        b=KsUlYxKxZR1oCV9Z4fppyvLKq8QtsFldlpWz1cgJT8WSf7kHVdohPIWaClPfiDwTPM
         tmH/QbkVxrZ7Kba06U63cScHz1EgCj/lZFtBIsHSAZ3B9CYCMU8AWxXxzoE9Nvgv/DGR
         Urq3nAZA1A2tZ3bDRk4lb0/chdxFXcwBhAJ20Nn5NoA+9p0mGxXSASOgGfaTDvJC/Vqb
         JewE9nuaj508CfDqBVJy10p2XeTsjRgQnmHj8uIIXzr5mHNpBm2GDYpOIJTB3wOVDbM7
         W9sMGIjhPAg/nTHElgg8D8Aq7ZxYqvz9aGMS67dlKQl6lckfE/zIsGl4KBRRJzM3pEaG
         ay5Q==
X-Gm-Message-State: AOAM533EZFL2HboateYCjZn6jvk2ufVl9tassna33XwBHRWBIS1ChxN5
        esD2pVgwmU5NFHvlj3RvoiY=
X-Google-Smtp-Source: ABdhPJwM6eXaNMTCDWTfwzTVXUSynuaytKF80a9i9i3UVlmeaBLBp1X4GnorHb5xvR5ZNpibnLyvyA==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr1237736wru.703.1642720839858;
        Thu, 20 Jan 2022 15:20:39 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:39 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] drivers: clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
Date:   Fri, 21 Jan 2022 00:20:20 +0100
Message-Id: <20220120232028.6738-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now define these clk in dts. Drop pxo and cxo hardcoded in the gcc
probe function.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index f6db7247835e..a4bf78fe8678 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3119,23 +3119,14 @@ MODULE_DEVICE_TABLE(of, gcc_ipq806x_match_table);
 
 static int gcc_ipq806x_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	int ret;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
-	if (ret)
-		return ret;
-
-	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
-	if (ret)
-		return ret;
-
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
 		return ret;
 
-	regmap = dev_get_regmap(dev, NULL);
+	regmap = dev_get_regmap(&pdev->dev, NULL);
 	if (!regmap)
 		return -ENODEV;
 
-- 
2.33.1

