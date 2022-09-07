Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFA55B01A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiIGKRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiIGKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08DEB8F30
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:16:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so85524lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=751surAPxPI7nKu0MMgW0W0B94zgA9MhkjYrnO7nGnI=;
        b=o5d+FdZnHGKmhZkD13oEr5F2G7/5qQRMGIc/xYqsZnha5sQxzrPVMX8IVbRTOKbcxw
         OAomQ+Q2KiUCOBAijRgd8owZ2Wc1aWPqqMusrNIYCPHkRrEy+m0NGndmwxFPYFV1zi1Q
         xN4/jxTG0tzd9/FdscLVJofV8cfq92yVgM2vsyL+U3qznumg0+2pZllHn+EH7KmkP6m+
         ih0hmX98sQVmXnYZ0dWgAC0/4s+/IYCCxVkhWv2R8eCKovkjAAyBIjq3KcuIFH9oJlF7
         ZYKNmHoWudAgOgpkWpR2+9zPqr6ZHpeqEyKgC7h64hDjsDetrjXqQPFs7zlQZavgITJG
         Z0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=751surAPxPI7nKu0MMgW0W0B94zgA9MhkjYrnO7nGnI=;
        b=XWIvOHyt4p65Fi9vTpBxeC7ASGuEZx6HipOURXKDayINPdscpU/SEpU7USikufU6ib
         uevFew+qoRqR/XTzvW7wI4Ueu+1bcLRS29c/hRDgWnk72DC0WWyKp871pJ030Pn9E8Er
         0KynvR1FyLs6e8UwS4i3pAIAMKt8XkxB1SwJsoql7J65VDyi+H9ag5z6xkNWgPKIf034
         j/ouhA5od3hCnFNjlpgwZDmnyI0cgdxksc0S7gYqWWJXLA9wHMgVnVfjLXjZi94aOmim
         hq2fTql6VpYnQbcqxzkTXx4QskiNuEjsP4Wo3yNVdDBsrzz8Bu0KGnX7Hx9r3ReaFlaq
         ZiVA==
X-Gm-Message-State: ACgBeo3e7P34z8KIUpX2gd1wVlB5hiKi7JNx9vJTBTYKUiZMQPmPYcHt
        42nciSvZOI3WQZwmn5sbBRY3fg==
X-Google-Smtp-Source: AA6agR7C/OFIpW9w94tqGiShtUWVPncRPvTDDLGRPNEnmp5S+qRQa35ahQen3VhMVvQmjiaL71XG1g==
X-Received: by 2002:a05:6512:3502:b0:493:e21:b77d with SMTP id h2-20020a056512350200b004930e21b77dmr843355lfs.580.1662545768897;
        Wed, 07 Sep 2022 03:16:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:16:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/14] arm64: dts: qcom: sm8250: align APR services node names with dtschema
Date:   Wed,  7 Sep 2022 12:15:45 +0200
Message-Id: <20220907101556.37394-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects APR services node names to be "service":

  qcom/sm8250-sony-xperia-edo-pdx203.dtb: remoteproc@17300000: glink-edge:apr:service@7: 'dais' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index cf5d65940174..84b4b8e40e7f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4782,13 +4782,13 @@ apr {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					apr-service@3 {
+					service@3 {
 						reg = <APR_SVC_ADSP_CORE>;
 						compatible = "qcom,q6core";
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
 					};
 
-					q6afe: apr-service@4 {
+					q6afe: service@4 {
 						compatible = "qcom,q6afe";
 						reg = <APR_SVC_AFE>;
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
@@ -4805,7 +4805,7 @@ q6afecc: cc {
 						};
 					};
 
-					q6asm: apr-service@7 {
+					q6asm: service@7 {
 						compatible = "qcom,q6asm";
 						reg = <APR_SVC_ASM>;
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
@@ -4818,7 +4818,7 @@ q6asmdai: dais {
 						};
 					};
 
-					q6adm: apr-service@8 {
+					q6adm: service@8 {
 						compatible = "qcom,q6adm";
 						reg = <APR_SVC_ADM>;
 						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-- 
2.34.1

