Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757344D671A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiCKRE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350517AbiCKREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:04:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E9CBD7C2;
        Fri, 11 Mar 2022 09:03:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j17so13959751wrc.0;
        Fri, 11 Mar 2022 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwsLrQT6c+k88K9ITqU2zLknOaYZbpaIvD8leAUiegA=;
        b=DNvHgYYlkL+pKnnv8hzc0Q+oE5OOGcOD8j7/py2oJBZY/TQyGMwl3PHMAaocTTQPBB
         xeOlW7qBfgoS7PYJr9bVbg9s6cNVuEvAzEdVTd4OrBy7Npe+SM7H+LgXjkOgBFBfwKID
         CI6dIVeJqUIm7qyLaDGadFQNRJ/I7cVqOUVdY/JWAKPThF2fm9ZW1XvABrGPhkBJ8jkV
         Elg618lD+Pkn5zmdFR3jh8BkGmsj+SeDXvBiwWV51WBLFceCl1E6KK664XdqvdZXtrbZ
         OgWweurUsodV9JAJRa4MP2+0skqMy0Wke4oVd3rb3nj+Sxprcf4oSzMDWAgtB2v61uNt
         RwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwsLrQT6c+k88K9ITqU2zLknOaYZbpaIvD8leAUiegA=;
        b=PcDsZGxB7iQ5VjHulgvfvqk2khZaJBgithKaUSgtA86S9WFusdBnxfWmZPZbTu1up8
         LOxBUCZl6Mmba8pOeC9744Ic12nFs/xtB37jsSFoQ7XOkLO6U61vXDpFGmEvlfonaXQE
         R2P86QAhOe8+b8n8v0+TShBBEHerLqGHsj3jR061G9QnJONXjOuObqMUciYi5MFMZ08j
         9qf6Jy/qgrAb9E8ij9V3GYyzgM7BihJ3j3o4bHqdkQF4VIKRLXJ9LBBQdG0lWRrJdfb/
         /H2g2zjklgvfjETokyJVgAQiGcI25nJ1prBg5M11hZX3AVkAfBA0HzcqLE2rdWRvfZtU
         3REA==
X-Gm-Message-State: AOAM531dkqzK8MWyBfTmwUnOx4OYjG5DXN2v6S7Gz9k60GVJ1pkbNwls
        1BCON+oKD+g765dtsnAWD1Q=
X-Google-Smtp-Source: ABdhPJyvqTvSUrmLkj0DzlrVmQ5Jc2Hg5r5yfUjHfqN3lCBGmYwfQDZIjqPDTkJIWkodCizdeo4Q2w==
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id i14-20020adf908e000000b001e7bea73486mr7809967wri.401.1647018181847;
        Fri, 11 Mar 2022 09:03:01 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm14067733wmp.13.2022.03.11.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:03:01 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] dt-bindings: display/panel: Add Leadtek ltk035c5444t
Date:   Fri, 11 Mar 2022 18:02:40 +0100
Message-Id: <20220311170240.173846-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311170240.173846-1-cbranchereau@gmail.com>
References: <20220311170240.173846-1-cbranchereau@gmail.com>
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

Add binding for the leadtek ltk035c5444t, which is a 640x480
mipi-dbi over spi / 24-bit RGB panel based on the newvision
NV03052C chipset.

It is found in the Anbernic RG350M mips handheld.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../display/panel/leadtek,ltk035c5444t.yaml   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
new file mode 100644
index 000000000000..817a9bed7d5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/leadtek,ltk035c5444t.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Leadtek ltk035c5444t 3.5" (640x480 pixels) 24-bit IPS LCD panel
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+  - Christophe Branchereau <cbranchereau@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: leadtek,ltk035c5444t
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "leadtek,ltk035c5444t";
+            reg = <0>;
+
+            spi-3wire;
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.35.1

