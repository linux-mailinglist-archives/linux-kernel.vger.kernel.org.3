Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6E482C35
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiABQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiABQ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94305C061761;
        Sun,  2 Jan 2022 08:57:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so17213963wme.4;
        Sun, 02 Jan 2022 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JpeJi0yBD942AUCHxsREdLSnIblSWTMYzLY8RDVTEU=;
        b=gYiQJr9qOZfUgO3rCKc+/aCbfxKPV3OS+qhOj4d7Tj12PBcldY8C4aO+PoW9K4p935
         0TQgy/b+/02G6cDsLdsUjrPF2F0KrhxEfT2hgAsfPCX8WV+h4A7UJEgdW3yRL/vShFpv
         LWogpGjXC5OxxAOW5oYKVd+/jaicjL61SaqgtqEZ12qNBBfCRvvL8sIyaSnPw6y6O5fN
         d5LLtQlPmGl04LPPDPurbTm+kJ3pyWJOjrwDkrF4AElYTdeV/59BckqGDdTcGP5fRUxH
         YWH1Nb8/7qca/V185BJCBFCUSRkIp+uFAd0yytDmzPqEW49wmXi0/PEQ5pUDDZatdSdP
         sLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JpeJi0yBD942AUCHxsREdLSnIblSWTMYzLY8RDVTEU=;
        b=eKWNy5Fgnox59JTCajRc9fZQHKKOe7ChTRuc8T8PxCEKpnRyhrhUeCuV1uLWUvN2q+
         M02ZX8NV8ahy2rvPA5H9ihD87rO+QwMXz5bXoR95x06RShotdAt8KWYK4gnM7KjtshXE
         6tCbh2czBSWIMeWLyvjTVmz9YYhvEU34ki079528+QcMryPtUo/UTdkqmcW4oocHMmlT
         qDbK5IEQnrXcU+0vO6GqpQB//f96lVIACCwN0tMBc7k5qk8G7BvTpCyZuBoPXqmpdD0y
         //X1KMlHyHde/EqAIDtdyI7CG+ZzWvfP0q/NbP5Oq8Y4sSdvsOZ5vfCR3heF+KF91tdz
         whiQ==
X-Gm-Message-State: AOAM531pt26lZzXdU7Xs8AnxVD9MKOjMmioZ8KWSMDZH1sMxtxZGIe1S
        71qJDf87UusPyajEpwgXaXkCXtG7MB5i9w==
X-Google-Smtp-Source: ABdhPJytsMoKEXSNH/cIPbIMvFJtaeNzmKn21Hbr+6f0Cy8+YgR+2GlCQxMZo7+dn35Jsadqow94sQ==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr36751205wmk.11.1641142657899;
        Sun, 02 Jan 2022 08:57:37 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id y11sm32899848wrp.86.2022.01.02.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:37 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] ARM: mstar: Add cpupll to base dtsi
Date:   Sun,  2 Jan 2022 17:57:24 +0100
Message-Id: <20220102165730.50190-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

All MStar/SigmaStar ARMv7 SoCs have the CPU PLL at the same
place so add it to the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
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

