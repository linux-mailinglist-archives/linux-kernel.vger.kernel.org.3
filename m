Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4569E5B114B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIHAcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIHAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:31:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E09E8BA;
        Wed,  7 Sep 2022 17:31:18 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-158-249.ewe-ip-backbone.de [95.33.158.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C80AD6601F81;
        Thu,  8 Sep 2022 01:31:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662597075;
        bh=zj4EycsA2up3moyNszlj5tFIZU3qPDoqX2acH/vKHBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqAHrqA9bnNi/xWYAA7RBwzj7kJNvnCf6CJTxKzxNbAt59NrVBjnX3HIlB+/i0GWj
         lMxhfuZZpGIaJv0QffUBxlLkpSBuTgJLYHW0nym0aK5/AsHqrFJcgFdvp0oMuQu3lx
         kvSRKyk24RBVeUP55t0PXqs05PhpEUGVjxTnxPWr2/779kIEkRtzpNL4gKUSYgMCFk
         6s8wX79ITycTgRiW59nBV0koyY8e6T0fzCeL9osft0yh3Y9P7M/0nzkLFiA3TXQtNG
         UOjxHcRiNgBgJSZFwm/xpPQoqujoJm90E2gdlbim2eSM+6mVgNr8mXtOlLg08A/tLE
         Is4unmWXH89Qg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7BE90480835; Thu,  8 Sep 2022 02:31:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 13/13] ASoC: rk817: Remove 'select REGMAP_I2C'
Date:   Thu,  8 Sep 2022 02:31:07 +0200
Message-Id: <20220908003107.220143-14-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908003107.220143-1-sebastian.reichel@collabora.com>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the changed rk808 driver (it now can be used with either SPI
or I2C) a configuration without I2C is possible in theory. In that
case selecting REGMAP_I2C is not ok. Since the audio codec driver
does not really care about the regmap binding just drop the select.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 sound/soc/codecs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d16b4efb88a7..646494973cfd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1192,7 +1192,6 @@ config SND_SOC_RK3328
 config SND_SOC_RK817
 	tristate "Rockchip RK817 audio CODEC"
 	depends on MFD_RK808
-	select REGMAP_I2C
 
 config SND_SOC_RL6231
 	tristate
-- 
2.35.1

