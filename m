Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA097596E25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiHQMFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiHQMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31E4F6B3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v10so13331652ljh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G5Gw9O1HRC2HZ2RUee8k0rPKQP+uhhOAxZLOGmh5CkQ=;
        b=FO6pkLjUvDS7GG3+dFzSYGZfDf/jqiKePe8B9y9yiDTDJCtSzPJYtScOvXgGTpYxSJ
         HcEJ3tBn34XbI4eHscrmAQDRaytwwXOYG8L6DZdN0DLsoH3lD3sYvRvXjDf7tsDL3Lxu
         mi3KXPa4mN4j45quv0b0nLakPgll63tmV4JvhICcJ/FAhwDp0f40wCuaha7fK9ASEhUa
         oDEs/yUILjgjgokjrVY5qO9R7reBi0+FeisMvr9nJ/2XHe6nBDtBNbwRcMJOZmeRlOOH
         r816zprWZiMRQ7b4Xm/LZIre1x7ldNzaEKEtqjPi51XiK5JkRGZmyy2zwvbCt3hfh2Le
         +e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G5Gw9O1HRC2HZ2RUee8k0rPKQP+uhhOAxZLOGmh5CkQ=;
        b=MfeUVE/A3FNhhOmX8y/h1twBKK/+pwTzRCBPN3uTQPFvNe3BbTCaLg7DZwyGrE0RDX
         ZVAU+i4Q6kiT9W9EJA1N3FEqBDgrYYGsYI/mFpZrwz+uewzd7oWs3t/wc5SSDexKs53H
         JOy4xcFHZsiFwL3LdJtCHmcUY1p1+5Zw3SzGoNE+SwqsHFKfb/4MJa2CNm4asekwQtWI
         oPZcq4EHKHvxFbsSjNoRIuhCJyX/qIMAeNeJkrEQd4P2WTaSTL8Eea8EBkrembNmJzrC
         UtPJ/HLf3pqE2fli7lhm9HQcsx2wBGuGD/hfKNRrYD/VwMjYspeIAi+nnRnEh7/UugVv
         +cBg==
X-Gm-Message-State: ACgBeo2BFYLOd1DnYt2avFIpp8L20hQHSuzQLVzGmUmCAYa0QyslTw0+
        zcbyDabstPQWLjKBn74GeM7KHw==
X-Google-Smtp-Source: AA6agR4IHiOubNO+AQY3O5FQFJEvUcmjobZ70PRwztSjlcEHmpGYy8OKKZMrZ78HD0ApkyktFlQN8Q==
X-Received: by 2002:a05:651c:19a7:b0:25f:dcbb:c9d1 with SMTP id bx39-20020a05651c19a700b0025fdcbbc9d1mr8064112ljb.450.1660737868505;
        Wed, 17 Aug 2022 05:04:28 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 10/14] arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
Date:   Wed, 17 Aug 2022 15:03:59 +0300
Message-Id: <20220817120403.458000-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR halt regs are next to TCSR mutex, so before converting the TCSR
mutex into device with address space, we need to split the halt regs to
its own syscon device.  This also describes more accurately the devices
and their IO address space.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0e286715d1b..21ed14200986 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2590,7 +2590,12 @@ ipa: ipa@1e40000 {
 
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
-			reg = <0 0x01f40000 0 0x40000>;
+			reg = <0 0x01f40000 0 0x20000>;
+		};
+
+		tcsr_regs_1: sycon@1f60000 {
+			compatible = "qcom,sdm845-tcsr", "syscon";
+			reg = <0 0x01f60000 0 0x20000>;
 		};
 
 		tlmm: pinctrl@3400000 {
@@ -3207,7 +3212,7 @@ mss_pil: remoteproc@4080000 {
 				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
 			reset-names = "mss_restart", "pdc_reset";
 
-			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
 
 			power-domains = <&rpmhpd SDM845_CX>,
 					<&rpmhpd SDM845_MX>,
-- 
2.34.1

