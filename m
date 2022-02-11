Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED964B2AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351738AbiBKQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:48:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351722AbiBKQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:48:00 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199F7BD3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:47:59 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E85943F1CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644598077;
        bh=4lswzRVAGMbVN4fxZWJ4W9VwOoIlRM/pZiE0wihHuB4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=us/gU3pKk5J87Pblr93ix2D+jgvo73/Dr/tZoalVjJXOo8ZG1yG2QfouR3BZzujKM
         QEDq6b9KIt3QeTZXEzYOIk587GYdmzBPKEYAUqIEQH19878FttW7qmWcp/uSmJa4zL
         ICZ2hH9bhJhBXYMrkuSfmExx2FPRGUTvLiKg5f1DnS89Gnv5q1rnemmYq4M+k6+13E
         i48gqu0cze+/TRADulutiYKNWyulxRWR1DfZ6AvFNdk1OCibbkAv1RWXwe405lw1ks
         dA58ErSCLn49TAK6kq2zqGRBpIEyMNDdjaBHw1EQN+pTUP5Aj4oaaFe4wsl6notxzN
         K7vamXY+54JbA==
Received: by mail-ed1-f71.google.com with SMTP id z8-20020a05640240c800b0041003c827edso4026438edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lswzRVAGMbVN4fxZWJ4W9VwOoIlRM/pZiE0wihHuB4=;
        b=TJSk4D6TDE2WGoXXzY7BDUUv9qAPtvgFTb28C0sL5iLmopS76EVfSbQWXRxb6xgOKW
         2fQlwpWMvHuqVZWSQpmU5Rr38vtBWPQjWqt314DPpXYlj2uKET9l4WrJNCMsrhP2gHBV
         qDJON0EJvDL74AeUWo9OCuhTEF61fqAicfwV+jNgR7zMl4NWbGUQhj4jEpDAw/6rwIMA
         ZW4zBudtEk9fSnQwi1Yq4cwqHKxsdeiWukU1UEsVIo3R34343LWo0exxDLYufN6ZfmTV
         763XbN5D956Yi+QugSuK41Jr6a4//XQsQOadunL7D5sQbAKnyh0/ZnGS+A2fV4moG0Mt
         a2ag==
X-Gm-Message-State: AOAM531uZlp3XS3Zs2GmUQvnHKy3nZVfX9Lpz8nPGPZ27+IKajF0NhZp
        lg6mE5MpC8gtjkRzAbeJ98B70rRsfPzK+abj8ehsjMcAOeeypLXuWSIb64crUARt4fOvExqGDj0
        dgtW2Hd2day5xpXEgPKUQX0rzq3m365QERbV48sb5kA==
X-Received: by 2002:a17:906:d550:: with SMTP id cr16mr2076697ejc.257.1644598077401;
        Fri, 11 Feb 2022 08:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVaaGgrMK6Xd0ZUKTGZK48foO64fs4vM24QmAKR7PNgLUxAff0uHLt5kCrVQyMq6YcUbvD2Q==
X-Received: by 2002:a17:906:d550:: with SMTP id cr16mr2076686ejc.257.1644598077198;
        Fri, 11 Feb 2022 08:47:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n24sm5036951ejb.23.2022.02.11.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:47:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: soc: samsung: usi: refer to dtschema for children
Date:   Fri, 11 Feb 2022 17:47:16 +0100
Message-Id: <20220211164716.120880-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Explicitly reference the dtschema for USI children implementing specific
serial protocol (I2C, SPI, UART).  The SPI schema is not yet accepted,
so it will be provided later.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Drop entire paragraph about USI nodes.
---
 .../bindings/soc/samsung/exynos-usi.yaml      | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index 58f2e9d8bb0e..a98ed66d092e 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -17,13 +17,6 @@ description: |
   child nodes, each representing a serial sub-node device. The mode setting
   selects which particular function will be used.
 
-  Refer to next bindings documentation for information on protocol subnodes that
-  can exist under USI node:
-
-  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
-  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
-  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
-
 properties:
   $nodename:
     pattern: "^usi@[0-9a-f]+$"
@@ -75,10 +68,17 @@ properties:
       This property is optional.
 
 patternProperties:
-  # All other properties should be child nodes
-  "^(serial|spi|i2c)@[0-9a-f]+$":
+  "^i2c@[0-9a-f]+$":
+    $ref: /schemas/i2c/i2c-exynos5.yaml
+    description: Child node describing underlying I2C
+
+  "^serial@[0-9a-f]+$":
+    $ref: /schemas/serial/samsung_uart.yaml
+    description: Child node describing underlying UART/serial
+
+  "^spi@[0-9a-f]+$":
     type: object
-    description: Child node describing underlying USI serial protocol
+    description: Child node describing underlying SPI
 
 required:
   - compatible
-- 
2.32.0

