Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BA251ECFD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiEHKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiEHKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:52:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD79B7E8;
        Sun,  8 May 2022 03:49:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g6so21892551ejw.1;
        Sun, 08 May 2022 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvBNJiZ8Rei9kCvvOCgcWJFVne61zQ3dcujbgkMHjus=;
        b=WJ+EKkRU5lf6p61s+aziGmHhhJaoN8V24tfbJBBUCaiVLPP6kf9ALBeiAk4rNLjpJ+
         U4TojXKkJz8tW8fkdWCrGTbu9MadVtzcCvzc9PfJZnpHUp5f2V7JoYCmZpt/eD9+catH
         qVsX8SjGXV6KocGtJdhZ1ChyHS1Eb9ToZQtIkiCIs2u1k7tGszYsQWAAmoxyowbUjI1y
         /ey/KZjxysEzLl82tegohB6JqjBXndkyBjaysmJFldQ/tYNSiPPOFHrwvtQZNfaMSf0E
         w5zk+2QV4EOr3C1f2KFC2XXe00zsqScxsIrmN2TjT6cE8I0IWFcAZwtFVJZ567BscUVa
         618w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvBNJiZ8Rei9kCvvOCgcWJFVne61zQ3dcujbgkMHjus=;
        b=KkRbZGYvnBlzbDhfWLS/KFIdU+yf3XZ/fV1+T071So6rq7KwuY64rq9voPiSqie1Vy
         lpfXOYgeQy83Mxwk1ZsJ4UtSDU5WVyHtOkFA45rMDceOOTC7yAD4dbPs3H0s5Tpu0NCO
         E/JcwL1QwvNeJgsi/4UWQzBV/8GxKvKJiz1NXq7GNS04BpVOFJm3Ej0g4oAB3LNPbkzw
         SHbqJvsA9rciOVMtlVtkcCIa1CVxkHWMAAipEWgQZDpw0vjVAkvfeqXVybkCMtyzdTXk
         lVigpu4lvK+bE7TCsPOnB+xr05F2O5J9LpkWsA+9cnu22QGaGU/q88lJEH6k3XcDd0NP
         NRfQ==
X-Gm-Message-State: AOAM530s2UG6d5rbtOGqlFfBTHOWvWtoqgBzeHeuiDkhZsvbL3LbE2rH
        mER3z8uA+Aw9bR6fPQ5u2F02+Ovc+cBBxg==
X-Google-Smtp-Source: ABdhPJyUoOXsFon979o9oEGdhhkSxghUylQHelWz44wXSsaJsArclcqfrG0uqSpjCjKbnWAIm5PtNQ==
X-Received: by 2002:a17:907:3da3:b0:6f4:4292:6d6 with SMTP id he35-20020a1709073da300b006f4429206d6mr9987539ejc.162.1652006940398;
        Sun, 08 May 2022 03:49:00 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:00 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 02/11] clk: qcom: ipq8074: SW workaround for UBI32 PLL lock
Date:   Sun,  8 May 2022 12:48:46 +0200
Message-Id: <20220508104855.78804-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

UBI32 Huayra PLL fails to lock in 5 us in some SoC silicon and thus it
will cause the wait_for_pll() to timeout and thus return the error
indicating that the PLL failed to lock.

This is bug in Huayra PLL HW for which SW workaround
is to set bit 26 of TEST_CTL register.

This is ported from the QCA 5.4 based downstream kernel.

Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL’s")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 1a5141da7e23..b4291ba53c78 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4805,6 +4805,9 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	/* SW Workaround for UBI32 Huayra PLL */
+	regmap_update_bits(regmap, 0x2501c, BIT(26), BIT(26));
+
 	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
 	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
 				&nss_crypto_pll_config);
-- 
2.36.0

