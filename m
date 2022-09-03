Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6798C5AC04F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiICRmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiICRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:42:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB855141D;
        Sat,  3 Sep 2022 10:42:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u6so6475223eda.12;
        Sat, 03 Sep 2022 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0WRb2V91EcpbVW8u0Sp6LXTsiRGhW6DTkPaNDUU1Ni4=;
        b=mH5r4nxkfCoO9Jc9cNOO//o7p3t3pMbkvQxbHkkMeH3VNnl6jaxSVReyAml88/UZbZ
         2x9KQQQtTu1sBSgMFXVFjjikMIEov34tLdj++jlVNXIK3M4cYjh9GH37XJ5oUUCD2lHj
         q/NUt6oL3EPBCeZVrOxnToqz8D2BWFH6WQeb0ubpY7y6q85Y88fB6rftDYD7fOVqsQU1
         wR9QFnBszBQpddm2MfMNzycZjC4jJDCyWFWxLE9uo3z/dHrCy5CZ/qfqzIERNy4fpPpH
         kAQu81znHT5MWM7C5DPcrmopAeVnJw3m1/eOg96AHyR9/FnLKoOdZO61biYfNjzn0OBf
         DTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0WRb2V91EcpbVW8u0Sp6LXTsiRGhW6DTkPaNDUU1Ni4=;
        b=ct+KRzZ4qHb3uKj02x12AbuSSarJuMAgV8vzrP9+1Mwn0BmiRgrufkmewqGEkQ2Lgy
         f7u40Tpd766x1A4yijB512PXGYNJ0/bVLACTihRUn97bNBIPMOAmfSDnJ8bZQNR1MSeC
         6w4pAoqsJWB7kWC3arib/2Ot+Tkz4zGVGWCOKE1DNiNBCEWDC7dMHp6nhMcveXFx3E0A
         oiKe0XW27RMvrcP3cjnASiccKtgZ79zUT+WJ1XSoawaRSTqEx5VQERnDEqz7aZwZwVhp
         73JY8tatYrDU1CYiNXjut9Es/gw/Ea8kXN0GpmVvUUQskgnv199Zb3BZLgQuGP6RGT45
         6fig==
X-Gm-Message-State: ACgBeo1cWNkxEWe8wfjx1r45pO8tLtGVZ2r/sBto8hRyywe9NYnsv3mq
        SEzivx/Qq4K8BcgmCzEdNH4=
X-Google-Smtp-Source: AA6agR4R9FsaOO172LC1Qlkygor8ueNi2Y4WqVoIHCT3jFpBFsSp1gBXWsspQ8Zz5Hc1+a25qrHMMQ==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id p8-20020a056402500800b00440941a93c3mr37639760eda.47.1662226945606;
        Sat, 03 Sep 2022 10:42:25 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906328700b00734bfab4d59sm2754221ejw.170.2022.09.03.10.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:25 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] dt-bindings: nvmem: Add SoC compatible for sm6115
Date:   Sat,  3 Sep 2022 20:41:44 +0300
Message-Id: <20220903174150.3566935-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
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

Document SoC compatible for sm6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index dede8892ee01..54053e16b8fd 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
           - qcom,sdm845-qfprom
+          - qcom,sm6115-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.37.2

