Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D755E480323
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhL0SAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhL0SAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:00:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7000EC061401;
        Mon, 27 Dec 2021 10:00:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i22so33604293wrb.13;
        Mon, 27 Dec 2021 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZQ7gHCQAZlakeETbiUb1MioVO2i5AohZAAATv78NYM=;
        b=PrHCsm0XE/g7kyILFqCoEKld6mssfEEGh0AbSwxZTlaIoxDoa+FussVbhdXziv5TC6
         LbG7qxPRXgniX84SeExqUEjNrJUdx5+5YTdXyUqLg9LbqF0v1YirchKYBlpFhZPOekn+
         sdL1DXEcBtSx1fXhz1OmGscxqU+siP1MxziUBVB4Ls/+kfBbCerm4ifjfn1gvMavchnj
         Jl1tzVl4qHkWXYNgDvUwDMkmN/d8/weUS/91uMArs6OFQhbOcAXIeGcei/MwJACs08zy
         galWcRcRBJdMHVs3yJv5/9d1vW7Yql4x32NvlKMV3yOQBB3GUufGc/PJK2ZjprQvSaF4
         z4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZQ7gHCQAZlakeETbiUb1MioVO2i5AohZAAATv78NYM=;
        b=h9dobSyxbosop1ObhxUIhDqe/V9zdrNRDAe96xKb7Hs0OwKCRTJu0yqiIqfj4Ry8Zz
         j3s/vwPFZISara27RcYLHKDpr6rQJnvDJVAJLkedsO8vCDKPyq5yzPrBhOhcQj1ML/bY
         Xl8ZfiNda9McTjQI8jmDRyX94l670XraEDa7zT6OGQmCi3NO833j0k0zNqOAPsFAGKsT
         CPb5Ck1LAyvC0+0pFISNeXUOz2LPHRNSYUvHuKPPDeuqAfOGr/IUJqauOM/NxAxkqn7T
         Uw6g2HhhcG+vS8Z/UQN+dYTYjGHNKQ40wonDCq9gl6pnmAC/HRMy9DdOJZlHqYVUQc7D
         izQw==
X-Gm-Message-State: AOAM531v8likNITS9x17ZuD1jU7+XsSNF1ro8r0/jqQOUxu1XEZySujW
        T12uxC2vuK4kTynXwjCip2r0BmB94Hw=
X-Google-Smtp-Source: ABdhPJwztOIQ+ohCI+e9b0xdHnsHB1yXoWTIDrywhAAv1mi1cNk/1YC13UuJgxs0uHI+hDja1E5MwQ==
X-Received: by 2002:adf:dc92:: with SMTP id r18mr13285103wrj.584.1640628042921;
        Mon, 27 Dec 2021 10:00:42 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4b2-f800-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4b2:f800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm18572946wmq.15.2021.12.27.10.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:00:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: Fix the UART device-tree schema validation
Date:   Mon, 27 Dec 2021 19:00:26 +0100
Message-Id: <20211227180026.4068352-4-martin.blumenstingl@googlemail.com>
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
- "amlogic,meson8b-uart", "amlogic,meson-ao-uart"
- "amlogic,meson8b-uart"

Use the correct fallback compatible string "amlogic,meson-ao-uart" for
AO UART. Drop the "amlogic,meson-uart" compatible string from the EE
domain UART controllers.

Also update the order of the clocks to match the order defined in the
yaml bindings.

Fixes: b02d6e73f5fc96 ("ARM: dts: meson8b: use stable UART bindings with correct gate clock")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index b49b7cbaed4e..94f1c03decce 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -724,27 +724,27 @@ &timer_abcde {
 };
 
 &uart_AO {
-	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_CLK81>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8b-uart", "amlogic,meson-ao-uart";
+	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_A {
-	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART0>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8b-uart";
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_B {
-	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART1>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8b-uart";
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
-	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
-	clocks = <&clkc CLKID_CLK81>, <&xtal>, <&clkc CLKID_UART2>;
-	clock-names = "baud", "xtal", "pclk";
+	compatible = "amlogic,meson8b-uart";
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk", "baud";
 };
 
 &usb0 {
-- 
2.34.1

