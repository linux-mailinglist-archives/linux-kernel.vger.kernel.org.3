Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09064D5B88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbiCKGSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbiCKGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:18:52 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A27307B;
        Thu, 10 Mar 2022 22:17:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s8so7061966pfk.12;
        Thu, 10 Mar 2022 22:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FLJvetiEVjSl2Z/q1Pm7lZvV+L+ilwexJGJt6xRhYkQ=;
        b=EijL8UVG0fQcWZrkhXqYaB9eHeaIkfHdSv02uOrRAK4nPXz7TwZUYqF+VlFbIxgmem
         1vdVBw681p2Fpk2oFgcY5hpXanNIm8CzsdkVnTCQa4wueMS32/ROX/5uZpG/vc7HA4dj
         B1rmMLYxFUp2jWYwC24WtSD9duxa+6AAw8C+Nj5F4SL9mCsX7vL7vE8VzV3J2UtluQw8
         L4vjt5G+isKb6PEoqdgIlyx1xUBLTW0lSVjXoJOzdygnVxFgSLvxuYYHTAzFXlhsLyAu
         7xkPzlp/Y3XfX4acIzi4mGWWMN02UJ/xqF1WGRFUtCfd+ai92SpdkJD7xH7N+8hEx54K
         HSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FLJvetiEVjSl2Z/q1Pm7lZvV+L+ilwexJGJt6xRhYkQ=;
        b=lyNM+i7NLC0L/v2Bmxvf2/c8SkYcV8dCPUsc2h/FVQzzMhBLLIBjQi+3bQ4FLy1alZ
         4P6fmmDMAZ9iudt9HbqT/9L4GqfEufYG6bsjGhXz7LwmigFyOYboRKXhecFA2mqMOvOg
         Z6nlgHoljXxcPusftlubwfKvnhaqm/rPldajWa1EiLCl56THxQEQBzhL7hiYQrbPlV2p
         JmNRwUw4DNPrVS1CJD41uULus+crUP/yaDdtbtm78s7crmw1BraJrrYRm5cVfDH0I3XT
         +P0kHsJmoPvqam6Bqdlk5OJWsmhSmF/5hnIQZoN6+odsUXaU5G4ZJJQQd6YQKDr7p7mD
         owfg==
X-Gm-Message-State: AOAM530ALoUs+oNNYZZ3PyL5iG8NkHROq4LLhQMyXud27e86cdBasde/
        SNcCxsrB0PKKdt3mFczxZo4=
X-Google-Smtp-Source: ABdhPJzOt/fejTiZOCiY5w1JYuR70gXh/h14mWMIrl8pCKWFI+ebG/iwX49rrPcwnNDQbeNRBYNg0g==
X-Received: by 2002:a05:6a00:a2a:b0:4f7:68db:5e60 with SMTP id p42-20020a056a000a2a00b004f768db5e60mr8752812pfh.58.1646979465091;
        Thu, 10 Mar 2022 22:17:45 -0800 (PST)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a0010d400b004f7093700c4sm9101764pfu.76.2022.03.10.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 22:17:44 -0800 (PST)
From:   jimliu2 <jim.t90615@gmail.com>
X-Google-Original-From: jimliu2 <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jim.t90615@gmail.com,
        CTCCHIEN@nuvoton.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v1 2/3] dt-bindings: support Nuvoton sgpio
Date:   Fri, 11 Mar 2022 14:09:35 +0800
Message-Id: <20220311060936.10663-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311060936.10663-1-JJLIU0@nuvoton.com>
References: <20220311060936.10663-1-JJLIU0@nuvoton.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nuvoton sgpio yaml in dt-bindings

Signed-off-by: jimliu2 <JJLIU0@nuvoton.com>
---
 .../bindings/gpio/nuvoton,sgpio.yaml          | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
new file mode 100644
index 000000000000..8766e1fa4528
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton SGPIO controller
+
+maintainers:
+  - Jim LIU <JJLIU0@nuvoton.com>
+
+description:
+  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC,
+  NPCM7xx/NPCM8xx have two sgpio module each module can support up
+  to 64 output pins,and up to 64 input pin.
+  GPIO pins can be programmed to support the following options
+  - Support interrupt option for each input port and various interrupt
+    sensitivity option (level-high, level-low, edge-high, edge-low)
+  - Directly connected to APB bus and its shift clock is from APB bus clock
+    divided by a programmable value.
+  - ngpios is number of nin_gpios GPIO lines and nout_gpios GPIO lines.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-sgpio
+      - nuvoton,npcm845-sgpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nin_gpios: true
+
+  nout_gpios: true
+
+  bus-frequency: true
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - interrupts
+  - nin_gpios
+  - nout_gpios
+  - clocks
+  - bus-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    sgpio1: sgpio@101000 {
+        compatible = "nuvoton,npcm750-sgpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0x101000 0x200>;
+        clocks = <&clk NPCM7XX_CLK_APB3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&iox1_pins>;
+        nin_gpios = <64>;
+        nout_gpios = <64>;
+        bus-frequency = <16000000>;
+    };
-- 
2.17.1

