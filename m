Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C449C2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiAZEuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiAZEuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:50:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A920C06161C;
        Tue, 25 Jan 2022 20:50:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v13so23545187wrv.10;
        Tue, 25 Jan 2022 20:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stznty7HVe/pzQfdeViHDJ1kDbJwUgBbrg0lxMVpxdA=;
        b=IqTBmOSMUo97L7KuoUK3kfpVMK590nOjpPaGAgSqlwz6OTDuXfxs7zW/VUdoQwsSE4
         zJLDECQ6EDo3kw0kwJG0WxigKWFmbLkQKm8Bv5a1FMrHs7BmnB8bCUEFE3Nr/Qq1kddT
         QeCzqd4TNDQAYKY9AtFef4sLsPy06TuRNvLQduCRAJ83FBJ0w+TXbOtwtrtocpGE74PD
         5NfHvS0sU9E3v/1cst44vthFPEHgXkaFWE+j/fuBzE9ndCw2F9xGmyv6rxWeQgJFy6lk
         01ZbIHpQaZE+TAd0EnDw/ylZqrSaAWP0Vtab53HX6wYOE7l1hTCt/3V0tuE74EHkWKDX
         IyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stznty7HVe/pzQfdeViHDJ1kDbJwUgBbrg0lxMVpxdA=;
        b=uJS0Tj9lzuI0/PJLBf9PVWKxoZeI5tsvxrz/6hRUclwW9RG4z/O1mszN5S2N65duFy
         mFncauFvkgdog7Y8GxWO4nwKCQIhSPVoDlvqRx/JmY9nVpQuXmzSBldFZdN67xdkt/uO
         gRjEgfBWZWIDtfCmawFz7bgXuOGR6fYLBTprcyZHshIvyBweMHZbecJGsit685NPWU36
         upN/jQtwokIAmW5bTzvBXvfQjp9XC01lyL3CMgI5lUvLenM4NbBOKZyoLduWxtxC+xLE
         4/6ngc03Xtt/5K0P34yfSFS04Ly19s2pDoSPumUAsuTWjiuU8wrIdv2y3KsISjO6D2h4
         xfHg==
X-Gm-Message-State: AOAM533xz3P/Wb2tUWe3g3cDEr/9zLR4zKPWQhJCXCfFDBqeCJTBILgz
        1ummQMm+BNMLDxl9yEa+S0Y=
X-Google-Smtp-Source: ABdhPJw+jLzjJzxrxscAYl6UjeWlffrvBe2Z/FWjed0KLeKL1hSQVsDlv6N/49LYVPceKooJ7s5W5A==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr21418931wrj.118.1643172600846;
        Tue, 25 Jan 2022 20:50:00 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n15sm2171342wmr.26.2022.01.25.20.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:50:00 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] arm64: dts: meson-gx: add ATF BL32 reserved-memory region
Date:   Wed, 26 Jan 2022 04:49:52 +0000
Message-Id: <20220126044954.19069-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126044954.19069-1-christianshewitt@gmail.com>
References: <20220126044954.19069-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional reserved memory region for the BL32 trusted firmware
present in many devices that boot from Amlogic vendor u-boot.

Suggested-by: Mateusz Krzak <kszaquitto@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 6b457b2c30a4..aa14ea017a61 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -49,6 +49,12 @@
 			no-map;
 		};
 
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-- 
2.17.1

