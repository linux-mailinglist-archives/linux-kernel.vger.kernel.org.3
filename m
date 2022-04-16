Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19D5033DE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiDPCFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiDPCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:04:38 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E871342FE;
        Fri, 15 Apr 2022 18:54:02 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so9417551fac.4;
        Fri, 15 Apr 2022 18:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Les2UL23YeIevDhG3Z2Qgn1FSs69ezvIqCdvr/g4ho=;
        b=X3pmP/83JNw068wUc0Dwc/eB1hfDmcO0c7h4P4CWTRPTAL9Lwi/6sNoDY75uG413G4
         u2Ac+RYGI4qc8tjzxtrBNe+ZmwHZ3JvQSl68DtyM0QcLoMW8cF4XbiFCBc/b2jtXxAvg
         czslVbtiqNZg3f+gAuSFakzhJRLu0q+WjfDr+or82OnN2qakZxO9vmcgaaiaxH6p7a1i
         EetP7YF73mPGYAEFAOB26josOoVQuyXIuM9H93FI0sZigrGMYUwfaNeRxspjwbR4Xo1s
         njR/j1fNgzalQdZZkJN+QoozaLKI4rR8G47kaRFhQv+kuQuvdbzN7mN9tqnuOwrkMlP6
         QuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Les2UL23YeIevDhG3Z2Qgn1FSs69ezvIqCdvr/g4ho=;
        b=fFUU9dlTfPhgFYhiZCK3ZF7ATbDAf+tEwiICQRHdeADouXf5iz28sTCliD5nPMK94m
         e83Qh01IITk5plnHTQuMpPxSCfYrY4ovn7IG0yDhC445RuR/iegtRLVMGD4N3QiwQ6JX
         JUyHYriejEfmdhbP6jji2K8kSJCT7iidS5BEg4SjfATKiuTcxZSI+hmdw1muJgdA7rhY
         CeZOTCMeqEy5UFFWtuAjdbOL6kKJaxa1jDS5Ly3iI0xa/Oz6jP51tX/32AgXX1bsJeJj
         OtfldqkwivQrd+CEuQs/MidO/ni+xdtVL/aBIdDBZHKrM78nssm4sfrnCTRdcMlLEUYC
         NxdQ==
X-Gm-Message-State: AOAM532vJ0hDTC7XEmRkID+mZAuEy53sxcA5egW6BILGvYGhB1vP4/a4
        ryMXsU7P6SOkr+4xqH14bDaAuP2M/X+c/A==
X-Google-Smtp-Source: ABdhPJykxiXYmn1N3ukz/dW55wNY1Lgeg6tCAhkCY9X2N73Pqr000lp0esog3uKXrWyO9G0bDcFVRw==
X-Received: by 2002:a17:90b:164f:b0:1c7:8d27:91fc with SMTP id il15-20020a17090b164f00b001c78d2791fcmr6869325pjb.228.1650069643984;
        Fri, 15 Apr 2022 17:40:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-94-58.hsd1.ca.comcast.net. [73.241.94.58])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm4222482pfm.17.2022.04.15.17.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:40:43 -0700 (PDT)
From:   Ryan Lee <ryan.lee.analog@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, ckeepax@opensource.cirrus.com,
        tanureal@opensource.cirrus.com, cy_huang@richtek.com,
        pierre-louis.bossart@linux.intel.com,
        drhodes@opensource.cirrus.com, pbrobinson@gmail.com,
        hdegoede@redhat.com, lukas.bulwahn@gmail.com, stephan@gerhold.net,
        arnd@arndb.de, ryan.lee.analog@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryans.lee@analog.com
Subject: [PATCH 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Date:   Fri, 15 Apr 2022 17:40:23 -0700
Message-Id: <20220416004024.210418-1-ryan.lee.analog@gmail.com>
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

From: Ryan Lee <ryans.lee@analog.com>

This patch adds dt-bindings information for Analog Devices MAX98396
and MAX98397 Smart Amplifier.

Signed-off-by: Ryan Lee <ryans.lee@analog.com>
---
 .../bindings/sound/adi,max98396.yaml          | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98396.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98396.yaml b/Documentation/devicetree/bindings/sound/adi,max98396.yaml
new file mode 100644
index 000000000000..4aee32f43ad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98396.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/adi,max98396.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX98396 Speaker Amplifier Device Tree Bindings
+
+maintainers:
+  - Ryan Lee <ryans.lee@analog.com>
+
+description:
+  The MAX98396 is a mono Class-DG speaker amplifier with I/V sense.
+  The device provides a PCM interface for audio data and a standard
+  I2C interface for control data communication.
+  The MAX98397 is a variant of MAX98396 with wide input supply range.
+
+properties:
+  compatible:
+    enum:
+      - adi,max98396
+      - adi,max98397
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  adi,vmon-slot-no:
+    description: slot number of the voltage sense monitor
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,imon-slot-no:
+    description: slot number of the current sense monitor
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,spkfb-slot-no:
+    description: slot number of speaker DSP monitor
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,interleave-mode:
+    type: boolean
+    description: For cases where a single combined channel for the I/V sense data is not sufficient,
+                the device can also be configured to share a single data output channel on alternating frames.
+                In this configuration, the current and voltage data will be frame interleaved on a single output channel.
+    default: false
+
+  reset-gpios:
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
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        max98396: amplifier@39 {
+            compatible = "adi,max98396";
+            reg = <0x39>;
+            adi,vmon-slot-no = <0>;
+            adi,imon-slot-no = <1>;
+            adi,interleave-mode = <0>;
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+        };
+        max98397: amplifier@3c {
+            compatible = "adi,max98397";
+            reg = <0x3c>;
+            adi,vmon-slot-no = <0>;
+            adi,imon-slot-no = <1>;
+            adi,interleave-mode = <0>;
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+        };
+    };
+
-- 
2.25.1

