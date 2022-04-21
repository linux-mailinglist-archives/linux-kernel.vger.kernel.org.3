Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8C50A6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiDURVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378036AbiDURV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:21:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4849F81;
        Thu, 21 Apr 2022 10:18:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h5so5195022pgc.7;
        Thu, 21 Apr 2022 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0mS+CbyPGtukceaF/klhCcJFKXw/icKEp31Ms5uCAs=;
        b=k4Yxh9YLP2aZqH3OncFP3bBDXxeJyPqp+l6T6jwYJo22BS3vKHs1yQ/BDUPaqZzeO/
         7Z9sBNqZR5aR37b6rMZWBxc7gMuOA0ZqtA+SSw90oRGRCZKbvAgNwgj4mSNsrIZvoM4a
         5SHR8hZQMyZGfGHKUIZeMvpiv0goyWk98ZMuC/I40+mgdOmuEJqxTf/UtQCnfCnFZ+0e
         jIXZOrSaoARruK1Zrtdm0Ke0nYgr2yeNiKZQVWqaK5DRO2IPPseePvUXnq6edCXn/Jul
         uPaPN0OAORWmBH/MiLmP3llKpk3MvQGh3MqyB6e7OLD8Q1z1Bhd5g2HIM/8YvWHTphxo
         92ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0mS+CbyPGtukceaF/klhCcJFKXw/icKEp31Ms5uCAs=;
        b=fpwqNwn4ohCNwigHUJ3tTZTRzfSUcprY5Am3w8VSfMijkuhQgOlhpQvJAqOltj1Oif
         8lEl76SNkjVrBzFNw1msENmD3g+X/WGSW61gge8c/GUECBfSORjSvAL0YkPnjEdCDrqD
         DYeVwpTTSGohq9I+AjyFcV9yoSkUZqSkM/u3C7Kb3KeUDNU2OD49xt9exwL9SEWgHecv
         elxjES13zZklsXH4kiLBJMvmh7A7E/sYiH34Ce7JUbpfwytKI/xVofCnXpeOf+WSbHnP
         JkuDajdAd1rJFJ+3YYR/AhMWcUmByqepEglzx3ZllO8q0tlEdcLMuZC0/UgFmsxbZQXZ
         Oa4Q==
X-Gm-Message-State: AOAM530oVI5o8qFh/aICaq14SNplImAVMrkCvZHPovBHvAcWENfZmxIL
        9txkZQFT87GUCe7rNw+eWysM+bIAV60=
X-Google-Smtp-Source: ABdhPJwvRplzobGlZFpii7lewaWETDmZDxhh4kEJyYxxBWGfGuTRKi4UrT5nQxXQyDUFq2BK/0sdNA==
X-Received: by 2002:a05:6a00:21c6:b0:4fa:914c:2c2b with SMTP id t6-20020a056a0021c600b004fa914c2c2bmr654863pfj.56.1650561519443;
        Thu, 21 Apr 2022 10:18:39 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m12-20020a62a20c000000b0050af5c925c3sm2881373pff.132.2022.04.21.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:18:39 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/4] ARM: dts: qcom: mdm9615: Use generic node name for DMA
Date:   Thu, 21 Apr 2022 22:48:07 +0530
Message-Id: <20220421171809.32722-3-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 4d4f37cebf21..8f0752ce1c7b 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -330,7 +330,7 @@ pmicgpio: gpio@150 {
 			};
 		};
 
-		sdcc1bam: dma@12182000{
+		sdcc1bam: dma-controller@12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
@@ -340,7 +340,7 @@ sdcc1bam: dma@12182000{
 			qcom,ee = <0>;
 		};
 
-		sdcc2bam: dma@12142000{
+		sdcc2bam: dma-controller@12142000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12142000 0x8000>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

