Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5B526ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384034AbiEMUF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383990AbiEMUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:05:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C12E688
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:05:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m25so11431263oih.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7P70puUZHaHmUVj8T6SQ30J3AHLPBrp4nUTfVql+nLE=;
        b=dWiFAderwMSYvobHS0LcrsKtUKhNp0PCSCbqakfZOC+Uy6AD96JBENhHxD4Jg1d3pT
         PKqnpSoZHCEhvknj+YlyAAKJMrdTpjipizNEdgcWcZJyXSF9HQrCweUAKH5/YlySONxD
         ppwBVNh3+mM/Hw9PiHpp2Mjoehf5li4zW3AZAZJeCEbYr+ePRxehb8VV0HZJLVpiU414
         EvFmi0Pmh04M2yDOGg425Tm9oK/t5oChbNDhN0S4BLEnybYNLmQsfujawcm4BSxEs6J9
         uGn8CnLB4/nYfmKXG+vrmszs7ISXHV0TPoKr5EHmubYQs62rZGr6C8ZcG3SaQ4hrCe+6
         M5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7P70puUZHaHmUVj8T6SQ30J3AHLPBrp4nUTfVql+nLE=;
        b=cyvF6ZYtKJVvaKWN+MIgYBz+4bpERr0AF8pN7fM7Sl5Y5yHcYmYX56MbwfH7KcKTh6
         vs/xuamqLEWLiWjsdQxMX95SZ5YO8fcmhC/1P12E0G45Ex9fEQ28er32lHKOPi9IOMHF
         n9MbzFX71fRMGe9PtZn3seUXc7iDfWO9PAqjQk2ph+f8UYv/gviR9QmFVgMA4PulsMU0
         q+JMm7td+MhFywn7IWw32fYzhfsKKRL04UbqDgDho76M9jgo7rg3dbDXzfusoJ3e/U2p
         BabIWZzifO5TgyzYnNEKYDREg7HeMdPHjA9veFaRX2p5c7lSVKjHx/nVdyHNtdQPGPuz
         HWKw==
X-Gm-Message-State: AOAM533wvSPBPLPdBeuEJk34kxJpPxgfklpaWnMRrjmS7kcowg0UvDY0
        AurCvl6IMaaJ1O0hXWjPNqdq1w==
X-Google-Smtp-Source: ABdhPJwZl+46lDdpUkZuLhi9JpRrD2DGW8k916M0oCnnMgPilPwtijVfM0QyS9/DGQWxNrFIFVS3Hg==
X-Received: by 2002:a05:6808:bc5:b0:326:c2e8:2d2e with SMTP id o5-20020a0568080bc500b00326c2e82d2emr2963358oik.97.1652472347264;
        Fri, 13 May 2022 13:05:47 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d5c81000000b0060603221240sm1456962oti.16.2022.05.13.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:05:46 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v3 2/6] arm64: dts: qcom: pmi8998: add charger node
Date:   Fri, 13 May 2022 21:05:08 +0100
Message-Id: <20220513200512.501156-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513200512.501156-1-caleb.connolly@linaro.org>
References: <20220513200512.501156-1-caleb.connolly@linaro.org>
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

Add a node for the smb2 charger hardware found on the pmi8998.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index da10668c361d..962a8719b07a 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -9,6 +9,23 @@ pmi8998_lsid0: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8998_charger: charger@1000 {
+			compatible = "qcom,pmi8998-charger";
+			reg = <0x1000>;
+
+			interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+
+			io-channels = <&pmi8998_rradc 3>,
+				      <&pmi8998_rradc 4>;
+			io-channel-names = "usbin_i", "usbin_v";
+
+			status = "disabled";
+		};
+
 		pmi8998_gpio: gpios@c000 {
 			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.36.1

