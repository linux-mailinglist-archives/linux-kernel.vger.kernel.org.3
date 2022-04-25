Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA850E76A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiDYRki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiDYRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:40:34 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741398C7E3;
        Mon, 25 Apr 2022 10:37:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 15so5622891pgf.4;
        Mon, 25 Apr 2022 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjD/mfBFlz/AtrrL9x0Nf4kx8DWM5v1izBjt6/Kpab0=;
        b=Hm4FE29UfoLbczENW+XUuxCsdMMB21yOePMZ4K7szKAY6zQSi9WbZ0m3noMmt3WdFf
         qsTwr/PTWjYXoLhBldxZMfcLvy0xHaSk1DzPVavJ3Tv6LSbXOuuf1CgvMwZvjCSQ2ELT
         MH1NMEW7Sd5Tp2B6vYcwVh14Mw5URoKlmENkbVYGpZjKa/Z1L3r+aj7/Z/lT6JfOd6hY
         qdcC2pcp0KjvDNv/Hk9uUZXp09QkIJ0zvYRbQA63h5G2S8hoNgLuKcl6Cro30i752XtR
         MA+eD4GRCz9X3sca2/MazGJVJXB9qFgSaVvnLp1dUkIbNk0Yqobk27DNZAMIs9wyVHzW
         kMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjD/mfBFlz/AtrrL9x0Nf4kx8DWM5v1izBjt6/Kpab0=;
        b=CfRQi9W6dtvRzaMuiOcqNXfJMdxxkvdkO+/+aS/WJCQE5ZLRWhHfOSegIU+fJBwjk3
         wh94dvE8KxVgLw5lzPWp2edZhp9JfeEIox88WIpQrYXccvhv7YXIBAhZDMVll1wQPmmK
         2O71mP3zV6HKZHI37iKFznhfsS2uSibEkKX4PpiHJEANkp6ihgVBDPFxUnMjBlBLZW5o
         keOxrDiMbsDr4wp/wFkn8n7L/8aNSPyFexbDmndoDdbFyUSpLKDuGhvj0AecQkxHjUmQ
         u2Zvl9aku92WcpA3hxyChMefT02yzZgyEJ/Vxe4rOZBYP1axTAxLYhSCuuZcV4iDTA95
         v0ng==
X-Gm-Message-State: AOAM532OCqkQH1sEy9mlrbavcT3gFHKKMltJoniLPKcBbzThuaVJ3GKa
        +G3/ScpvrQXF+FexZNLzA7M=
X-Google-Smtp-Source: ABdhPJzd1XOAwmlG/JRg8XpnkspvBtxjBREClAWoak8wuJRQq2EaPozR9A9EhbRPAaDnsVWD5jTavA==
X-Received: by 2002:a63:8ac9:0:b0:3ab:dab:16b4 with SMTP id y192-20020a638ac9000000b003ab0dab16b4mr9077462pgd.129.1650908248880;
        Mon, 25 Apr 2022 10:37:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-241-94-58.hsd1.ca.comcast.net. [73.241.94.58])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090ab28100b001cd4989fecfsm16218491pjr.27.2022.04.25.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:37:27 -0700 (PDT)
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
Subject: [PATCH V3 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Date:   Mon, 25 Apr 2022 10:37:15 -0700
Message-Id: <20220425173715.1827706-1-ryan.lee.analog@gmail.com>
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
  Changes from v2:
    No change

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

