Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE054925F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355535AbiFMM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357106AbiFMMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C764BCF;
        Mon, 13 Jun 2022 04:13:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso8505626pjl.3;
        Mon, 13 Jun 2022 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2LOWa0LYPNbUOdZwXstN4Fj+e3Z/fV8r2vTbFyL+u4=;
        b=QWJkRnN2FsU0KWBpmQ0dClhx2X/Q4DMK9O2gzJeroxqmrEQxh9/Ce9w7uvOzjztTN9
         Cps7cjw2oA4cGlShBG+N3BaSCMmpzIcFqLITmOuYndkT5OOSpCYLbuZm6AYod79wiHOz
         xVxQdPM8KLhnmlyQPfmbbArC9EVKNCBtEWDpROJSIXStwGne0OEcce/wdz+9jeElhpw0
         KJj0XehQz+yipHnUvS6ka77cD9f4kLFkQWFhFNSZ5goan0N+XNhgPZ4LmSmiN7yOvxTm
         fSGhTRr5HnsKQa/cJWfTTvvC3Ou015Bb0VpJqhpcbUKXT6NXvuCMtFolGUcHOy2Si1gm
         lzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2LOWa0LYPNbUOdZwXstN4Fj+e3Z/fV8r2vTbFyL+u4=;
        b=uGpLHqUs05b6271I7LyibXR3jefsr93IGHuVlP11e/gSp5FBJ5OF9FpCYhjpYVunnZ
         qPRlKcPxRtf+Q0BrKMb8WqTHmjeBaXyCBgjc8JPRIsj1HAt5P1i8L553yVStOytbhhQn
         ToOXxFnANUhc6EM5lBLo+6O0dp7ne5eYI/kIwjfIxpq/QKuIOavRvtYP8/v29YjDVKVq
         fMVLNAHqwn/AvhwEkllVSvHWQLUbMNbJbXH065pKXxD0FCr0e0pmpwAfJskmYCgzxe8e
         H6+wY1qq4kGgS15LX8HBfOpEk6tU83CExRjacJxnkGUM7ho+2UINkiGdn+rUveLrk1N+
         DbDA==
X-Gm-Message-State: AOAM531A4CqGvQ+n5krCCmuKQB3ybijxx/eWarqx/kVWnzQ/As+NN2ng
        JC5r0pyjT5SZxSwirh1Q1Xo=
X-Google-Smtp-Source: ABdhPJziskZ5VakXCRbxfIE9XDHG2+SOluNMJVEggkCCLainBKLWkbDKcCDtwc49dmgiEPsQomfjZQ==
X-Received: by 2002:a17:902:bc84:b0:167:80c6:aedd with SMTP id bb4-20020a170902bc8400b0016780c6aeddmr38752631plb.97.1655118782858;
        Mon, 13 Jun 2022 04:13:02 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:13:02 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>
Subject: [PATCH v2 04/15] dt-bindings: leds: Add Mediatek MT6370 flashlight
Date:   Mon, 13 Jun 2022 19:11:35 +0800
Message-Id: <20220613111146.25221-5-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613111146.25221-1-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
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

Add Mediatek MT6370 flashlight binding documentation.

Signed-off-by: Alice Chen <alice_chen@richtek.com>
---
 .../leds/mediatek,mt6370-flashlight.yaml      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 000000000000..13610bc23d0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
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
+
+    properties:
+      reg:
+        enum:
+          - 0 # Address of LED1
+          - 1 # Address of LED2
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

