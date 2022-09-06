Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB15AE7DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbiIFMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiIFMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:19:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71C7D1E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:17:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q21so2856807lfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pShykHWoNvg0r3Ewb/OZKB3QYRKzKfqFYZ0KOJ2rq3w=;
        b=AhIkh5FR6npoShM6uugzD5k9iK7mxV70+HUEAtdloIiU8B9We4/vxf/3jNzSLGnMum
         gncYJmVW9RdZFnAl85T4DD3LdTSI+uaknLF84FaRenmV5iKZoSEWfeBrAeZ0TG7/qVig
         PZBzlWPAQWJkeFpfQjslokSDQ69qFYDqFdUX5ywZSlxcEfp6/smXdBcfRy3X+ZhyMYKa
         ErYhr2dQBl6N2O40vJh8ePzCLF5EkxGqQ/BAXsqOzDiQgi0dUV7rgdHfXM+cY/vLUEY7
         pa0X5TsJSyLcTFQbwBb9JRfXK7mhNcrnbfzCtgu/6rPugtabxVcbErnUxSynBAusmM9D
         U6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pShykHWoNvg0r3Ewb/OZKB3QYRKzKfqFYZ0KOJ2rq3w=;
        b=7wTzHgZgXAHLKYH/NPMzGa7X1z0Z1yyDEJ0UkxmtvSeCkkhoWRacvz6cOT0grFhPY+
         XkJMLTnbR/klXDducXxZq9Rz+W5FuY7CBvUc4Sqio/qvzzPf11+iU3V2wzUkXzkHvAkh
         v/mcJXcJCESWcT1pODRs6+QcXG3Y1D82c942Wv9/pKA6Ft6Pw+oFpP8lUxxmVZd4sug8
         Zy+NYitESLqMRZy/rkhSMtY4vhynoGd/SgRUqeHfPRDf5xquDODXrhIH1o0QcYH6208y
         lp4Xh2KoVBTI0twPmxgMRsSxCJ3puPK1mxZmK2Qq+zC3LcbeEOcQG32+iGrkxdduMmHo
         IawA==
X-Gm-Message-State: ACgBeo2ljQE3bAhZxl+aSjdZX2PogPVJ2xd0g0VEg953+nexbXm7s0o+
        k0kSShFO1Q7fknU6n109VR/0OQ==
X-Google-Smtp-Source: AA6agR4qr8s28dZedBmuzdp0myoMb7Xb/7ljIivdwwXHXPEKQ4N3LJ7PzASOXM9daVOBYG3plOAM6A==
X-Received: by 2002:a05:6512:159a:b0:492:8c61:1991 with SMTP id bp26-20020a056512159a00b004928c611991mr16402938lfb.245.1662466631431;
        Tue, 06 Sep 2022 05:17:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b0025df5f38da8sm1882802lja.119.2022.09.06.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:17:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/12] ASoC: dt-bindings: qcom,q6dsp-lpass-ports: cleanup example
Date:   Tue,  6 Sep 2022 14:16:53 +0200
Message-Id: <20220906121655.303693-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
References: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
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

Cleanup the example DTS by adding APR compatible, using proper device
node names for services and fixing indentation to 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index 5e666d9fb388..9b5b53d1edf1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -153,9 +153,12 @@ examples:
     #include <dt-bindings/soc/qcom,apr.h>
     #include <dt-bindings/sound/qcom,q6afe.h>
     apr {
+        compatible = "qcom,apr-v2";
         #address-cells = <1>;
         #size-cells = <0>;
-        apr-service@4 {
+        qcom,domain = <APR_DOMAIN_ADSP>;
+
+        service@4 {
             reg = <APR_SVC_AFE>;
 
             dais {
@@ -165,8 +168,8 @@ examples:
               #sound-dai-cells = <1>;
 
               dai@22 {
-                reg = <QUATERNARY_MI2S_RX>;
-                qcom,sd-lines = <0 1 2 3>;
+                  reg = <QUATERNARY_MI2S_RX>;
+                  qcom,sd-lines = <0 1 2 3>;
               };
             };
         };
@@ -178,6 +181,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+
         service@1 {
             compatible = "qcom,q6apm";
             reg = <GPR_APM_MODULE_IID>;
@@ -189,8 +193,8 @@ examples:
               #sound-dai-cells = <1>;
 
               dai@22 {
-                reg = <QUATERNARY_MI2S_RX>;
-                qcom,sd-lines = <0 1 2 3>;
+                  reg = <QUATERNARY_MI2S_RX>;
+                  qcom,sd-lines = <0 1 2 3>;
               };
             };
         };
-- 
2.34.1

