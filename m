Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7E5AE7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiIFMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiIFMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:19:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2167E319
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:17:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z6so17046175lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=atG6Q13qT72aqye5DdU2XHAaxI/9PkvW9OECNhOqjGs=;
        b=jsssXtnc0wcmQvENwTPaWWUYWwq54OmJYb0Ho39eO7oBDHnmlEiTs5LXHXcLDUb7UY
         PIjd2mQnLCJqb9tSCf4yWwHa3JKa5hV15HEHUKvZwE0wdxNIvgPJXeB6zJR8KLwI6YXD
         9EdkPu1gWe9nPoGy7/H6xpV/aLW+5Tw1u3A2nA/RI6dWMY5ve+tqoAvKawkF1qUG72qH
         YD+Hf6/8f2CjxZom00GZt0Ut9BCOebHg0ct0rOMQOQeKMDZ9NEWhMFD5ZCz3mvSD82n9
         9T6oY4e18tssNSfYp+bZD0MSzYuLMCcLcI8hmSggWjO22fpeQZny2IMQDz1Ss96jP89r
         mcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=atG6Q13qT72aqye5DdU2XHAaxI/9PkvW9OECNhOqjGs=;
        b=b7fYQb5jRlHFqcaL3wijT60SF+6J2QUbFFDCjW9olwLWn5dkLtjVOTl6efopGBYqXb
         sg/YZA9pEiG5wlyQgcBT8PJTD3ToqumAyVyb1Jn0972NodotId/YJcQ0klgYLV+KXKAn
         e9Jruhmlg4sIU8JJolBD/K/MKLKl3Qtvyu27LvvurSF27k1rOrV8oAzIDlhMBVQx+q9k
         rk1CuTnjFnDBXHJf3qGkYJR/458xBX4FYFbdBg71HYiLnvx1Dub29F+yKGMDXsxdeidb
         knIELzJZVRNdf2O+EJ3gpAc3SCKRzyCQMaBQ5knMQrQo1GjS6S4QahYdwx/7o8QKE3si
         w9NA==
X-Gm-Message-State: ACgBeo0fG1T/2B7RMR6g/a3Ym8A28hra7++dpyS5+8FJLUO9uMxAx5Dd
        Er499RIvTplF/op7hXy0SIeR2g==
X-Google-Smtp-Source: AA6agR6kwAX2CNe3gZUiQIJU1EqskO4sjnTjjKHe/QSrhc51J/bbUCKpBgdWxTfm+S5ucS/V9tMBUw==
X-Received: by 2002:a05:6512:e99:b0:48b:2ba1:1511 with SMTP id bi25-20020a0565120e9900b0048b2ba11511mr19685247lfb.0.1662466618788;
        Tue, 06 Sep 2022 05:16:58 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b0025df5f38da8sm1882802lja.119.2022.09.06.05.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:16:58 -0700 (PDT)
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
Subject: [PATCH 00/12] ASoC/qcom/remoteproc/arm64: Qualcomm ADSP DTS and binding fixes
Date:   Tue,  6 Sep 2022 14:16:43 +0200
Message-Id: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Dependencies/merging
====================
1. The DTS patches are independent.
2. The binding patches should come together, because of context changes. Could
   be one of: Qualcomm SoC, ASoC or DT tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  arm64: dts: qcom: sdm630: align APR services node names with dtschema
  arm64: dts: qcom: sdm845: align APR services node names with dtschema
  arm64: dts: qcom: sm8250: align APR services node names with dtschema
  arm64: dts: qcom: msm8996: fix APR services nodes
  arm64: dts: qcom: sdm845: align dai node names with dtschema
  arm64: dts: qcom: msm8996: align dai node names with dtschema
  arm64: dts: qcom: qrb5165-rb5: align dai node names with dtschema
  arm64: dts: qcom: sm8250: use generic name for LPASS clock controller
  dt-bindings: soc: qcom: apr: correct service children
  ASoC: dt-bindings: qcom,q6dsp-lpass-ports: cleanup example
  ASoC: dt-bindings: qcom,q6dsp-lpass-clocks: cleanup example
  dt-bindings: soc: qcom: apr: add missing properties

 .../bindings/soc/qcom/qcom,apr.yaml           | 85 ++++++++++++++++---
 .../sound/qcom,q6dsp-lpass-clocks.yaml        | 30 +++----
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 30 +++----
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 10 +--
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  4 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  8 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  2 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  2 +-
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  8 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 10 +--
 11 files changed, 124 insertions(+), 69 deletions(-)

-- 
2.34.1

