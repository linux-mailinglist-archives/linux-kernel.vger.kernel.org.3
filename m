Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD9578694
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiGRPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiGRPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:43:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2181A045;
        Mon, 18 Jul 2022 08:43:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bu1so17635896wrb.9;
        Mon, 18 Jul 2022 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTBmCzurJnZITyZ4+vdomE5npkyVBEtub+c0MxYfnKE=;
        b=A2wsW1np8iDyW3qo44bwOkA2Qg1lex4haTlLsKjbyygxlm93Fcg95GYGNIrsGkeCb+
         FAhv6WxSqmameMIz5KVlSA5sk2ysBJ9GMm2NdcBeIk2wpVJfqxxsvvIFKbwMEeDr/CBF
         8meuEKxLOU9QeSdTeYpbYybndt49ihq53F4st9nXIIRnQI2mRRcD2xJk3/+x/7MDMQ0S
         aDzb1ghgUwLoK9IB3S4GxC8SImDYolSwl8yyWtFiw3p8euUC/H8LJ8gUF81WmCsJJtCj
         bt3cn3TjSNIMcHZAwwph5FAixraftKkiAGpjXzscjKjX5vNxJ2PNlr3EYbSzPv8PsYQj
         Foaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTBmCzurJnZITyZ4+vdomE5npkyVBEtub+c0MxYfnKE=;
        b=7JbhxPc978saze8JJo/WR4ckViKikYvaD40+doOdWSwwRqblXT+85Z379BYKLgudxr
         FqQARJnZVu7jjUoV0WczpmuLPhUlEv469uL7AcgBVMzUIYzsCAdX3CBBOFty3x7e60mJ
         8L3Aldj8UuaVfa7idxEm+NugJxHqH4iwRElUc8zJEbCoXYzEYnlp93BxmXDbywc7vrA9
         AtUcu6MfYw9rkErlHUoZCjWludFsJUU8p/QWAm3x7zmzwKXAay3bepXd7I0F5MTqahsj
         UMLFpdSXA956/FRaVUDY5dezhR3jb0ohAWfzZy5peqb09E8SLfFlxclrXUC6u7C1CDNN
         wocA==
X-Gm-Message-State: AJIora9TxYOODFVx6PIO7a3z6xWycw0N7nkammNa0lmXx1dHTeZpUGJZ
        bAspIUACUSDj4xKwvp1+mi8=
X-Google-Smtp-Source: AGRyM1vIYKez3YmOH3//zsEF0fV6nQ+Efql2eZP3eG4lBDHF97itohTvW+WzhUWiQt87XZxYbYUVpQ==
X-Received: by 2002:a5d:6c63:0:b0:21d:bf45:f90f with SMTP id r3-20020a5d6c63000000b0021dbf45f90fmr21215186wrz.715.1658159002135;
        Mon, 18 Jul 2022 08:43:22 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t4-20020a1c7704000000b003a308e9a192sm13416308wmi.30.2022.07.18.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:43:21 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] ARM: dts: qcom: ipq8064: pad addresses to 8 digit
Date:   Mon, 18 Jul 2022 17:38:15 +0200
Message-Id: <20220718153815.29414-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718153815.29414-1-ansuelsmth@gmail.com>
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pad reg addresses to 8 digit to make sorting easier.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cf41d330c920..9405d6167b20 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -348,7 +348,7 @@ vsdcc_fixed: vsdcc-regulator {
 
 		rpm: rpm@108000 {
 			compatible = "qcom,rpm-ipq8064";
-			reg = <0x108000 0x1000>;
+			reg = <0x00108000 0x1000>;
 			qcom,ipc = <&l2cc 0x8 2>;
 
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
@@ -389,7 +389,7 @@ tsens_calib_backup: calib_backup@410 {
 
 		qcom_pinmux: pinmux@800000 {
 			compatible = "qcom,ipq8064-pinctrl";
-			reg = <0x800000 0x4000>;
+			reg = <0x00800000 0x4000>;
 
 			gpio-controller;
 			gpio-ranges = <&qcom_pinmux 0 0 69>;
@@ -571,7 +571,7 @@ IRQ_TYPE_EDGE_RISING)>,
 
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc", "syscon";
-			reg = <0x2011000 0x1000>;
+			reg = <0x02011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
-- 
2.36.1

