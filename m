Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7801D599030
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiHRWHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345210AbiHRWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D529D25D7;
        Thu, 18 Aug 2022 15:06:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j21so294121ejs.0;
        Thu, 18 Aug 2022 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/p7wEsx40ftm7k1b0tuUKI3U1MknbT3BVCyH8Q6QIMU=;
        b=O7gPhKqOA0e5MnX3kqEysQ7xDxR0LdWdJTtp0H1JYMxXNafSfWudGmq7yFKqCD4U2X
         ZGW6JhJjTqhBSY8Wqxekj6ZUq40biTjtb+vzGF9EFk5FRMJUy9S+pA2yCIq+Thn3B+ib
         2VSz38MptPDZlsrJEuO6pwRL7+Rl7bMI5yfe9XtPthli/btDuO2JnthwjwhHs+2Ke7il
         Wbsdo5FdpQ/x8ZvehO/d1prc8dFPbYqQuPXu1/k7t+264B8OEv9TLeJTOhJkiaZVyyP9
         788fkhpjdD8jDLLvF70xgyluNBXrJAU3veWN+gefn8dU0BaEii8kNzWuYwpI0F9BcksO
         hgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/p7wEsx40ftm7k1b0tuUKI3U1MknbT3BVCyH8Q6QIMU=;
        b=ENbeHRJf9oj6DDlpzC6ifHUHx2r2DPeJOLeyrAMYh6aUM41kAZfmZL3X7CBc9IF++n
         +mfVCzTN3ilamZO4eVCa27b2fo/9Mhrvpd/FzKbnWkPjqdGyvBLVWw3smX6sFCj265Pj
         WYlYOVpwYbTgISIcGLpHpyzDLSdaTY+66W0maZn1F8tPLTBKa5EtwYhcF3QIqErshQAS
         kqocMg9fEKK5MTMQxp0ZB3YuzinDaPYae8PnIdKm2zdrGS2mF1k6E/1z1keUC1LfpKbI
         PlFeHDZr05L/ft+ITj6mDZJzs7Aydvn6UoEBDAms3bGCu8HOe3lXJYPbcsFqnc16uWFf
         kesg==
X-Gm-Message-State: ACgBeo2C5X1njPrtosvWMwAMGypKWr1vWf1CYXADTDDMEwtsvEIMSywU
        MDdPifcjadd8IH0uCo+U7cI=
X-Google-Smtp-Source: AA6agR4fdYnQnGN3buSCRWdAQjBgFY2MsSDF7MfCymXNJOZKGU1skM3Y2SD1j+dAwwTgceh1EvRqwQ==
X-Received: by 2002:a17:906:b2d4:b0:731:4594:8ba1 with SMTP id cf20-20020a170906b2d400b0073145948ba1mr3088359ejb.288.1660860399732;
        Thu, 18 Aug 2022 15:06:39 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 9/9] arm64: dts: qcom: ipq8074: add A53 PLL node
Date:   Fri, 19 Aug 2022 00:06:28 +0200
Message-Id: <20220818220628.339366-9-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
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

Add the required node for A53 PLL which will be used to provide the CPU
clock via APCS for APSS scaling.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 5b62d7590fc6..bace14b742a1 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -709,6 +709,14 @@ apcs_glb: mailbox@b111000 {
 			#mbox-cells = <1>;
 		};
 
+		a53pll: clock@b116000 {
+			compatible = "qcom,ipq8074-a53pll";
+			reg = <0x0b116000 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.37.2

