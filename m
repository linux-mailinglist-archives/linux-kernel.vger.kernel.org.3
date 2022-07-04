Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276E8565F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiGDVYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiGDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547FD1146C;
        Mon,  4 Jul 2022 14:24:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z41so13067671ede.1;
        Mon, 04 Jul 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aguHBKBuHMX4tBuQp1cFa26DPca4WlhIJZY4sZw7kpI=;
        b=ojujb3UjR7HvSea3IliR0bkYdtIX7oMv0SXdby+o/etwI5aBvu/mQ0JBHo8A8QtpD4
         dGG98aq1Kgcg8WAFUcskS+ikG9MqSlPo2ULSRmbVoOqoSM6oAtTMsRm+g5xkrOGMpkcO
         kNzuh+mCpaNUPrS0A9P12Z/NIRCIBoy57sb6HdyLISv7QiaJXGZLk9KNykvcZ8R+vQjM
         Myb/s0yjXSCfamNW/sXFT3UDNdtYBAEDr8FT+9FJWY4SgU/1X58wzEvMwo3Un5i/EqPH
         cQ5nSqX1DpRsMAD09zSVC5KnWTZQ7t5ErwF/cUCnIaenB99S/pojqJi6gIdkGi0dcixa
         Hm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aguHBKBuHMX4tBuQp1cFa26DPca4WlhIJZY4sZw7kpI=;
        b=m2I2uyX4JCNKST/QJgo+13aMIjlrEzSWaFAslu62EE3L9snqNnxRGKeDhqaemlMsGy
         N6uUSvDo7HXydpVOHvlU3z53282rFZh+AlFtLiipqRStR6mNe/uHEQGTMnmqGAwn0MJ6
         N5zif80WfSQigeylHpFVguSYc3yY1Fr7FGmRvFXPuvc0H08jdaqp9uiCcJWfSpXkQy3w
         1CsBL4bsKnwM/e8UfnEDFgtYMxT8k4fkDHf2nH2hALm44bI0PJJ7b0SkkGZNz25QXQ6a
         BwuMCpvCZPQLPQ1tKp+E5j/+N3RNcUy+Ed0itKMFxxH4FtCydOOcc+Rw4xuBivBn4Brj
         YCjg==
X-Gm-Message-State: AJIora9QwtJcVi6od1cnv5wB1ct7uZUvdR6xOsZOuIULCQ8rYmC9C/JO
        FcrOgQa2dkk9rJyFe6OaJuI=
X-Google-Smtp-Source: AGRyM1uYnmUs41aY4+0Bx//un652jbOxDwftRFuw6MGuHm1nvUYU7VO6Te9W+NsFnV4lxLzi0g/Vcw==
X-Received: by 2002:a05:6402:b34:b0:435:d064:8762 with SMTP id bo20-20020a0564020b3400b00435d0648762mr41916027edb.238.1656969853859;
        Mon, 04 Jul 2022 14:24:13 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:13 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 08/12] dt-bindings: pinctrl: qcom,pmic-gpio: add PMP8074
Date:   Mon,  4 Jul 2022 23:23:58 +0200
Message-Id: <20220704212402.1715182-8-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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

