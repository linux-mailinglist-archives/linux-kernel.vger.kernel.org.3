Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6D4B9D01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiBQKZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:25:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiBQKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:25:44 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5C2AF904;
        Thu, 17 Feb 2022 02:24:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f37so9001458lfv.8;
        Thu, 17 Feb 2022 02:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IP7PcCy1//3+2eLuk3yMfPvTyyCntet0laQmLiMhwkY=;
        b=puBtr+eDzVX5eCmyW9kBNnDrGEiAPkPMgWdkrIoIy1ZlzhGT6FWsStw+nHU2z3Y770
         IfBqQH+lFQuRzGQNw+P6W+AOW8bac49XWSCziqO3J20Mqc2Datidjnvmy1uWcFRV6fx4
         MltDn2QDShy95zzuLRGw4SRiLlznzvUXvsTcTVUBoKbXkDQI8KYrHRCtfJn2I17SsJDV
         3CSGueqBnM9uKrEZHg++Psyd9OS8cuhBR5KjYf/tn5QxqMu3rLnXSewRk72P1XyczO4D
         fUcONK4wXVgJq5oSepJYFxZ7XR7bWT7hckF7jpv3gT7gSRl5U72DT6+DcohFalf/0/a0
         dI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IP7PcCy1//3+2eLuk3yMfPvTyyCntet0laQmLiMhwkY=;
        b=X98gRRfgIUyFccAIsucZsqQDwu71QwJulCCkJCwoRSuOBE1xDxe5+ebD+slE079eZo
         F1zzQ9gO6wRF4VtQmbseYjPB37RJl6ADVDtBQ1EWTVkxjSXabTljA/3J5AM1KAazutka
         HVRc4Ca07yzHtL2k8iexN8iFZW5Z/Twcva6dJeDFiEvU95s9NJttB/zlswKWdkVFFPH0
         fj/lYLl7IAmZR63Uaz4MRomMpgGa5mjaRWdJPvkmuXM/47CKZR8m4t2lROjsPRQqisam
         jbP8c94vOLKwQ996sTvutPCHuvupZudL9TLlDNWSF49PjOWxnEylu75LBpYyconKLJaP
         nFfQ==
X-Gm-Message-State: AOAM533Vj8cmKIRNFmoawkbAgxi+lQ2a+JZAAG03ynGB9Bt28vVgB+ii
        8FPtCdY826Ae0VDe7caqg4E=
X-Google-Smtp-Source: ABdhPJy9iN3pbnOBG9o3EF6L1/K5/6fnHQMeqcpOcXXTomGaoWM7oLrKjntmJZ0Orf/6bctKmhz+KQ==
X-Received: by 2002:ac2:5fe1:0:b0:443:3c53:b941 with SMTP id s1-20020ac25fe1000000b004433c53b941mr1536110lfg.146.1645093497226;
        Thu, 17 Feb 2022 02:24:57 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id w8sm1303858lfr.242.2022.02.17.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:24:56 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: mtd: partitions: add UBI binding
Date:   Thu, 17 Feb 2022 11:24:48 +0100
Message-Id: <20220217102448.27586-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

UBI is often used on embedded devices to store UBI volumes with device
configuration / calibration data. Such volumes may need to be documented
and referenced for proper boot & setup.

Some examples:
1. U-Boot environment variables
2. Device calibration data
3. Default setup (e.g. initial password)

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/mtd/partitions/ubi.yaml          | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
new file mode 100644
index 000000000000..cd081f06d4cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UBI (Unsorted Block Images) device
+
+description: |
+  UBI is a layer providing logical volumes (consisting of logical blocks) on top
+  of raw flash devices. It deals with low-level flash issues (bit-flips, bad
+  physical eraseblocks, wearing) providing a reliable data storage.
+
+  UBI device is built and stored in a single flash partition.
+
+  Some (usually embedded) devices use UBI volumes of specific names or indexes
+  to store setup / configuration data. This binding allows describing such
+  volumes so they can be identified and referenced by consumers.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: partition.yaml#
+
+properties:
+  compatible:
+    const: ubi
+
+patternProperties:
+  "^volume-[0-9a-f]+$":
+    type: object
+    description: UBI volume
+    properties:
+      volume-name:
+        $ref: /schemas/types.yaml#/definitions/string
+      volume-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+    anyOf:
+      - required:
+          - volume-name
+      - required:
+          - volume-id
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            compatible = "ubi";
+            reg = <0x0000000 0x1000000>;
+            label = "filesystem";
+
+            env: volume-0 {
+                volume-name = "u-boot-env";
+            };
+
+            calibration: volume-1 {
+                volume-id = <99>;
+            };
+        };
+    };
-- 
2.34.1

