Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78413597259
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbiHQPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiHQO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:59:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3C9C8D0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u6so13815079ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1QVlzwLkNHF9UXsx3O2rYGkmRfJt4dkKS0KBL8iUsvc=;
        b=oIwHG8Q0UTc/nnEojy2dnPB+7fFarHQ3xuFjgZx8724qo1OvEaXCPUj6KTN7pcLRmk
         aXgilgoTWPgTF2J5Zhz4jID/tJYQA/X6zuiEU5AoH6FkW4SExKiAappKNyZu4e3sWXXQ
         kTFVa+4EgxMq23/KIktODUpt0Jl6lOSWYgwIiFgled3j5sE/IkCeuaoajYW9cikUnwzH
         pQLQwn4d2bqTB18BTAL2CLM1KJhOPPk1Pz8MdKaqtg62XKGBeo+S/g2JewjEe1W4znjH
         Eqj1e5pDuSoSVGGQCs7nLPZNJxDxrsw5J72+AQx1kS2Bv/OZrzTVisRhYcIlMfbzX03U
         eFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1QVlzwLkNHF9UXsx3O2rYGkmRfJt4dkKS0KBL8iUsvc=;
        b=EPYGVXB95umsYYvLbwU2rsyKpJwaxrK0pciNlxoxgsMdgb/iq8kXjVV48jlfjYjYiO
         yGs1Ct1HAEHlCmAYhYsltIK1Twy36FdtYGu9dvY8eEwL7WQJ1X6YnnWHGAgZBaw1m9cY
         y8CXDuBilE/RsbUHLf1zHkIEzdm4qqDNqOUFzcpwwZA1wq/fuIBXhD6SxrdXzEHJXgQW
         L9jiggLIJDW57VYtgcjS1SeVWrsWLGGnWdQt9CZde1BkddsZPvAQBrDMXHKUQkrLUm4X
         1RTI6viTTfUbiC1OwsRCjZV7k0GnFmswDoLAC2N5pUQ+N31HtlnHrgRPUWm6x8M6Bg/C
         Z/UA==
X-Gm-Message-State: ACgBeo35rVFIdm7rb8M3jEMUfFrGGQHkKUGqrcOVjAPRjbOAqyfsCKBp
        sbhazu7SzKWTxatWfX9Dl3+k/A==
X-Google-Smtp-Source: AA6agR6p9WUsnF6L5gnP+KvhZ7MoRuiIVN+hxXCSQ/ongmrKvd7AzjPCWT0zum4yNSbSEox5v+uRDA==
X-Received: by 2002:a2e:a808:0:b0:25f:f326:f2ab with SMTP id l8-20020a2ea808000000b0025ff326f2abmr8527111ljq.152.1660748373382;
        Wed, 17 Aug 2022 07:59:33 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2250454lja.111.2022.08.17.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:59:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 15/17] ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 17:58:59 +0300
Message-Id: <20220817145901.865977-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom-msm8974-sony-xperia-rhine-amami.dtb: tcsr-mutex: 'reg' is a required property
  qcom-msm8974-sony-xperia-rhine-amami.dtb: tcsr-mutex: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index ada232bed2c8..6bb06eaf08fd 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1228,9 +1228,10 @@ smd-edge {
 			};
 		};
 
-		tcsr_mutex_block: syscon@fd484000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@fd484000 {
+			compatible = "qcom,msm8974-tcsr-mutex", "qcom,tcsr-mutex";
 			reg = <0xfd484000 0x1000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_1: syscon@fd485000 {
@@ -1719,13 +1720,6 @@ reboot-mode {
 		};
 	};
 
-	tcsr_mutex: tcsr-mutex {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_block 0 0x80>;
-
-		#hwlock-cells = <1>;
-	};
-
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-- 
2.34.1

