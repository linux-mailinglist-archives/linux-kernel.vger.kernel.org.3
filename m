Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4653909A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbiEaMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiEaMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:20:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B3377D2;
        Tue, 31 May 2022 05:20:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g184so12704683pgc.1;
        Tue, 31 May 2022 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7ahqBydDZnP+CjyjsQFK3suIZ5X/7W6Ul5AL8gL7a4=;
        b=V5itc85HJVOWLynsGAGbF1b5IIyjo0uTDnuVBTCCvpXUdjthi8sBYuyxa4mOI983QJ
         QRaZ23PoQwQuHk9R5/xKIoGSln9pltwe9Lb6AnFLQotGz1OZ4dGRMeT+wZp9RU2qFn0b
         lciRB2KdKxg4IWBsOWL2RR3ezr4cEzL5zf+aF41EqU9ySuL/2yKglUC/xzz9Xd8mMjDG
         8chU43vxbt3ZkKn7/jcxCwm11FuTojBCXfq8Cr+A66YKjx++ANR8c/mpuuj/bNex/otj
         LeRysJHhBMTXapMxRzgaAlKfUP6g5WXMCrZvMYi5XjLOZBFPgxstIbP+1lR6a/81s6FX
         1xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7ahqBydDZnP+CjyjsQFK3suIZ5X/7W6Ul5AL8gL7a4=;
        b=SpgQMFiBu0lGYZyoHNUKlVtdR0DqacaUcQM5h1iEGulbivZKzR8dHWSYK48cqK6Fcd
         HKdhvXsDO5Lz4b0+MBspxlNHhKYOIxKJ3wyCjaptyyDRdUtW6R966IKGHVj+Gb1s150o
         s3jPQkVUaa1HimJbfZuXXSJxqh5IRkilBleNzOejAtfa/IQkjjsKg0/Jo7zbI/iovURy
         XRXf69TIh8i4A56wXbxfAV88T7wlweQr7oIiKT7Ly4tpg1kwMVbLOTStxI9L7ZPQR5Qb
         WZ1N/5RhD6d7tcnd13L8KtMOtkTypYJ9ye/MVoZfDj75YJwFfAMq3o+mpmmN+ZBo5V+U
         DJYw==
X-Gm-Message-State: AOAM533SSx8RudZvW1QODGL0I6TN5uct8NKB8MdmKk3CyNhUo5ZHR9ZU
        JHfoZjCSAYVLTOlkQT0y0vn0btRvq0s=
X-Google-Smtp-Source: ABdhPJzR0hOuFaR8Ft3dRJkMlyvX58IIHNvptaqVZwrijhZ0GTUJ0qsvccPRjoO36QbkdyU7o6Azrw==
X-Received: by 2002:a63:6806:0:b0:3fc:3b43:52d5 with SMTP id d6-20020a636806000000b003fc3b4352d5mr4887737pgc.319.1653993071115;
        Tue, 31 May 2022 03:31:11 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm10216519pgg.73.2022.05.31.03.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:31:10 -0700 (PDT)
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
Date:   Tue, 31 May 2022 18:28:07 +0800
Message-Id: <20220531102809.11976-13-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531102809.11976-1-peterwu.pub@gmail.com>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
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

