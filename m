Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D144E4D41D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiCJHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiCJHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:34:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE35C66E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:33:07 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2E4A3F30F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646897584;
        bh=TgML8vcIsj55qZzyrpKzLOZN/rXvmVkt87rh4Y06uDM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=GEAP9l+oL78qZbRvoGBzjpJkRrcaDQzjOv7kW2gFipV7oMXEKB8icpV28zrxV5Okx
         eM9bptitZTMNYNYXUZ/j7J3w3a98qDTWA4mVNFrI6jwyH+li6TEFWAhwsisoJwvMa0
         wA+Z0keuyq3THw2Fksix5+Ws5JAlcU9jxwdU04OQFz+9fzfSYBs5ZLNZjG9jKFCmt6
         7zbKzWeZvxW/kBHz+qnrbwPAubrx8hgRz0t1Q1erqOgrO708E2xV/g9diS3eAPQf+M
         gj2JW/nL1Nr+RtTSXfC+n97v12FeYowbjslv+RXsl3AKBsdz75lIz3Eb/edYIwwXzr
         MC7l3uylt4/5A==
Received: by mail-ed1-f71.google.com with SMTP id b9-20020aa7d489000000b0041669cd2cbfso2609416edr.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgML8vcIsj55qZzyrpKzLOZN/rXvmVkt87rh4Y06uDM=;
        b=E85ez9YhNTgWGq/raj1UsGlaGOQllD/av2gej/Z+sieNi1UBV1ngVgXaDLjGwdBVO9
         Lm6KiwpuJX9LelSE29S55enH5Sw8Kn4IBmPRHAMwu8kw3gLGABDR0zlft9NsuYi1IAdf
         Tkx4lSAbhAyWgb/sG8vMxZvJofH7ijE5MlqgunS8X4RGA5pHvJEVMG7ANM1mKsWkntJt
         p5Br2Usfee9RkucXq8KvhKcyOOYCf8gL+twHzSdaAe/NVBwaP0FI5EBK9KwxEo2iCW3p
         FluoFPGEifuV7ENHzXuF9MWXKvx4YQMq3tBCe9p0UKTWMqFhREUZ/6/G6NLKO9qdM7dQ
         SW0A==
X-Gm-Message-State: AOAM530MhlYqzi374+KmCPpvzdIIrRZUYDlQc2LSKZU9ntKu4MKeOxDc
        +gSerHO8CJKx0tjdWqk+WU1znho7sM7VOkp47FN+he47CWL45TTFPgGsDyujQjoGI3hRfxrh0LV
        p5zFF6dmpML0M3NhCE1Ah9GPbPeaYXtQx8QZdxILqVQ==
X-Received: by 2002:a17:907:6d14:b0:6d9:565a:ed0 with SMTP id sa20-20020a1709076d1400b006d9565a0ed0mr3005868ejc.331.1646897583797;
        Wed, 09 Mar 2022 23:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRXVwL9gA+TMs2+QC00qdM7V4AHy3V4XlW18f1P6pA5J8sS0tY30urvNkwogvuZq2bAwWLLw==
X-Received: by 2002:a17:907:6d14:b0:6d9:565a:ed0 with SMTP id sa20-20020a1709076d1400b006d9565a0ed0mr3005858ejc.331.1646897583641;
        Wed, 09 Mar 2022 23:33:03 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090609a900b006cd30a3c4f0sm1533494eje.147.2022.03.09.23.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 23:33:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: extcon: maxim,max77843: fix ports type
Date:   Thu, 10 Mar 2022 08:32:58 +0100
Message-Id: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ports" property can contain multiple ports as name suggests, so it
should be using "ports" type from device graphs.

Reported-by: Rob Herring <robh@kernel.org>
Fixes: 9729cad0278b ("dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Hi Lee,

This is a fix for a commit in your next branch.
---
 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
index f9ffe3d6f957..0216ec868c3e 100644
--- a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
+++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
@@ -25,7 +25,7 @@ properties:
     $ref: /schemas/connector/usb-connector.yaml#
 
   ports:
-    $ref: /schemas/graph.yaml#/properties/port
+    $ref: /schemas/graph.yaml#/properties/ports
     description:
       Any connector to the data bus of this controller should be modelled using
       the OF graph bindings specified
-- 
2.32.0

