Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C051ED1D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiEHKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiEHKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:53:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C51DECA;
        Sun,  8 May 2022 03:49:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so21875522ejb.8;
        Sun, 08 May 2022 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7p1Ky747M6b7mZG1S1tHMWxma441ZRmxJs8dLDJ9L1E=;
        b=AJ4N3IqUrdRc0rQ4YUPrVJo2vf4IqnY7XGyLPV0+q5v+vy3/TXyWcH1A5iWPat+eQK
         HNqTnAquj7KTJc4D3W9mPjChTsjQ3yMfknYy3hG0SktFp4lDWUqLoF3oDnOPnaHb58rG
         PnXuC58S72Ge2p5kmD3JAYeoK8EJ3OGP4IngaILlZ8fCl3Sm/3Rp/ZkT4UjRNWhajOJc
         My9w4D7phNHzwQs2RKOF+LEskW5TEb7GqRp6WcAb6eb6XRGMi9Kam5ja0wTMvxG8G/c1
         8fNGeKqOVL/h1aDOA/Cr44tB6G2i+gylXp+VkbwAZAm4dU0eQfpHwSgMujQ3pzYuW+oW
         xtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7p1Ky747M6b7mZG1S1tHMWxma441ZRmxJs8dLDJ9L1E=;
        b=nE32qanna1ODC1jLT/YAzU7kzOc1zXFy7PcvcVwf+U8CiOCkBnsUNw1CYFQUzIk5o3
         yUZv0jbRNB9gMAoU67O720xvwsvpjgreVksJDtZqlud0z6wGG68avh8pJLI4Pb4vvRDU
         AcoVeYu70d9UZIPzOlMO1MVrEtsL5DH44Jvzm27iNtXnpfilBapHPkzewpLmC0MmB5bS
         D5yQI+YUkixSvaT766zSuwphAduG1M54d4X2Q85lSQ8RnBYxhzPqyBHlsobUZCBji3t5
         FCrwpSSGsSthI8qhOMNa1y+zwK3oMrPNKs/9xpcDdo0DLc/2I+HEBV6AfThA/IZsz3WW
         UBsw==
X-Gm-Message-State: AOAM531xBy2zkKcA2bUuLT1AEq5EohDGFR20F441CApKZY3yn9SxSuRP
        lkejoqHHEbfnME8YZ80eJtk=
X-Google-Smtp-Source: ABdhPJwSIYliEMNd5yuIHSMUvUw8LUMnPmhuUrimOKGtP7mvXX6S5/PY4uamiZMMv3jcgtAczMvG1A==
X-Received: by 2002:a17:906:5616:b0:6f3:8fe2:a8e8 with SMTP id f22-20020a170906561600b006f38fe2a8e8mr10099685ejq.465.1652006954619;
        Sun, 08 May 2022 03:49:14 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:14 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 11/11] arm64: dts: ipq8074: add USB power domains
Date:   Sun,  8 May 2022 12:48:55 +0200
Message-Id: <20220508104855.78804-11-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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

Add USB power domains provided by GCC GDSCs.
Add the required #power-domain-cells to the GCC as well.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index ba81c510dd39..0bc21b0c177f 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -383,6 +383,7 @@ gcc: gcc@1800000 {
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <0x1>;
 			#reset-cells = <0x1>;
+			#power-domain-cells = <1>;
 		};
 
 		tcsr_mutex: hwlock@1905000 {
@@ -610,6 +611,8 @@ usb_0: usb@8af8800 {
 						<133330000>,
 						<19200000>;
 
+			power-domains = <&gcc USB0_GDSC>;
+
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
@@ -650,6 +653,8 @@ usb_1: usb@8cf8800 {
 						<133330000>,
 						<19200000>;
 
+			power-domains = <&gcc USB1_GDSC>;
+
 			resets = <&gcc GCC_USB1_BCR>;
 			status = "disabled";
 
-- 
2.36.0

