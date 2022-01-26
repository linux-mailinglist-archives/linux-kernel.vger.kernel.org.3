Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD98849D145
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbiAZR43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiAZR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75339C06161C;
        Wed, 26 Jan 2022 09:56:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c23so418571wrb.5;
        Wed, 26 Jan 2022 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=987i68G0hoSD7befa/sZSvlzgSvWjRDhljDEuS8vWhM=;
        b=YW2UrPWX3Gqj7NPwSuzV0pZYMXbe6mghkz4zxiAfBMsjgRWORd2wNL9Ngd0v113N6Q
         l/d1ujsUKh1C4a0IkFe8cWm+W55eBPI8OLU3IMuLr9EGPsdBU4rzmsosqxzuQ9Ra1r/J
         GbSDXVoiYDUuKwVBb77ylkN5/wMJC/3VLqFFLlURyO5RM6w4/Vje+9MOMzsxWs5tLCI0
         TjCwXoXSyssc+muDW3ktraSDb8P60usz7GTOr/Id/aOa4bi2mp7gD69wquIF8u3ir2YU
         8m1A4uLkadQxpmnR4K6Qjs0JcHTAEaMTH8Fxq6M3ZWndr+S0XSXb3+m5bD9pQvb0hEOe
         Xv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=987i68G0hoSD7befa/sZSvlzgSvWjRDhljDEuS8vWhM=;
        b=TGgFJYJbfgU5d9TNRvl1Jwk71CIk3XcCnfxL6FGC4fv/N3Dz/a+FrPGUbrfF+lXi/l
         DoDIY31l3y87/mDhIGgYB0W1YSczi7rFipoBQr5BJUPLsaaLv2rV5jut2hjJpYG0J877
         riBNPwdv3pexREzbNJms3jBclhau/A7PDPM11UTXJUEE3Cp888y/0ngAG4jyCs2qMb6U
         EkJaxJjE0AHrjbr0GhFbMi1eiFAjAcHZsYv8lNi7/mKAftFpvtG5kaEybYV/Rv7QzA+d
         jZ9ESUcHSg79AHOz4MzwvU7zU50wLYEJV43Wn/p2uaFewCKYltL+5ieCr8yKmqZ+M2wX
         yvhw==
X-Gm-Message-State: AOAM5312L2XU5KgS0ODZ2thJuNZZhyD9K3G/wAqpoR+6iam0mhQe9+D9
        1p4lplZA0WxocSRBHgQGQVc=
X-Google-Smtp-Source: ABdhPJyUUeUIz50LPFJ1txfvAZ2tlqLG/uX9p2O822Wau+U7NjY7bHm99jmtJ6NwczP49HCwt50baQ==
X-Received: by 2002:adf:f791:: with SMTP id q17mr23246847wrp.340.1643219779015;
        Wed, 26 Jan 2022 09:56:19 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id o2sm2179098wmq.21.2022.01.26.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:18 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 6/8] ARM: mstar: Add OPP table for infinity
Date:   Wed, 26 Jan 2022 18:56:02 +0100
Message-Id: <20220126175604.17919-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
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
Reviewed-by: Romain Perier <romain.perier@gmail.com>
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

