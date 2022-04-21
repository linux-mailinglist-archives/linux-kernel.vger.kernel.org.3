Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08BC50A6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390694AbiDURV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378036AbiDURV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:21:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82249F8D;
        Thu, 21 Apr 2022 10:18:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id iq10so1787188pjb.0;
        Thu, 21 Apr 2022 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJSmH5HGIsEkdbH7JbwoGyJBYB+6uLDMnSLmAQUIDRE=;
        b=hAV9M0spLIM3had7dOn1M+eBUQSb5D1uB3i9PJeB7BEZLgeJSqwgiMah5B5MBwZap6
         zx9TpQ7cIcEw09BofxGXvye/RhRh3CQtB+ANqFio+VCIySjqM93KQw4Lx3UFIH2FHD59
         Y+XAwjV6u5i3NCQ7soRuDewG+pXeXH3iKjvBL3vYbyEMWlit0QDMtdQNJ418sK56dKK8
         HtxV/C17dNlga9rM1emHyffuEuLm0oHrt8JDOZXV4RpxpEPwGP5Rkh3ri7ziVKuFq8YR
         +3eb6dFjllgJy3NV78tS7svEe60bUNW4WhAaLSTlYnkCZQucyE07vjKocCIHTENujONS
         LW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJSmH5HGIsEkdbH7JbwoGyJBYB+6uLDMnSLmAQUIDRE=;
        b=alkktq3Bs0ijSLtKjSE8kZbs4Hor+huu3mEk2D7bf+itw+G8ZMPW8Dp3BJYrdXx4aW
         ZDFnyMRYZ9Uj7bDBHJ2ABeNRApAcFcsWJJTVmP8CnkMoGTdLIQpctPHS6tq4A6KmWCAV
         6eCmk1yYE1nUrps2GPbzeP8swESG1oEFVmE6bb+cqz4aWxiyOj8bHTUyNjPW3qj33e3R
         AWuoSXJiqTRpcf4tcs8o4ud/Utb1jYdpGWZtrAlNox/4kQcEj14I8eHhGOv/XmdlFpvb
         /EhLQbiah2ZmYTvoq85f7y0xN9zmEF/LXHAwOZOxDclL7lz2LNOgwdK0Yr/8iAQBr9v/
         Ik6g==
X-Gm-Message-State: AOAM532Hq9atU1Zq22sRPTdZ0GBb8GAEKDVeFn+ySzLSVxo/ZVaiVwA8
        CjHQXB0xS5d9c2XopOGD/FBELLLpJpY=
X-Google-Smtp-Source: ABdhPJy6fLccRCpK+3FKACQql0+vKQu9X4vpdIEbKHczTPEZLGWvGt9VRJ5gcRhhJYaQsckPnlCgow==
X-Received: by 2002:a17:902:e0ca:b0:158:cc0a:44f7 with SMTP id e10-20020a170902e0ca00b00158cc0a44f7mr540751pla.70.1650561516157;
        Thu, 21 Apr 2022 10:18:36 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m12-20020a62a20c000000b0050af5c925c3sm2881373pff.132.2022.04.21.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:18:35 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/4] ARM: dts: qcom: apq8064: Use generic node name for DMA
Date:   Thu, 21 Apr 2022 22:48:06 +0530
Message-Id: <20220421171809.32722-2-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-apq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index a1c8ae516d21..b2975be3ae04 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1040,7 +1040,7 @@ sata0: sata@29000000 {
 		};
 
 		/* Temporary fixed regulator */
-		sdcc1bam:dma@12402000{
+		sdcc1bam: dma-controller@12402000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
 			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -1050,7 +1050,7 @@ sdcc1bam:dma@12402000{
 			qcom,ee = <0>;
 		};
 
-		sdcc3bam:dma@12182000{
+		sdcc3bam: dma-controller@12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -1060,7 +1060,7 @@ sdcc3bam:dma@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc4bam:dma@121c2000{
+		sdcc4bam: dma-controller@121c2000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x121c2000 0x8000>;
 			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

