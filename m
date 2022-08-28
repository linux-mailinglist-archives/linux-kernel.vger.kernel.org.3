Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7A5A3CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiH1IoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiH1Inv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:43:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9832E6BC
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m2so3605109lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aaOiZG1NI0RQb6DCDN3adeH421v/gsaYZDUBXChVaUE=;
        b=CvLkX0mh5r3Msyv4A4A1aKjUCvaLsZwb3PSj/p864gui4j3qRvk//Uw3YZrA0yGyoS
         qIaN5L4x2rPWROnV8qlurw3iehft9kfzYEAlp/TKWf4HXOt+Z9IChk/2wTueko8rjGti
         C0Gi8c+DLfDi/0oyIjuKlHeNbJlmLfntow8pUTJSmlj6TB+TV8vOF6SbQLOaoT/pItkU
         t/IZmxw+RQjqf22MPxQvlXwHFLXc7tYq7Hg44ir9+NhMeV/56oFl+JPyhSm5TxkPTDB8
         dowZAX2yeMNjO5RtjW9PiTiHEtFJqbmgNhStYmkxKK7qLaIy2rIheHDycBunusfShFs0
         Gydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aaOiZG1NI0RQb6DCDN3adeH421v/gsaYZDUBXChVaUE=;
        b=4r7veR1+TFommNZuh4lNKnP2h3Bh3A7dKNKVBCcKVizu2HBYL8NRYFZ/A1wDpSA9kE
         0vMYjhrasJL1IKe0Hin3oK/2ils7gedoMVDgXH+fE2IGuzm4Gr1I+KlE1rlz/vA2vhVH
         p/O1Q6Rz3z5jmX40GNMjdDvy42dzDSWhcO/+MzYEF3IeucTTAO5fIrSDP+gv66Cd8Vfu
         U1Bj3sBqslNezWA0PPMnjy40zKMMYlqyBKYSndaDz0Iw+OCaEmUkDhLi+eBAZMSRdowU
         jOUp0g64wPVL2743XRCLEgNoO4dinm16/PiwRWVxq4qqJzyafvb4A4naCl1dWQSSuomj
         yg0w==
X-Gm-Message-State: ACgBeo3nrMsJgz2Up53txgutmbQ8QMTvH6gC6iUVgbrs7fkfK7Ji96AZ
        5UHYCZgSSDP2dbf8q2OB1s4YWQ==
X-Google-Smtp-Source: AA6agR68gtPSaQEma5Z33xaniTYoQli85bbsPrKJJ1YcJ84ZbPbQwUSLa+VrAwS2hFmx59Y7CCZduw==
X-Received: by 2002:a05:6512:ac3:b0:494:69fd:c9e0 with SMTP id n3-20020a0565120ac300b0049469fdc9e0mr459092lfu.348.1661676228592;
        Sun, 28 Aug 2022 01:43:48 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/14] ARM: dts: qcom: pmx55: align SPMI PMIC Power-on node name with dtschema
Date:   Sun, 28 Aug 2022 11:43:30 +0300
Message-Id: <20220828084341.112146-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect Power-on node name to be "pon":

  'power-on@800' do not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-pmx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-pmx55.dtsi b/arch/arm/boot/dts/qcom-pmx55.dtsi
index 9de7578a4c5f..e1b869480bbd 100644
--- a/arch/arm/boot/dts/qcom-pmx55.dtsi
+++ b/arch/arm/boot/dts/qcom-pmx55.dtsi
@@ -16,7 +16,7 @@ pmic@8 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power-on@800 {
+		pon@800 {
 			compatible = "qcom,pm8916-pon";
 			reg = <0x0800>;
 
-- 
2.34.1

