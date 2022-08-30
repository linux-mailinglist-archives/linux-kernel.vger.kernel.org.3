Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0488B5A5995
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiH3Czn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiH3Czk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:55:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2A4DB52
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:55:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fa2so2119255pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=U0nZ3+uAvlRMqEL93tIb2WEzxc3KpOg/eA3TIVLY4A8=;
        b=dgDPeKeOSDA219rI2iUDR4QVI8IU2C9X+Fb8SHMDTqw8xxI5qJCF3WUf8i3UMCXwWX
         iyCgQC9yQZDa3tQ9AfO7IT6UdI5yhJPDZBCzYqQjrJqIxVP4WJTorPWcoospIjn1D9Lr
         gi0QOpasFuB4g44CEwIIeLPrFgnlpfNwxsEjI87qQHjp+wySgOZ5QQu4BHvjxrc9a62P
         SkIYzeC3Ohqeu5Rm3QAeB7zY8aoKGNXWdeuvv+j4GqQbBFZzG3bWBNSYN7/shGEhcF6o
         fpjDLHTu7GSd1Ge+vAYXdOqO3dxnRfhzRydi8aYiFgfvkxsHaeoOZNe4gtJpSjt5ehN6
         WiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=U0nZ3+uAvlRMqEL93tIb2WEzxc3KpOg/eA3TIVLY4A8=;
        b=HKVU3fP593iIvzVYKcgYgoeUR0i4dwBCyDcELlTWbltZAB5hCVEyHm+zjBombnDVwi
         KZzfM0Y6vPw1QCxSsrIZICIuv/iBJ6LRQvffnxw20CM053p0QV7z+yBlBQghJbdmLiXW
         VuLPcIYEOdP9NgFZpe/w5V1KAS4vCdr0KZJtuC+ipT25gO7Yvhdkod2RMniY02vPhd2W
         UnTlJv5WTnQbOc92SzE4a01SNHWTxG9OhVz0emlgOE4rm8rSKryerbtHIXiEfbyftNUf
         YypsHfXIAaUPdWvEJEhxMQDG8r1+7dYHZJsjdR9rgr8IskmWovDiHEQJvq5T89bZzimf
         fcyg==
X-Gm-Message-State: ACgBeo1XbWWmbyLdfy9KSvUDurTq/HWT9z+cU/Nke93MEUQKzShtmTdg
        DXKpQ/3KfdYiU2NH/6oxLm7pEN0LAD3CKR7SFvw=
X-Google-Smtp-Source: AA6agR5gqKLKE+BMyJrcl5uwTv9ej5G4Cl6dury6w/+t2tttd3P7/Y+P9KkvL1FHLDL8XE55xj7z+Q==
X-Received: by 2002:a17:90a:8a15:b0:1fd:bcad:2471 with SMTP id w21-20020a17090a8a1500b001fdbcad2471mr9905906pjn.38.1661828138356;
        Mon, 29 Aug 2022 19:55:38 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id y125-20020a626483000000b005368fcfb7f8sm7919125pfb.89.2022.08.29.19.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:55:37 -0700 (PDT)
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
Date:   Tue, 30 Aug 2022 02:55:25 +0000
Message-Id: <20220830025438.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
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

