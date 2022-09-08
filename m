Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045685B184E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiIHJUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIHJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:19:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7633A28
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:19:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y29so6532795ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8QkNF8EHcAEMbV0p0CldmJdisF79bfeyCTRVHy2ZadQ=;
        b=rxs/2KJmQND0f4YtkkIpIgXlcndtvWbuYzB+5X/LcPEYzOV5thoVP2fQDQgz0c6dsH
         8Tt+BrSXHBZbujQu7Rk6eDH32O5VxLIDREHZiq6BwE1EtZH5ia/VmNS1FmdSsqCu+Lks
         CeAIIoSGEwGv4j0rl7hlrF0pGxOPtq5w2PeE9DNLtyAnGGvFbrq1iJwGWyoY3PwTlay5
         BzvPS/dRKthke1WCB8QLozETOFIRuCJxvBQM2b9/3xY1csi73O0/hb0k2gykc6fHLS5t
         hcCFZrY9nHOZz2SW6wIgPdBFhx4WWhQ0OHnyXpE+dPNcXMTdMHBWwtIGFG8JPDEAfEkY
         jhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8QkNF8EHcAEMbV0p0CldmJdisF79bfeyCTRVHy2ZadQ=;
        b=BKFApqUM6+3yTIEdhDeqFcQUUqZrXfPmIvN02LoFoqs2hwjuoPV3S3awxfN7wmkPFv
         Dj9bcIu6GZDNzp6qEJ8hQP4xFlDBPLR0Io1pd2tUrpo5EKpCKbnIN12HMN+zm4J1YTor
         RU5wWbayIYvGb5OZTz4I6Fh7dSYhefXQvP4fB9HkBaFaA6stlwqPG9Bt6Pt6fT2h05x/
         /sTKjlOfL24OKKi5HX3n4VWetwvJX/9HCj2wKyq6nrlcWePOmCt5ZCz9ATxgjcTcujij
         Pw6del+5ZfHBbQRyESUcbug5E1nrffC0huMHVCHDpkx9FY7D6XRH7YZbxMrJ2R3iZzAd
         0Ebw==
X-Gm-Message-State: ACgBeo1Ey2xxD1ibkztZ2rbTf53aSkDcu12rRNuhYTHxf9aYUMtILKdT
        KQcijF7WEpL1cW8nvxanMlHt6g==
X-Google-Smtp-Source: AA6agR5eijq8eBk3C33kCDyeQYpgFaH/Kd+NWw/17xqKLLEsxYWMECRBYUt79dYI8fONsaLyUUNDTA==
X-Received: by 2002:a2e:98d1:0:b0:263:76b4:5dc4 with SMTP id s17-20020a2e98d1000000b0026376b45dc4mr2086762ljj.460.1662628793190;
        Thu, 08 Sep 2022 02:19:53 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a056512211100b004946a758d21sm218219lfr.161.2022.09.08.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:19:52 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v3 02/14] arm64: dts: qcom: sdm845: align APR services node names with dtschema
Date:   Thu,  8 Sep 2022 11:19:34 +0200
Message-Id: <20220908091946.44800-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects APR services node names to be "service":

  qcom/sdm630-sony-xperia-nile-voyager.dtb: remoteproc@15700000: glink-edge:apr:service@4: 'dais' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 347c3abc117b..627e32515d29 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -767,13 +767,13 @@ apr {
 				#size-cells = <0>;
 				qcom,intents = <512 20>;
 
-				apr-service@3 {
+				service@3 {
 					reg = <APR_SVC_ADSP_CORE>;
 					compatible = "qcom,q6core";
 					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
 				};
 
-				q6afe: apr-service@4 {
+				q6afe: service@4 {
 					compatible = "qcom,q6afe";
 					reg = <APR_SVC_AFE>;
 					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
@@ -785,7 +785,7 @@ q6afedai: dais {
 					};
 				};
 
-				q6asm: apr-service@7 {
+				q6asm: service@7 {
 					compatible = "qcom,q6asm";
 					reg = <APR_SVC_ASM>;
 					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
@@ -798,7 +798,7 @@ q6asmdai: dais {
 					};
 				};
 
-				q6adm: apr-service@8 {
+				q6adm: service@8 {
 					compatible = "qcom,q6adm";
 					reg = <APR_SVC_ADM>;
 					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-- 
2.34.1

