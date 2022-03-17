Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E34DC58C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiCQMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiCQMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:10:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3B8141FD3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:08:50 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5A4D43F1FC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518929;
        bh=X7QhYmDIEsiW2YaB7ul9V/GC60Wb8/S3oj320pLtdF0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JTR7nwW0C0bnJ1DDrB4AclY0TXg3uza7Ltblo19iQm7kKXCjcQBVc2UOcEv1eqO5J
         3YfjBqNb2yzMBZ05zjQ+UcUonqPtPQaoMl+uqB7bajexuCUwkDrhg4kvzpiJtIIwPP
         AO10nRWrlIpNd4nJOlYzdt73hmoBJTk39dDYYsKck8W2Qxy+9r6E6P0vNThGhOWBke
         1dxNn5igoLHKgot8P4RJ5LeTcMrO3X3NzIibZD3U4X4sC6Ve5JRlSn3U8efhstE8fv
         yBK9wO0oxmn8Rb/+49jFVPRYfUoi6sA4kyV4S2ZzbNXH78O4m17N7YbjTA3gR9RhD7
         3odqtrEE2eDng==
Received: by mail-wm1-f71.google.com with SMTP id o19-20020a05600c379300b0038c7117460dso1480658wmr.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X7QhYmDIEsiW2YaB7ul9V/GC60Wb8/S3oj320pLtdF0=;
        b=oG6frz9M4OiPAPghABbpMG8b9Z9keqE+DSDINHHliDV1F87LTgbu5YYYvPMHlsj+21
         OCyPabKHcxFevX8NfXkcDS1gZX2abrWZV7Oq1StfcKd6DnI64dZjJg9JVkMQqPH27+f6
         W2kJYOFNEd8Vfyell0cQIXo9Ie4dvPr4kxAFgKNNAD5yEFrzoGoiS2CyRb1nY3IifzH0
         lE7e4YhSMN51SIpfvV8X7CWVV5v6onyDJgCGFpg8xxnPW3KlJysEdgL7zgS+hiS9YDfs
         LpZBfRWx6PPP1dtVtCX+keJcMfoV9pzHlmAyNeExVJ7a0KsT9cNLNsdHdutCAx2Iwefo
         Ud/A==
X-Gm-Message-State: AOAM533UpaTDGdyxvVTX/Zc2atL3v9iIYHlwEQFh7Q+TijMqF/vz+Yfq
        LAWcjC5z86Va3NXzyu8iYBUmyFlPrgerWthNLeV0YUM7vBpriGuY+Y73NhMeY1WGOLxKCa1yK0t
        k7k+YSTI9+nEdUFL2C6s5yUfIpiJcL9lYo12aswEi1Q==
X-Received: by 2002:a05:600c:3595:b0:38b:42fd:fe2f with SMTP id p21-20020a05600c359500b0038b42fdfe2fmr3620778wmq.76.1647518928552;
        Thu, 17 Mar 2022 05:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3/TN6BuIOGImoXaaSmmnMpZDC8v2dSDLcP6OOk9tKoxZIzgO1qTsE0hvhz9F2woPEm1mIkQ==
X-Received: by 2002:a05:600c:3595:b0:38b:42fd:fe2f with SMTP id p21-20020a05600c359500b0038b42fdfe2fmr3620753wmq.76.1647518928330;
        Thu, 17 Mar 2022 05:08:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm5091748wmh.41.2022.03.17.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:08:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: irqchip: ti,sci: drop Lokesh Vutla
Date:   Thu, 17 Mar 2022 13:08:45 +0100
Message-Id: <20220317120845.452813-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Lokesh Vutla bounce ("550 Invalid recipient"), so add Nishanth
Menon as maintainer (TI Keystone maintainer).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml   | 2 +-
 .../devicetree/bindings/interrupt-controller/ti,sci-intr.yaml   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index 935a61504aa0..f2148212ed3a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments K3 Interrupt Aggregator
 
 maintainers:
-  - Lokesh Vutla <lokeshvutla@ti.com>
+  - Nishanth Menon <nm@ti.com>
 
 allOf:
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
index 0d35a5e21a64..9b6b0e0dcf7e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments K3 Interrupt Router
 
 maintainers:
-  - Lokesh Vutla <lokeshvutla@ti.com>
+  - Nishanth Menon <nm@ti.com>
 
 allOf:
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
-- 
2.32.0

