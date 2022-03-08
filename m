Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660EB4D0D67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbiCHBTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiCHBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:19:29 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B936E33;
        Mon,  7 Mar 2022 17:18:31 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D33867C8;
        Mon,  7 Mar 2022 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646702311;
        bh=gr2x0McqUm6AttCXHBXmPoHrzYua62hvh5ryRZTRS7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAER39zXNAdf6FGdGARa83+dH6IQkjhJlJA5pDlCxAqtAkj3qyC9htgGBj9YRAmXd
         q0G9hjEiCrEnPGCNW+LeA+RMLUZ3olqIArXDr/pYly7TNTpAbQNqw4oI9ysSmZPgvb
         jU2bPjXkIenCCshN6p1FHfYKEh2g5LIL0biM3SFM=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: Add power-efuse binding
Date:   Mon,  7 Mar 2022 17:18:09 -0800
Message-Id: <20220308011811.10353-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308011811.10353-1-zev@bewilderbeest.net>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used to describe a power output supplied by a regulator
device that the system controls.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../devicetree/bindings/misc/power-efuse.yaml | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml

diff --git a/Documentation/devicetree/bindings/misc/power-efuse.yaml b/Documentation/devicetree/bindings/misc/power-efuse.yaml
new file mode 100644
index 000000000000..5f8f0b21af0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/power-efuse.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/power-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic power efuse device
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+description: |
+  This binding describes a physical power output supplied by a
+  regulator providing efuse functionality (manual on/off control, and
+  auto-shutoff if current, voltage, or thermal limits are exceeded).
+
+  These may be found on systems such as "smart" network PDUs, and
+  typically supply power to devices entirely separate from the system
+  described by the device-tree by way of an external connector such as
+  an Open19 power cable:
+
+  https://www.open19.org/marketplace/coolpower-cable-assembly-8ru/
+
+properties:
+  compatible:
+    const: power-efuse
+
+  vout-supply:
+    description:
+      phandle to the regulator providing power for the efuse
+
+  error-flags-cache-ttl-ms:
+    description:
+      The number of milliseconds the vout-supply regulator's error
+      flags should be cached before re-fetching them.
+
+required:
+  - compatible
+  - vout-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    efuse {
+        compatible = "power-efuse";
+        vout-supply = <&efuse_reg>;
+        error-flags-cache-ttl-ms = <500>;
+    };
-- 
2.35.1

