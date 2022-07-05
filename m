Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA1566B82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGEMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiGEME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:04:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FFA18B08
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:04:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i17so9457805ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n04xRHDLPG5HTJiUoTVbiyOiGV01+5rVdjSb2OnFTXM=;
        b=BCDuSqECc+nJ4QixySuzLrzpTldvI4Om7Dhhe79zvfcZpzEzGecmAsDtbOf3XLzQC7
         w1uhu4rB9AKVhxlEOmTXJsDmqBX/3XMZXi9nrbmqxCnspovd7Q8yAdlrQQX0aZYeV6Fl
         c8WcJWt8Si79EF8UcAIz71wn15IahJMZQdjSgHyrHfHv/2MYqOUJadjBcEzDAjbrBDzj
         rRImKl3ArYsXlhHZx7+a/pZCSpAYvIjJP14wEi6xVHIkMAoeQyfbYASKFAWMrBNse3wm
         KDbQ04/bH6MFUz+3trU9Jg7lhMH741aCEqeBNZBq8fgVsCxnHx9VVKxFpE/9R8U5Fvkr
         YDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n04xRHDLPG5HTJiUoTVbiyOiGV01+5rVdjSb2OnFTXM=;
        b=bkw/dfX401dwEpY8P+pT6narC9dccQuHqOFT+kdtxiVdxLasKj8q92emgsqTOPYwgw
         p0SgHmgj4HXmc1AOSCCBPP4vSzKI+wXtdQCoRdfbCeMWhaKxVn1sHZVW0Yvzqe6u8ebi
         7etVhvIz7ASUkBhzxnSPrbCiwshjNH8KWHJs2b3UDterHj2u4v1yMhm0gRxhjlxXIPj6
         /FGMzw4MavoC4EmJqcKcp9ElVbUtv2JE654snqeqhdP1m/QILA5avuN2bb1SoKMujKya
         Rip20TIBdGFNTeDjtipC3iX1LnmST5koX+qitCaM6kmkskp6aMHfVoXx0EdiO4cXQdqV
         7Lhw==
X-Gm-Message-State: AJIora8uqDWOfMQWo3pz2Ftts6eRZ7Ao3/Ge0uDh0FNtkCfQNrReEIx5
        W6QZ68U28mCF9kt3iYCGZBDrg7a2NatEig==
X-Google-Smtp-Source: AGRyM1sl7oYOktjybXQ7DcS9EisH+raxTv/CIYoUdIA4mqFgH0EaCpesDAtzqgGs0ayhR8cQfoLLyg==
X-Received: by 2002:a05:651c:1699:b0:25b:c598:3803 with SMTP id bd25-20020a05651c169900b0025bc5983803mr20101511ljb.0.1657022646876;
        Tue, 05 Jul 2022 05:04:06 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id n13-20020a2e82cd000000b0025a885a135csm5547082ljh.119.2022.07.05.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:04:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3 3/3] dt-bindings: input: gpio-keys: accept also interrupt-extended
Date:   Tue,  5 Jul 2022 14:03:56 +0200
Message-Id: <20220705120356.94876-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
References: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
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

Each key device node might have interrupts-extended instead of
interrupts property:

  fsl-ls1028a-kontron-sl28-var1.dtb: buttons0: power-button: 'anyOf' conditional failed, one must be fixed:
    'interrupts' is a required property
    'gpios' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index e722e681d237..17ac9dff7972 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -92,6 +92,8 @@ patternProperties:
     anyOf:
       - required:
           - interrupts
+      - required:
+          - interrupts-extended
       - required:
           - gpios
 
-- 
2.34.1

