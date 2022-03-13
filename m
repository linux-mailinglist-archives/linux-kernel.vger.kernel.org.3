Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA264D77CD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiCMTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiCMTHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:07:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED4E51E4B;
        Sun, 13 Mar 2022 12:05:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so29510602ejb.13;
        Sun, 13 Mar 2022 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=MtegQtBvPQDBpaGLhB2WrNX/E0Tu2vRax15Zb+J0ntgtjQHbz5gW/fJ6MJ/1kSrKRs
         m1pQHSYvAMbmnbQ81CG9or9Dur3COP/7fZt8i1LdufLj6f8PxAQHA0B3oYeqyjxbfORb
         ZhkpsQUlH7lxu8CpJrrCt4p+ILMnLwUVRWm3KBlDXLT2JnKKoRSC7ny5Pqu5dPnFupx0
         bjmYsITWLZw9uat6RC2VmKV6t8Z5cr4SLycHlZK3gAR67GJnZCkM9IXhgTlS8ZZA1m/t
         JY3cga55dxPD9kGrZgaLU8x+1vb8OS3vYVAwMDJ3vhwE+BHJA+t+II6+YQiVMize1X9a
         IcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=jwe6Ry9KoLUF7VK53w4Mu6HOlTo8tVL8019Ara1F+9N+D6gi7zIa2vKTPfPPn91ptG
         E7ownYIy0ttOegT07tB96AkZWLijnNiu6WQanrMNshyhgWJZ2ZURt7bUNO2g3JV5MFKU
         uXqnD/PVmVCg3DfzpKup3Bq2CtxnlQSqAtcEaWcL8udo5caEAebHBPMhhamWUpaRktjY
         BiA6k/muTsn4X2HkOXrrW9yv7IK0kDARmE7os3O6duFcqRH4RC/ZtWwJcFe2Gjo8+ADU
         l3ebax1ZE6cJbIiNFSOwweYMRxqV7J1mjuI9uMx+1D+xcBLfDQ/EZj1lcUNkZt2uEUDZ
         qgJQ==
X-Gm-Message-State: AOAM533qziSfVfFvd9kkufo2Xhz13z5kQl9fRxMLFYw6CLxkWSclG4ws
        tTA3bRIm4nlsnbUHW4QeVsQ=
X-Google-Smtp-Source: ABdhPJyGKH0wV1cFqwVRH0bS0asq/PkVZXvShZquXJauFDnzxGLNkM1WOKSCavi9N4dQIZdxg5dXyg==
X-Received: by 2002:a17:906:948:b0:6d6:e479:1fe4 with SMTP id j8-20020a170906094800b006d6e4791fe4mr15899252ejd.240.1647198318526;
        Sun, 13 Mar 2022 12:05:18 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 15/16] dts: qcom-ipq8064: add missing krait-cc compatible and clocks
Date:   Sun, 13 Mar 2022 20:04:18 +0100
Message-Id: <20220313190419.2207-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

Add missing krait-cc clock-controller and define missing aux clock for
CPUs. Also change phandle for l2cc node to point to pxo_board instead
of gcc PXO_SRC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..888f17d64283 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -468,11 +468,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu0_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu1_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
@@ -782,11 +790,21 @@ tcsr: syscon@1a400000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
-			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
 		};
 
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
+				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
+			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
+				      "qsb";
+			#clock-cells = <1>;
+		};
+
 		lcc: clock-controller@28000000 {
 			compatible = "qcom,lcc-ipq8064";
 			reg = <0x28000000 0x1000>;
-- 
2.34.1

