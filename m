Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD444FBBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345990AbiDKMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiDKMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:13:39 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160406429;
        Mon, 11 Apr 2022 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649679084; x=1681215084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ihRXxFS8SkHT5FGn2iF3um7fIEpIDhvWzzhLfWwh4k=;
  b=aR6SR/c5cwAbNa5mBnT9xdkjMzS4qEj+Jj/EI+hFTtTCeeH4OZWRa66z
   84gSzkg0OcAYvpoKiUGzgjzsffbGfG9wtlAUfD3FJAd9FJpV+QcGOXFyu
   Qj8CBNoh8Wpigj+WPbx9vdAXyd0/OAfBtjEzpgHYtRzY3Bo/rx4W5aU6f
   i2OHFtgFuKMvsgkmJMWlRnSHFoimdioScW/0LXSPRGfXepslwTiy5WjmS
   sB0hxvPnoOJJ7lHstZvtDF8jg/9iNgau+yLa/LwMYg7bx29EWBdwr2Qzy
   CtWRgRcj6rdr8aoQ6s3/wCHliObgwt3cKoxcREWPRAiXNS75OmubvKBhj
   w==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643670000"; 
   d="scan'208";a="23222027"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Apr 2022 14:11:21 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 11 Apr 2022 14:11:21 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 11 Apr 2022 14:11:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649679081; x=1681215081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ihRXxFS8SkHT5FGn2iF3um7fIEpIDhvWzzhLfWwh4k=;
  b=T5Nish/2oK4T/TgyH1Tua8Txbe9CwgAcjMOsa9b8lQCpBLNGQdmCmInM
   2fYU5S4vcXWUj10xfzy3Cst076/B4J8s/ypx3flXw+y0rDpuvPBoxjogA
   q2lSpPg2rKLyV6vuWxRkw0heeHcktDLJ4qhbvs3Gol7wjQa5kL58QvJKv
   Rwdyyz159lUu36cyc5bRfHpGofnr5fVEoIutqF+XCtTA2viAB2X3CI0fx
   HIY48+AYgyYbLDxhN8k8LCMCDspwCp1PycRH/m++gwTaqwu0+UTc4//8d
   hJnlD+hXZHBz2EpupnJnlsq1fi4Ug4LlChlXVin/NOXVw/IdV6weobsN8
   w==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643670000"; 
   d="scan'208";a="23222026"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Apr 2022 14:11:21 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 9C134280070;
        Mon, 11 Apr 2022 14:11:20 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] arm64: dts: ti: k3-am64-mcu: explicitly assign UART base clock rates
Date:   Mon, 11 Apr 2022 14:11:08 +0200
Message-Id: <20220411121108.63436-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that (at least some versions of) the sci-fw do not assign the
expected base clock rate of 48 MHz for the UARTs in the MCU domain,
leading to incorrect baud rates when used from Linux. Use
assigned-clock-rates to fix this issue.

Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

I'm not sure if this is the best fix. Should the clock-frequency
property simply be removed, so the frequency is queried from the clock
driver instead?

 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 2bb5c9ff172c..69b0f127eea5 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -15,6 +15,8 @@ mcu_uart0: serial@4a00000 {
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
+		assigned-clocks = <&k3_clks 149 0>;
+		assigned-clock-rates = <48000000>;
 	};
 
 	mcu_uart1: serial@4a10000 {
@@ -26,6 +28,8 @@ mcu_uart1: serial@4a10000 {
 		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 160 0>;
 		clock-names = "fclk";
+		assigned-clocks = <&k3_clks 160 0>;
+		assigned-clock-rates = <48000000>;
 	};
 
 	mcu_i2c0: i2c@4900000 {
-- 
2.25.1

