Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAD570BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiGKUe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiGKUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB45247F;
        Mon, 11 Jul 2022 13:34:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id os14so10787302ejb.4;
        Mon, 11 Jul 2022 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygfoxsCOcEZFDvZwwxHJZr7GgBlZqbqyOyuBkqlE4/k=;
        b=FCVkMHINOi+2nayP8xiMeu+6NxUb1DpQe8dqbjAdVDiNqodttsFdNUyGFXI+oLNvd0
         iECv+ebdL2J8jGqBB+PU/VsPUxc8WxkRFs6iwA061C9s3norGTb1t0DmDjEB7BgL2YJ2
         8hVFkC/FavZPXtwF3ETGluwEExsTXP8PCNiuoCwSNXarpyLer5nveuP6L/qBKKgDrgdU
         qHa6n7XpyZApbvu4PYQzziBxsQWIIXTr4L6GKhlDgjBwcOfEcLFV40C0pI/0UEwObCZj
         GZmsY7bDG0QO/374g/WhV4dCtqDVkMRX3smkyCGBt8p+1SEB+xxUM28QTqPOO/P4vZBr
         oHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygfoxsCOcEZFDvZwwxHJZr7GgBlZqbqyOyuBkqlE4/k=;
        b=ZQpOArmK0z9vfIPK5fh08yNqdaIM1a2jxG7i0s9EbjXNOllRyIUBIU8yyG72FFCHhK
         LgSimP2OJV/ivSlsFzTn5iYSPQpN3+nFKHLjvAtkk1TBGgA69aaylUsnd38eFrzALhei
         UO1pik/n754J23Pn0w9uFiLFxusKWL5JUkkyUhRpVPVvMd88YHgXTowRSLNG310UYwbV
         AjSCzHT+XVT+ySLxburJkhUDXpxaEyCjXoWetHFWcKiE9XTYAsI9eUIM5Jr0PIudoiFW
         lPAlfNuP5n9cvNKyiDwFUdJEPkz0BXMTJkflLpWMwqx9xcIJv7YHeCUkx1xAcJIXo5aO
         8GXw==
X-Gm-Message-State: AJIora+XkPxdvY0+5Ltvsx8LjT+gHvK3cXfT8SZgODKYFjjTQ60bFZw6
        hCVIQou2fhqowcTgqN5injI=
X-Google-Smtp-Source: AGRyM1tZwrEqdPTK36k8QOQt/Uhr1nRt5Zz9+7YdYR0j9LZM8H0iTxhFlm1Nh2VfhJCSZeit3NIDww==
X-Received: by 2002:a17:907:2bd3:b0:72b:44ed:6d6b with SMTP id gv19-20020a1709072bd300b0072b44ed6d6bmr11741284ejc.632.1657571652006;
        Mon, 11 Jul 2022 13:34:12 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:10 -0700 (PDT)
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
Subject: [PATCH v7 1/7] dt-bindings: mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Mon, 11 Jul 2022 22:34:02 +0200
Message-Id: <20220711203408.2949888-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Document compatible for the PMP8074 PMIC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v7:
* Fixup commit description

I planned to convert the bindings to dtschema, but there is already a
patch to do so [1].
I will make a patch to add the compatible to dtschema once it gets
accepted.

[1] https://lore.kernel.org/linux-arm-msm/20220626191630.176835-1-david@ixit.cz/
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
index eb78e3ae7703..c46d17609f3a 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
@@ -46,6 +46,7 @@ Required properties:
                    "qcom,pmi8998",
                    "qcom,pmk8002",
                    "qcom,pmk8350",
+                   "qcom,pmp8074",
                    "qcom,pmr735a",
                    "qcom,smb2351",
                    or generalized "qcom,spmi-pmic".
-- 
2.36.1

