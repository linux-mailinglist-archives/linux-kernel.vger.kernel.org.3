Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43177480321
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhL0SAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhL0SAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:00:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A1C06173E;
        Mon, 27 Dec 2021 10:00:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t26so33655731wrb.4;
        Mon, 27 Dec 2021 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AifEVwl64n8+jB0pcjGlLMYOzYJ44R5sKYb/8MP+sB4=;
        b=c4ODpaquaFJ1vesePUF39r9v1GVlO1r76gUPCVX9vUqod4/vCG4Uw0nflrxboG961B
         ooT2tfUmpzsYQqS7PdPN1AwdvOkyh2I/tGLYIOi82uyMQL+0P2Evm43th/D913QTfTHP
         08BcsuIOcc7z9/xWRB5m+SOfUujCipq435CaHWnzl2jAur+Zx+eTL7ePsovNYX+TTD4o
         j0XvAZTjxxvDE4z17fdwp0OaZTfIaBw8pQOcOxbl1nFw8XaAfIzVvAn7S/O9YZR4SGim
         sC0XCWfbn0NA7b+0DCy3sMLa+2bwjJUWtz34dD88Gp7q5mztAdbleO3I6u1Ied4Xw/J1
         3cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AifEVwl64n8+jB0pcjGlLMYOzYJ44R5sKYb/8MP+sB4=;
        b=TI1o3nNpNWyouGprXxUN390m0YjUZOrjgMoAyWY3Ga4xC7QRkdEGRTc3tsC4FjQMqB
         zZjOeyAHe6XNnkVxKe9YVQQHMcsRjcqAYgqa21agt9PnbQcfGckrUWi0TuVHIpEH0xBB
         1ptl5RvPfuV0P3XKI0t6zvrzujkOMUE32TcrC6MuOuHY/d3vHftpYjVzJEdDbsd9xj/C
         /FMIs4t8mcmwMMBZB/s2YJRqcl7F42phbzYzIpED6krgs2tLt2kwwl6piQwGEEZh2HZE
         zSd/4nL2I8VHo3hvORcOkVs469xunNWWg1SwzI7Vad2mfs8QcPCp+Hra2DTelO73hjLC
         fAQA==
X-Gm-Message-State: AOAM531AZj6d10kI25vhJBm3NbFf3huJnJ0wIwE+4MEP2v3i0DZfw5Q/
        ozUzm+Pg6jGnmpWliQ0lbInfq/Qjaxg=
X-Google-Smtp-Source: ABdhPJyWwMW74S5bnU02w2MBV1shDTKIeHX9GvY/jJmgla2vz/DdH8PRpGgLn3sNuKlKuw3lvo6w6Q==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr13517205wrc.637.1640628042247;
        Mon, 27 Dec 2021 10:00:42 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4b2-f800-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4b2:f800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm18572946wmq.15.2021.12.27.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:00:41 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8: Fix the UART device-tree schema validation
Date:   Mon, 27 Dec 2021 19:00:25 +0100
Message-Id: <20211227180026.4068352-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt-bindings for the UART controller only allow the following values
for Meson8 SoCs:
- "amlogic,meson8-uart", "amlogic,meson-ao-uart"
- "amlogic,meson8-uart"

Use the correct fallback compatible string "amlogic,meson-ao-uart" for
AO UART. Drop the "amlogic,meson-uart" compatible string from the EE
domain UART controllers.

Also update the order of the clocks to match the order defined in the
yaml schema.

Fixes: 6ca77502050eff ("ARM: dts: meson8: use stable UART bindings with correct gate clock")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index f80ddc98d3a2..9997a5d0333a 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -736,27 +736,27 @@ &timer_abcde {
 };
 
 &uart_AO {
-	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_CLK81>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8-uart", "amlogic,meson-ao-uart";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_A {
-	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART0>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8-uart";
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_B {
-	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART1>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8-uart";
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
-	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART2>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8-uart";
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &usb0 {
-- 
2.34.1

