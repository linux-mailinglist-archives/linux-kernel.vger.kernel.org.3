Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531685670B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiGEONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiGEOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E952B5;
        Tue,  5 Jul 2022 07:07:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ay16so21853685ejb.6;
        Tue, 05 Jul 2022 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1dzDVO7k14VN/LYcA75166IOI46MQb45gCsMGBsNGE=;
        b=OMT/O1LSzr85LlbnPmDY3YiZH3VDRtT/qq8L4O9p01DlF4/ADyW2mt5NDn3SnQM2db
         MX90HP6qxS9NCKeBSUSxYiXrrml/6EFGRjaAdelTKZdCHDrwWNVtmiX75jlJ5cHMlAPP
         df2t9JHECIcPRAD7cgUm8PbtZZVt6go0GZ8lPVutQjZoFeFa1CaU6JGjKzWmxrVAlJkt
         oirfMq0G4JM6PNaFMwopZKyHmNHQrgPJqfa/LGJriDhfwxHgt20KIOcbev5+yVQrFNoG
         y3bBVineqbPL6SaR9+COW/7OxY1QTG62MLa/heKQKslSDjYaVyBRzi2v33m9xw5mRTLD
         fjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1dzDVO7k14VN/LYcA75166IOI46MQb45gCsMGBsNGE=;
        b=FqvZESfIIDRA+pUFzrFPN6SeRVjyW0GwedtD0MAnKcz3bHBTyuvOtdRA/PZ/rViaJp
         +eboX9JDDr0QSVrYd4C3akP9oryrAX4bYhxwuEu41VvoUAQFY/vwANsfK22b6wH4AJVe
         eeIawkBWmUDRMEaEY6D1HF0NR6WjgOAa64j1q79NvPPBJLskM18cHshJHyHvyxDExFvI
         m6uN5VVP2c2cGRAcoLrZW7pEUcnypLDdg2F3cBje5j/g8Lozu+KSGbW0zNkDW+qa4oLO
         bMMeT/sMt2BHy8H8RlY6AIk6POg6MfdKhxb8eK8FGlV/bBCjmUn8ayA5Hgxghnamr9e3
         YIWA==
X-Gm-Message-State: AJIora9oIfiygzUMlgLFGFQi/ZS0fPNnFvuznbY6K92zTPpIWSb3GfT/
        WdnCb9FnUw3iJDWjCcFUItPZgguAGhU=
X-Google-Smtp-Source: AGRyM1tZH3ruOukgfMZm1JWfDUvhMfwhk/8vCT1JWTKMOt5NeF1nHVr8FqKmZJxehOKsYSBRTRfiiQ==
X-Received: by 2002:a17:907:7da7:b0:728:1c89:129e with SMTP id oz39-20020a1709077da700b007281c89129emr34989225ejc.637.1657029998046;
        Tue, 05 Jul 2022 07:06:38 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:37 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
Date:   Tue,  5 Jul 2022 15:39:13 +0200
Message-Id: <20220705133917.8405-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Add missing smem node for ipq8064.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index b5aede3d7ccf..98527a7d885e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
 			#reset-cells = <1>;
 		};
 
+		sfpb_mutex_block: syscon@1200600 {
+			compatible = "syscon";
+			reg = <0x01200600 0x100>;
+		};
+
 		pcie0: pci@1b500000 {
 			compatible = "qcom,pcie-ipq8064";
 			reg = <0x1b500000 0x1000
@@ -1332,4 +1337,17 @@ sdcc3: mmc@12180000 {
 			};
 		};
 	};
+
+	sfpb_mutex: sfpb-mutex {
+		compatible = "qcom,sfpb-mutex";
+		syscon = <&sfpb_mutex_block 4 4>;
+
+		#hwlock-cells = <1>;
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem>;
+		hwlocks = <&sfpb_mutex 3>;
+	};
 };
-- 
2.36.1

