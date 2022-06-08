Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297DF542993
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiFHIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiFHIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:31:04 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FAC1CE7B8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671960; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bvBVBp311UrrA3YEXD3M4S9ESkLApb49rsbhfGG8twXJaPM5FGXZEuIkyjKV/qliv4jDa9vpL2y3P8sWLD3CTijGlUjH0N9FLel+k0IdcwWZ/mS1oauxGgIr/5MA62+ilVBZVPReB88NbzKPmtaBQrwTOpDwNa+qlhmCKH3MeVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671960; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bwLNTfaNNmXUu3sy1HadN8NYZVEx7VSfxP8UHGZMLLA=; 
        b=fmnIHZUjzhMAZTajRK/wUl5YYDW4NxfsHfCceBaEcGVQWhduF4H+9MHWuQcA8EbYm3qHiJy7WQjAMCoiau68k3TCFQdm1zOwpsRhm5TYDTgsBeoKKpv0CVvCXsqGNeDB3jatLlI7trDtrWR2YDQ4OCEhtgP3WwsjXVFzF70x4D0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671960;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=bwLNTfaNNmXUu3sy1HadN8NYZVEx7VSfxP8UHGZMLLA=;
        b=GXTl4vKL53A4jWqTuURNFn9gezZrfZok8N+u7O9RFmYEcm8rNb8uSOP6nof9hn39
        8qx6fm11SglYz3ThP5ObLBlFhH8O16B76O29CmNhVwrcN3qrLzbL+G5NJ2z0qnACGsg
        8kxyu7p/svDe3nUba14D6n9jW11+Wj6JVuecp0jo=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654671958834763.4225983678638; Wed, 8 Jun 2022 00:05:58 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 7/7] ARM: suniv: f1c100s: enable USB on Lichee Pi Nano
Date:   Wed,  8 Jun 2022 15:04:52 +0800
Message-Id: <20220608070452.338006-8-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220608070452.338006-1-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Lichee Pi Nano has a Micro-USB connector, with its D+, D- pins connected
to the USB pins of the SoC and ID pin connected to PE2 GPIO.

Enable the USB functionality.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index 04e59b8381cb..1935d8c8855b 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 #include "suniv-f1c100s.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Lichee Pi Nano";
 	compatible = "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
@@ -50,8 +52,22 @@ flash@0 {
 	};
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpio = <&pio 4 2 GPIO_ACTIVE_HIGH>; /* PE2 */
+	status = "okay";
+};
-- 
2.36.0

