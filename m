Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4494BCA09
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiBSSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:43:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbiBSSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:42:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3726AF6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:39 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3573840306
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645296151;
        bh=rlo6dv8R8AO8D00xVoydpkfzh23wJWM99TpGFXJ1F5U=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nIe/GF4eFfgeyjk+3IYN8rKCtt4tUs8OBkVKrg6MHbSYhaYX0oTxXTdolv32g95E/
         CSgMMOZtCaEEgi8fOsmtSJInJSWl77dq9uU4ZTpnJD1vRhnnkHKztqlcVOZMdF19VK
         KPopoU4+Gs1eaC4acd/lOylK7MaBoaNcaoLE5jJEZy/eCrqlS0O3MPYHiKNz1G19tu
         IkCgla8+QkdO2ezXkuPtGk+5bBCbUtNMJedzdOGnsc+vP2brMnXtWmXdVI1HP8EbXS
         Sjw1C/LtZXWSfCUSkh4/RRmvGtYHkYDdzUNSwreLPCowwHamgDd+xTHj+zF3VgJkgC
         OL1HX/aR8Q6qg==
Received: by mail-ed1-f70.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so7419878edo.22
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlo6dv8R8AO8D00xVoydpkfzh23wJWM99TpGFXJ1F5U=;
        b=vu8UAhZpg0I23LyyC1cSq+dw9jM0lgOyc2WdgZ7rMjjv0kxlFvQELPArIN/nA4FYfa
         dGLoaz6HcksqVWBu6UXRKZ46Df19FtQxmra9muujCqhKsvfd27XOhcjjUmD6V2HHCgC4
         oK9VSdYh6QgmQMRWr96R2ioWaMHVNF83GojWmlEJkGRnjGnr+qjZQrGlUQkBhfaBMKSF
         eZvrpIyTGbitHkIaR6FIkF5w6daa8P02cVd8aDhKr5SotJ1HRYf3x8O/qgBiEKUYD2G8
         KtAtfVY/3bCVjt2v7hG6vW7tpudbVHHkdYdhyLbK3f7AAS+RnC4IF9agwa0wfkhcJ+Sf
         7B7g==
X-Gm-Message-State: AOAM532Qf9AygGZgy2/OyONENAdcERUPvO0dE1Mp1iLLfs1Wd1E4gE/O
        4a6+kaSonFCfqQnK09hTMNnZlHFlAq5tlYWx4peRWPRuD3/zdBJ5r4RHCL7Yb22xsuzZoVjJJ09
        VQTv8rmHTEmXD3/zKv1sQL6bu1ZRnsajDaCBFmDgCKQ==
X-Received: by 2002:a17:907:3a13:b0:6cf:1186:1381 with SMTP id fb19-20020a1709073a1300b006cf11861381mr10792756ejc.539.1645296150893;
        Sat, 19 Feb 2022 10:42:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2naSdEU4Ep7cfPOis7zL8hDLMxXjvy+MqwgzXgYHKGMAwKMtnXxUn3sccavk0GfxDOqA4cQ==
X-Received: by 2002:a17:907:3a13:b0:6cf:1186:1381 with SMTP id fb19-20020a1709073a1300b006cf11861381mr10792750ejc.539.1645296150719;
        Sat, 19 Feb 2022 10:42:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j8sm6680745edw.40.2022.02.19.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:42:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 2/8] dt-bindings: ufs: samsung,exynos-ufs: use common bindings
Date:   Sat, 19 Feb 2022 19:42:18 +0100
Message-Id: <20220219184224.44339-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../devicetree/bindings/ufs/samsung,exynos-ufs.yaml    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index 95ac1c18334d..e01408b4fcc2 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -15,8 +15,10 @@ description: |
   in the common ufshcd bindings
   [1] Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
 
-properties:
+allOf:
+  - $ref: ufs-common.yaml
 
+properties:
   compatible:
     enum:
       - samsung,exynos7-ufs
@@ -47,9 +49,6 @@ properties:
       - const: core_clk
       - const: sclk_unipro_main
 
-  interrupts:
-    maxItems: 1
-
   phys:
     maxItems: 1
 
@@ -67,13 +66,12 @@ properties:
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

