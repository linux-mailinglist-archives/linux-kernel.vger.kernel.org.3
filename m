Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0234C31E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiBXQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiBXQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730561D084A;
        Thu, 24 Feb 2022 08:49:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so558605wrg.10;
        Thu, 24 Feb 2022 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+pQcjvXUZYutZ8wYJSMkNby1211eu2K9CyIndZSpmYw=;
        b=G3z2vNr1v0tkz3d0G87f+D0Mwg9JcO7sv9hU/dZiDPts9MkonoOnsQKdsO2X3gNwBn
         q8BN4DeX5/cie9sUFNj32dr1R/3RscVDbE7r47LZ46bcODUZ49lcUce56J5DjTaczApH
         57kZnIwek3U9dcKWO5ll0cgsuPP165f9gKYGFu0PUHGz+J/K9z+sJX/FgNXT/iQoU8pX
         bruVbg1X1JkbzlnTnGJLgLMOS7u/qK15BQkOTn/ycuyoAwx+KY6A6XyLUV1xghtR+SA3
         nKTjvsR6bUr0w6jBvXrUMFNa37zIFi/X7cG+xGN813dn0Kl1BanL+A5VwIeHVa+XcUM6
         q87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pQcjvXUZYutZ8wYJSMkNby1211eu2K9CyIndZSpmYw=;
        b=DEvONnMC6CyQyxttvTBnTBZZYx3Z46tx87xQIt5Vtma6R/EFFQBG/t6bY6EkNFYGqJ
         HV9HeBIdUyZ3ELsvcFMb9fYZurN2XiVlfjXmBw+zCX/Cx+idILFDrAOFc79Y7C+LBts3
         vR244dLEv/TMVi08uDRCMlL0JhZ51kOpWiC9Tx5eKjr7Fh01lOzfNwOhMqWOBUdQhNeI
         wfUBO803fDmX+PQp4E082IbFjaEgXjxbhmxv+OpzRx2HY9ETfWV9DIlW4t21i78AhCgK
         4LN2ab+kzLnBLvCWTdy3V1KMXVjYmqQEZM05fz3n4vw7U3PTB8XNXo+g9aUaL2N+Ft07
         O6dQ==
X-Gm-Message-State: AOAM530wH4JflGNYL6S8CdYfLDY6x6RVGXjqljlcYIXRjt+ztv/AK5z6
        MH658vAf85O5YIXD7h1cLrM=
X-Google-Smtp-Source: ABdhPJwRfabdIq5Zm6fX5U6G1F1XmgyujZ2n6yd5ZwTigQxnjU45JwD/J7220Q333qF4A6s5SxxIFw==
X-Received: by 2002:adf:d1e9:0:b0:1ea:7fc0:6625 with SMTP id g9-20020adfd1e9000000b001ea7fc06625mr2884330wrd.152.1645721341744;
        Thu, 24 Feb 2022 08:49:01 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:49:01 -0800 (PST)
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
Subject: [PATCH v5 14/15] clk: qcom: gcc-ipq806x: add CryptoEngine resets
Date:   Thu, 24 Feb 2022 17:48:30 +0100
Message-Id: <20220224164831.21475-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Add missing CryptoEngine resets.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 4c095f42eea0..8ec643164443 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3327,6 +3327,11 @@ static const struct qcom_reset_map gcc_ipq806x_resets[] = {
 	[GMAC_CORE3_RESET] = { 0x3cfc, 0 },
 	[GMAC_CORE4_RESET] = { 0x3d1c, 0 },
 	[GMAC_AHB_RESET] = { 0x3e24, 0 },
+	[CRYPTO_ENG1_RESET] = { 0x3e00, 0},
+	[CRYPTO_ENG2_RESET] = { 0x3e04, 0},
+	[CRYPTO_ENG3_RESET] = { 0x3e08, 0},
+	[CRYPTO_ENG4_RESET] = { 0x3e0c, 0},
+	[CRYPTO_AHB_RESET] = { 0x3e10, 0},
 	[NSS_CH0_RST_RX_CLK_N_RESET] = { 0x3b60, 0 },
 	[NSS_CH0_RST_TX_CLK_N_RESET] = { 0x3b60, 1 },
 	[NSS_CH0_RST_RX_125M_N_RESET] = { 0x3b60, 2 },
-- 
2.34.1

