Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5C4A00E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350960AbiA1TcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:32:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:35031 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiA1TcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643398318;
    s=strato-dkim-0002; d=ko-hh.de;
    h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=5YlNcTtCJN5n71TbHMcDEInsEHXP0BHMHEC9kJEYAL0=;
    b=RNeiht6tPzmjXga6Dpf/Wv58kWRF/AW13caAhmU6RLT64A5TUYC+PKfnQB4EK6gvJ4
    SXKI3eMNMzeKQP9hvKV2C9YOULI522sq7ZYQ0gaswjpEP9/PI6/1WnG0wT9Bqt+LeVsV
    E9Hw7JZzcL2hd4XlZvQKo6gdZLLJXTDU10fgbYwFX3kkfeEWkBs7/Rfs6lLmsrQf6FbY
    gThDqfp/3Geyl4rOfT+HG08vNWk2GYKh86iHC3ynScqwmhkNZUAxIwV8yq8332Y3F8sx
    4I3VZJNhVfR8xnpZYTQ5hH90TPwnN7SsejLEMvrfPVowQarSTBU366nspbC89w2mWRSf
    c8gQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OGQBeUWjaN+znm36YqWmJEx4lU5vgP4am+jDJsl40KLIzDO7mhvQTIqgxZ0NBW/c2w=="
X-RZG-CLASS-ID: mo00
Received: from odroid-VirtualBox
    by smtp.strato.de (RZmta 47.38.0 DYNA|AUTH)
    with ESMTPSA id L5f488y0SJVvxCb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 28 Jan 2022 20:31:57 +0100 (CET)
Date:   Fri, 28 Jan 2022 20:31:50 +0100
From:   Lutz Koschorreck <theleks@ko-hh.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1-odroid: fix boot loop after reboot
Message-ID: <20220128193150.GA1304381@odroid-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the correct gpio pin is used for enabling tf-io regulator the
system did not boot correctly after calling reboot.

[   36.862443] reboot: Restarting system
bl31 reboot reason: 0xd
bl31 reboot reason: 0x0
system cmd  1.
SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:B;RCY:0;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
bl2_stage_init 0x01
bl2_stage_init 0x81
hw id:▒SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:B;RCY:0;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:2;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:3;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:4;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:5;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;

Setting the gpio to open drain solves the issue.

Signed-off-by: Lutz Koschorreck <theleks@ko-hh.de>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index ed7cd5f53046..ddb1b345397f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_5v>;
 
-		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.25.1

