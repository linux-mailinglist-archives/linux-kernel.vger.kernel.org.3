Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4D49D13E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbiAZR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbiAZR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7808C06161C;
        Wed, 26 Jan 2022 09:56:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so2231660wmb.1;
        Wed, 26 Jan 2022 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFG+KbiJy3wAWlhs/uVFVtW9rYrvfOZjzcLWJqCo1fo=;
        b=LYyV1sqt3V+CilRqHORvu19Q5iFoifflsAI9EMT7RgETKa7Z2l8g4937mrgt+k82J+
         iuHJfVJ5PWsUllglXHXUN0jeG3K5UUVqhgv8QwAFv/BqhG/Y00uaO6cCIWRzNQQnOpLE
         YwaG2WvSfGL9U6sUki1LSapJvKefEGNnxnE5hBLhQKM+SkVnbnIdF4m7xRz1ENtdTclA
         ZzLS0cQHqcFChNmw0C7TbO8C/oXQmZb6UZnLRhJhcpzODvIlDKS5aexCinO+6eNmJ036
         pe8m9lKtEUDSUWTP6VRllRw20ucUbIMSjaocu5KrFd5RMSH7SinvIfIY+iO3UnC9lQTY
         Z8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFG+KbiJy3wAWlhs/uVFVtW9rYrvfOZjzcLWJqCo1fo=;
        b=uc1B4lmfxDzC2olITv2HjKai4WKXxw0T0/fRMwd67ZbbrDQsu3eJrLnvFbrb0J49BX
         N+Cgw/DsZmOSlvDM5WQMUrbwI9qy/6mp+/E0od7TfYWiVldOvuis4zcu0sxuAlMG1A/P
         gpmSWug4cSGBmlGnt/i5YU7Gxa1lKfx0nB+J0aJeUf8ZPx71z8EN3/V/ZuBs+PoAQYhT
         5y8JRYHrVXjxY9mELyXiG/Rmrdwp8ZelEqSZ1Hr99RjPY9xDtoz0HjCthTVB+F1uXhsv
         eTjsnbche7Rwzv88TJY+dtoNX3fnqAq8BiBjWioSDnNg7a0K7iW/n8CaVgorfo7G/PFX
         HBQg==
X-Gm-Message-State: AOAM531xZ+fdnzy2zhhj6MR7w1Yoo+szHDhZG6WUjkxE7vbo78I2DiV8
        w+KABfHygZyoT/l7eWxIEpvc20oNq+8I8w==
X-Google-Smtp-Source: ABdhPJxHqVfmfSGZaYeB37u13ndBi5Z+7BR+fQsrn2XVjPF2K2i0Y0ubrbnTFZVE8oDxx0SY6LVa1Q==
X-Received: by 2002:a1c:27c7:: with SMTP id n190mr8431580wmn.99.1643219775988;
        Wed, 26 Jan 2022 09:56:15 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id 6sm21098983wry.69.2022.01.26.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:15 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] ARM: mstar: Add cpupll to base dtsi
Date:   Wed, 26 Jan 2022 18:55:59 +0100
Message-Id: <20220126175604.17919-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

All MStar/SigmaStar ARMv7 SoCs have the CPU PLL at the same
place so add it to the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 89ebfe4f29da..2249faaa3aa7 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -155,6 +155,13 @@ mpll: mpll@206000 {
 				clocks = <&xtal>;
 			};
 
+			cpupll: cpupll@206400 {
+				compatible = "mstar,msc313-cpupll";
+				reg = <0x206400 0x200>;
+				#clock-cells = <0>;
+				clocks = <&mpll MSTAR_MSC313_MPLL_DIV2>;
+			};
+
 			gpio: gpio@207800 {
 				#gpio-cells = <2>;
 				reg = <0x207800 0x200>;
-- 
2.34.1

