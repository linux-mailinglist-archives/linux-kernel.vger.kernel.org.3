Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D164BADAC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiBQX6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:58:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiBQX5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6941FB9;
        Thu, 17 Feb 2022 15:57:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id x5so6814236wrg.13;
        Thu, 17 Feb 2022 15:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v/5XpP2o4oras0yfl9rRpfS7wlw8o3QwJIwjKKbzGZY=;
        b=B8XMvom0WsbQwAR5Ksu2mBaZrtdaAaDLk/mRLPLajgGpUXZplL7eV620pIrY0aNN8O
         0fwHzvHufrTdzSq7QYyARav9Zt21UgAW0JTAXjFAnjGjXFg3FjGC8uXMdxXo06TauPdA
         P23/Q/9pJNfBzkh7UkXWG6uTdBrs95xWGXrP+QO7WXtYRNsI8Zbs7VE2druKPimYY0+Y
         yjZjw+pg8id5MBGi8fF5KvMiJiUt9jGt0jzbJZRIAeW5sDXFWr0aFpFbN9ywl6LcFXpp
         ZDfvGFObHW1KdPlP+O36t+w1jIOXmtq7ZmpLYCM7hQ7VS5WQ4gfP4SKQrW7Q703Sz7cO
         3+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/5XpP2o4oras0yfl9rRpfS7wlw8o3QwJIwjKKbzGZY=;
        b=nRVa+F0b8oY6LfsN1CPUs6jwHMqE2JVydJ8LFO1GJ8b7H5mk7714IwdmS6ZSfgtHVe
         iAb2RNsBrSHrGWt9vk5jzCQAsptDNqqNX7+md+Q9V6jaQuqjBykvFS4zPBUp00LIt6KA
         SpmyLir+cQ4JcUMZqXwDA4FzBq1PHGixJ3dxzE5lMok+EcPVy7jF2tvALF5nM6Df0pu9
         u974RKwQxn4qhiffGjCtNyUcUxoG4wbJ5DkHbS7I7y/VOZfWvvTa2tc4rZKBZTRCYWi7
         rMILT2rXsgEZ6kHUy9wFqQIVF4UGn6/2agxK2O3iaSDoCMf8Sn6z8FKrCvwGC0xOYA6U
         WC9w==
X-Gm-Message-State: AOAM531VL8PwwdwCIWxrHERqDLF1CtQt9qVEOhbIpto0E1QInHygAvdk
        tKT0xLE5Gn+Iuogtv/whsrg=
X-Google-Smtp-Source: ABdhPJxoaCVq2/xXwgrZl0Xo9LbuYrYYxbdj0AxfnoyWPBhLztPxCRgWYLKEURCxJ7OLKAPrks+EJQ==
X-Received: by 2002:a5d:6b86:0:b0:1e3:2862:d5d9 with SMTP id n6-20020a5d6b86000000b001e32862d5d9mr3936167wrx.493.1645142231416;
        Thu, 17 Feb 2022 15:57:11 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:11 -0800 (PST)
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
Subject: [PATCH v4 08/16] clk: qcom: gcc-ipq806x: add additional freq nss cores
Date:   Fri, 18 Feb 2022 00:56:55 +0100
Message-Id: <20220217235703.26641-9-ansuelsmth@gmail.com>
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

Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
clocked to 800MHz. Add these missing freq to the gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index a4bf78fe8678..53a61860063d 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -232,7 +232,9 @@ static struct clk_regmap pll14_vote = {
 
 static struct pll_freq_tbl pll18_freq_tbl[] = {
 	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
+	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
 	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
+	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
 };
 
 static struct clk_pll pll18 = {
@@ -2702,7 +2704,9 @@ static const struct freq_tbl clk_tbl_nss[] = {
 	{ 110000000, P_PLL18, 1, 1, 5 },
 	{ 275000000, P_PLL18, 2, 0, 0 },
 	{ 550000000, P_PLL18, 1, 0, 0 },
+	{ 600000000, P_PLL18, 1, 0, 0 },
 	{ 733000000, P_PLL18, 1, 0, 0 },
+	{ 800000000, P_PLL18, 1, 0, 0 },
 	{ }
 };
 
-- 
2.34.1

