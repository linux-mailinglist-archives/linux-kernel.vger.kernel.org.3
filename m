Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034A459B3BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiHUMZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiHUMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 08:25:38 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Aug 2022 05:25:36 PDT
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34D23BE7;
        Sun, 21 Aug 2022 05:25:36 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id A8E1D4043C;
        Sun, 21 Aug 2022 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1661084377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+mX+E2U5Kj1obVCkKq6AgjmAmQIXffJWSfiqX88EuGE=;
        b=mPrTo19/zdfuuf4XSdUu3a9C83/V1IlITtVj2wWpXYYZN3TBXEOMtBRVOj4RKD7ppBr/Uk
        0I4VNR1Imj9BFqN+2LsE9Oa9Fw7Rih1GEJ0QqpvnKltCReCBNZev18dn4h4bAVPynni9hT
        elkbmT7JDNgkEiTv87smlhvUdvfP4no=
Received: from frank-G5.. (fttx-pool-80.245.78.134.bambit.de [80.245.78.134])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id D954580238;
        Sun, 21 Aug 2022 12:19:36 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: fix upper usb port on BPI-R2-Pro
Date:   Sun, 21 Aug 2022 14:19:29 +0200
Message-Id: <20220821121929.244112-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8810f431-9f53-4528-8e8f-6e28cf61227a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

- extcon is no more needed in 5.19 - so drop it
  commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
- dr_mode was changed from host to otg in rk356x.dtsi
  commit bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd
    operation of usb_host0_xhci in rk356x")
  change it back on board level as id-pin on r2pro is not connected

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
for hostmode to work this fix is needed:
https://patchwork.kernel.org/project/linux-rockchip/patch/20220708061434.38115-1-samuel@sholland.org/
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 5e34bd0b214d..93d383b8be87 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -678,7 +678,7 @@ &usb_host0_ohci {
 };
 
 &usb_host0_xhci {
-	extcon = <&usb2phy0>;
+	dr_mode = "host";
 	status = "okay";
 };
 
-- 
2.34.1

