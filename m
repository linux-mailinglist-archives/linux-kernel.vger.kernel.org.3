Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A105267C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382648AbiEMRAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382600AbiEMQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:59:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67D205E9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:59:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m12so8527416plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akI0HHvtv/s/0pYeEJ5z0Kcqmea/A/JWqccnsMWH/Bc=;
        b=ESma4KX3+jT8KWhTcJtBAzLW4Tb8V6hUsR8CIKfFbN7/2k+fJve/LLDaVNp2SOIsPW
         ivHOJxEGI1QClXGOJybL8HXZOhIzXaSmWH2B5vnHryfSNOW4eT9Zn0nkJX8ftQiDeQvn
         L4qevS03Y7JrWKCCxFvoUgqn8lS1jZUQJg9Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akI0HHvtv/s/0pYeEJ5z0Kcqmea/A/JWqccnsMWH/Bc=;
        b=rQ6KA7+DVyjQWyqXaw49YY4jxvIoivSdBOmOKArVqLei1RUfH8S3Lyt+xkV2Md72p0
         KilxjJQeDTw40OZ2cJwCd9RECRa4XzZPZv4LF/PlqOeOJ6zbR0OH6oxFeplYB/G8fCZa
         jvqqIkjk4EKHM5+O4u+UVy9GbCFw0ki+kX6Y9WP9hJiQbCCBCWYD/F0NrxJrI9vMw11c
         erXzRf5A0eZumoY45a/rxVTYslXJPFo/1DqPhhdVbwCLkhx/Cndh7WPS6r+gA9V6PKir
         fmn4oQZ9H2UR2Pe7TcboVhftamhqOHCa4FgoWBYhJtl29SzP23On/Aw4vtwwl3KKGKPl
         v7WA==
X-Gm-Message-State: AOAM530NWim6/bWMq2WPi0sRUcgemEGYB+p43dANSWMNevEUWIDCZx2h
        poE8PI12lHKg2Qi63WG6SBUIpg==
X-Google-Smtp-Source: ABdhPJxOwiVCRMWvIXzR7DXZ9hmayF1Kb036D4jPInNvsL5Hjh7pF0J0LTyja7wpNVc77s8EZ+hZBg==
X-Received: by 2002:a17:903:41cb:b0:15e:ab0c:5172 with SMTP id u11-20020a17090341cb00b0015eab0c5172mr5336743ple.170.1652461188656;
        Fri, 13 May 2022 09:59:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f334:6f80:82ed:5653])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a7f8100b001d97f7fca06sm1824548pjl.24.2022.05.13.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:59:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: arm: qcom: Add more sc7180 Chromebook board bindings
Date:   Fri, 13 May 2022 09:59:20 -0700
Message-Id: <20220513095722.v2.4.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds board bindings for boards that are downstream but not quite
upstream yet.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use a "description" instead of a comment for each item.
- Use the marketing name instead of the code name where possible.

 .../devicetree/bindings/arm/qcom.yaml         | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c76ea703c2e6..6d1d44b48289 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -263,6 +263,16 @@ properties:
           - const: google,homestar
           - const: qcom,sc7180
 
+      - description: Google Kingoftown (rev0)
+        items:
+          - const: google,kingoftown-rev0
+          - const: qcom,sc7180
+
+      - description: Google Kingoftown (newest rev)
+        items:
+          - const: google,kingoftown
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 (rev0)
         items:
           - const: google,lazor-rev0
@@ -364,6 +374,48 @@ properties:
           - const: google,lazor-sku6
           - const: qcom,sc7180
 
+      - description: Google Mrbland with AUO panel (rev0)
+        items:
+          - const: google,mrbland-rev0-sku0
+          - const: qcom,sc7180
+
+      - description: Google Mrbland with AUO panel (newest rev)
+        items:
+          - const: google,mrbland-sku1536
+          - const: qcom,sc7180
+
+      - description: Google Mrbland with BOE panel (rev0)
+        items:
+          - const: google,mrbland-rev0-sku16
+          - const: qcom,sc7180
+
+      - description: Google Mrbland with BOE panel (newest rev)
+        items:
+          - const: google,mrbland-sku1024
+          - const: google,mrbland-sku768
+          - const: qcom,sc7180
+
+      - description: Google Pazquel with Parade (newest rev)
+        items:
+          - const: google,pazquel-sku5
+          - const: qcom,sc7180
+
+      - description: Google Pazquel with TI (newest rev)
+        items:
+          - const: google,pazquel-sku1
+          - const: qcom,sc7180
+
+      - description: Google Pazquel with LTE and Parade (newest rev)
+        items:
+          - const: google,pazquel-sku4
+          - const: qcom,sc7180
+
+      - description: Google Pazquel with LTE and TI (newest rev)
+        items:
+          - const: google,pazquel-sku0
+          - const: google,pazquel-sku2
+          - const: qcom,sc7180
+
       - description: Sharp Dynabook Chromebook C1 (rev1)
         items:
           - const: google,pompom-rev1
@@ -394,6 +446,16 @@ properties:
           - const: google,pompom-sku0
           - const: qcom,sc7180
 
+      - description: Google Quackingstick (newest rev)
+        items:
+          - const: google,quackingstick-sku1537
+          - const: qcom,sc7180
+
+      - description: Google Quackingstick with LTE (newest rev)
+        items:
+          - const: google,quackingstick-sku1536
+          - const: qcom,sc7180
+
       - description: Google Trogdor (newest rev)
         items:
           - const: google,trogdor
@@ -404,6 +466,36 @@ properties:
           - const: google,trogdor-sku0
           - const: qcom,sc7180
 
+      - description: Lenovo IdeaPad Chromebook Duet 3 with BOE panel (rev0)
+        items:
+          - const: google,wormdingler-rev0-sku16
+          - const: qcom,sc7180
+
+      - description: Lenovo IdeaPad Chromebook Duet 3 with BOE panel (newest rev)
+        items:
+          - const: google,wormdingler-sku1024
+          - const: qcom,sc7180
+
+      - description: Lenovo IdeaPad Chromebook Duet 3 with BOE panel and rt5682s (newest rev)
+        items:
+          - const: google,wormdingler-sku1025
+          - const: qcom,sc7180
+
+      - description: Lenovo IdeaPad Chromebook Duet 3 with INX panel (rev0)
+        items:
+          - const: google,wormdingler-rev0-sku0
+          - const: qcom,sc7180
+
+      - description: Lenovo IdeaPad Chromebook Duet 3 with INX panel (newest rev)
+        items:
+          - const: google,wormdingler-sku0
+          - const: qcom,sc7180
+
+      - description: Lenovo IdeaPad Chromebook Duet 3 with INX panel and rt5682s (newest rev)
+        items:
+          - const: google,wormdingler-sku1
+          - const: qcom,sc7180
+
       - description: Qualcomm Technologies, Inc. sc7280 CRD platform (rev3 - 4)
         items:
           - const: qcom,sc7280-crd
-- 
2.36.0.550.gb090851708-goog

