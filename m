Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8504B539085
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbiEaMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiEaMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:18:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C937A1B;
        Tue, 31 May 2022 05:18:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j6so13005450pfe.13;
        Tue, 31 May 2022 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7ahqBydDZnP+CjyjsQFK3suIZ5X/7W6Ul5AL8gL7a4=;
        b=pbtIgDiOlAAzMPQJX9RSET7wKKMb0cURNTYAf8khBIJ7tgAMritvSeyBHK88OgWp3J
         p2eY3mg3nQEC5svVgaRYVeHAiWB0LK1plQskY/5QYNoiPRdVCIIoFp6C7FMbAF8UGrrd
         lBadBgtoaMg++H1MWs2p5uzAP/rBSoi7lJAW3YNDUwxLdmQJga2RGklhnlZheYx4tGWA
         JDLreq67j91X+rNozmBhfZclynEPT46jWN/SwmgF8xb5UhpKWmTArXQaEu+WsdRc677y
         XMwxshss89EaOuzNJZgSx1EX9fVS7xIgMGz1U4lbxqWjQpEQZw1NlJ6XcpFM9jWAulGH
         LEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7ahqBydDZnP+CjyjsQFK3suIZ5X/7W6Ul5AL8gL7a4=;
        b=WHXbqFH+cu6p6gjsD4bf+MOSHVeNabMUt7VTk7w1iiDQfpMDXCUfmOCxqkz3mPKxLk
         rrjX9oPMbL2aiHL7jENqI3aO6ojgw5uQ9veVuTXZTiROriQYzFUl6Cbp4d+sr2sIhx7D
         mqWH0ziiPeh3vzNtVu6aF9KdxbWEBP6vI0bO93pYn/y3hD9zX7z+SUD1NxE0K2L+3pvW
         xvlgHV4bG2u1pY74vCYtnUqXxw0hqVMsdB7j0us0VQWdbeJ9iBUmwIAAhVNsWtPGGMe1
         fSDW7VlTtDkbHFgWZJg4K+oXQSRfeZZnos9UoZwiEDBCOVhXaRaCrGFpfdtKtdqr03Vc
         88tA==
X-Gm-Message-State: AOAM533v4xUNp9ZVBHN2d3MDgf2H3LPkiOpvOOQhtwJ0JpBRbNlJZVzf
        4xAmg4slsEqWTA/gkPj0nL2UP2LiVCY=
X-Google-Smtp-Source: ABdhPJxfNtDreP69KzGE54ZQe7nNgxdxT4MxnC6lkz0a7elU8yTD8DI/llg0zMIxb1K6PG6nwQyNxQ==
X-Received: by 2002:a63:1066:0:b0:3fa:c21c:bf38 with SMTP id 38-20020a631066000000b003fac21cbf38mr29418134pgq.453.1653993756469;
        Tue, 31 May 2022 03:42:36 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090ac25300b001cd4989feebsm1525829pjx.55.2022.05.31.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:42:36 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 12/14] dt-bindings: leds: Add Mediatek MT6370 flashlight binding documentation
Date:   Tue, 31 May 2022 18:42:09 +0800
Message-Id: <20220531104211.17106-4-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531104211.17106-1-peterwu.pub@gmail.com>
References: <20220531104211.17106-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Chen <alice_chen@richtek.com>

Add Mediatek MT6370 flashlight binding documentation

Signed-off-by: Alice Chen <alice_chen@richtek.com>
---
 .../leds/mediatek,mt6370-flashlight.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 000000000000..b1b11bd3d410
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  see Documentation/devicetree/bindings/mfd/mt6370.yaml
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    description:
+      Properties for a single flash LED.
+
+    properties:
+      reg:
+        description: Index of the flash LED.
+        enum:
+          - 0 #Address of LED1
+          - 1 #Address of LED2
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.25.1

