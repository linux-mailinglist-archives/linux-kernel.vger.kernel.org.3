Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31974D6135
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbiCKMGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348522AbiCKMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:06:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B11B0BD0;
        Fri, 11 Mar 2022 04:05:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x15so12560644wru.13;
        Fri, 11 Mar 2022 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYOH+D47s+nPvs6dVoBRspa7x8lAvKDpmLjt6UBzJDU=;
        b=AuKnyw0EnGIqZUppIffzfnzL+YN6QaezGTe6yGSfh/NDTX886ag6hFNQH9hMsjYMOy
         vrKvoVIG+qFEpN1d55zp99Zm+HUAdTO24Wp5t5dgAglhXQJ1WzRaAlnB5LaILbYrrt4c
         ZCIv1biM/+6eL0nt2tEWZGi5q0fyeQkoXBHWwtUO6wV2Znuart0Zp/vZlIY/2Hu4fbCB
         Ks2sJlBsPZRk9uTJ1Q8C64gGSgV3z2nj2rMd3kwAPLVbxPQbu5aNR8LMaujPZtdHiY6a
         xQzczXmGELqukqsmKW+uqVyuBQG7LkUKPZH7kFZCuqGdoJgtK7KO/mAL0MqSc7PX2RLQ
         mOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYOH+D47s+nPvs6dVoBRspa7x8lAvKDpmLjt6UBzJDU=;
        b=2bGii9ZIZKb0Spe7sZ8N+QmD4ucPdwothqNMxkHOVsAUnuPYRxgAo8L4ufBJUDyvkw
         3rhx1XFtxnhECvE7z5qPIFuG4Ocf9yzolbhLY/4NbEJkRIQzhoW+GYS8cVE/OWaPfLg4
         z8Hh7EGfs2+GCMC8cG2msR/o+4VoUAfWQcSqBDQHrL9wBSoA9Yeg53Rw09NqnuAvSQeF
         mIu0sghLV0gT+i3QLmvxmRSTEKzgTNU0MEE6H1lVIc4ero5GzIc29pya7RFSuAVY6qIw
         8jVZ0MXeQCwUNJ8RxA9zQZh/jg+fBBItTvPbUsdJwbFHMWW7PBXTYYsqcfKhpE9mNoTe
         zXnw==
X-Gm-Message-State: AOAM530XIHl4TUb2WqMiv9+OJsmW9YndO9V8tePgNCu5Ysp7ai8ZRKjm
        lE90GVQPYYVErgMwgvY4Abg=
X-Google-Smtp-Source: ABdhPJzPnjYD1zLgfIdrULQgUSle81YQ66OZvmi43Udp/O9Tniin/9iunU/jOKH1zntKpuZLoaZq0g==
X-Received: by 2002:a5d:6405:0:b0:1f1:faf1:a48f with SMTP id z5-20020a5d6405000000b001f1faf1a48fmr7067835wru.684.1647000307260;
        Fri, 11 Mar 2022 04:05:07 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm6595223wrr.88.2022.03.11.04.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 04:05:06 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] dt-bindings: display/panel: Add Leadtek ltk035c5444t
Date:   Fri, 11 Mar 2022 13:04:53 +0100
Message-Id: <20220311120453.163297-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311120453.163297-1-cbranchereau@gmail.com>
References: <20220311120453.163297-1-cbranchereau@gmail.com>
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
index 000000000000..9e728f8ce0cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
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

