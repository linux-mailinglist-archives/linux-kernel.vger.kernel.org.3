Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C575A7B96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiHaKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiHaKnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:43:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B5C88BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:43:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j5so9862560plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=A2LdkydV9AGLhMQY5rQpkTItkU8kDqfLlwLCs52s6tI=;
        b=O4kipsSqeeQI8MpWgYiCpxLdomQ3bpf2BSWx1H3x1JeumMRmRG7KowaWaIMKyrvyik
         QWgFIiQq5hdIxoyp4DzuxbdinvGrSM+iamYZgNAzed9RC3rnbaNHC7+Ff3k5iTmOb7IH
         7vE/X0buWdmytGSaiNQO+ZUUskkD7n2hYrCb7c2keCDagaaKyaul4DxCElDHCalFe1TK
         WNYAgMT4+bLFZpU160IUqYngC7TxXXoSIvM4YbmoND+dXKAp0PRI69Yy9MTIzlqWPIR7
         RpOhgS3h11bjoUMuYXY2zIWgtjZ9pk70FVboyU6T/KjayipZNIEfRcliLpMBE9ZC2A8b
         FyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=A2LdkydV9AGLhMQY5rQpkTItkU8kDqfLlwLCs52s6tI=;
        b=oKQTsLSGiyAhAXnPpPcdDkt7VxxeglXyJpCZKbb05B1jSHZYWZUJ1Urcg4Vk9DWxNB
         Gyf/ejFIVo+9i+mwocUFOgE4gIrYGOBFqKZ7JWVAUMcI5KAWB1o1N4vbDFl1+XUkivUj
         3Gz8IOC+Lqlc6XjJ9PJc3sqnVyJNW+6YojK+N7Jbe4spZXwdXowTSficlxijkz+Etk+y
         o2heUZzQtCIHWl7i9wi+t6rJNcxg6ugpenKA5PWrql1eDkSbuIysToUhm15fuc3CCxKn
         xTqbGrGxeiyXIDyMJ5OloUuO8SL0AMI0LEze00PWAavXgJ0zFBCmttgAqS+fRFy+hKk7
         jTAA==
X-Gm-Message-State: ACgBeo0EbfU2PigeLrec7G5urLdn2VWcVkuEYLJSom7bnFTnn2FSR9kY
        /U2p8KKb7IsTQF7h36s9a63aAGzXvzcbkOKO
X-Google-Smtp-Source: AA6agR7t0T6zJQLfXVRFxDuVMmANdIBGRVNj2vLbzWSOvv80L3yA6WjJ/IpZ1VM9O+wObuj1HVPtqg==
X-Received: by 2002:a17:902:ba8a:b0:172:baa0:5676 with SMTP id k10-20020a170902ba8a00b00172baa05676mr26140608pls.64.1661942607691;
        Wed, 31 Aug 2022 03:43:27 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b0016be596c8afsm11266905plk.282.2022.08.31.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:43:27 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Wed, 31 Aug 2022 10:43:17 +0000
Message-Id: <20220831104220.v2.1.I11899dbd0476ffc83aaca07f8ca9b204ecd9a84c@changeid>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

(no changes since v1)

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

