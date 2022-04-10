Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411FE4FB0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiDJXCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiDJXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:02:37 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB21835A;
        Sun, 10 Apr 2022 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=qWl2Mn2dgNw5/xL1kBPYx11jQuGzlGIXV7NZL9/oICM=; b=UL9lELEKVxByJLvZhjCsj39PtB
        yW1RyKZtT4AQBKso9lya4nFexHKr92ehuRDpdqU8pr87ZjhRE2Rbpn0+c2swJ9mPPOgvcwLEOTlvt
        EHqVgEfnwYXajyhWMoMJY0L9+nKIUXvq1vh5qNDgXsQc/MZZPXvkbo6C92l0vPm577Rc2nIr8tQoi
        X3WMFE3gEL+oxxvj306blQGjD+XVm0n+WDCcap0ahxG/J1m6Ik0Uj+ui8/fZcHRBIFyzOtxi3NK1W
        etsaEKvYRF3MfxO9KSQ5uKj4wG9QU4zGChZk3x0z8nHiuB/piK+rns+Vbr4O4mNm5ETt9C9CAmoLW
        TIwOLWTQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ndgXe-00BKdE-Pr; Mon, 11 Apr 2022 01:00:22 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.95)
        (envelope-from <aurelien@aurel32.net>)
        id 1ndgXe-000ZMn-3l;
        Mon, 11 Apr 2022 01:00:22 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, soc@kernel.org
Subject: [PATCH 2/2] arm: dts: Enable device-tree overlay support for RPi devices
Date:   Mon, 11 Apr 2022 00:59:40 +0200
Message-Id: <20220410225940.135744-3-aurelien@aurel32.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220410225940.135744-1-aurelien@aurel32.net>
References: <20220410225940.135744-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the '-@' DTC option for the Raspberry Pi devices. This option
populates the '__symbols__' node that contains all the necessary symbols
for supporting device-tree overlays (for instance from the firmware or
the bootloader) on these devices.

The Rasbperry Pi devices are well known for their GPIO header, that
allow various "HATs" or other modules do be connected and this enables
users to create out-of-tree device-tree overlays for these modules.

Please note that this change does increase the size of the resulting DTB
by ~40%. For example, with v5.17 increase in size is as follows:

  bcm2711-rpi-400.dtb       26481 -> 36830 bytes
  bcm2711-rpi-4-b.dtb       26537 -> 36886 bytes
  bcm2711-rpi-cm4-io.dtb    26426 -> 36945 bytes
  bcm2835-rpi-a.dtb         12641 -> 17852 bytes
  bcm2835-rpi-a-plus.dtb    12765 -> 17976 bytes
  bcm2835-rpi-b.dtb         12763 -> 17998 bytes
  bcm2835-rpi-b-plus.dtb    12979 -> 18263 bytes
  bcm2835-rpi-b-rev2.dtb    12847 -> 18131 bytes
  bcm2835-rpi-cm1-io1.dtb   12839 -> 18113 bytes
  bcm2835-rpi-zero.dtb      12681 -> 17924 bytes
  bcm2835-rpi-zero-w.dtb    13135 -> 18430 bytes
  bcm2836-rpi-2-b.dtb       13687 -> 19255 bytes
  bcm2837-rpi-3-a-plus.dtb  14133 -> 19740 bytes
  bcm2837-rpi-3-b.dtb       14310 -> 20006 bytes
  bcm2837-rpi-3-b-plus.dtb  14670 -> 20474 bytes
  bcm2837-rpi-cm3-io3.dtb   13680 -> 19266 bytes

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/arm/boot/dts/Makefile | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..85644149de44 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -81,6 +81,24 @@ dtb-$(CONFIG_SOC_SAMA7G5) += \
 	at91-sama7g5ek.dtb
 dtb-$(CONFIG_ARCH_AXXIA) += \
 	axm5516-amarillo.dtb
+# Enables support for device-tree overlays
+DTC_FLAGS_bcm2835-rpi-b := -@
+DTC_FLAGS_bcm2835-rpi-a := -@
+DTC_FLAGS_bcm2835-rpi-b-rev2 := -@
+DTC_FLAGS_bcm2835-rpi-b-plus := -@
+DTC_FLAGS_bcm2835-rpi-a-plus := -@
+DTC_FLAGS_bcm2835-rpi-cm1-io1 := -@
+DTC_FLAGS_bcm2836-rpi-2-b := -@
+DTC_FLAGS_bcm2837-rpi-3-a-plus := -@
+DTC_FLAGS_bcm2837-rpi-3-b := -@
+DTC_FLAGS_bcm2837-rpi-3-b-plus := -@
+DTC_FLAGS_bcm2837-rpi-cm3-io3 := -@
+DTC_FLAGS_bcm2837-rpi-zero-2-w := -@
+DTC_FLAGS_bcm2711-rpi-400 := -@
+DTC_FLAGS_bcm2711-rpi-4-b := -@
+DTC_FLAGS_bcm2711-rpi-cm4-io := -@
+DTC_FLAGS_bcm2835-rpi-zero := -@
+DTC_FLAGS_bcm2835-rpi-zero-w := -@
 dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-b.dtb \
 	bcm2835-rpi-a.dtb \
-- 
2.34.1

