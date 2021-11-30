Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C339464278
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbhK3X1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhK3X1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:20 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508DC061748;
        Tue, 30 Nov 2021 15:23:59 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id k2so44336079lji.4;
        Tue, 30 Nov 2021 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXolFcz4QOLnIUZoiZ0Ry5uu5XANR011N6AEo6cZVfo=;
        b=OXu134ZknM16mp/t4fYeI0tjGNPyk5M7izksLk+a9ehM0XqghuECkM9iNLajpPOAW9
         HSKaYltiiE2fVtjjkFAx0C5C9VOVSk+6tLhEbfDwCle0X2H+D47YYn9T6vOhadb2+QVh
         F7X/wWoLPpKj8CnRhZTfrQdI63zpPmEV6t/5Qxx1d5VgxcyAaaKhAzknboK05FEHJwVm
         zJrAJclyt6s91b1Jy1R20qqO84D5hkD5BHTcR6xQE/1vFt5BN+e0s0vA1qAA7vuEipAr
         XewldVfwSIVkCw1PkCMRkzySyawQRrUZx7ijY3/BS1noKVScovRmPLMTBEomBjSceiWu
         Wyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXolFcz4QOLnIUZoiZ0Ry5uu5XANR011N6AEo6cZVfo=;
        b=aSbSl7YaSi0qd9Ewy4ZTY5uvTpTvszR1nH0lkDGN2w3LBoYZs6s6vpIW+gPsBkgbJc
         MfWhCS8yLXWAuPkooWTW/tYA//tJhbmEEK8+1ltbAof0nQFPFLIs0XVoMPmkH02eNhXR
         VrcwddIqDl5I/VG4/mfxbawwyTRxBgirglDpnTz30IJoWjEl2+wldKLrvvU86ZBGoHC3
         +leBQS02xyTNPAO8w2VpRNlQ7GNcK2GEncmZX2gYS/sAbuIN5kwc963qZjvldo2Hc34T
         oFHzUJh1rVu59Fz9U+B7hm/FhD78qPtzfv/+5CsseQ97SmDQNJ1ncTh5daR3Ew8j5Ltn
         PdVw==
X-Gm-Message-State: AOAM532HWlOQ9zNqvK0qI9UdgiR2yH/noIZHAa4LDi0QVzlf/iBlsNQb
        +9H3vuDDKi2NiRzgl6GSlv0=
X-Google-Smtp-Source: ABdhPJz6W6krNEzBX3IW5DlNPEVv77H2J2aWulC37ZRZQJs4gEsq9g4I+6cuf2fvO0OWjUPse1lfKA==
X-Received: by 2002:a2e:a594:: with SMTP id m20mr1861100ljp.332.1638314638272;
        Tue, 30 Nov 2021 15:23:58 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:23:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 04/40] dt-bindings: clock: tegra-car: Document new clock sub-nodes
Date:   Wed,  1 Dec 2021 02:23:11 +0300
Message-Id: <20211130232347.950-5-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document sub-nodes which describe Tegra SoC clocks that require a higher
voltage of the core power domain in order to operate properly on a higher
clock rates.  Each node contains a phandle to OPP table and power domain.

The root PLLs and system clocks don't have any specific device dedicated
to them, clock controller is in charge of managing power for them.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/clock/nvidia,tegra20-car.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index 459d2a525393..f832abb7f11a 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -42,6 +42,36 @@ properties:
   "#reset-cells":
     const: 1
 
+patternProperties:
+  "^(sclk)|(pll-[cem])$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - nvidia,tegra20-sclk
+          - nvidia,tegra30-sclk
+          - nvidia,tegra30-pllc
+          - nvidia,tegra30-plle
+          - nvidia,tegra30-pllm
+
+      operating-points-v2: true
+
+      clocks:
+        items:
+          - description: node's clock
+
+      power-domains:
+        maxItems: 1
+        description: phandle to the core SoC power domain
+
+    required:
+      - compatible
+      - operating-points-v2
+      - clocks
+      - power-domains
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -59,6 +89,13 @@ examples:
         reg = <0x60006000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+
+        sclk {
+            compatible = "nvidia,tegra20-sclk";
+            operating-points-v2 = <&opp_table>;
+            clocks = <&tegra_car TEGRA20_CLK_SCLK>;
+            power-domains = <&domain>;
+        };
     };
 
     usb-controller@c5004000 {
-- 
2.33.1

