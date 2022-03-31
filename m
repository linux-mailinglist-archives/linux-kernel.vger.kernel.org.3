Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04D44EDDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiCaPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiCaPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:55:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314061D322
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:53:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b24so28645684edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfqnpxEBLu1gt/dV+MpD3O2O3QJUWpLD1wEVvGzFG+k=;
        b=ZYT8C/9Sf2/mU8nHDNHlcSA5Xv5Crgz93bGknHOlYsuRBRvkcRhPSA0TdbXxnxlHtC
         6Ueqia9muU32k0nbRZcS0lyxhVUsU7lDyU/mlU+1DTdyf8YSKCJ3zDxgYjiZTPEJZv7h
         1KEPonjd/Bai1bU4g5AiWvl4nHhBN9R7qZXYmYZoYBUKoxNYQzOscReUvEz7j4AxIPrI
         bUCK0ha9rOVYqMewOI/s1Pn9GlDFWkalWNcG123mJSilbyKEezdpXX42by1IhRQP3ojf
         ogG/18GIgKw277U9iH4Ivz32ykY16uf3pMvHjqMxiSWW3y+k1mOJZOOEB88e+vaIV/qc
         bwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfqnpxEBLu1gt/dV+MpD3O2O3QJUWpLD1wEVvGzFG+k=;
        b=m75T+muPWTDzoZn4rjNT8isRQOqIRrddlZwTVpSOZl6bMjz1jNlAFVd6O/E4CkGmDA
         w86iCWML7YRBKfNvSXLo73ZOPw8XIM9P3H5i/1A4fLGplwV+3lkZJNolXVSJLd2U186I
         RV/S/W2/yEQLNdK6JKynb2eM4egF60XtfnS24xbFn+aP1PW8wbKNfIn00UOlrMvnGW4M
         qxXT64xhjo3CrUaVR/r/b2hBrD3/Ov7YJVSh3C03kyPRLWEJWJMWZ95DByUvWpr7R3WN
         DuF7Zt7yofgxPwfJZnF2eU1U+XtOUBghOidtaqcF3PMY9Lq5ugWzFF6bDOClUIQoioZo
         q4Fw==
X-Gm-Message-State: AOAM5307DJ8Mt6H+Ytu3031Q0dwBgM1ofWVj1/lWEPTzmGUv2lULKGmB
        fcq5WSySKO7WNwWs5iFn2+SQ7g==
X-Google-Smtp-Source: ABdhPJz78zD5NmLuCynbTIQIfUn3lkSnR/YHoY9TISYRgxpFTIMDeF9dNJV6AF94dMfTO/oNAX41MQ==
X-Received: by 2002:a05:6402:5243:b0:419:4ce2:cb5c with SMTP id t3-20020a056402524300b004194ce2cb5cmr17315679edd.151.1648742008767;
        Thu, 31 Mar 2022 08:53:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm11658583edd.48.2022.03.31.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:53:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Subject: [PATCH v2 0/4] spi: dt-bindings: qcom: convert qcom,spi-qup to DT schema
Date:   Thu, 31 Mar 2022 17:53:16 +0200
Message-Id: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Hi,

Changes since v1
================
1. Fix path in com/qcom,gsbi.txt.
2. Merge clock-names in example, correct $ref path (Kuldeep).

Merging
=======
The DTS patches are independent and silence warnings pointed
out by schema.

Best regards,
Krzysztof

Cc: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Krzysztof Kozlowski (4):
  ARM: dts: qcom: ipq4019: align dmas in SPI with DT schema
  arm64: dts: qcom: msm8916: align dmas in SPI with DT schema
  arm64: dts: qcom: qcs404: align clocks in SPI with DT schema
  spi: dt-bindings: qcom,spi-qup: convert to dtschema

 .../bindings/soc/qcom/qcom,gsbi.txt           |   2 +-
 .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
 .../devicetree/bindings/spi/qcom,spi-qup.yaml |  81 ++++++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   8 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  24 ++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  36 +++---
 6 files changed, 116 insertions(+), 138 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml

-- 
2.32.0

