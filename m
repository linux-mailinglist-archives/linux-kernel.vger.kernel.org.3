Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3646ED3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhLIQl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:26 -0500
Received: from box.trvn.ru ([194.87.146.52]:43707 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239658AbhLIQlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:20 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8940041F24;
        Thu,  9 Dec 2021 21:37:35 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639067856; bh=IKXmKvCFlWItZeQ+S4YnIO8PPn2o910X9uFp4aTBE+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZCmQ2WNBDgHvQUnHrFmWvrFwtiQ1M2QXZS8ZsDPTLP3+lhmvKRSwdej9thSxnEpH
         DtgyMv9edIkNn2biC790j05OjFb1UgCA9cZ8l5rFRrWHvM0vs3/3rmfbYVdciWyUpx
         YkZloMS//iWZovSbDWaRcZ7N9ztRtumLdVAUPIAo1Zvh2NW8dl1jaBEA2tVX+vqoyp
         ON5RUWO4HzqhY1le/SbN+1/obb2mmuAG0Cx0m9WnDIeaehgRNHt4gwvcWlMdYWd63b
         O8jJgFKTn55b90pJ/HgyKgkkI1Gl4hgdut4izLm7tU3EcZ7RAVFefMxtGR9GQg1HGt
         wSO/5pbOpcdpw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 3/4] pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed
Date:   Thu,  9 Dec 2021 21:37:19 +0500
Message-Id: <20211209163720.106185-4-nikita@trvn.ru>
In-Reply-To: <20211209163720.106185-1-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.30.2

