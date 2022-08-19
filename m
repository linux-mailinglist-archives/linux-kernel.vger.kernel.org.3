Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392E1599724
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347245AbiHSIdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiHSIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245D8E9A82
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b38so2614045lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+kinn7FouMNpw/yKeKaQATpcIgCOeso1VYgBKDbxVYo=;
        b=RKXxm+SDvm6sTqNszupfoIxaFYIrwkDEug0oB549p3/EqwD2n6PQ78FLDNtdCf7Vsx
         bE8bYf47YP7rsQT9ixmS0v4FEI07qlBaJfWCi0GkDRZWoafSebX3KbQ01N6bSNpIPY2U
         6103pvlb+gsnIu8Go516RXltyk9PgAx92etxTsEVpxVgTG3QrzHjiLBB8LO1O2MLtGCf
         gIyt/IiNQNyuOfeaG932bihxCoSGmPqDDwhTzFU8iCS7aDu1OcwrfGHxabeqZgdjLaAD
         pJxtBZ/DDaeGS3fgIZdrbjGGwnGLV7oioWVPZPvVX3k7j16qxrWaFSbOSiHYU+Mn1NAK
         wXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+kinn7FouMNpw/yKeKaQATpcIgCOeso1VYgBKDbxVYo=;
        b=hJmc6mL+WnMJvsYHV/Jd1g81l9m4vlnsoaK1UEna3nFSZjllSc8ONKe3FHG3JvjuAC
         QzOr8KdX1+2SkuB9ozwojkU2apTM5+HQ+1bAJSPZhnUsGPclkEZX6mJSBCo3iAh6J6rN
         OrmbarloQ3dL4dCn0hcUcNr8/fUSvlH4Da8sBErXrPYGYLyv+EgRn7tWCFVH/K0OMSe7
         TY2P11MLK4yLzxT4xWITP80xJ09AQaEsTlqxp4yEumI4jvihWNdzGcKQj5eL00BHVn3j
         MlT09sWOQSvXPUSH5MebPuLDnf/sU0Rj5eAlTWYlU71PTxV5jZ5XDshT+rwfzLUQ4nPz
         JJag==
X-Gm-Message-State: ACgBeo0vIU82F8eFUkY5foL/vJJTFzPp1ZDTtCxl2NlBYk1+eVijyEex
        x7ecJSjd4BqHDBVmbGNqUIz4WCxzmqyDNAC3
X-Google-Smtp-Source: AA6agR4CLMLtr/xKoBlXz1v1rcyLD+1DC3Zg/+CkiI0xDB8n0AYOii5VQNkb2YO578SOgaaXHVnYXA==
X-Received: by 2002:a05:6512:280f:b0:48d:81c:27de with SMTP id cf15-20020a056512280f00b0048d081c27demr2141319lfb.378.1660897951498;
        Fri, 19 Aug 2022 01:32:31 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 13/16] arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
Date:   Fri, 19 Aug 2022 11:32:06 +0300
Message-Id: <20220819083209.50844-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR halt regs are next to TCSR mutex (in one address block called
TCSR_MUTEX), so before converting the TCSR mutex into device with
address space, we need to split the halt regs to its own syscon device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 1bc9091cad2a..a4f73be3d60a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -699,7 +699,12 @@ tsens: thermal-sensor@10ae000 {
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0x01f40000 0x40000>;
+			reg = <0x01f40000 0x20000>;
+		};
+
+		tcsr_regs_1: sycon@1f60000 {
+			compatible = "qcom,sdm630-tcsr", "syscon";
+			reg = <0x01f60000 0x20000>;
 		};
 
 		tlmm: pinctrl@3100000 {
-- 
2.34.1

