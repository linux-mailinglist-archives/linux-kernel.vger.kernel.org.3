Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3054BFB68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiBVPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiBVPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:00:10 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA110DA4F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:59:44 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B7E0A3FCA2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645541983;
        bh=74/pBhghHeWH7/mWTs7/IJw313x+oiYcimgGGTWLW0I=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lZzY+9CANg/mFRjWa8pOexhcMYuFW0b6a/t344ieDX4kPDvTBUtc49+xGyINzLd6p
         9vuBEFyrnjPz3gpFCW/JvPW2EyMBvK+BauXG5/fS4+PrGDoX1eMrDqcb5lBz6r04gk
         6BoHNqnfE1x0aoXoLXOJaglTIKh7nJ/95RY5jWupGLot9pN2zLp+3LEHrbfBfqnzO8
         +NnIVHOzYOj5j7ZeDN202F8KkY4itiYgJ9fzMp5gcI4pWBAX4gIpBmM/325yFaQ6Kz
         Ek0Xs1u0FxfLdY74beC+TSaNKqWZxqiIU4mSdHf10RbX2NSPik4AKPRPGoeoQ+OZV7
         Yu9uLfJAHGFpw==
Received: by mail-ej1-f69.google.com with SMTP id sa22-20020a1709076d1600b006ce78cacb85so5897079ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74/pBhghHeWH7/mWTs7/IJw313x+oiYcimgGGTWLW0I=;
        b=Pf/1/4uV7rM78VtZdcYDpa1W7O4TSf8aucVIl/0vsHwZ099rrHrl0QvMy01+JyO7oR
         cQXJn3SXLmitPCgEEQZx9+zeR+EpBZlt4ecMSzjLWvv/wL40oqRypmb+9bE+GyPjxG3t
         NyoDDpgmzgUlwZtsKGvKSndtg+PI9xJZGDBf7XY5/Oj01CX+2mi1b6x0a3f6zQTJ7kRz
         ZWoPx56DctK2NPMIyanXsclsYGoeV3adMrrnP1z39yqPXHp/xP602z01PFKmjeTbf+64
         vIw9gbuYuvmSnY1N7ydMlDOdZkEelrNSy0UEoGOqDWpweOvn2ILhEJyFyFCcPV+27e2M
         VJhw==
X-Gm-Message-State: AOAM531sZmnbglASzatLDDz2GKG1DiL/YqjSqefmSzFYOptwgTCgTgK0
        olNP7H1GAZz74lJiLiP9mZOJkobhmbKit9KEZW9WjTybgKzzxbbgiGHIf4aiSV/9W0+QnORgsC4
        /kzZEg2+aVrihP521D39wVT02rvSuIZhlOiu3zK58hA==
X-Received: by 2002:a17:906:194f:b0:6ce:3670:92b with SMTP id b15-20020a170906194f00b006ce3670092bmr19235880eje.737.1645541983446;
        Tue, 22 Feb 2022 06:59:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnm5ZDMw7fGj3UZIRVOLHmbWI713Qr92YShXMsW7GfodY/Q/WqKceA948ZzJpTHBhv2Bc9gQ==
X-Received: by 2002:a17:906:194f:b0:6ce:3670:92b with SMTP id b15-20020a170906194f00b006ce3670092bmr19235863eje.737.1645541983264;
        Tue, 22 Feb 2022 06:59:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:59:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 02/15] dt-bindings: ufs: samsung,exynos-ufs: use common bindings
Date:   Tue, 22 Feb 2022 15:58:41 +0100
Message-Id: <20220222145854.358646-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common UFS bindings in Samsung Exynos UFS to cover generic/common
properties in DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index 95ac1c18334d..c949eb617313 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -11,12 +11,11 @@ maintainers:
 
 description: |
   Each Samsung UFS host controller instance should have its own node.
-  This binding define Samsung specific binding other then what is used
-  in the common ufshcd bindings
-  [1] Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
 
-properties:
+allOf:
+  - $ref: ufs-common.yaml
 
+properties:
   compatible:
     enum:
       - samsung,exynos7-ufs
@@ -47,9 +46,6 @@ properties:
       - const: core_clk
       - const: sclk_unipro_main
 
-  interrupts:
-    maxItems: 1
-
   phys:
     maxItems: 1
 
@@ -67,13 +63,12 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - phys
   - phy-names
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

