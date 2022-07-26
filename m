Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A958197A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiGZSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiGZSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:11:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BF2529D;
        Tue, 26 Jul 2022 11:11:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o13so3711171edc.0;
        Tue, 26 Jul 2022 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAlmBW7+z94ckr1rUoxpohDIKELh8ni7cBJ4JtsF9yc=;
        b=V9ppXbuHujqUgPUfCqkeSD138OCFvbGM6EwsRrzkEX+uRamt7hi7vBoUjbxXtvdyRa
         iFvSgeeJa3sElbi6jAh+msOj1GBL+SyvHx6rf+sDu35a7v1mYR8Tp/wE0vlTzzgaHgOP
         Z1W2E3hcPbNPjkMMxs//aAEWgfNrNB/+UAQOvGrISIXn2YNTLXKfNvZGN9Pn8YiH8ZO8
         VqU/VyyC8k3CSBUfOYRsYVEDw+5lEojPQ+blJCpyv7BOX/jdT3/TfPIWSrqvq+OZKPU4
         zEwvokSuMgfzkCYfYzobluYcFwqOQ8Hz59oUxYhhzkJIz9GinWhIsHkTMoXrNyY2TKKb
         3sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAlmBW7+z94ckr1rUoxpohDIKELh8ni7cBJ4JtsF9yc=;
        b=cY+i/HCjn0Eydne8QyvYk1zRRWDoiNak1QonZzWjdV2dONPgYqe+0IYso6CllZOxoF
         LGkBgjKBwd2yxeezTxU+QugdaN2xOqv2VEY3rGZr1JDVKPInaHJfhrz6CFPD4Z49ev0Y
         Iz+YYDgRxTPlkTBgK7LK342U0v6lVwl/CR17ZFpIea5V1fOpSgfzeJ5gHAzNv9CYEPmX
         sLVh3kqdZtpnYGOIocv8+q14iAudPVXnePxCJ18w1q2IYIGCtE2+5noWNT37sQ4NZ9Vj
         C+xk3kB7nH4zALxGN3Sdeb7BONfMzyNzPgbJ+eTLglIf7zaS5WsowCBM4toIuwqTSCvE
         bgwA==
X-Gm-Message-State: AJIora9MI41KJfvQOTCQSSoTQ53jrYJ+7C9Z1hw6v97Jyowkr1NY07/t
        3gaU3uLwLnfyzULt4YgUoKy8BV80P3kzPA==
X-Google-Smtp-Source: AGRyM1um6X1xKZmJ73uosZwBjYlgYy6nIyDH5sCF71MHnaVzLsYSLJS1pPyx24CAKbSRDIsJVTqyKw==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr18745913edb.273.1658859100950;
        Tue, 26 Jul 2022 11:11:40 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id lb2-20020a170907784200b007246492658asm6790312ejc.117.2022.07.26.11.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:11:40 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: regulator: Document the PM6125 RPM regulators
Date:   Tue, 26 Jul 2022 21:11:30 +0300
Message-Id: <20220726181133.3262695-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726181133.3262695-1-iskren.chernev@gmail.com>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
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

Document the pm6125 compatible string and available regulators in the QCom SMD
RPM regulator documentation.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index c233461cc980..1122a3a17f56 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -57,6 +57,9 @@ description:

   For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob

+  For pm6125 s1, s2, s3, s4, s5, s6, s7, s8, l1, l2, l3, l5, l6, l7, l8, l9,
+  l10, l22, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24
+
   For pma8084, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3,
   l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
   l20, l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
@@ -90,6 +93,7 @@ properties:
       - qcom,rpm-pm8998-regulators
       - qcom,rpm-pm660-regulators
       - qcom,rpm-pm660l-regulators
+      - qcom,rpm-pm6125-regulators
       - qcom,rpm-pma8084-regulators
       - qcom,rpm-pmi8994-regulators
       - qcom,rpm-pmi8998-regulators
--
2.37.1

