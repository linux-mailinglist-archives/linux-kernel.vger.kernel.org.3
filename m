Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE146A4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347430AbhLFStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:49:20 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:33057 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229657AbhLFStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:49:19 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 13:49:18 EST
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud7.xs4all.net with ESMTPA
        id uIskmTAN7gFRtuIsmmHMCh; Mon, 06 Dec 2021 19:38:38 +0100
From:   Mark Kettenis <kettenis@openbsd.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     maz@kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: apple: t8103: Expose PCI node for the WiFi MAC address
Date:   Mon,  6 Dec 2021 19:38:16 +0100
Message-Id: <20211206183817.31964-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLzBkhflzirjAqU5L80rOkYbJiqkAbBbLXNB1x5NfPSHKK/cQtfwEFaFyoV+7wSDyG9WTwmO25vPegnwtnaWg/NWH9QtDPBrRJ4NMlT/RdYeTMPTRhjA
 eRhCSLsT4OoqaVLLp7zzrHd9OrTaCUtBP5V0CVaOl5B91WJpz0SHSC5OYfQhlyFp7a/b/cZuhTGBiumDI+34B0N0EtUH9KQ9KgGdaGL/FtLbSWvHiuyxy+si
 yE4U/MvwSo3JX5Z4K4iQDOgMlr/ksgNTiJYMWBm1xiTKp2K5IelnHEhtE4qTXORXeHFzaOl2dHwDF6ZRYC7MMvaOs5lueHRmHlZ1ZOLEeenBstj1uO02KcJj
 4gvCWfXbA2NtH2NwPSFtl+JrMfq4b1H0VPe7553KVCMQH/tG3Q+1jvq3qsZyAndpWtJsZ9WeuSuKIKdqAXCTYxzYRH7yKivr5l0AQaB7dGoo004kZCv3stWu
 nRcNsnNjpfv7G4Y2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the PCI node corresponding to the WiFi device and give it
a 'local-mac-address' property. The bootloader will update it
(m1n1 already has the required feature).

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---

This change is based on the asahi-soc/dt branch since the
t8103-jxxx.dtsi file isn't present in 5.16-rc3 yet.


 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index 876278fe0afe..acad6afcb1d9 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -12,6 +12,7 @@
 / {
 	aliases {
 		serial0 = &serial0;
+		wifi0 = &wifi0;
 	};
 
 	chosen {
@@ -64,4 +65,9 @@ hpm1: usb-pd@3f {
  */
 &port00 {
 	bus-range = <1 1>;
+	wifi0: network@0,0 {
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 00 00 00 00 00];
+	};
 };
-- 
2.34.1

