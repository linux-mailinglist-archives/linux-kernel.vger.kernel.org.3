Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095DD482C42
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiABQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiABQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F1C061792;
        Sun,  2 Jan 2022 08:57:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l4so20212305wmq.3;
        Sun, 02 Jan 2022 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwkPi3zTHNX/WgU468/COGljzbksLucVcX9Vresnwgs=;
        b=JA3YqBV0dBer5Kp4K4W0e1lBP6bSyY186oVs0gUMBG/kXP0OX78v3XYHCJ8PBQo8uB
         cWYW3Ib/cvCCIONWmyVw2+E+GgSZcxO2vGZb/TfXDSSBwbGOMG3jyFm5lSp6vPaHVZjZ
         UTwdWVwx3kmBJ1Pg0LaVcHw08IXN5jizUIdEpH9boncaqtN00PdeOm6rXJ8hHBdFY3m9
         gat0WYf7GEIKTchc+6r6l82+dwKBz6Cg3lIGIw+ysX/c42L78vNXfh5YfnYIVdRVtH1D
         uFREgLOjlIlUNtIqIAi6MVwAAPFskIl2qINRBUvLxueBlWP7msm3PeSrIq0OmAsRb+yQ
         8M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwkPi3zTHNX/WgU468/COGljzbksLucVcX9Vresnwgs=;
        b=FJ++KW9TNlLlu/OF/QyAm2VsbpfWfEefrgR2gel+kLrRD6lVweZ5kjeDOrdyKtkeYZ
         gT5HAjfjrrUb8UJvS4oig2SC/Q3pe6DtZ5TnW1pTZq3cu7bSTOjO/2WEL/TNclab3p6C
         TVLJzDYQePOazbQQPIRBW7stBRDWGwKU2Xz0QPW6QUK14cufpASFJVCAGUpGhPSvruqT
         tUqbkKcYJgEWNioJWfFFdrWqUZj3xscc4mmgSJAElDJdfOnA9zJg14iez8DXEsYwxOp8
         Tr1BhYKNSANGg/ylWeR2mhl1YmmVaAePKRi+XyRWSzn6fjrpUi4pHyu6GzTiZ4ExsfEE
         t6HA==
X-Gm-Message-State: AOAM531eNIMn7fH1Z2LfXsPXTB7KcFZRF63rdeGoccIohDMktGwTQLxL
        9k5y8FMzhgEeumXvbm2YBD8=
X-Google-Smtp-Source: ABdhPJw+T+7Kva7Grqslf4Ard+f+I0ns0p4qkTopFlTEorvQ7OO+iaZQtaZdCphuRJ7GAg2DLWSmcA==
X-Received: by 2002:a7b:c745:: with SMTP id w5mr36644779wmk.96.1641142661060;
        Sun, 02 Jan 2022 08:57:41 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id o15sm26163717wri.106.2022.01.02.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:40 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 6/9] ARM: mstar: Add OPP table for infinity
Date:   Sun,  2 Jan 2022 17:57:27 +0100
Message-Id: <20220102165730.50190-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add an OPP table for the inifinity chips so
that cpu frequency scaling can happen.

Co-authored-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index 0bee517797f4..441a917b88ba 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -8,6 +8,40 @@
 
 #include <dt-bindings/gpio/msc313-gpio.h>
 
+/ {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
 &imi {
 	reg = <0xa0000000 0x16000>;
 };
-- 
2.34.1

