Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918635390CC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiEaMe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244604AbiEaMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:34:23 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D818DFD3;
        Tue, 31 May 2022 05:34:21 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-f3381207a5so6862039fac.4;
        Tue, 31 May 2022 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjL5ChPbIi7K/V0MdTfM2rPQhvrdOuYsXgOFgMyivaI=;
        b=Dt4cmAwTJzLQp+0BhvSpwI46ky2dI72Ho0ICX5p7qoY/Cq20zgcg3MruR/EMF2Bq/b
         bttgX4DseumTdpOkyOeLDbhu/g0tdhRqMTJq3xHeH7Y+46XvfvsF6ZP0IAktzO7U/eKj
         0versn33tjTT0IlRhUYB+CU5TjsWXAfTIXhupO9UAG0+WcQTF2olwkKQexwJa36jFxyt
         JYXcZGUcWG0zYb6nYsM9gn3xgDRKrfJ+kh54KRUoE8hpcI5Mj4N0PWANGjFFYncNE+7l
         5k9RicWNlg6t8/gUtoxx5UXQY1J+ugPqpYcnRDiZjTqXfOM7cSycfbANCKRtA0ZdAi/2
         Pi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjL5ChPbIi7K/V0MdTfM2rPQhvrdOuYsXgOFgMyivaI=;
        b=Z/JSQBPCpEoMP+iYcyo+7G+aKY35HXC1oWJBL1DPAQ5jbOGa9LYUVzkUslNMu4Q6iY
         52PHtKhKMV+5gOSk0e3sishXwj4SWBhq9lozbcCktZcUQC/b05vViXEp+g7hxdUkhOGp
         7ZA9RM3Sb5cECBiymtogU7jdSAYzXcsVgc4McukK1EwvnM5cbVpx1QOu5/ir8TQtB70U
         AZIuAWeJbnX7DlvdpRZAmiyrd+5Ml9NbvikEosAgSaLwvENkWo8gl2hFOL8jRUgt005m
         2fgtXKyYNU2MMx9D/OFgfbfqbngpts+yBqDBHb6IzenZTDew4tOhlRwGiKegIza8Z4b1
         Yc5w==
X-Gm-Message-State: AOAM5320XJtxd9Gu3ZKb0EFb0bmN5TO8C9/5Jzj8MrE3FS9rtl5xjRpH
        fi9q7HmohuW1Sbhs/yg4vyz4WtildpI=
X-Google-Smtp-Source: ABdhPJxcNj1TTo46zD0wjy4+ZyPww3ji1KDlsT3qEGdzSt4nXnXjTaqvtqMA3y7vBlN14PrpZHzriQ==
X-Received: by 2002:a17:90b:33c8:b0:1df:aaf7:5822 with SMTP id lk8-20020a17090b33c800b001dfaaf75822mr27811307pjb.9.1653993738855;
        Tue, 31 May 2022 03:42:18 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090ac25300b001cd4989feebsm1525829pjx.55.2022.05.31.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:42:18 -0700 (PDT)
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
Subject: [PATCH 09/14] dt-bindings: usb: Add Mediatek MT6370 TCPC binding documentation
Date:   Tue, 31 May 2022 18:42:06 +0800
Message-Id: <20220531104211.17106-1-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: ChiYuan Huang <cy_huang@richtek.com>

Add Mediatek MT6370 TCPC binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 000000000000..49316633f92f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek MT6370 Type-C Port Switch and Power Delivery controller DT bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Mediatek MT6370 is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
+  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6370 Type-C Port Switch and Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-tcpc
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
-- 
2.25.1

