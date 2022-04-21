Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804050A6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390723AbiDURVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390706AbiDURVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:21:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFE249F97;
        Thu, 21 Apr 2022 10:18:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x191so5204951pgd.4;
        Thu, 21 Apr 2022 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neDN1KCMCtxQgItvcLAO4p/MZZhmZ/mnswWStrxLUUQ=;
        b=cxTi7EltIrvR2pPOR5x/JefJV2ssLScw1dNMYyXLcqpR2/uhJObEW6pK5D1IQ2ia1J
         dUjR4nLkaWtktFC4Yn6ossG9H1X+6vvVRMT+btIZEmvk1WS9SdvST4VQ6vrxVpi6dKAU
         H1IxDeZIuAVBGbdCDo/7KQhxen9F5dePEVj4hyXLJ+OTys0VIoKml5iOiky3O4N5nGzB
         zt5IsLOOlULSL24Rf4hzGrWBwJBfd2hkWJnNjeOHEeCZEQvPoTpsiV76oryAGyUFptNn
         GCuOmNDsXd6I1Jw8bxwLWrDgSwM12W9RQ+p+xEKJCJ9KsISH6iq/79F62bhZHgfkoOIi
         YT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=neDN1KCMCtxQgItvcLAO4p/MZZhmZ/mnswWStrxLUUQ=;
        b=t36rHD7+qFsTlX5oViTtibEPXyn/utsJYwHaVVhSXzaYaQjcRozj7NG19UWGfvXj0Z
         pKoEF8ZNzIKJGmaPRlMlJ+sttdmZrKumx9YZhShVGUWP04tReWg+AWivTy4Le9kR78nU
         jvhFzNESS9c5ZC1bAy/JxshMYRIEtHjD+w1v5aK7Rhrqe/6onjxhH5I109HZ3Fjf7ENZ
         aU784dRIj2gpeAFYVly2xdXgg2W/hEF4udwoNO4qTqNngeIV0Oo7vswIKDsjcFXFxzT0
         BZXqgq9CAmyoGNuqICvK+DvGRL0XlsxGFFYuCQN106rULdSBsOAdO77b6ntubljosnrV
         bsAQ==
X-Gm-Message-State: AOAM530m4+ua/KY+8UAbjC0iSlQH3fr/1M5YazqBAjEnQmtiH0C+Ea9m
        /63Yv/vm3O9yZvU9rmAfs9s=
X-Google-Smtp-Source: ABdhPJyqk6FuxM44+1GdAnmPhj7eqNVi5Zf23lKBPtSDITCCnh5TreXdqCO4/d9mYHItveiKBbbc3g==
X-Received: by 2002:a63:195f:0:b0:399:1f0e:a21d with SMTP id 31-20020a63195f000000b003991f0ea21dmr364292pgz.393.1650561526269;
        Thu, 21 Apr 2022 10:18:46 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m12-20020a62a20c000000b0050af5c925c3sm2881373pff.132.2022.04.21.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:18:46 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 4/4] ARM: dts: qcom: ipq8064: Use generic node name for DMA
Date:   Thu, 21 Apr 2022 22:48:09 +0530
Message-Id: <20220421171809.32722-5-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421171809.32722-1-singh.kuldeep87k@gmail.com>
References: <20220421171809.32722-1-singh.kuldeep87k@gmail.com>
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

Qcom BAM DT spec expects generic DMA controller node name as
"dma-controller" to enable validations.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 8cb04aa8ed2f..7e68d4b1527f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1155,7 +1155,7 @@ vsdcc_fixed: vsdcc-regulator {
 			regulator-always-on;
 		};
 
-		sdcc1bam: dma@12402000 {
+		sdcc1bam: dma-controller@12402000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -1165,7 +1165,7 @@ sdcc1bam: dma@12402000 {
 			qcom,ee = <0>;
 		};
 
-		sdcc3bam: dma@12182000 {
+		sdcc3bam: dma-controller@12182000 {
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

