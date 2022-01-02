Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1315482C45
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiABQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiABQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA1C061785;
        Sun,  2 Jan 2022 08:57:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so28948982wrg.11;
        Sun, 02 Jan 2022 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StcZHqzmvLp6v5k+mwDmcDs/ahnsoFhEqrHgEMI6OjQ=;
        b=j2xcZ3VS6TFIJjYJ+vmRZezy9qn60VUnG3E/ECjUl4HCPj0rBPuLzDzMwAufGOjAKy
         Oc9fg2uOo+kWqurnFvUrgF26zLYYowfHO3ANqzWXX80wan7+eMy5pqMsOqkVRRPwPzdi
         XdVqBYXHiOcxHy45XTI1f2dIu738oghcXKciM3thU+SRfmrDsc+LJGWCiC2VD/ljdQmt
         e0nEOtz4zLqOcHEyGCOrqkgPaaJh1e9wAqF2j16kVREALD44gYROXkYmCmtk0wyVyx21
         K/+IJnM5CcXakBi+Q4J4VB4gesigSf+DFXkLOVmT92RIHvk7bPWah40RihYdXsnCSfHA
         kwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StcZHqzmvLp6v5k+mwDmcDs/ahnsoFhEqrHgEMI6OjQ=;
        b=xwbfDDZeiwkRmyxlRMija+Y2vGyvTHDdF6kJz629VTJq03z2DU+B57/9OTL4XTKg1E
         vdiqa54rrxMoc70XGQMA27oL5yJb9DHac0xZl0bPgvCtF1DwGitoCK34vPjgNWQisWlL
         muFhoIeXVaNrfOyn4C3mzPjCHr5qKmQTvBHqS2ktzUYj01MfVzEtiLwn0U6DessTJwn0
         AuGU/GGHYI7dAP0DG+oNS0LpFQ+dvaSeDevN/Lcri3/v1tL7Htx2jZrsGRM29GPVfQZ2
         P+GeAMfAmqxDqCxnajig5FUbbjAvWGf0MWL/HH4bGudX8B80znG/duySNi6So7mtMQHB
         G1Ow==
X-Gm-Message-State: AOAM533bFGW+JP/xSkiIE2OQVfRpToH0oFV7TyQx9Q3c5dtzXIvF9iBN
        CiGQE+0gASnXRnH0y4RztDhpfZncFqSasw==
X-Google-Smtp-Source: ABdhPJx4Dxr2RaztEoTqjlm4Ao926l9evgTdBBN+vsLJtkzj0doTCeZAZdeT9CKRktC4SnKfnHmUYQ==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr36990100wri.566.1641142662958;
        Sun, 02 Jan 2022 08:57:42 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id p13sm25787035wrs.54.2022.01.02.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:42 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] ARM: mstar: Add OPP table for mercury5
Date:   Sun,  2 Jan 2022 17:57:29 +0100
Message-Id: <20220102165730.50190-9-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add an OPP table for mercury5 so that cpu frequency scaling can
happen.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-mercury5.dtsi | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-mercury5.dtsi b/arch/arm/boot/dts/mstar-mercury5.dtsi
index a7d0dd9d6132..80a19bd23c9c 100644
--- a/arch/arm/boot/dts/mstar-mercury5.dtsi
+++ b/arch/arm/boot/dts/mstar-mercury5.dtsi
@@ -6,6 +6,42 @@
 
 #include "mstar-v7.dtsi"
 
+/ {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <800000 800000 850000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <850000 850000 880000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <880000 880000 890000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 900000 1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000 900000 1000000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+};
+
 &imi {
 	reg = <0xa0000000 0x20000>;
 };
-- 
2.34.1

