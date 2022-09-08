Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1D5B1865
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiIHJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiIHJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:20:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14F4BA40
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:19:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z20so19131183ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/UI25rqJUxEZV+KxQUPmeT2zHV2+PmX8LADJ48o6xoo=;
        b=KBODdy75Wft+JHstPoIvy6Q557uXJSD1mFwan7/iXcYA7kysX9VJjfyEhjvakhJ0K+
         DMZ0ps+Fa93+mZhlt7iqnX9E+ZUqVjUxFTKGy0Atgm25gt+AziBCYD3FWrNLzcqiuy7y
         n7fVdSZSg+dKka17HviQdRY0T631/K9WoXSBXciVVyX9pFW0Z/R6wJbk1OY+ohkSeyER
         912FxjZ7PyN3lspzZKABel0q+2E3MAkJBK1KctKlra4I4rV/lmASx3Biw/vCCPInLWQr
         UFFMOqoH+400C39UitmEEHvaAPxItCV9THPQQbMJ6q0aE+Rsm1OitYYuXXyJjnxA/Dh9
         O36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/UI25rqJUxEZV+KxQUPmeT2zHV2+PmX8LADJ48o6xoo=;
        b=z42pRKaNe8S8LCn1MUxRcW15BWCdAbATAuQuu2rUfiwE8StvOpWcSa9EpVtCHl3SzU
         ewFlYqf8TWdh/NeLig0KwOE+JoR5vAa1ROsM04zBe6EWEmHcaymwuIW8FAh7wMlUidc0
         aPb3fdK1TfbMPGBKNBmXe82hOuTr4WNQ/AH6ZNaxXiqgm75dcgmpTuwcVKB9MaxSH+DR
         hKckahftPwZUN3jOEmLJDttYXM6N8qYwbJ4t+zYEgcK9OLZzcvPYYoR7LJ4v7PAYQT0D
         /PWC/w1SJJH85FrV/tVI6rsLwU2nYYQPuIhCIfgd62VB+yLlshCDAtGq3QrIiNOB4jhP
         Ud1w==
X-Gm-Message-State: ACgBeo0ixKY92EFzUlWAopRMcx/byOkJsk7fksAMQUuhuRZBFqlJOFI7
        UtgEu3ZEhlKpNLBi9mKhiV2PCA==
X-Google-Smtp-Source: AA6agR6qEO8uDknL2F7QOCw5O93PZp02P6M/Hq4sZ3Zhi5sScHvtdEE+/aV4Wp32DbyE32qUg1wc6A==
X-Received: by 2002:a2e:a90a:0:b0:261:d622:248c with SMTP id j10-20020a2ea90a000000b00261d622248cmr2085650ljq.332.1662628798161;
        Thu, 08 Sep 2022 02:19:58 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a056512211100b004946a758d21sm218219lfr.161.2022.09.08.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:19:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/14] arm64: dts: qcom: msm8996: align dai node names with dtschema
Date:   Thu,  8 Sep 2022 11:19:38 +0200
Message-Id: <20220908091946.44800-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects DAI node names to be "dai":

  qcom/msm8996-mtp.dtb: dais: 'hdmi@1' does not match any of the regexes: '^dai@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index abc17c905bfe..b346ecccb94d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3402,7 +3402,7 @@ q6afedai: dais {
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#sound-dai-cells = <1>;
-							hdmi@1 {
+							dai@1 {
 								reg = <1>;
 							};
 						};
-- 
2.34.1

