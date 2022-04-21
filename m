Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036850ABC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392499AbiDUXGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiDUXGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:06:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC2483A9;
        Thu, 21 Apr 2022 16:03:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d15so6944653pll.10;
        Thu, 21 Apr 2022 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6lETE4tLzS4hKJ1u/oePk2fhU7jHe/s3/pNmvXVjZcU=;
        b=UhzbFZk/OF9avjf1Dw5CvpdHDR7o/YhO54wS+drjkdZVgv+x1Zmf7Vp2/nMFu/vHNQ
         aB0zvD92+OaAXYCHpSddb8B2J0GGlDIoT1SeXVFjwLBa5DGckLhQAzd7xM7QCwcgHcFX
         rw6/5k4C9qqA7idqS4r7oLTvtN59UvRAi4xQzBbJW9ea6tOQJlcJVGx8TwnF6kiVd/WV
         Ymxgf8KMJWr0WebEPvlomFEHHgZ/yaQDjQBqlzo4fdyrV87W/t98TbfjECfH3D0DBEjb
         WR4B7bDrIJp3j7TAcvmMURrm2rbubhPYxv7ykIISQg+eupAuhBJqd5998L3Cut2YY+n9
         9nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6lETE4tLzS4hKJ1u/oePk2fhU7jHe/s3/pNmvXVjZcU=;
        b=S1+B8TS495LApofUfvuNWxLNZ6Hs82IwPr/eoOkKctuEuLeylgd7qyG8Saexwdk093
         4276Yq8yGe4d+eHpirJQDrnEJm8jhtvYPNb/gn7ty1uf2NTd1gUUV8wAtc9uED91RkAh
         Tx4cAWnDsF7F2bUjE+SMECkNdAGRBBjmjOHfxAs+jJxDEHH0wRYY48AagN+z4nIArpOF
         GwLUuyOBNa9U4YDjgyc4GYts4ItoMTqMSCsjcHF3rjtD8jzELquevhxvFZV5F6kuKqbA
         UfYqYFscpx7uSNrFl9XfvYoO6A+nwZmkdgvNQMHzDqqj74DtsyI8UdkO941sclqSniWY
         ahGg==
X-Gm-Message-State: AOAM532vDhOxPn09R9UTLCNB+0H9Zz1N+nnu/PnyBkMiHqdMgZ4EgVj7
        mffzTCt+qBnzZsVjQTHabgs=
X-Google-Smtp-Source: ABdhPJzW+XA9jMQWSiTiZveW2YDJbye/xVxh8r5uT5ngeig1q9drkro5hFvvGcxMHBf+ET2adpzZ8Q==
X-Received: by 2002:a17:902:f688:b0:15b:45ea:b682 with SMTP id l8-20020a170902f68800b0015b45eab682mr1472088plg.134.1650582230362;
        Thu, 21 Apr 2022 16:03:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-94-58.hsd1.ca.comcast.net. [73.241.94.58])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a448200b001cd4989fee7sm3810238pjg.51.2022.04.21.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:03:49 -0700 (PDT)
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
Subject: [PATCH V2 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Date:   Thu, 21 Apr 2022 16:02:52 -0700
Message-Id: <20220421230253.823798-1-ryan.lee.analog@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
  Changes from v1:
    Fixed yamllint/dtschema/dtc warnings and errors

 .../bindings/sound/adi,max98396.yaml          | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,max98396.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,max98396.yaml b/Documentation/devicetree/bindings/sound/adi,max98396.yaml
new file mode 100644
index 000000000000..ec4c10c2598a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,max98396.yaml
@@ -0,0 +1,79 @@
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
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,imon-slot-no:
+    description: slot number of the current sense monitor
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,spkfb-slot-no:
+    description: slot number of speaker DSP monitor
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  adi,interleave-mode:
+    description:
+      For cases where a single combined channel for the I/V sense data
+      is not sufficient, the device can also be configured to share
+      a single data output channel on alternating frames.
+      In this configuration, the current and voltage data will be frame
+      interleaved on a single output channel.
+    type: boolean
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
+            reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.25.1

