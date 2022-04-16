Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807005033BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiDPDB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiDPDBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213EFA23F;
        Fri, 15 Apr 2022 19:59:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ks6so18207263ejb.1;
        Fri, 15 Apr 2022 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kCehNo5ngnv+AR/8Crw7G8bbbsFA1kQKSA748Q4B5I=;
        b=kqHylPCidoznaIHTWZKtutc7vYQy7agr+P/t43ywdDhc1YOPaXfslUSYWb6QI0cGlE
         dpAdde4bqExFOSf2c1JXDNMq//7GFBgiMPRYmALM4HYPzLFWscDKhWZwo5ftWGEQkyEe
         Wh6I04zQknzWcK19+tGjvo1UXEgrcU3IDxJrVF5WGgBrs+xu5qDHlhcQqVeCHFHLggAq
         1DuTkwtZLuHrCqAnDVP8/Xc9PegZfvLSoQY6hFVp91JlWPCCLDwQf0jXrGG64uzxm1YO
         t0y4durJxLr+YUo9zd7/tRCfVqMM9z6cBX4Bgei7VobL+GbFsGxjcKfmhMA1qIIkZDUG
         a36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kCehNo5ngnv+AR/8Crw7G8bbbsFA1kQKSA748Q4B5I=;
        b=kicPTzIt/bsKC8v4w0H012i8n5iZD/WWZ7eC+29yZFF9bFQu6iFkBHqTkpgU4ehBp3
         VADqNhSrymnqpcortEMewHeVZB4BF4WV4A+rq6F+JKmNd8QehNYW7BOQVLJXxFu9ccpk
         1MABDB+UWpZ8Spxtf3oAUQLOadGG1uEa8R1UFAU8NeTsfiBTaLn31wCXJQTknq9dAe9c
         POMdfQYdHrD8ZcmmUcvfKhkFY1aVE+6m7muCyuvGhMTkxpbAT8EtyeiyTNZDLnU9kjGR
         A6L7Y4mxzrPN5B1j6+l3rYn1bQDSVXqoxqZ/Fbf1vOz7/eltxZPMfFb2++gSGOf2eRia
         +AZg==
X-Gm-Message-State: AOAM533M9pNUW4JVLM8iKFt0CtaMEX2UjRjBS5p4+Hhq5ik86M9JZn+P
        eOCw9HQ5MJVeM1+1J6dQA8E=
X-Google-Smtp-Source: ABdhPJwHHJ1fnnyDCZwsM8RO7I0Dnd4veOx5hIB19ACG2nH8GUAQcIde8QHE6NvnM+nhX3NHP+1pwA==
X-Received: by 2002:a17:907:97c8:b0:6ef:6a79:6285 with SMTP id js8-20020a17090797c800b006ef6a796285mr1370190ejc.231.1650077951595;
        Fri, 15 Apr 2022 19:59:11 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:59:11 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 9/9] arm64: dts: qcom: msm8996-xiaomi-scorpio: Use MSM8996 Pro
Date:   Sat, 16 Apr 2022 06:56:37 +0400
Message-Id: <20220416025637.83484-10-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xiaomi Mi Note 2 has the MSM8996 Pro SoC. Rename the dts
to match, include msm8996pro.dtsi, and add the qcom,msm8996pro
compatible. To do that, the msm8996.dtsi include in msm8996-xiaomi-common
has to be moved to msm8996-xiaomi-gemini, the only device that needs it
included after this change. The msm-id is also removed as it is now defined
in msm8996pro.dtsi.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                             | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi           | 3 ---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts            | 1 +
 ...m8996-xiaomi-scorpio.dts => msm8996pro-xiaomi-scorpio.dts} | 4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)
 rename arch/arm64/boot/dts/qcom/{msm8996-xiaomi-scorpio.dts => msm8996pro-xiaomi-scorpio.dts} (99%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f9e6343acd03..72b8fcdd9074 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -37,7 +37,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-gemini.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-scorpio.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8996pro-xiaomi-scorpio.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-asus-novago-tp370ql.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-fxtec-pro1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-hp-envy-x2.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 7a9fcbe9bb31..1bdd3f09f536 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -3,9 +3,6 @@
  * Copyright (c) 2020, Yassine Oudjana <y.oudjana@protonmail.com>
  */
 
-/dts-v1/;
-
-#include "msm8996.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index 34f82e06ef53..e360187109a2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include "msm8996.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
similarity index 99%
rename from arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
rename to arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
index 27a45ddbb5bd..2028325e1c0f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include "msm8996pro.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include "pmi8996.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -12,9 +13,8 @@
 
 / {
 	model = "Xiaomi Mi Note 2";
-	compatible = "xiaomi,scorpio", "qcom,msm8996";
+	compatible = "xiaomi,scorpio", "qcom,msm8996pro", "qcom,msm8996";
 	chassis-type = "handset";
-	qcom,msm-id = <305 0x10000>;
 	qcom,board-id = <34 0>;
 
 	chosen {
-- 
2.35.1

