Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A955197AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbiEDG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbiEDG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:56:36 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231120BE6;
        Tue,  3 May 2022 23:53:00 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 50BF9223;
        Tue,  3 May 2022 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651647180;
        bh=NGgm9ZytERpttgSYTz22XkDyLz7akFtC0NdMbrSk3Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBZa54PqXgXcLE6/k/HrFbeNJv4F6EzjUtzedbwiSK6Ap7+y1MjNaXUgqluZA8Ogc
         3HWlcIB9V3AOqIT0ylHmV7qVu6qk1oC9wW7yCtJBqt/egcUXeUapVuDVO2E64hpJ+0
         V/O0Pns/givWDrHjDLhDjz7XbCJkOq7YQ2VjHolg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: [PATCH 2/6] dt-bindings: regulator: Add reg-external-output binding
Date:   Tue,  3 May 2022 23:52:48 -0700
Message-Id: <20220504065252.6955-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504065252.6955-1-zev@bewilderbeest.net>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
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

This describes an external output supplied by a regulator, such as a
power outlet on a power distribution unit (PDU).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../regulator/reg-external-output.yaml        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/reg-external-output.yaml

diff --git a/Documentation/devicetree/bindings/regulator/reg-external-output.yaml b/Documentation/devicetree/bindings/regulator/reg-external-output.yaml
new file mode 100644
index 000000000000..c00bee5bd9f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/reg-external-output.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/regulator/reg-external-output.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator external output
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+description: |
+  This describes an external output supplied by a regulator, such as
+  a power outlet on a power distribution unit (PDU).
+
+properties:
+  compatible:
+    const: reg-external-output
+
+  vout-supply:
+    description:
+      Phandle of the regulator supplying the output, which should have
+      the regulator-external-output property.
+
+required:
+  - compatible
+  - vout-supply
+
+additionalProperties: false
+
+examples:
+  - |
+      output {
+          compatible = "reg-external-output";
+          vout-supply = <&output_reg>;
+      };
-- 
2.36.0

