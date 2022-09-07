Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C15B0190
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiIGKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiIGKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:16:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65807B8F11
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:16:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so9364033lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I+Cj5rW1qPBHDkQI4vuAbqESvVL5430WmrKXOMhCHDY=;
        b=zw7LF+v/GSLMvrb4j4VoXsv5Ndiyq17UrNjLf6ZHflRLbgAEm7sK3GcwD0JMS/OElJ
         3/OYfsGF/OiEcF9c/1CN/H8hvQnGdzhmF6geF/7yqi71PP9SF/ukFEZP3f1dfEwTo98z
         gpYpl1l+vr3g3k1s79HybNOQtaDKMUhUrmmZV9AH9IY65XFQ9Xgyz127hmEW1VK2DO4W
         f4zw/5dR/IzUII0RjLirDuBLqHxWty2WAEWM9fD4Yqb23BBqgtIXqCVDmZzexmB8CoCj
         q2APQ0q1LHNAt9nn8l/Q1w9BmlWVz0jRgWpiqIEjIbZ4LEkzUx2HzUqvN/n5rJcK0ewQ
         h3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I+Cj5rW1qPBHDkQI4vuAbqESvVL5430WmrKXOMhCHDY=;
        b=q58eiOWK0IgEBK6T0h5T40bvSyRWSrvPde8OYTXVwwp3z3PpLoGaulGNysJcgOso0L
         0Jtrfvuih/3QZpcpLACNMNB/aAguCqIIml9VHUGDTAn6ZgScbzaI27qODCPkOsGLTuF7
         IRcSPT/bdznf060H6RdgMfd/GVjUUFxFx+VMoFy298FeeZLZuk0bLRh6xkok/j4XdqRI
         Ghu5Nv0zx4yTsTFfRQ9sNspBcNudBRAsHcSzxWYmRhTPPs8GPmf7CYQ4W5dv2l0eamd8
         mNu1JZjns5qN2gx2f8JUK9KzKDFM76UOrSZMz0+xxvOBrYjkSrEwxQO7u5jpSRYMqs4n
         tgxw==
X-Gm-Message-State: ACgBeo0L23gZprurHOBpAw0sWkAIvdWJoAHLRZl+yhh+ZRJM9UvRiJHw
        UZWnLQ+rVQUKy/SYK58RliZMOA==
X-Google-Smtp-Source: AA6agR6awmhGQ57KqfVEWjXn9QT2nqWu9hWZ169t7LkCnwnlpe3HEgAaREW54MCDCv35aCRH3s/VmQ==
X-Received: by 2002:a05:6512:3f14:b0:47d:e011:f19b with SMTP id y20-20020a0565123f1400b0047de011f19bmr826474lfa.427.1662545765991;
        Wed, 07 Sep 2022 03:16:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:16:05 -0700 (PDT)
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
Subject: [PATCH v2 01/14] arm64: dts: qcom: sdm630: align APR services node names with dtschema
Date:   Wed,  7 Sep 2022 12:15:43 +0200
Message-Id: <20220907101556.37394-2-krzysztof.kozlowski@linaro.org>
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

  qcom/sdm850-lenovo-yoga-c630.dtb: remoteproc-adsp: glink-edge:apr: 'apr-service@3', 'apr-service@4', 'apr-service@7', 'apr-service@8', 'qcom,glink-channels', 'qcom,intents' do not match any of the regexes: '^service@[1-9a-d]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 9ae6610af93a..3cd1f40b44fb 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2224,12 +2224,12 @@ apr {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					q6core {
+					service@3 {
 						reg = <APR_SVC_ADSP_CORE>;
 						compatible = "qcom,q6core";
 					};
 
-					q6afe: apr-service@4 {
+					q6afe: service@4 {
 						compatible = "qcom,q6afe";
 						reg = <APR_SVC_AFE>;
 						q6afedai: dais {
@@ -2240,7 +2240,7 @@ q6afedai: dais {
 						};
 					};
 
-					q6asm: apr-service@7 {
+					q6asm: service@7 {
 						compatible = "qcom,q6asm";
 						reg = <APR_SVC_ASM>;
 						q6asmdai: dais {
@@ -2252,7 +2252,7 @@ q6asmdai: dais {
 						};
 					};
 
-					q6adm: apr-service@8 {
+					q6adm: service@8 {
 						compatible = "qcom,q6adm";
 						reg = <APR_SVC_ADM>;
 						q6routing: routing {
-- 
2.34.1

