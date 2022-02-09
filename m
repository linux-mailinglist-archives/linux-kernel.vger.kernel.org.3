Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BA4AF363
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiBINzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiBINzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:55:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B68DC0613C9;
        Wed,  9 Feb 2022 05:55:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so1619732wml.5;
        Wed, 09 Feb 2022 05:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7U/uYfF5BBXdgNLHE4+fM0Xnr2orfhJ3kV6quQhuKN8=;
        b=A1Raudlcg8KbydfuTRJDWC+KE9y+kf05/OEpM2s89EkYAhXlrrtpi9qGKOnu+OqeMj
         gz2TEjbu48jg57g5SiHYUxrwLtZEHADVglTk2P8p5a9fFeCfUR3mp41KaOUHsr2Gdr/9
         2vBvYQjnHuYEtFoMhYKZtypiLMju1EoF2zOHQl2wHIWtcp2+LJDSC0NlnZbiVoYZp7E7
         y0/JqL6hg1PE7TU3cm7stqKK+T3i7EZCVnwFjvwurHJMOOF756CQxi6wcfoTlZhKGTfc
         SB0pcp3mDEPsC/pUEVdUa3i3Fg3QZgx2zoQf+qQ16qWiel7aCQdLbm/Us2DB8RFLZ0E1
         tAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7U/uYfF5BBXdgNLHE4+fM0Xnr2orfhJ3kV6quQhuKN8=;
        b=cMqSTgoKwJl/73fLX6iXKyztmS2387Xv/iwn6/xFFAPS+jmKtWKY4NyTkaFEfBEP6b
         irns9P1hS16HVqH8JRQrsq9HFmGUTAU4Dkc2vtTBXqaNNsQ0VXlJj2bjKgr9gzrJ734B
         3beQvS+XLi+qJxHH3Bvo2iFhrDjiO1Zp0mA9UW+8sN0WgmUn2HH/49BPy3BXVgooSDbo
         eAphqoaY0a/ujwHW7/0SEATui6Lq6u33rxp8DOZpkrMurJrR1MG4hJogBgXc6cKxvC0V
         7CCq/QXToOjujYhl/HbcM0s4M+ycdGm9UnIMFm0m+yolnElW94O5tYgnwf9O6XxaJ1SA
         0u9A==
X-Gm-Message-State: AOAM530mr1ZMfHgPHowgikrLFKE04jq+bJn5thiPork8Pa/mYb33TOw6
        fHDAugkJZdWT7IiigfG2N2w=
X-Google-Smtp-Source: ABdhPJwxjFBgHIB+UhKYGiBo3CoUpqS8lR5s3DiuLtu+98fiXKhZHC3z5PVCNCW/puAce4XBpJkvlQ==
X-Received: by 2002:a05:600c:a03:: with SMTP id z3mr2688181wmp.73.1644414940868;
        Wed, 09 Feb 2022 05:55:40 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g14sm3014309wmq.3.2022.02.09.05.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 05:55:40 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: remove CPU opps below 1GHz for G12B/SM1
Date:   Wed,  9 Feb 2022 13:55:35 +0000
Message-Id: <20220209135535.29547-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12B and SM1 devices experience CPU stalls and random board
wedges when the system idles and CPU cores clock down to lower opp
points. Recent vendor kernels include a change to remove 100-250MHz
(with no explanation) [0] but other downstream sources also remove
the 500/667MHz points (also with no explanation). Unless 100-667Mhz
opps are removed or the CPU governor forced to performance, stalls
are observed, so let's remove them an improve stability/uptime.

[0] https://github.com/khadas/linux/commit/20e237a4fe9f0302370e24950cb1416e038eee03

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Numerous people have experienced this issue and I have tested with
only the low opp-points removed and numerous voltage tweaks: but it
makes no difference. With the opp points present an Odroid N2 or
Khadas VIM3 reliably drop off my network after being left idling
overnight with UART showing a CPU stall splat. With the opp points
removed I see weeks of uninterupted uptime. It's beyond my skills
to research what the cause of the stalls might be, but if anyone
ever figures it out we can always restore things. NB: This issue
is not too widely reported in forums, but that's largely because
most of the Amlogic supporting distros have been including this
change picked from my kernel patchset for some time.

 .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 40 -------------------
 .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 40 -------------------
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 20 ----------
 3 files changed, 100 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
index d61f43052a34..8e9ad1e51d66 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
@@ -11,26 +11,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <761000>;
@@ -71,26 +51,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <731000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
index 1e5d0ee5d541..44c23c984034 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -11,26 +11,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <731000>;
@@ -76,26 +56,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <751000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <771000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 3c07a89bfd27..80737731af3f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -95,26 +95,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <730000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <730000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <730000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <666666666>;
-			opp-microvolt = <750000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <770000>;
-- 
2.17.1

