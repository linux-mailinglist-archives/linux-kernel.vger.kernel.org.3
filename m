Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846924CEAAF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiCFLM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiCFLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:12:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4886606E1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:11:34 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 627CE3F62D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565093;
        bh=l+3yBFGs2kRX1wnF/pKhhZHPFcB8pp4apl6TxfDIAEo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cNaou40RPlvBhEhsJwKhPo6bGSoddqMe9MgHZCG9Jb2UvptSeUqi4YeEgCS5/2SsX
         FXECURlxxqHJ3t5jsrjVRGj+Qy3g0+Ne3NKJVAVIwMi7zNdhHo/KwLQTkq2eXAnHGK
         /oPD3YcMzb5W5h7cNz302qKYUF/ZZ0rzr4GYx1+C471gNOmpV1tfOUlr9EA42/xE4u
         wGclw7t9Oo3Jz46gQaEor5Pgjwt0e7DgXJDL0wPJuhI9hbFAFLgQZR8ApFfpWCAT59
         szwUrzxsvny96weNlj4vDtYyvvmNp5Lr1lQboLNEAje+9XQAXdvF4djXmYOTLXhcze
         YZSjtKi0EUWTw==
Received: by mail-ej1-f70.google.com with SMTP id le4-20020a170907170400b006dab546bc40so2878340ejc.15
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+3yBFGs2kRX1wnF/pKhhZHPFcB8pp4apl6TxfDIAEo=;
        b=deRZH8+UxYCmdN9sYyVeApWfmBgH92FmZV3MYNDorV0rX4lkoR9VOGBYn0iki7LVUZ
         mKWntdcAWV+tAB/rIIhCOj9Qw6bwiSmQ87tjwvfCY9MVeXobHjjGI1eSc4QfEfBj+BHd
         BlV7uLZ3SX5TMsPTBtAPyHhFiA+KlEjOABCrBjj5SIzUg39DNqTIf8D7H06X49wrjMrd
         JlVkDH0VKNKDt20Omv7nzfc5Vjn5L/z/x7r67hFXu3s/wJT3IFpQbZSTKDLuM9ljInCW
         U0YAgRYMjHY0/XO9+VWk940r8Z157/+gRMo2yuoQqnfN9xLf5+LApm4JzxwD4yiaEX6l
         j5Vw==
X-Gm-Message-State: AOAM530rl1t+Tzf9rXPTHd8Mpp8W42IZ1ZEax/YQG2N3luI71DuejWCc
        GhRzFgQWS485//4epgtmZdXmS9VWp0Py5v73l3nf3JqpwGu/XLaPUzPgoHt4K1YnJEJrtl02r75
        IJqk0OuYEjDSv40L96KH5lup8Uv1JBkJO5tF+xIakKw==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id n23-20020a1709062bd700b006cdf89dc828mr5685959ejg.232.1646565092949;
        Sun, 06 Mar 2022 03:11:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFqqBEGSiJykeoRQrbuWpAeTlK57pqo/2+l/saQ7OCHi1VkQZAPsAbz54RGXOqql4jg2q7ZA==
X-Received: by 2002:a17:906:2bd7:b0:6cd:f89d:c828 with SMTP id n23-20020a1709062bd700b006cdf89dc828mr5685937ejg.232.1646565092784;
        Sun, 06 Mar 2022 03:11:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/12] dt-bindings: ufs: samsung,exynos-ufs: use common bindings
Date:   Sun,  6 Mar 2022 12:11:15 +0100
Message-Id: <20220306111125.116455-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common UFS bindings in Samsung Exynos UFS to cover generic/common
properties in DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

