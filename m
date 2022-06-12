Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82896547A9C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiFLPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiFLPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:00:53 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361149F85
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:00:33 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id A090E4B00F;
        Sun, 12 Jun 2022 20:00:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1655046018; bh=jp2x8yViozN+IlCDICU84cGBy/PA8CqFPQjOLcNghP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vV3m+5K8dSKvmJj7/SUdo6ffKiYXkTXdUrysE7DsUPQtw1doZEwx3DXzAceZjSbv
         Yn5/pATx4Wy9h2DJV+9xv5YbFqJClpyiggKQCOn9NWuz6fyLTlkahiQXtP+/b1HI16
         Ror6F0itvSyCAmMXuXH1MoqSrrA4gQszRZRg3V1iWa2iTC8gnY1pwDuYESpPoPHVLl
         9Ssm8YpDMUwWu0sr2BbiFcPIgh8QClI+639yhrC4ooPbBFeb8YavbLjObNYo+pKKTB
         xsi1x4dtvjQ8ECEmkTewlB6/+y7qXK+ptd1YXiuEB1DJr5R+3NTzC1/siWHDAhI27t
         2hj5Z05qy8T+Q==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 3/4] pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed
Date:   Sun, 12 Jun 2022 19:59:54 +0500
Message-Id: <20220612145955.385787-4-nikita@trvn.ru>
In-Reply-To: <20220612145955.385787-1-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO 31, 32 can be muxed to GCC_CAMSS_GP(1,2)_CLK respectively but the
function was never assigned to the pingroup (even though the function
exists already).

Add this mode to the related pins.

Fixes: 5373a2c5abb6 ("pinctrl: qcom: Add msm8916 pinctrl driver")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/pinctrl/qcom/pinctrl-msm8916.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8916.c b/drivers/pinctrl/qcom/pinctrl-msm8916.c
index 396db12ae904..bf68913ba821 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8916.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8916.c
@@ -844,8 +844,8 @@ static const struct msm_pingroup msm8916_groups[] = {
 	PINGROUP(28, pwr_modem_enabled_a, NA, NA, NA, NA, NA, qdss_tracedata_b, NA, atest_combodac),
 	PINGROUP(29, cci_i2c, NA, NA, NA, NA, NA, qdss_tracedata_b, NA, atest_combodac),
 	PINGROUP(30, cci_i2c, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
-	PINGROUP(31, cci_timer0, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(32, cci_timer1, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, cci_timer0, flash_strobe, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, cci_timer1, flash_strobe, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(33, cci_async, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
 	PINGROUP(34, pwr_nav_enabled_a, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
 	PINGROUP(35, pwr_crypto_enabled_a, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b),
-- 
2.35.3

