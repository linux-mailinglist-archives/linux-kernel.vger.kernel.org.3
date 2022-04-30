Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47F3515D29
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382574AbiD3NDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379480AbiD3NDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:03:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF874DD6;
        Sat, 30 Apr 2022 05:59:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so20064042ejd.9;
        Sat, 30 Apr 2022 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCHO3F9UUQUUhnGse2puZfAbidpQJJI1trqWLrmHldA=;
        b=ElvUvrvHg+z/qMdkgJIkhY6+KwDX1JkH7s02dWPJaH1GSJD9o9eLxFaYcEMbZ+5bPR
         5bBD26zyftE3HJ1SrjL7Hf0azBqWd9YSVWCcYJPnImw9bD45Nd2Vji1tCTWxrH6IJCjr
         zVsOQ+moOWJ1+HD0vglv1TDhJvECJ1qKtwo5svFWxpdULb0RTKwtGjmgtHoaDMYok9h/
         HSzmyhIAZwyS7iWEnqO5ACKu1q4gQGtzqLcS6BretCuyPSynEm2B09mjM+tmE3yGiN3M
         K8+Eqjj+jL+OKs40cOU+90XbpFoD7tHR2jg6fKadihUC6rZsLfeLzra25+ncaRicjA/a
         7VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCHO3F9UUQUUhnGse2puZfAbidpQJJI1trqWLrmHldA=;
        b=uDy3HciRvk/uD2xl4PdvjGF+qwsqOOY9mBfFDEOeU3hcM6yBe8ltTGBgc3zXZmbp7b
         KLdPuvWFWFhw+YtwCwthCzW5/7g1ZbPMzx3j3Ood0qDV85P59Y909iQ/GjuDivl3Bjbe
         loRDCE1I1dY3fl9hqhHIrHU5SQVp79grjYm+irOuW4zOCyXv9WnwhPiU9uQG0Wd/uCzE
         5NbJ10rCIj4LTPZzE8QsXMofnVFZv1MqkRMv2m2tAnUy+TRXqyBeErcaca5FdyN1LzQk
         RD2cjyPGPFcto3ZYM+RGxcydFTAttMk2Yfh2rF2hiOaFfn2r07L1Vwg6iXkK6fcWS4tr
         xwpg==
X-Gm-Message-State: AOAM5301ke+qoVnvvNydFH1krJcXHwUgnYTQpEjt2xQ4V6iWHDgy2LnG
        I0sYiQ+sFSoZzz0Km90R5CE=
X-Google-Smtp-Source: ABdhPJxBsKEu1mvUeIwlkp8br54hpHeAiFIy4YQ8I0RTtQ94BCROdSpnDd18Duw+0825xi3jbb8uhQ==
X-Received: by 2002:a17:907:6286:b0:6da:6e24:5e43 with SMTP id nd6-20020a170907628600b006da6e245e43mr3684637ejc.449.1651323581354;
        Sat, 30 Apr 2022 05:59:41 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id a25-20020a056402169900b0042617ba63c8sm4125077edv.82.2022.04.30.05.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:59:40 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 2/2] ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Sat, 30 Apr 2022 07:51:18 +0200
Message-Id: <20220430055118.1947-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430055118.1947-1-ansuelsmth@gmail.com>
References: <20220430055118.1947-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add syscon compatible required for tsens driver to correctly probe driver
and access the reg. Also add cxo and pxo tag and declare them as gcc clock
now requires them for the ipq8064 gcc driver that has now been modernized.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e6ca8d1d1c5f..ad30f7c8a5a7 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,7 +298,7 @@ smem: smem@41000000 {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
@@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
 		};
 
 		gcc: clock-controller@900000 {
-			compatible = "qcom,gcc-ipq8064";
+			compatible = "qcom,gcc-ipq8064", "syscon";
+			clocks = <&pxo_board>, <&cxo_board>;
+			clock-names = "pxo", "cxo";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.34.1

