Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC9596E13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiHQMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiHQMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A74F651
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u1so18735807lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DbSnvFkY9bvjJ+mlDkzyxC4/7mNnK/XqOObaGJH93/Q=;
        b=VMufVlr3u+pUoXDgiGfPz3XPbBKafmaGKzn6bmaiKba1I9hURUbjKqgBD+zt+6qIze
         mfMFjg368kc1fsOcLA9OOX9n2WPX7rdgGCNIH8zYVuacBApl820j5gHk5HmoLYZEER97
         G890T7nHXRfei3vKzNwaeJ9chudhIKO9FSjEDLZp6eFNMKP4PXp7j+M6tNzR4iHB09hs
         RT8kt3uhjfvG6Ib6KqlmOsiwXjJp7p3kpS6LvLD/mjTwGp0syZBVuhaBSFlUVgT9rJC3
         3oOMQmK2vGBr4Wxd/v++GFjJbylPmlfrhWbV7spBctETRf84nJh2hyAXrmUxgbnPclNL
         tBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DbSnvFkY9bvjJ+mlDkzyxC4/7mNnK/XqOObaGJH93/Q=;
        b=OXeQx0tvuMdP06O7wH3OKvmAXUCKI+TrsBkZ4kEDZV5M9ZoBvg//FyYtHDdJgQfqEZ
         O6RA4dYy90Oeblbpv/uuyJbltt+zz+KjBRmTZcm4yPIahybsZlzZUh/Kp+4Ss2cvT5sf
         Dfm3aalFvr8lC9jXVmFsXI4NIlPj2nLJBoDYOhx4Hvel9v6Tqqqr1jytqFLRG1Bax+bY
         tLbW60AdV8i3HbcBoPt41Em0MAmzu2CPNu6n0YouPBtgnpvpA30G8PnybSxJujo8WpuO
         xgJxp/HOOnpDMW62iC9O0xwe8LmjC1zH4HSOARINSm3zytfZrV/R0cvuQR0rpSYuSVmS
         zzMw==
X-Gm-Message-State: ACgBeo0ITHGU863fYhTeC92skn0veZQcyxSyPwDwgCEizu45dUoqkmUy
        i6LxRVS8iOwq4PhJk1z/qw0wEQ==
X-Google-Smtp-Source: AA6agR5iQBUte+94JslVCBUtz7QXQfDuFjA1iFoSnomMCkgrjB2XEOCZ7NyAh6iO+SvCaj0s605HRw==
X-Received: by 2002:ac2:499a:0:b0:48a:e96b:9f66 with SMTP id f26-20020ac2499a000000b0048ae96b9f66mr8259895lfl.12.1660737865730;
        Wed, 17 Aug 2022 05:04:25 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 08/14] arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
Date:   Wed, 17 Aug 2022 15:03:57 +0300
Message-Id: <20220817120403.458000-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
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

  qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: hwlock: 'reg' is a required property
  qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5d2dd21da79c..e8debb0da411 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -555,12 +555,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
@@ -1462,9 +1456,10 @@ ipa: ipa@1e40000 {
 			status = "disabled";
 		};
 
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_regs_1: sycon@1f60000 {
-- 
2.34.1

