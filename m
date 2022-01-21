Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC04965C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiAUTgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiAUTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D88C06173D;
        Fri, 21 Jan 2022 11:35:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q22so1506281wrc.5;
        Fri, 21 Jan 2022 11:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBkuRgwe6wjN8B0dWdq4qTtmz/vmICR+ObQMfngMweY=;
        b=O9JyzuHxsKOFunpzLm1NYXhbGQa+ChfNsd5JWvOX1nyic3o+BdNjoHrCWDNqYzAl4M
         LfFFoWvm8LKZyZjppzTfSytupqohwTAayMTqzC4cve5IFWjCIO5HJoCdLEMkokywfa1O
         8qpUdG/AxUgcjnNP0zCUHuTujGd6LEbTHwJT103aAiH0AX/ukX6aKls9RFzu06E2x5LE
         QuA2rSsoUYLcwm2eHwZgZDwua9K76EeFKhMgqJTorQE2AG5LJIXdQtfb3px9dwtdZOI/
         3UvDUkkogf/rprv5ZC4TzGqJpswbE9mcwlozOyzsuwmf/rM84Kfp3E8QGXicgkQw3M0R
         Hc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBkuRgwe6wjN8B0dWdq4qTtmz/vmICR+ObQMfngMweY=;
        b=kXsYi6JarnIKS4xe9YySTtqBSmJi/MFHLm28Cxd9h3AXo7DU2TWYOtMeHU5XN/7VDb
         0AHk1VJA7bS5PcRi98+PyVGHZK8x1IuXJVdTaS75WwsHUERx2uwrBFmiumqkb6A9DWaC
         llcVNLhQJoH3qSguCShGMEX5Dj5coq5c3ydBtuzNz+dF1S2rh/dLe0pqVcEgr35eIFDN
         MbLwSXhHMiNqZrkDBtnyo+QSInH0NvWmbuujDsHoyo1phY43/lfjKJLM82JjU6PXUDlV
         LPGMWINNJkgvnBUs4XwdRrcMTKNPQzbxxFxrm4FXtS3vIe4qez6Y2IY4BE47xHf2ekMC
         id/g==
X-Gm-Message-State: AOAM530D52fiJMvjbakOKipXbtCuuX2DuQxmn6FPlpa6uDdf+mcRSUu7
        BSRv9VEY+MS405MputRr85w8C3WBXkAsww==
X-Google-Smtp-Source: ABdhPJy1LaVeyY+Ot8O5P3cv87hxYyzBFU4XK/HMU1KkSa+tiFmuEgPZ54IgF+1VaedIe+Ar6XVxfw==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr4770121wri.682.1642793754716;
        Fri, 21 Jan 2022 11:35:54 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l6sm8685539wry.75.2022.01.21.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:54 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] ARM: mstar: Link cpupll to second core
Date:   Fri, 21 Jan 2022 20:35:40 +0100
Message-Id: <20220121193544.23231-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The second core also sources it's clock from the CPU PLL.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 6d4d1d224e96..dc339cd29778 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -11,6 +11,8 @@ cpu1: cpu@1 {
 		device_type = "cpu";
 		compatible = "arm,cortex-a7";
 		reg = <0x1>;
+		clocks = <&cpupll>;
+		clock-names = "cpuclk";
 	};
 };
 
-- 
2.34.1

