Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669035705F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiGKOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiGKOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:41:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F010CB;
        Mon, 11 Jul 2022 07:41:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so6525733edb.9;
        Mon, 11 Jul 2022 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXeQpXRbrH5X43wWagOkIwwhygGaQIFF6qtQ+Z9h8xo=;
        b=N7HeRO1Yvm19znwIzCh5ffaLuZnmb2PEkGhC+hxSVoeSJyjxYUn6MBAl6XKbBxyd9q
         EGyzOSFn986XUUZS+x6Y2NZjsR3TfIrMCZ3pxbUM/mRHxu9D1Qq+Pksh2z3XSxr7HzWY
         xHlUFOi/yDNIY6XlsuLe9oBXKkD0Uuz6mZ0yXGRKbV3uqN9vxkoXtw8BrG+sJ0md/Ivo
         fO++fcV0UqlXsKS0rDdJvfVN0fkT+l+YsHOW8ihaKiud1FvzbqBUoTSKyY1Y8aLt8UGj
         +a/wjLIXZdlJpZQE2i6/hS32jUIPvIoGwoZkv5iqve3rvRilOsYEHPpOmNpGaGZ24mYc
         Gxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXeQpXRbrH5X43wWagOkIwwhygGaQIFF6qtQ+Z9h8xo=;
        b=Qw7zt4rMXNQu66u2xIZL/r+hKY8Ovs9ZQI35aXAI0Z0cpEOecA8Tg+1dVj9nSNF1WJ
         rsPNBUrZqRXS0p1yI87yZXnZV2S/Adu50RinF9kQnUsypY3h/1JfizYGMqgtDNbWaAwF
         rQxL6n2Y0VNMVQodNY8do/3DrBXHxUuj6nBdhCDXZssvMssA7V+Ki8BaVL06aSqHx/Sk
         RsQpbYNCCf3jsbmImfinNnb2uxqkVlYInVvHpc1mOBBVjXYAFkdRtRNz9Ahoerivv9r8
         QtTSYQUXVnJ4wEE7Xx3zzEV+7FiVu7gJRYB1fW0nobTGZ4mUxLT9dcAtqWRimQOBcdYs
         3qvw==
X-Gm-Message-State: AJIora9GhyY2zUNunqhMd8J0hdoLUCdIW/Un6sYgJcsBdMLuMOMS6lZV
        t4WoBGLVkbzBY6dJrOL7PBE=
X-Google-Smtp-Source: AGRyM1tJUMuH7XabXaTMce5UeEqx7be1qKFN4GsEZqFEfJZPrdZYHtfCZW9rynveVK/SB55KSyMq8A==
X-Received: by 2002:a05:6402:248c:b0:437:afe7:818b with SMTP id q12-20020a056402248c00b00437afe7818bmr25054824eda.239.1657550503859;
        Mon, 11 Jul 2022 07:41:43 -0700 (PDT)
Received: from localhost.localdomain (89-39-107-113.hosted-by-worldstream.net. [89.39.107.113])
        by smtp.gmail.com with ESMTPSA id cm10-20020a0564020c8a00b00436f3107bdasm4461390edb.38.2022.07.11.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:41:43 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] media: dt-bindings: ak7375: Convert to DT schema
Date:   Mon, 11 Jul 2022 18:40:37 +0400
Message-Id: <20220711144039.232196-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711144039.232196-1-y.oudjana@protonmail.com>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Convert DT bindings document for AKM AK7375 VCM to DT schema
format and add an example.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v1:
  - Add vendor prefix to DT binding doc file name

 .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ----
 .../media/i2c/asahi-kasei,ak7375.yaml         | 41 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 42 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml

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
diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
new file mode 100644
index 000000000000..22b1251b16ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/asahi-kasei,ak7375.yaml#
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
index a97fef8c131d..e6accf8bc12b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3063,7 +3063,7 @@ M:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/ak7375.txt
+F:	Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
 F:	drivers/media/i2c/ak7375.c
 
 ASAHI KASEI AK8974 DRIVER
-- 
2.37.0

