Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3F52CD8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiESHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiESHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:51:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17BB1DA7E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:51:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so4765670wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8nd64bbYuPtZbk3gzEjUJPg36SEhyQKMYL9m18hVxQ=;
        b=K9Not7I+PyZgkrTUlvVKLMxK26XXWC22aRyuioGV9vGEC1RwgFJcdeonATmNFFb0yn
         46pEFPaO2T4rV+mpEXbhUEk5k6oW2w3YTlo+wy7Lf2uGFDuesPGQwQ4zun5zlSMEzDco
         nFYuNMv5mFtLPDjKpooejPiTdUsLRq1sfAFLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8nd64bbYuPtZbk3gzEjUJPg36SEhyQKMYL9m18hVxQ=;
        b=xDUhM2sDQYYjdmDlTHEBwtoHsqedf/JZRuyzEN8a6mqfk2fvG0ylMwP6Yv6jyMeHIW
         ODrIuDiMnQCFdzxnl6crHmhXIef89JmbyqZWDB5PU6qV8xvl0hYjelscW6BF98Kcm8ul
         1WHmmIdDnJtvAH9DFMbadGQlrVgtpKlaf2esRKa4LMCvgsDQjOlhAlRdjMDaNLTU4KsS
         CkLHrPmiAXD3vlgZplmU+O4sN4DL8ea+7hPLV18yHUa7U+LEcantJqcz+0xLLQuv+TEB
         dY6CjSi5EXPOMjsjCLR7qH478RHBbbBrvqUcnUrK1JlRcdYQVB4hE23sur+TuvxOz7fs
         txmw==
X-Gm-Message-State: AOAM530tP0sf0fgmf2aIblv00dW+UDJ7LX3EvyHBierFcMPnAhWERrSz
        86yywBGqI2a2ZEouPK2uIQ3vBA==
X-Google-Smtp-Source: ABdhPJxmIkNAYgF+QDQxw92qkyMAyQOfu9THq+oITmvFlxH/AZHtvenhrXRlRO0Ke8oDbg6nXEcIKA==
X-Received: by 2002:adf:f046:0:b0:20d:e9f:9ed6 with SMTP id t6-20020adff046000000b0020d0e9f9ed6mr2861358wro.539.1652946686410;
        Thu, 19 May 2022 00:51:26 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c4a0600b003942a244ebfsm3370254wmp.4.2022.05.19.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:51:26 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     tommaso.merciai@amarulasolutions.com, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: px30: add mux for mipi-pdn pad
Date:   Thu, 19 May 2022 09:51:16 +0200
Message-Id: <20220519075117.1003520-4-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add right mux for mipi-pdn. Mux this pad as gpio2 14

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 53930e28eadf..0d05a1b098bc 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -450,8 +450,8 @@ ov5695: ov5695@36 {
 		dvdd-supply = <&vcc1v5_dvp>;
 		dovdd-supply = <&vcc1v8_dvp>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cif_clkout_m0>;
 		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cif_clkout_m0 &mipi_pdn>;
 
 		port {
 			ucam_out: endpoint {
@@ -544,6 +544,12 @@ cif_clkout_m0: cif-clkout-m0 {
 				<2 RK_PB3 1 &pcfg_pull_none_12ma>;
 		};
 	};
+
+	mipi {
+		mipi_pdn: mipi-pdn {
+			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pmu_io_domains {
-- 
2.25.1

