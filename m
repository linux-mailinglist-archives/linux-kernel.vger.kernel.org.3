Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894BF52680E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382854AbiEMRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382803AbiEMRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:16:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFDAE62;
        Fri, 13 May 2022 10:16:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2C9D51F463BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652462186;
        bh=a4rg/JyrfKEPVSNVifJkG8mIf7X7Pe0ajY4dp1vpzts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfWFvY/LXmYBQIPzMB7wxWUuxS6pAK8vApDF+K4NY2W+Ul10s0F1N8Z2HVG/akls8
         p4im//lbntV6csv9ohgvSXR3dNxOMGh/Yqm3r+0zTPXFDZDerhVGR9pm9NcaATYuNm
         izkpuaOCaD6epbiQ6Uc0fqHcnNfLkoqetDY8MBwdg3tdj6fwPH16s0yiNsXgom+2W0
         Gv1RRZwHaIDMHKH3GDiyKQVvz5R1+9HQ5kjGDx0cze0iM1Z0/M2VUlWyR+37NPEWof
         JJB59E1OrlcgnVIIVH2c6PrqiVxR8mFtiI4h0LVgwvJmDBhCLuzKCCfAL7UKEB16dn
         Gm1HPnQcylfgg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/7] arm64: dts: mediatek: mt6795: Add watchdog node to avoid timeouts
Date:   Fri, 13 May 2022 19:16:14 +0200
Message-Id: <20220513171617.504430-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least on commercial devices like some smartphones, the bootloader
will initialize the SoC watchdog and set it to reboot the board when
it times out. The last pet that this watchdog is getting is right
before booting the kernel and left it enabled as a protection against
boot failure: this means that Linux is expected to initialize this
device and pet as soon as possible, or it will bark and reset the AP.

In order to prevent that, add the required watchdog node as default
enabled: this will have no side effects on boards that are not
performing the aforementioned watchdog setup before booting Linux.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 639104b3f693..363fa25b4edc 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -188,6 +188,14 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt6795-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
+			#reset-cells = <1>;
+			timeout-sec = <20>;
+		};
+
 		sysirq: intpol-controller@10200620 {
 			compatible = "mediatek,mt6795-sysirq",
 				     "mediatek,mt6577-sysirq";
-- 
2.35.1

