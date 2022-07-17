Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7298F577870
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiGQVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiGQVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:36:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F61146E;
        Sun, 17 Jul 2022 14:36:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id n18so16538114lfq.1;
        Sun, 17 Jul 2022 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KooW2N6XXBy0fm3lvXxFc3gF3H0S8vrp09/3/CzkG8s=;
        b=hwsT2FygwQAkQOiCEOX15Zu5bkIyW5ZngKH5X0vPUe/yuP86g8uVNB1z8JWRnhYZ8M
         4wr49FE4gs+ThCXIeXHt6r8OGuF1KdfamLUTYeVj0bkiiKSNh7vW8BbDZLiACZ1439zk
         6gGKf0s+paz23yynUvoX9gPDcSSSSdE+TIBjeHu+EdLOHi8eNQClBsW6SiieTD2sUIN4
         viouMhoYciPJ26aQlFDzuv+EXA//Ml3NuEch45HTy/noGgy9AJ4OavtjFn8MDI2e/1nJ
         sqp8qDwTVgIKFZV4lpOAzFD8TPG9LBD8A8f3Y5pgfYFbeS7316IPZFYq3h2ilfa6dEec
         vIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KooW2N6XXBy0fm3lvXxFc3gF3H0S8vrp09/3/CzkG8s=;
        b=R4a9se6UlvdP1r2PDKgkn76Ohq32NgautmPM6xDQEf1agl6HU2D0nDsWE7LEAfUMz7
         7duCO00rU3NIDaPOShaTXHf2qMfBbonhvCiiO1Ymy/LEOP+S0x0j6U06DLIr7fe6AQlz
         uvMrTwhxgpD3A0nMDRjIC1N72MD9UCFkPdXma0aHptM7QV0gQ8vLmYHjI8W/S+0Thhoa
         smrJv1Nr3P58crl2VIwEHYk4gQbWUxHvhJSCkSj3VeL5nZAXLRaejpNhzjRtCaAopF4Z
         QztxlxhfbUKw1/SPJEFiE0fs4zbeAbxO3/7ThAdg5s/2Pwy3yRoskkvr2wicvhmdzK1K
         whBg==
X-Gm-Message-State: AJIora8AzvqoifZVsv41jJlykPRmjDeBTDSoI4pgxLBULD7uZQOmksrB
        MmJgJg09cvhKtqlmEAuuCfIAmbNZlihmyTQFyQSGfQ==
X-Google-Smtp-Source: AGRyM1tw2rKeu6tDxORbXnT2mdjX0hgTAtINoBuMo6PHFEhl1s4U9mKao+oIxhGRslPTUoeUS+A4LA==
X-Received: by 2002:a05:6512:4029:b0:489:c7a7:42c8 with SMTP id br41-20020a056512402900b00489c7a742c8mr12834014lfb.461.1658093795801;
        Sun, 17 Jul 2022 14:36:35 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b00485caa0f5dfsm2251088lfr.44.2022.07.17.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 14:36:35 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Document samsung,matissewifi device
Date:   Mon, 18 Jul 2022 00:34:30 +0300
Message-Id: <20220717213432.134486-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
References: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) tablet
which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..5a24dfd66823 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -104,6 +104,7 @@ properties:
           - enum:
               - asus,sparrow
               - lg,lenok
+              - samsung,matissewifi
           - const: qcom,apq8026
 
       - items:
-- 
2.34.1

