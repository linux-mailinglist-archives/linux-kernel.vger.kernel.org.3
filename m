Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38EB56D3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiGKEaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGKEaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:30:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7A18E3A;
        Sun, 10 Jul 2022 21:29:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dn9so6805312ejc.7;
        Sun, 10 Jul 2022 21:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yv9OpwL9wanJopC4m2vgg7+GMxN3Dmx4qKHjP8pLI8w=;
        b=GSc+/hthmv5AO96QcPzeJ5L0HfFuhhef8GwitjmYLtqK+6gUdyDwMUSLNvI8WQ3wE/
         uk4FUWIbbdPvX9mHKYNCJ3qDr7GFLm9SA122abF9DY1VuOO6S+PYY4fyAlROCM1qJ9PD
         ghAkG3Ds1donGmWhE0KwrJpNo4XoJlV0hs7UEB3Zaorwxd40IqULWIpmiB/3yiejsXUF
         575A8s/+z45xloSQbZVd0Tg5Pi/FghOrMtBM6yQH5aM8d0KCgshH1NsscCD/itN/M2fq
         hFXMnkUr93DPl0VANY5aPINw5Z61DwCtCum/hnOXj3UDqeZylhxTR36xzpY7izj1HksX
         RxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yv9OpwL9wanJopC4m2vgg7+GMxN3Dmx4qKHjP8pLI8w=;
        b=BdGiyIoqBTFTNhCquFpohVwFNHKHFaKAOAL2qBp1lyU0uecolbuxfIZxuhcpsnZPmI
         nK5YOWharpdgzDIOKl0EjmoBDRO+zYBT2Ln4UnH1e2pDGcYZ1AORZL4CCvU5IBl/uQmr
         RdgPJ7LOEtQKitYwaPN344e0ouhZEMeFQ7Pfz3/wsql8FFmCsiPGMZ9SoN5/Z2KEAyaL
         2VSeJsjhS1LFTOty9z+aCq43qC7mUjZNIix3auWgUFu3vl82zFtkA/m7YRnlYvKcOEcC
         3GJJ/abTckTQ9bWfSSWlShAppA4zygQ5xqLwdzcjNMyfhO2L/1EVnyuY+i2Xu9Ryzcag
         /VCg==
X-Gm-Message-State: AJIora/EO6J5ZBfJ0pGJspUDkO32JXRnTK3T2tdGe9QXGVnU94iTSNyP
        nlYt6e8bEdBj1kmO1PitowU=
X-Google-Smtp-Source: AGRyM1uD5satbuuh1hHHCA8GEKVcLteXvA4sAWvyM3FwCJY4LWBcHQfj9LuFHg84KkrCfUwIaQ/aqw==
X-Received: by 2002:a17:907:2cf0:b0:72a:aec1:2bcb with SMTP id hz16-20020a1709072cf000b0072aaec12bcbmr16089440ejc.565.1657513797092;
        Sun, 10 Jul 2022 21:29:57 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00726298147b1sm2203100ejg.161.2022.07.10.21.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 21:29:56 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] media: dt-bindings: ak7375: Convert to DT schema
Date:   Mon, 11 Jul 2022 08:28:37 +0400
Message-Id: <20220711042838.213351-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711042838.213351-1-y.oudjana@protonmail.com>
References: <20220711042838.213351-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Convert DT bindings document for AKM AK7375 VCM to DT schema
format and add an example.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ----
 .../devicetree/bindings/media/i2c/ak7375.yaml | 41 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 42 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ak7375.txt b/Documentation/devicetree/bindings/media/i2c/ak7375.txt
deleted file mode 100644
index aa3e24b41241..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ak7375.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-Asahi Kasei Microdevices AK7375 voice coil lens driver
-
-AK7375 is a camera voice coil lens.
-
-Mandatory properties:
-
-- compatible: "asahi-kasei,ak7375"
-- reg: I2C slave address
diff --git a/Documentation/devicetree/bindings/media/i2c/ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/ak7375.yaml
new file mode 100644
index 000000000000..4fc216846ae7
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ak7375.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ak7375.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asahi Kasei Microdevices AK7375 voice coil lens actuator
+
+maintainers:
+  - Tianshu Qiu <tian.shu.qiu@intel.com>
+
+description:
+  AK7375 is a voice coil motor (VCM) camera lens actuator that
+  is controlled over I2C.
+
+properties:
+  compatible:
+    const: asahi-kasei,ak7375
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ak7375: camera-lens@c {
+            compatible = "asahi-kasei,ak7375";
+            reg = <0x0c>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a97fef8c131d..19faf9ce8258 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3063,7 +3063,7 @@ M:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/ak7375.txt
+F:	Documentation/devicetree/bindings/media/i2c/ak7375.yaml
 F:	drivers/media/i2c/ak7375.c
 
 ASAHI KASEI AK8974 DRIVER
-- 
2.37.0

