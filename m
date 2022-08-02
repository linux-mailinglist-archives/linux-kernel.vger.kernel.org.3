Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF84A5883FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiHBWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiHBWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CD42AD1;
        Tue,  2 Aug 2022 15:11:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gk3so16124981ejb.8;
        Tue, 02 Aug 2022 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2iZS78mXw01epsfevnWqzaIVlWTJFHCguvSE6aPN+5w=;
        b=b6Tx5foVLxPF944Z0ykOQkntwOdkOXxE6r97APxU4k36SyXy4fslhG7jhkzztLQxrX
         JoL2SEEIxkRhoWhhf3SJkArSID1mzK47kNVBpc/og2oUGkB2EV1RQEM8yRFxIhSCRwA+
         /TYFakHK5ZNsSecp2G7P513GRVT2hVIi+LXUZzmkjrCB1tQGFql/XQGSHbYMcDxAQg8w
         h7Pvem1h5EiaSfhGfoqHf71pFOAbgh7quzzbEvDg+wBH0J9mNmIAHt9yCV/8Oi4eJc3a
         N8SVQKsoQqcu7g782ysE7ztYYz+45/5e95BLk6aPXjnxgfw+QE7ZFKPYmtF/h1900p45
         tQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2iZS78mXw01epsfevnWqzaIVlWTJFHCguvSE6aPN+5w=;
        b=r8NhNYQHfjj1FpQNdH0KIMVGPywrseGtTnTcyiIliNjBob1u01RW+RmGnp+lGKOsyf
         yVXeEjeElr3/DmuzqlFyj/tLV1K5ZjxJAE6UTKe+mYRZ7EHm4FlaA0IUw5sVw/yONgk0
         LtVziPYaCQVngdX6AWSwuHkzO/vxPZWXcJEcWKJmqpwGZz+5+DzkROOxWK4QzsM0D3Jx
         b3R8Yw2H+Yv/YODRRfCXVHyPSiDIKdg44Kc9OugkOsnjVV9nDFhEDrogmZuzjd6axQfJ
         iUCCMAnnUX0/6Wmsz1GAtXhZ0v8UYAHC20nSvNnQ2ef9EW+YYc8RJYN2AHkskjR/GSSs
         U64Q==
X-Gm-Message-State: AJIora8TgrKmc1w0HYpBCmYkGPOfSzwLUBy0bF9Hzyk5+WbgfRH56m8r
        OmA+gB2U0eeUkibQaq4plpyDsCoWQoE6YZ4s
X-Google-Smtp-Source: AGRyM1vc/W1PjCA5+PpHzM7yJj9XOjB/aSJd/0iw1rfrpPKOAh0eMJyptFcMA7ApG/BipWGouzn+2Q==
X-Received: by 2002:a17:907:7205:b0:72f:38ec:f70e with SMTP id dr5-20020a170907720500b0072f38ecf70emr17437676ejc.130.1659478298868;
        Tue, 02 Aug 2022 15:11:38 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0072b91a3d7e9sm6646391eja.28.2022.08.02.15.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:38 -0700 (PDT)
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
        Adam Skladowski <a39.skl@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 04/13] dt-bindings: regulator: qcom_smd: Document PM6125 PMIC
Date:   Wed,  3 Aug 2022 01:11:03 +0300
Message-Id: <20220802221112.2280686-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

