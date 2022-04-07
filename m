Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5784F8A24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiDGUof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiDGUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:44:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C065396E15
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:34:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so7845490ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgadCIuDHSONda5a8AlBMiHSHORPXO/YIVbS7AR7TQA=;
        b=HJcyO+iyzMqE/sQyRjthCVW+qXowVaN11+BZizM5k1G161UQb2N9kNPsp7GKv6z+zo
         CWHEYiTS1J5yuneRxmPcMImj6LTHI3O4XD5500mf93f9iofku7I3jOFqQFvk/pY7KsE7
         iSrnxlwj22PC9mHQtg4bmj1wQszLTcPWQnwqH04EQeLVJu96yveMmTal53PCAYWhxk0j
         GCUl1IuKda4n0K7ksYu7wy7xxLhFmyGapDNwVxM0UfyCnlrTWTALpG3vSc8RD0lhAZGO
         89DeWEHs0PCYfK1Ozss6ps4moEu7BPtdZtBd+AyPRD064enE7bwxNMy3urL/mbFZp9oD
         cMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgadCIuDHSONda5a8AlBMiHSHORPXO/YIVbS7AR7TQA=;
        b=Wnq2ZaoE2lBEddEPO5qayvBaXacMoHJ4VYt5+eGSgNxAQUvQWwcv55vrw9nqalYeny
         Ocy3b4x11SS/0/SgQbZLJikKWtcRTJ/2q5mFK3HE+gX6RyyXGxCTs568CNyFTGdgMWFV
         UYQzxhJeDqeoX4jFGg896pRiNPqXokG1/D8ilelFS4aHkHUmLdGGDAt8l7XJN5I2AP7U
         E9Ccuei/tL+GAVJ2V0r1n36wzqMs7J1kfKKeMOruvgJmL5NK+fynnfFDqhnUAXpTOU1q
         YjC/17QZIOx0X4/LvBn3Th/rElUGeJbe7vsFi1W9Lk8kcv+FJeigWKR3lhbUXoE2nBPD
         nsGQ==
X-Gm-Message-State: AOAM533N/wOYZnwLiL4spbDRjkoBXoMLT/pPVHsNfeiJlTvh3LS2C429
        gR0QXpo75DvdncNP02GYp+ZTIQ==
X-Google-Smtp-Source: ABdhPJwg2fPFcOmOxRETaOJJDkf4GoOxHDtuoVYZsGbXoaBOj8r/RXDTmCiJ+hztxHnvqqxDzS2f5Q==
X-Received: by 2002:a17:907:7ba6:b0:6df:ee7d:10f2 with SMTP id ne38-20020a1709077ba600b006dfee7d10f2mr15400650ejc.98.1649363648703;
        Thu, 07 Apr 2022 13:34:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p13-20020a50d88d000000b0041cd1a083f7sm6134799edj.1.2022.04.07.13.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:34:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: mediatek: align thermal zone node names with dtschema
Date:   Thu,  7 Apr 2022 22:34:02 +0200
Message-Id: <20220407203402.33356-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407203402.33356-1-krzysztof.kozlowski@linaro.org>
References: <20220407203402.33356-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of thermal zone node to dtschema to fix warnings like:

  arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
    thermal-zones: 'cpu_thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index acb775ca682e..9811f92faa56 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -273,7 +273,7 @@ cpum_ck: oscillator2 {
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu_thermal {
+		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 3129e7783902..151877fa6bfd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -823,7 +823,7 @@ thermal: thermal@1100b000 {
 		};
 
 		thermal_zones: thermal-zones {
-			cpu_thermal: cpu_thermal {
+			cpu_thermal: cpu-thermal {
 				polling-delay-passive = <100>;
 				polling-delay = <500>;
 				thermal-sensors = <&thermal 0>;
-- 
2.32.0

