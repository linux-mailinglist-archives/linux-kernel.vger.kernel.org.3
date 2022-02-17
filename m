Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6214BADBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiBQX54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBQX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA44B45ACB;
        Thu, 17 Feb 2022 15:57:11 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so11733716wra.0;
        Thu, 17 Feb 2022 15:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/V/kNjo2cNdyMkfWAxfbV6ANoJYgo5xv7ELjtCpU5fI=;
        b=DrkRZpSmjzSXrnd3CbnwFATkW8xTqv5F1Pr2VopaxSAGi/R27151itlig8q0QPRET+
         4Ff9rJYgrspEPCC7BEW0u5YBZ8fsBA8v8iDJLosQochWiJ71NrBet204RiwYFsj5zQ/8
         He35P+0xMJjyx3sZnZz5M30Bf3JmGPvhi/QVvV4ZhTEc3P8KxZJRsdPSuRMr3wWxYSm0
         DYKXm1PhKr8WOFHOj/0R4HeTFt1v81fDAuUbV46pDiW0ssKyOEDYgyPir+0ZtLOdYPOZ
         hl1TAseWbXhuHQo+P7/d0mHZQL8+pgnj3qONxAMvEYiXLLu4FV23DRmJL6XxpYn2sBUI
         9u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/V/kNjo2cNdyMkfWAxfbV6ANoJYgo5xv7ELjtCpU5fI=;
        b=VcsnWIdL58q+Ya0Dadp5tT4MoCaXUI+aJyHFnAgvIcjfnuFxZUw/AoNYFLmPvKRBWd
         CIMEDb/v56ep+YDzABDnIzwZFwfQxMz7zXRbrOnWcTSxZru7/cfQqyJzl3XRSKnGyGPU
         vZvubZ1BYVz/bRSpFDUZcWOP2HY/bMp8l8hzJeLGSFnhzMXiaB6UV/2mlYmtOwv2y9l0
         RZKWlVwKYRPJAfBDkCpnw/311UgrwIO1v8Nt58VZxbfmlLW70VK29k28GYoV6cUtu1Vu
         DXzTflll9DsF2VyRZDZrIQpAEls8DJVOd2A8c81XrfksUwopmPJeIa2rF3bLQ//oNJeT
         73zA==
X-Gm-Message-State: AOAM533Ot+MgLVMqtkObjarSgXxj7XrJTTiVQAKv56XCTB8VicwSAZ73
        idBdWTH2opj/JxM21AHGTbI=
X-Google-Smtp-Source: ABdhPJzxMiHyu782VQqey05LPGKayaQ00ylGROpUu37P8TVY3q4vQaTEHIhECARuSbX3V6uzJg5UQw==
X-Received: by 2002:adf:d182:0:b0:1e7:a7ea:37b4 with SMTP id v2-20020adfd182000000b001e7a7ea37b4mr4103827wrc.631.1645142230367;
        Thu, 17 Feb 2022 15:57:10 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:09 -0800 (PST)
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
Subject: [PATCH v4 07/16] clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
Date:   Fri, 18 Feb 2022 00:56:54 +0100
Message-Id: <20220217235703.26641-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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
2.34.1

