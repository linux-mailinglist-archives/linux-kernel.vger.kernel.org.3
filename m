Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3479052E0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbiESXwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343806AbiESXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:51:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927A3969C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so6537404pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2j8gBiRNl2VaOq43M0rn2Ao2XR/GvcvBpoHrX5f89k=;
        b=mZ9xWcJPGJCLwrQNju9yrBuEuoKSQwUkwLIZnq2Z6nDS5vOkDGMOSfsKQ2m5wbrJGS
         im9eLAUujU9NdwzEiNvDe08dbGQFiBgqdKNUfakDj3mF9zmQpV/sMgYT8f+3D+/YSZYq
         x1mgKgyJM6AaxFa5ZJM8fwIirKWFbnctjc8M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2j8gBiRNl2VaOq43M0rn2Ao2XR/GvcvBpoHrX5f89k=;
        b=auh3poPRlS+bhSzsueF9FZZpyj3xDuFw32gcq0Y5OTc+RFmHtVw3bkK1pnBNK59SSR
         p7fQ3v+seR7BJlCPjaIA4Ayqiy3ZgEhdO4d4+Y8aY1ybbB4TrBjBF1rKsO4ryABQs20u
         QiUIqjeXS/gEwkjFMYwvicQ8wkBuARFHdPmzY+2qvWptI2MGzI2d/nB+lp7XOi0TWUKH
         0Pdi7IvH2sXFxGsu1mBrp1VzdTXsfx0X0oMCk4Xue3g7vF2k0O8l7sIO5Do+K0Lum1ws
         SSEZhQm4dAUsuJQv5SmjZJgfsNlZ4iTqL6OpACYiPtDufF6gJBRFe4ec27eiFvnjfv5K
         ZaqA==
X-Gm-Message-State: AOAM532UkqcilNczNRWvhDM+HrSSORM86y7KkVwtgFLOyBlwY6mBXbaa
        hMYLzDr9hQkxYkbb8bHiQ1ZSfA==
X-Google-Smtp-Source: ABdhPJxUwcFTBnCpm03bJuEKOfdkbdElV+yux9xGU1D+TTegkYpeTprFQkCozMA/Qs7+oaUQIP0DXg==
X-Received: by 2002:a17:902:c752:b0:161:7cb4:78b8 with SMTP id q18-20020a170902c75200b001617cb478b8mr6940375plq.39.1653004291348;
        Thu, 19 May 2022 16:51:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:e45f:1f3c:299b:4d86])
        by smtp.gmail.com with ESMTPSA id m2-20020a6545c2000000b003c18ab7389asm4128992pgr.36.2022.05.19.16.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:51:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] dt-bindings: arm: qcom: Add / fix sc7280 board bindings
Date:   Thu, 19 May 2022 16:51:08 -0700
Message-Id: <20220519164914.v3.4.I1318c1ae2ce55ade1d092fc21df846360b15c560@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This copy-pastes compatibles from sc7280-based boards from the device
trees to the yaml file. It also fixes the CRD/IDP bindings which had
gotten stale.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
It should be noted that these match the sc7280 boards as of the top of
the "for-next" branch of the tree
git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git

(no changes since v2)

Changes in v2:
- Use a "description" instead of a comment for each item.

 .../devicetree/bindings/arm/qcom.yaml         | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 2269493a1b48..f8caf4b920c8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -404,14 +404,40 @@ properties:
           - const: google,trogdor-sku0
           - const: qcom,sc7180
 
-      - items:
-          - enum:
-              - qcom,sc7280-crd
-              - qcom,sc7280-idp
-              - qcom,sc7280-idp2
-              - google,hoglin
-              - google,piglin
-              - google,senor
+      - description: Qualcomm Technologies, Inc. sc7280 CRD platform (rev3 - 4)
+        items:
+          - const: qcom,sc7280-crd
+          - const: google,hoglin-rev3
+          - const: google,hoglin-rev4
+          - const: google,piglin-rev3
+          - const: google,piglin-rev4
+          - const: qcom,sc7280
+
+      - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
+        items:
+          - const: google,hoglin
+          - const: qcom,sc7280
+
+      - description: Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform
+        items:
+          - const: qcom,sc7280-idp
+          - const: google,senor
+          - const: qcom,sc7280
+
+      - description: Qualcomm Technologies, Inc. sc7280 IDP SKU2 platform
+        items:
+          - const: qcom,sc7280-idp2
+          - const: google,piglin
+          - const: qcom,sc7280
+
+      - description: Google Herobrine (newest rev)
+        items:
+          - const: google,herobrine
+          - const: qcom,sc7280
+
+      - description: Google Villager (newest rev)
+        items:
+          - const: google,villager
           - const: qcom,sc7280
 
       - items:
-- 
2.36.1.124.g0e6072fb45-goog

