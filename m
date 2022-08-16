Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F12F596459
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiHPVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiHPVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585EC7D7BA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so5485wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LvSKUVtr5Gp4BgmH/TzQ81b8EX2DhTfAUAFDUiW03kI=;
        b=bRWLm4TI/Y2cCF3vuQE23DoT1UwUjndleUK28KJkWmBRPnO0LnyaE6mhqZxkLqJqaV
         E8IpyM62YSpJlid86sYrQUMi72m7iM4g821qxkCnx3aNmk0b6AX8SvFlyXI4TI6opng9
         fEAIdhShwdMHA0818rzk7NpGSXqW2ru4e+I0Yq4F+w1DsWjH1XacMNVuGYdGuYKV3UlK
         1LK8sYwd8aDHAD1cGExKH23bxORx4AAm9e21Ad9QC3niM413zTIvbz7N1oEP4T+fpPhP
         rG5bEwkTTbiK2XRIolrzxtBc/AGW4kGpPqfjo1DR8+wqWbgOdnNDclPU3Y6/hJ73atI9
         ytpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LvSKUVtr5Gp4BgmH/TzQ81b8EX2DhTfAUAFDUiW03kI=;
        b=DMXSEbGktf6jxV8BU3injLwSoR3EButsXX/MGGd90IP/VCymRfk0B+yDZ2zfLv2JxU
         lsT17X+xnrzczj7/Fb0wZVSVIVF1Fcpe12CBOX02sl6d+H13Qoyw3y+bZww5sMwg/S1q
         76+K4Nk0Ty1gPFP77yeGhJmX2nKgxqMUKAlXLI4gF47IEOGMquVYTpGXX1giAi3cVb4I
         k7YvkmcijjgZkBg7aJi0Y5mKGmNK8RZ89c49pxcQCZDZ9+fMQRF3tf6qJ+Bv2A9wICI8
         BT+hlPMjCJxnLZdtQzB5fODJZN1Dc83EQFmqlj4JW7leoeR4dBhicE5iQxhlcyPlSVZC
         v+2g==
X-Gm-Message-State: ACgBeo0om8LaSXb6K7mKOuED4YkqM6NHtGZ6Dj9sYf2fH2PLPrSeghQn
        E5Jwml+lNplY2QlmvtOKnsVAXA==
X-Google-Smtp-Source: AA6agR7WU2umVyZku64Rq1qUALdsgHptgVygp32cUgOiAnp2l1mktYWFst85Ti0DAjmfA66iEX6z0w==
X-Received: by 2002:a05:600c:206:b0:3a5:41f1:aa23 with SMTP id 6-20020a05600c020600b003a541f1aa23mr215637wmi.31.1660684497606;
        Tue, 16 Aug 2022 14:14:57 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:14:57 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 01/10] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
Date:   Tue, 16 Aug 2022 22:14:45 +0100
Message-Id: <20220816211454.237751-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the bindings for Synopsys' DesignWare PWM block
as we will be adding DT/platform support to the Linux driver soon.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - fixed typos, added reg
v3:
 - add description and example
 - merge the snps,pwm-number into this patch
 - rename snps,pwm to snps,dw-apb-timers-pwm2
v2:
 - fix #pwm-cells to be 3
 - fix indentation and ordering issues
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
new file mode 100644
index 000000000000..e7feae6d4404
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/snps,dw-apb-timers-pwm2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DW-APB timers PWM controller
+
+maintainers:
+  - Ben Dooks <ben.dooks@sifive.com>
+
+description:
+  This describes the DesignWare APB timers module when used in the PWM
+  mode. The IP core can be generated with various options which can
+  control the functionality, the number of PWMs available and other
+  internal controls the designer requires.
+
+  The IP block has a version register so this can be used for detection
+  instead of having to encode the IP version number in the device tree
+  comaptible.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: snps,dw-apb-timers-pwm2
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: Interface bus clock
+      - description: PWM reference clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: timer
+
+  snps,pwm-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of PWM channels configured for this instance
+    enum: [1, 2, 3, 4, 5, 6, 7, 8]
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+
+examples:
+  - |
+    pwm: pwm@180000 {
+      #pwm-cells = <3>;
+      compatible = "snps,dw-apb-timers-pwm2";
+      reg = <0x180000 0x200>;
+      clocks = <&bus &timer>;
+      clock-names = "bus", "timer";
+    };
-- 
2.35.1

