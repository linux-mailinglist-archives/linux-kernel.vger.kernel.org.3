Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF5561911
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiF3LZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiF3LZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:25:26 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 04:25:24 PDT
Received: from mail1.systemli.org (mail1.systemli.org [IPv6:2a11:7980:3::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC44F653;
        Thu, 30 Jun 2022 04:25:24 -0700 (PDT)
From:   Nick Hainke <vincent@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1656587878;
        bh=OPUPtfw6pfWCiR1mZeXscth6kv6xBVcFjag/DYVBL48=;
        h=From:To:Cc:Subject:Date:From;
        b=+YxJ4+G0hePqtaNyGs7JHJJs4ZP3r7h0fmuyqN6Ay4vISE+ON4aL0THp0A4D3Grdh
         ZvAZFqesoSjzk+112z1z2DWtAWQmdBvA7crbd49LvccUcHvY5AOls1G3BPnMwnC1rK
         H/47i+3HpRnh82uL2dUd8pAk/rPVT896dFniOkg3HwkALOdURiN/fNd7boQqfJZOqT
         WKDAu+wP3eP1b79Ds/wX9MXryytTjoBXSzBBq7Lu5DU3bvkt6vHXCNSeAou4zLUrDF
         rq9nm6/gCqwB1HaSLJagyLcXtw66K0wE0Q94IMWCSh040V7NFeuqIrJEmIenGZ3+oN
         PogK2koGz7ekw==
To:     linux-mediatek@lists.infradead.org
Cc:     Nick Hainke <vincent@systemli.org>,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mt7622: fix BPI-R64 WPS button
Date:   Thu, 30 Jun 2022 13:16:57 +0200
Message-Id: <20220630111746.4098-1-vincent@systemli.org>
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

The bananapi R64 (BPI-R64) experiences wrong WPS button signals.
In OpenWrt pushing the WPS button while powering on the device will set
it to recovery mode. Currently, this also happens without any user
interaction. In particular, the wrong signals appear while booting the
device or restarting it, e.g. after doing a system upgrade. If the
device is in recovery mode the user needs to manually power cycle or
restart it.

The official BPI-R64 sources set the WPS button to GPIO_ACTIVE_LOW in
the device tree. This setting seems to suppress the unwanted WPS button
press signals. So this commit changes the button from GPIO_ACTIVE_HIGH to
GPIO_ACTIVE_LOW.

The official BPI-R64 sources can be found on
https://github.com/BPI-SINOVOIP/BPI-R64-openwrt

Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")

Suggested-by: INAGAKI Hiroshi <musashino.open@gmail.com>
Signed-off-by: Nick Hainke <vincent@systemli.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 2b9bf8dd14ec..7538918c7a82 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -49,7 +49,7 @@ factory {
 		wps {
 			label = "wps";
 			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&pio 102 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio 102 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.37.0

