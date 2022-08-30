Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7055A618E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiH3LVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiH3LVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:21:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7CE42E7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:21:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d12so10787924plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=kcIm0U0ucDYNF4GdKdc+KO2BzaJqo9jU7lP+5SuHRBY=;
        b=o3Qhqb60ks3ZGbk3LnWYih9PxTQeRFi5CUGT6HpFGm3te/u7Qmg2zV1jwm2ABOBTsC
         fAFOMviQUg4FuF7Gt1gMWOcbsNyxrT/8olKDxebIDogYt46o5TPfxDXDtqUlLVBzIfZ3
         7rTQUeoNMkaEEhZ4S86DY/9QVlbFroAPWvNH0SduWQvcTIvyBBIRj2gEj12Y7DLwCAwB
         Jow3MQk3Y1ScRUEyXImyIF30DGCpRVhYLEOKfBXchNZBIVmce0ttlZah5LKyrw8fW9bH
         Oiz62RTntZ/FD8HTbWnP0x2PRVIOfEG6btxjjfbHdpVhvVX6V4hW+hJv/ak8iAPu+Lm+
         SMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kcIm0U0ucDYNF4GdKdc+KO2BzaJqo9jU7lP+5SuHRBY=;
        b=2l4bNGkoy5WnTBvl6trPno6liDbUPDaGj6fTA/izCmQxLno/sF3IwnfgN4fw09BQNB
         oG0oYuwZBZGU1VIX/eEOj0r4JcXotm+tfRKdA+r9l2/kAnC/mmKIt3AgXBCrlDKlw6gH
         B1ghsuGwLMPk7wnjP8OuVXlOckQUWuekgbe8zIJdSrN/ml68W8IZJfHRXridUb2N4WSe
         VgyRuy/saa86HpjbVLbto5W6NyOKSVd2e8gWXhw7aKpAbYATLXkIniMorVmVbNaKWjZI
         PuX+edV6wQfRtsR3uYRL4maHW/SM80HoxetQdGYECQSYXAYv4WXm0V9defDuI5ZLv7+S
         ub4A==
X-Gm-Message-State: ACgBeo2MuzdmfRA7DLYw2t5EKhQs6OC6v6aGV05NAVa0oHs6ys9HWQYM
        J8yI6UO75A+mifhZCGKhsb6b1l9qhy+Z3oKC
X-Google-Smtp-Source: AA6agR5w0+dm/LQANqoxD2YgrMGVwPtnMfj/tMLYXpBoS0X+/vkd2UnS5ArjwV9S2gj9qh9KJ+lbrA==
X-Received: by 2002:a17:903:40d2:b0:174:e086:c748 with SMTP id t18-20020a17090340d200b00174e086c748mr7479291pld.108.1661858475620;
        Tue, 30 Aug 2022 04:21:15 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id q41-20020a17090a17ac00b001f54fa41242sm8310957pja.42.2022.08.30.04.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 04:21:15 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Tue, 30 Aug 2022 11:21:07 +0000
Message-Id: <20220830112013.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
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

