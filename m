Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05C5861B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiGaWiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiGaWh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:37:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD24112087;
        Sun, 31 Jul 2022 15:37:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id rq15so11277446ejc.10;
        Sun, 31 Jul 2022 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jbat/6N9TBWtZowJnZBxciJbfbi1Cb/hwo29+DnQgDo=;
        b=Bj/Q5SP3hvnHUlv450T2rXuUXztnY2Qq02vki7EX7zvKpX/9zcCSZ3hwb0PT/xz09q
         o5FNKGLOcqiR9xHC6+A8sS8yAnK/iXoQ7Rl9KHQmBNEpFfwjdDMQF9VgBrRzSSiBo1cu
         g4GXvwcQSYPoUsuKRVD1KgNilxFBNCitbDdJIKCYzqTaRhauCnGgPXE5YTKlPAhLJswH
         eUsVwiYx4e1jnK5BwcHnbqUlRFqSh/wErBerHgmB5TtuRtgngRZetnDNmwMaEK8r3TTl
         74CTTIA6C7pgANEYeY3FqlUuJXwYPJh4+kk9BX2Ij6WKPEXd3Fi0MwB8uBHr0/qsn8bx
         j81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jbat/6N9TBWtZowJnZBxciJbfbi1Cb/hwo29+DnQgDo=;
        b=ZdQVADblgVxJK/bd3wqs3qc/DsI1Njx4xW4Q14vFJXgB0oQgbU1zER+jrogIQex4k/
         hI5+5fGYHQOZSTGU92dFlmceyhR59k68tiO7c50HqEHi59b8W/Z6unf9GCicVgh8r0P1
         2bkD7KbHQy/hemOPYseYku3yd7Y7srGk4PFgYyIY6ZfO+JhHsQmuftBJUWiLixT7eMkY
         38JRg3xLT2NdJudmiXzZVjobqXZb19MfdyK5wMqCexFv+Rn26f0UExRY+XQf2uwO4g/j
         vEwwFRaGkjZCxAWIBBKYiPIa4M/+qOZ2a6Cn5T4lL4pJnxqsRQ7N4fcsIIuRFb9o6dyK
         kyAQ==
X-Gm-Message-State: AJIora97IrisnLAJucVz21zgb2i1QDDokSRoppiAqQd5ek1aJKRRLuPB
        Q5oBBh4II1TIhNkGR5a8poE=
X-Google-Smtp-Source: AGRyM1vYGPZXIuEM5cvU2JEG2Y3q15b0NRxvYWhrd9TaUx64nLRL5gbJ5sCEqvztGjXGhRLgZNYKLw==
X-Received: by 2002:a17:906:7308:b0:72f:3294:8002 with SMTP id di8-20020a170906730800b0072f32948002mr10154165ejc.311.1659307074188;
        Sun, 31 Jul 2022 15:37:54 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b007307d099ed7sm787763ejc.121.2022.07.31.15.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:37:53 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH v3 04/13] dt-bindings: regulator: qcom_smd: Document PM6125 PMIC
Date:   Mon,  1 Aug 2022 01:37:27 +0300
Message-Id: <20220731223736.1036286-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731223736.1036286-1-iskren.chernev@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
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

Document the pm6125 compatible string and available regulators in the QCom
SMD RPM regulator documentation.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index 39802c1223c6..961eed51912c 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -27,6 +27,9 @@ description:
   For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
 
+  For pm6125 s1, s2, s3, s4, s5, s6, s7, s8, l1, l2, l3, l5, l6, l7, l8, l9,
+  l10, l22, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24
+
   For pm660, s1, s2, s3, s4, s5, s6, l1, l2, l3, l5, l6, l7, l8, l9, l10, l22,
   l12, l13, l14, l15, l16, l17, l18, l19
 
@@ -80,6 +83,7 @@ properties:
     enum:
       - qcom,rpm-mp5496-regulators
       - qcom,rpm-pm2250-regulators
+      - qcom,rpm-pm6125-regulators
       - qcom,rpm-pm660-regulators
       - qcom,rpm-pm660l-regulators
       - qcom,rpm-pm8226-regulators
-- 
2.37.1

