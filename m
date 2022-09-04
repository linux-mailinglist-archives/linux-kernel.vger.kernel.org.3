Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057765AC820
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 01:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiIDXhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 19:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDXh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 19:37:27 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844B2409F;
        Sun,  4 Sep 2022 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1662334641; bh=jLRdilnMCYu/2LORSkSSfxq/7hawIRimyy0TcaBVSdg=;
        h=From:To:Cc:Subject:Date:From;
        b=S0ySmocwO3hM9JxO7DVtM3BcsMOuVQiuSuyiUqAblDsNs3nMBXZz0MtnYh/iRZZlw
         7GBbCtHMg2YpaYHkUaAxJxRa2FNET3QbSWn8CuzwBBgHVbqtoCEwKakqKj1/4ZY1Nh
         GibpZNZcbt55iHvGPsOnwgTEhQC6T/UsbLlQO8f8=
From:   Ondrej Jirman <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Caleb Connolly <kc@postmarketos.org>,
        Arnaud Ferraris <arnaud.ferraris@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <n@nfraprado.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: rockchip: Fix SD card controller probe on Pinephone Pro
Date:   Mon,  5 Sep 2022 01:36:47 +0200
Message-Id: <20220904233652.3197885-1-megi@xff.cz>
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

Voltage constraints on vccio_sd are invalid. They don't match the voltages
that LDO9 can generate, and this causes rk808-regulator driver to fail
to probe with -EINVAL when it tries to apply the constraints during boot.

Fix the constraints to something that LDO9 can be actually configured for.

Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index f00c80361377a..2e058c3150256 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -253,8 +253,8 @@ regulator-state-mem {
 
 			vccio_sd: LDO_REG9 {
 				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1710000>;
-				regulator-max-microvolt = <3150000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 			};
 
 			vcc3v3_s0: SWITCH_REG {
-- 
2.37.3

