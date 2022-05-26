Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9E5354C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbiEZUmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347442AbiEZUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:42:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478EB7D3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y13so5180107eje.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBSottq5B2GJ9FFPovyG/bRnnI/fVKoW6GgzyoAPPks=;
        b=mqm2TyTwLe9J3JzIvwLX0t7OOCi6SC7Ci5LT4ey3rSWSr8XLS4LfCEMPkzVFr2g1gn
         WFOBsQO10LJuTz0PS5+KKEd6B4piYrbVXwbQFbPk16xZzidpogTh/2p8GawS9uDlK2EJ
         75ijNM9oNz2CrSCWfYq9OeQEKcMbdccezQIUnlECkj+1Ga47rpvvfNnmRoEUXS/wX/Bu
         nkpptkYm+hQ2SdifCTJRPuhVGA+ZlcolTCOXKto5mcNNxXpk3MLqekCzj6lywkPtYamB
         J8TOImHlRF9NHnRL5G0QAbZtmRebyd4kErEdpW61miRlVEmQfh/SkdF0KsXxs8jzxrJ6
         jcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBSottq5B2GJ9FFPovyG/bRnnI/fVKoW6GgzyoAPPks=;
        b=1padWN+61A1tDpXfa46rp/frTzcyEz+lLrZYF6CPT+ntoItlMi1LfQ1QdiF5aWBXVI
         au9qpB9/5Mfdq67IdxdxRwd4HQw/mKGxuqbgzGdZ/5vEzE1hPq4H+kDodgIMEKE/WHa6
         MuGOJ1ymnggRwhlhg+0s2b7t+IsK7mL2le1aRDBTK59yqMw6nyZW5J2pOdiG3M3PNTal
         yVdUI6pGfxpm4OXZSp/WR15fEQ0Y+hrO74e2Oj6U83g35l4OVO1tnUcDuWRwIrhEGphc
         vjgcZAJE6x997PDizDsQIztrTm9JV1EuzSifhXPkJuSau3s/htZ0JIyNC6BuU9lW8Q+A
         bsiA==
X-Gm-Message-State: AOAM533hE/5Ip0FOTxDsN3KzlviBZMgEfLwRPF8tr4Vy51/LX0Po+p4P
        V8/0ilTAkLQRmSDWwz7aKACW3w==
X-Google-Smtp-Source: ABdhPJz7O6I5XI5FpXBZSFKsMcuwni2DNPsFAGM+js5EZkfB37k56jQ/r1s0n1NCr6XaDCKTFlOHaQ==
X-Received: by 2002:a17:906:49c6:b0:6fe:95bb:93cc with SMTP id w6-20020a17090649c600b006fe95bb93ccmr34838737ejv.30.1653597754194;
        Thu, 26 May 2022 13:42:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ay21-20020a170906d29500b006feba4ef020sm798012ejb.180.2022.05.26.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: renesas: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:31 +0200
Message-Id: <20220526204231.832090-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/renesas/draak.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/ebisu.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |  2 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi         | 14 +++++++-------
 arch/arm64/boot/dts/renesas/ulcb.dtsi            |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/draak.dtsi b/arch/arm64/boot/dts/renesas/draak.dtsi
index 7231f820d601..ef3bb835d5c0 100644
--- a/arch/arm64/boot/dts/renesas/draak.dtsi
+++ b/arch/arm64/boot/dts/renesas/draak.dtsi
@@ -630,7 +630,7 @@ rsnd_for_ak4613: endpoint {
 				bitclock-master = <&rsnd_for_ak4613>;
 				frame-master = <&rsnd_for_ak4613>;
 				playback = <&ssi3>, <&src5>, <&dvc0>;
-				capture  = <&ssi4>, <&src6>, <&dvc1>;
+				capture = <&ssi4>, <&src6>, <&dvc1>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/renesas/ebisu.dtsi b/arch/arm64/boot/dts/renesas/ebisu.dtsi
index 72f359efa23e..aef0896b2f5f 100644
--- a/arch/arm64/boot/dts/renesas/ebisu.dtsi
+++ b/arch/arm64/boot/dts/renesas/ebisu.dtsi
@@ -711,7 +711,7 @@ &rcar_sound {
 	rcar_sound,dai {
 		dai0 {
 			playback = <&ssi0>, <&src0>, <&dvc0>;
-			capture  = <&ssi1>, <&src1>, <&dvc1>;
+			capture = <&ssi1>, <&src1>, <&dvc1>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 31837fcd7bf0..09ff1708cfa6 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -832,7 +832,7 @@ rsnd_endpoint0: endpoint {
 				frame-master = <&rsnd_endpoint0>;
 
 				playback = <&ssi0>, <&src0>, <&dvc0>;
-				capture  = <&ssi1>, <&src1>, <&dvc1>;
+				capture = <&ssi1>, <&src1>, <&dvc1>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 5bcb84403ef6..408871c2859d 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -206,12 +206,12 @@ pcm3168a: audio-codec@44 {
 				clocks = <&clksndsel>;
 				clock-names = "scki";
 
-				VDD1-supply	= <&snd_3p3v>;
-				VDD2-supply	= <&snd_3p3v>;
-				VCCAD1-supply	= <&snd_vcc5v>;
-				VCCAD2-supply	= <&snd_vcc5v>;
-				VCCDA1-supply	= <&snd_vcc5v>;
-				VCCDA2-supply	= <&snd_vcc5v>;
+				VDD1-supply = <&snd_3p3v>;
+				VDD2-supply = <&snd_3p3v>;
+				VCCAD1-supply = <&snd_vcc5v>;
+				VCCAD2-supply = <&snd_vcc5v>;
+				VCCDA1-supply = <&snd_vcc5v>;
+				VCCDA2-supply = <&snd_vcc5v>;
 
 				ports {
 					#address-cells = <1>;
@@ -438,7 +438,7 @@ rsnd_for_pcm3168a_capture: endpoint {
 				bitclock-master;
 				frame-master;
 				dai-tdm-slot-num = <6>;
-				capture  = <&ssi4>;
+				capture = <&ssi4>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 90a4c0629d24..5f390865a4cd 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -411,7 +411,7 @@ rsnd_for_ak4613: endpoint {
 				bitclock-master;
 				frame-master;
 				playback = <&ssi0>, <&src0>, <&dvc0>;
-				capture  = <&ssi1>, <&src1>, <&dvc1>;
+				capture = <&ssi1>, <&src1>, <&dvc1>;
 			};
 		};
 		rsnd_port1: port@1 {
-- 
2.34.1

