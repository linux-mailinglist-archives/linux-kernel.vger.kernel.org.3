Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324005A25D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbiHZK1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiHZK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:27:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EEDCE325
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:27:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 145so795957pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=fO7KL3cm/qIPOC8UecVFXzf3EKkcw+jqA4gikcKM8lI=;
        b=K2BTt0VcJ4sYcngEjxV7pnzwQwmizrXBFjeez1wbX5TycUbJKWh7gh5HfvT0COwabF
         XfLDDbzF/Ntzp3YkSYEexF+YHaI7ufrdkPBTNXZES5E4UXD3nDBROaKqw003GOTS3EqO
         BajDAtofubaai5gGoe20665Nh+mFhr+jTK0JohFB0lHcoLPuZz7TxFTlokaTl/XKJcfK
         fX4zE9fLMElNDOWBUu2cAC4RwsZgYN3aIqGsuigH/D/ptgdXNUgvD5Ll7SfNtCZx9m3o
         IwzVqhXrAYA+qImN4jVszsgjbnZH+/u95iiUR7dGpDvQYBVJdDcoNdJU+fPOg8Rca6yQ
         62ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fO7KL3cm/qIPOC8UecVFXzf3EKkcw+jqA4gikcKM8lI=;
        b=L4cwUbLFKFYKAkLBTAqFx17y83MHSXl6Q67QhSHcebIU4Wx9x5sgIaoxT6BtyjdS3k
         5VTrmLrwRRiPacka4IcBoessjC3SQefme94Ct6Jq5wAjnjQgbfpC3nQJnyTOh5VqhTxz
         HPVMO+lCcQaudPt406R1iEfWJp1DrT65QV3zWMf2B3p+uNRQaYS07ry7NXT1dCBCmjFP
         LmltuwS8Hl2FqaYmsbs+oFllz6TxSMlrhpDqv5s/cG7yBV8/pIEj+GKj9CDiKHv7lo9e
         MWl7RysVmq60p4b1s8fCYP+QunFtmQhoRN25uLDRor0dN6+qCDj93ZozZy8TME/kuD9I
         TIdw==
X-Gm-Message-State: ACgBeo22k0Xzo365+eqoiJv/wiJFEGICjW9yZMtbCyM8hYuDQbbKdXCQ
        ueyWJHA+JdQ2CUSO8cEvGzwuURijSepOM5Jd
X-Google-Smtp-Source: AA6agR6zcJ3+LpttCrblYmJEF7TpFa9w6DSDtPCB/iNYo6AC188ibR46pgLmWOaT9w/GHqiKAHhNrA==
X-Received: by 2002:aa7:8096:0:b0:52d:d5f6:2ea6 with SMTP id v22-20020aa78096000000b0052dd5f62ea6mr3410295pff.0.1661509633472;
        Fri, 26 Aug 2022 03:27:13 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id d11-20020a62f80b000000b0053624c50d74sm1333866pfh.126.2022.08.26.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:27:13 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Fri, 26 Aug 2022 10:26:07 +0000
Message-Id: <20220826102513.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pazquel360 is an extension project based on pazquel.
We create 3 sku on pazquel360:
   sku 20 for LTE with physical SIM _and_ eSIM and WiFi
   sku 21 for WiFi only
   sku 22 for LTE with only a physical SIM
 Both sku20 and sku22 are LTE SKUs.
 One has the eSIM stuffed and one doesn't.
 There is a single shared device tree for the two.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>

---

 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..851cf5edb582 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -459,6 +459,17 @@ properties:
           - const: google,pazquel-sku2
           - const: qcom,sc7180
 
+      - description: Google Pazquel360 with LTE (newest rev)
+        items:
+          - const: google,pazquel-sku22
+          - const: google,pazquel-sku20
+          - const: qcom,sc7180
+
+      - description: Google Pazquel360 with WiFi (newest rev)
+        items:
+          - const: google,pazquel-sku21
+          - const: qcom,sc7180
+
       - description: Sharp Dynabook Chromebook C1 (rev1)
         items:
           - const: google,pompom-rev1
-- 
2.17.1

