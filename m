Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343AC491347
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiARBCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbiARBCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C47C06161C;
        Mon, 17 Jan 2022 17:02:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 15so39406800edx.9;
        Mon, 17 Jan 2022 17:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cf+P4bGd9tu17hA7rWQ2MKI9pQI9iWRAdtNFE5256nQ=;
        b=hNiKVFT6a1uEaLKDwH5eTkMXs+pdGmRvKQj7+xC5FNd5hyGW9eSBziEa/K9RYGIkG9
         fMYMtUan3uXfBqvBNDsFC3/BmSYMxXSQcShsxHi/Q8UduFBrON7ipWdu6UnWbWoVxh8e
         nT7Xi3MsH+dHZ0l84/PfsYFLJUGXuFOLpsYQ9VnIPrB72ko5o0V2phWCWTHYXeM7i5Pt
         Qjo81SQ1iMcY1VGNfR5scll8qzRSE1gKV37qUHAIEp/mRFWVNCzjyhnXh7oY9k2eigUi
         qukMKG/plYe6jx4dTyvWKEI7qSVx/IRANqXyAHQRI7ugLr20hXAH0brnVvvIP3aarZhb
         GKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cf+P4bGd9tu17hA7rWQ2MKI9pQI9iWRAdtNFE5256nQ=;
        b=Pfs41im4jckenrB5Au7CWp7tUKrn2dPxI7gM9c2lG+vh2GNI5BfqwGQwps2kKzQ4qN
         NK6sZZKjLwya0jsbzVfvcGjORYu1+ettcSeYvfXgeIf4vHTnBbQJoxGX8vwVRR9FsuOM
         +3rYyGwDXb4ra48IktiPKQOyqGS7oHDAuK5DzUJzual36SQxLBmXrzRZ+DZoTfoL0l7J
         YvCaqAoZpkhwO0GvBmR/NqMVk8iCd3O1nN4DEaXH/85TdqJhcU306JDxOM+0CbYTDcpw
         l4nAW1TA85fbB5BOIhf6gIFlV96i/0+ODBAI8xuUpiV39eETQ1EYP63N5PiLz2UqD5jz
         1dGw==
X-Gm-Message-State: AOAM532fJv5o5lSJxVHUTmsMnEqmNyWueJuhr0/fF0kW3rQenMWqrPk3
        mE3WAKsInORCF1yAnvwlwx8=
X-Google-Smtp-Source: ABdhPJyK3QyODMzR20rsrBpJ8qA/Jmi/N6HnkkXzEKhM0NWzz4+7/07L5SF8fohRNueWVgJpIxkEMQ==
X-Received: by 2002:a17:907:1b21:: with SMTP id mp33mr18157651ejc.580.1642467719093;
        Mon, 17 Jan 2022 17:01:59 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:58 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] drivers: clk: qcom: gcc-ipq806x: add additional freq nss cores
Date:   Tue, 18 Jan 2022 01:44:27 +0100
Message-Id: <20220118004434.17095-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
clocked to 800MHz. Add these missing freq to the gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index ce5654d3e937..d0c5441eb98e 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -242,7 +242,9 @@ static struct clk_regmap pll14_vote = {
 
 static struct pll_freq_tbl pll18_freq_tbl[] = {
 	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
+	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
 	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
+	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
 };
 
 static struct clk_pll pll18 = {
@@ -2716,7 +2718,9 @@ static const struct freq_tbl clk_tbl_nss[] = {
 	{ 110000000, P_PLL18, 1, 1, 5 },
 	{ 275000000, P_PLL18, 2, 0, 0 },
 	{ 550000000, P_PLL18, 1, 0, 0 },
+	{ 600000000, P_PLL18, 1, 0, 0 },
 	{ 733000000, P_PLL18, 1, 0, 0 },
+	{ 800000000, P_PLL18, 1, 0, 0 },
 	{ }
 };
 
-- 
2.33.1

