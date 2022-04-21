Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9746B50A6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390715AbiDURVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377536AbiDURVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:21:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8396B49F8F;
        Thu, 21 Apr 2022 10:18:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h1so5573211pfv.12;
        Thu, 21 Apr 2022 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyoYT34vE21reYxzXT3S3S+WDIUzizq/vDe74t4Cwr8=;
        b=qvzKtsP1Y0/VWah6IFCnyoVaK6EvV7E+2ISnCNSf4H4utivqw1eHzeERWSgi8LV7F0
         JH57DrBdHTrc5QoRKOVZ+llH0YnYjtjCMS2ClB3tw06ZR1305IdKqtWCiC8dijKuDY0o
         7hGxs3M42nP1IpuVHRIOnqn/yPcYRWYdu7Qxs/9RpL1WvxnOmd5Vd5bKI6HvZy75YQQv
         YhfqbuyAcMkYu62BfL+fY+aTBf2UU7E9mAGvJaCjCQ0hSmdJyt1TKUrXBeS6OAVZboO1
         fIVXy9lrW485UpNnvreDTLLY0sNnqyx+gQLI+QsAiuA7j6gMa0VAI9HdNA3HTogCgo4w
         AZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyoYT34vE21reYxzXT3S3S+WDIUzizq/vDe74t4Cwr8=;
        b=xhpFs52yMrD/QcQdkK7rix0K+rc0F6bUXpTR8oNzdGE9jaI5aKa8Q+eSHHN5AK+5aL
         Cb5OdMyMymLjU7f+/lpyjWONACGzbtEW48S5mxfZ5FweV0Rv+JH4Xa2FE45dlqp5p78A
         UILrr9XftvIhfZvsAvs4cMcP0C4GLWW981y820HfKgucs8rwIgmhVvq0AFqfPCf4lGIZ
         5WWT7gbD8QDbzZXhcMIU33M+3oDSvHNyd6ceHYx4aqbkzCkWiGwZ6V6/nTfbofNv5+w6
         ls3QrE8WcTzbFwZ922vHC432VtHXV2aQTw5s/agE93EiGNkENMDd17d6YvfqmGuF3NdI
         pBMA==
X-Gm-Message-State: AOAM532iv6LN1aXgOa26Kn20jpEwWPSkBmZdRSrBsc5E7pQNpeV+VBNB
        2LbxweCjszQluIGqi/mQ3RU=
X-Google-Smtp-Source: ABdhPJzfX9nqlUdQMaArgX4raoVcmqpsbGhxGEyQUJdkCxiSnS8nzjEQZsIn+LmmP9/rTTziRyYM6g==
X-Received: by 2002:a63:4a09:0:b0:382:597:3d0d with SMTP id x9-20020a634a09000000b0038205973d0dmr423741pga.18.1650561523037;
        Thu, 21 Apr 2022 10:18:43 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m12-20020a62a20c000000b0050af5c925c3sm2881373pff.132.2022.04.21.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:18:42 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 3/4] ARM: dts: qcom: ipq4019: Use generic node name for DMA
Date:   Thu, 21 Apr 2022 22:48:08 +0530
Message-Id: <20220421171809.32722-4-singh.kuldeep87k@gmail.com>
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
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi             | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index 0c10d9e096db..03bb9e1768c4 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -64,7 +64,7 @@ pinconf_cs {
 			};
 		};
 
-		blsp_dma: dma@7884000 {
+		blsp_dma: dma-controller@7884000 {
 			status = "okay";
 		};
 
@@ -89,7 +89,7 @@ serial@78af000 {
 			status = "okay";
 		};
 
-		cryptobam: dma@8e04000 {
+		cryptobam: dma-controller@8e04000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
index a7b1201dd614..79b0c6318e52 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
@@ -8,7 +8,7 @@ / {
 	compatible = "qcom,ipq4019-dk04.1-c1", "qcom,ipq4019";
 
 	soc {
-		dma@7984000 {
+		dma-controller@7984000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index 7a337dc08741..2a43367692fd 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -79,7 +79,7 @@ serial@78b0000 {
 			status = "okay";
 		};
 
-		dma@7884000 {
+		dma-controller@7884000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
index 94872518b5a2..0107f552f520 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -52,7 +52,7 @@ serial@78af000 {
 			status = "okay";
 		};
 
-		dma@7884000 {
+		dma-controller@7884000 {
 			status = "okay";
 		};
 
@@ -62,7 +62,7 @@ i2c@78b7000 { /* BLSP1 QUP2 */
 			status = "okay";
 		};
 
-		dma@7984000 {
+		dma-controller@7984000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a9d0566a3190..258510eb30fc 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -233,7 +233,7 @@ sdhci: sdhci@7824900 {
 			status = "disabled";
 		};
 
-		blsp_dma: dma@7884000 {
+		blsp_dma: dma-controller@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07884000 0x23000>;
 			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
@@ -300,7 +300,7 @@ blsp1_i2c4: i2c@78b8000 { /* BLSP1 QUP4 */
 			status = "disabled";
 		};
 
-		cryptobam: dma@8e04000 {
+		cryptobam: dma-controller@8e04000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x08e04000 0x20000>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
@@ -471,7 +471,7 @@ pcie0: pci@40000000 {
 			status = "disabled";
 		};
 
-		qpic_bam: dma@7984000 {
+		qpic_bam: dma-controller@7984000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x7984000 0x1a000>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

