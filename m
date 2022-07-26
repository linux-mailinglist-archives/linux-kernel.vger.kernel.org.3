Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9C580DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiGZHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiGZH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:29:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED522CDD1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:26:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso10746254wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rb/J2paXCQbY9WOdGJUo9+9cCQm+agYr6BL4znNtuT8=;
        b=hIjIzkPaqSf53WTJL2J88j6VVWGiBLIot2PM86d6IO+5pNYCG2odIzbDBTPaVdj4rM
         LWMuy7vZzKkDM1LeLJbzR5pqU+rjx8+91S9YRklLiq2jfr8/7zVYibu9qWyNLHae1tlO
         bcdwqeRgy3P6QKBI3cGdZ2WTM2XErduxQ5DqJ49OcRbI5YSR2a6O59EpQHNBwq+upwYS
         Eo1XF87jRCjA22pfVuNcpvxd6Jjq/7zx4Re++JrBexnpQHQJ+Ti/mBHx5fGLENsgiSZ6
         sfXhDuaQeqNOPH6I0KUdN/dzGrAQXH86hJPnoYZwGnkadzO+wn3X4nGmDNl/iuAprOs8
         lmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rb/J2paXCQbY9WOdGJUo9+9cCQm+agYr6BL4znNtuT8=;
        b=s2wZ3H/04fG/2/36w//3sBii+bvUTTQtu9twFIYDiTgY5TG0cQNrB5uiOpLsfpem0+
         ilaYiPDHQ6GeOn+wzFMKKYFsi4020BTa1+HuztVmVlFZMoDk//9tvXa+NPZuCcrW8N4S
         /sMqm3kCD8Ybr2hVqcOV7B6ISI/4qgASCycFhB8E3eHFKIugz4ekNe7OkrvpLPFOcLEi
         8++YwHWxxCnR0uuzl+sKOgajNnRaqZeRquJVTyNIZt/5JXeQlWav/1EjBnquW/ntbZHe
         RvaYsmAUZnU0voN5fhLOBtmD7Xt9ZjM5TgqFSWAeRCTBIHaa6xzb6lOowcBgqr7jkQu3
         3CKA==
X-Gm-Message-State: AJIora8/nkYfMSVGhyoYwjnWYgNnQnQUgaLsGrvj1f8IFYmHPQVFCCeE
        EW49Qq6AUbOeyHib5s09XZCO5A==
X-Google-Smtp-Source: AGRyM1vUHj+p03bFdxBNpvJ/ADK7wO0Sgi+HKKAmKdJsc+Toa4f904HvF300Lkhl3qbHo8wyU5/Tfg==
X-Received: by 2002:a05:600c:3d93:b0:3a3:3a93:fb16 with SMTP id bi19-20020a05600c3d9300b003a33a93fb16mr15507442wmb.190.1658820371065;
        Tue, 26 Jul 2022 00:26:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:77d:8cd7:621a:855b:69ac:c34a])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0021b956da1dcsm9007835wrv.113.2022.07.26.00.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 00:26:10 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v1 2/2] dt-binding: iio: time: add capture-tiecap.yaml
Date:   Tue, 26 Jul 2022 09:25:53 +0200
Message-Id: <20220726072553.5136-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726072553.5136-1-jpanis@baylibre.com>
References: <20220726072553.5136-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a YAML binding for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 .../bindings/iio/time/capture-tiecap.yaml     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml

diff --git a/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
new file mode 100644
index 000000000000..4f08e49a8506
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/capture-tiecap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Enhanced Capture (eCAP) Module
+
+maintainers:
+  - Julien Panis <jpanis@baylibre.com>
+
+description: |
+  The eCAP module resources can be used to capture timestamps
+  on input signal events (falling/rising edges).
+
+properties:
+  compatible:
+    const: ti,am62-ecap-capture
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ecap0: capture@23100000 { /* eCAP in capture mode on am62x */
+        compatible = "ti,am62-ecap-capture";
+        reg = <0x00 0x23100000 0x00 0x100>;
+        interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+        power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+        clocks = <&k3_clks 51 0>;
+        clock-names = "fck";
+    };
-- 
2.25.1

