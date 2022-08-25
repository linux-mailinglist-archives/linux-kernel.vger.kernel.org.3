Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B45A1122
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbiHYMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbiHYMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:54:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089C58092
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:54:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n15so7025291lfe.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=S3SutAB1J4Kb12rqzo8+qQuuCiQhbu1bFQAHyt9SB6M=;
        b=dYjtx8g4GgRergvoaiFBiWUr5mp8xRc3ajTrabyMa3BOgh/UVTKQun5yXKMMauJRMc
         0+eMWOZNpd+3omG8H8DsIx+7J/08M1obW4O6HuN1/6XLZ7QuOwCY1q+xfn6tJ+0Xi14+
         ksNb9HYycX9JV7LSoOaOjrls83z6BtK7RxIHe3ALGiTFz8yuJpE4sPI1e86PN7lUIzGK
         S8tSB5c0ljyYXthRQu2jA7GyvpLd+heV1qrFqZCGJBjiEVJ6Vy6J+YZ24ODQg1o2U+IP
         Dze5Q7iBwMGW9rsKKt87+CJsHJHv0w9JrU4MyWUPP+KZqYEF+MoQG0xlpjAQYO0XCqSZ
         jISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=S3SutAB1J4Kb12rqzo8+qQuuCiQhbu1bFQAHyt9SB6M=;
        b=SKpO6KjZqq/Oi/Bc18FBRyekn3IPnP80wK+CZk3tBMp5R6/WtQli4c8VkMliJaV5i5
         1hk6HkyjY+x5s8Zrs1lkhN/+CdvEsYADl5FiBIJo6pTcVnK+J+sFc6k9WDXNqPe75EQK
         yXJvyGA3E/7NGf9N/FO4TzJ1mhCxO9Rnvjh191ZZGuwv0WJRIDyigWrqppAT6NiTkFG+
         MOyfiiqKQAE/rdu2n88a8K3KyFuvUgYOcf8ItYcKA5/pu6WW/p42piqHrjab15V9sY1u
         BphwMyhejBy5dWvqaqqUEvKXkFUj6kiJVdXffelIvpds766Hc2KjPcCIfyvBeL/Cxkds
         uzBA==
X-Gm-Message-State: ACgBeo25rW4hLTClqa5IWer7fuV8ir8IigQfBkhxCRRozO2W6q4QWiWt
        j6Vtr9F8lcBu4hMSlwcCGuct5Q==
X-Google-Smtp-Source: AA6agR6Beh4p+rci4zh/hhXKnzTrbCflB3h0vAEJeLxMjM0OmsBCjw8pY7pJZ0BeP5ai02rnqARMJQ==
X-Received: by 2002:a05:6512:b08:b0:492:87ad:5f5c with SMTP id w8-20020a0565120b0800b0049287ad5f5cmr1269359lfu.293.1661432052713;
        Thu, 25 Aug 2022 05:54:12 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512370e00b00492e3a8366esm494304lfr.9.2022.08.25.05.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:54:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND - dt 0/2] dt-bindings: left-overs for DT tree
Date:   Thu, 25 Aug 2022 15:54:08 +0300
Message-Id: <20220825125410.232377-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

These were sent some months ago, then resent and still were not applied.

You already reviewed them (I removed your tag here). Can you apply them to your tree?

https://lore.kernel.org/all/20220720163720.7099-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/daaf6ad7-6204-2a13-442b-05068d29e734@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
  dt-bindings: leds: qcom-wled: fix number of addresses

 .../devicetree/bindings/leds/backlight/qcom-wled.yaml    | 9 ++++++++-
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.34.1

