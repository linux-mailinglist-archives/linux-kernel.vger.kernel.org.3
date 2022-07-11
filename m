Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45EA570BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiGKUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiGKUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0967422F9;
        Mon, 11 Jul 2022 13:34:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l23so10776347ejr.5;
        Mon, 11 Jul 2022 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOAFibCJe08MWChM4fURWU6yWlY0z6ldM4g46DVUVng=;
        b=ALS9kcEKsPUmxukYHPUDXY2HTXKYuh4jMai1pGgMVmtGMQOoloYuYw4MrMsrhpoCFv
         DgfSqydLV4nGwh+jgbNxnX86vx6IvL2ZrIvXAITBhQ0ynwxntUydvDy3yLcuy3EMoA2R
         haS3UKaIWuVX4VmbDS/G6omOuNgHtXbujRzO3eXqaa5S7AqjIFQA9iGtel4JfWqMsADG
         ykoRczJ0SBqXteh7vkCSlL6UHR7RYxUaFYVej2Q7+x9fcXXe/2up3Ja+2X9WgjOhLLJJ
         hKAIl2p6NZ7/72kHaF/VSTUAmx0qKjGFBfs83SrdtZnBXh0RMq/zuSCMsRFQ4xAry5NY
         JRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOAFibCJe08MWChM4fURWU6yWlY0z6ldM4g46DVUVng=;
        b=DCaBFBaTMJ3CnGOCTwZNTkJu0aaWdfZWeRKdZ2yoQKOO0XGzajn/LAR7R81DqxtHZG
         QKhquuNP86oDmmT9hTlX9Je9N9lMpg4Lnwb7qFm5xTJg0+9Kb/fb43a264pbIQDquWo3
         mwRLWk402gSbr96QgMKMoXm+g7CQXOS96suPaQ6Om8k1P/tyYa/I6VYj/H5ghCBnRtuk
         FVcMPznaW46CPar+GDjUnwSPm5izSyxCTU1QIqoykIqdRw16AEdFnfVNJ5CxAwi63+ZA
         cgvGO86K0C7F5XrbO+aYU4nQRpZmdpstBWaNpV7lTU/x7Qbe2dd11MksS4fsXD1YwMcm
         v8Ww==
X-Gm-Message-State: AJIora+oJhRZuL7vio2jb/nrDGpKeoV6BLuoKzKPufpLoX5QcGiCQJfL
        vYRUVYV+pjhxxCzOWrDqICg=
X-Google-Smtp-Source: AGRyM1tv5/bCh5YZueC8NLmycryR65b3kWd9cEavJoRy/mmQ6qC14ZypSTEsJCOH2nUaazmQG9iyew==
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id g4-20020a1709065d0400b00722f46cb891mr20318245ejt.4.1657571654513;
        Mon, 11 Jul 2022 13:34:14 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:14 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 3/7] dt-bindings: pinctrl: qcom,pmic-gpio: add PMP8074
Date:   Mon, 11 Jul 2022 22:34:04 +0200
Message-Id: <20220711203408.2949888-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711203408.2949888-1-robimarko@gmail.com>
References: <20220711203408.2949888-1-robimarko@gmail.com>
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

Document the compatible for PMP8074 which has 12 GPIO-s with holes at
GPIO1 and GPIO12.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 6f2efc3772cb..6bc84779b092 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -52,6 +52,7 @@ properties:
           - qcom,pmi8998-gpio
           - qcom,pmk8350-gpio
           - qcom,pmm8155au-gpio
+          - qcom,pmp8074-gpio
           - qcom,pmr735a-gpio
           - qcom,pmr735b-gpio
           - qcom,pms405-gpio
@@ -233,6 +234,7 @@ allOf:
               - qcom,pm8150b-gpio
               - qcom,pm8150l-gpio
               - qcom,pmc8180c-gpio
+              - qcom,pmp8074-gpio
               - qcom,pms405-gpio
     then:
       properties:
@@ -415,6 +417,7 @@ $defs:
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio4 for pmk8350
                  - gpio1-gpio10 for pmm8155au
+                 - gpio1-gpio12 for pmp8074 (holes on gpio1 and gpio12)
                  - gpio1-gpio4 for pmr735a
                  - gpio1-gpio4 for pmr735b
                  - gpio1-gpio12 for pms405 (holes on gpio1, gpio9
-- 
2.36.1

