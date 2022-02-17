Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C94B9D82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiBQKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:46:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiBQKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:46:25 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A971294112;
        Thu, 17 Feb 2022 02:46:11 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 888F2C55;
        Thu, 17 Feb 2022 02:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645094770;
        bh=uUlF8FcwaYf9aGYW+5rRDb+F4fC71b6gQUNd/l6QrtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr18n/QleCAZEULPoAqyKVz/yD9EN5HfdEQ1N3l777roRbcdi6qlN8d9skbhQvcAd
         /zbvzR0CJgzqAX8xDj7YynY2uZeYgne2OPQ5srXGItCmyJlMKftXlzLY0cpbxAEwLe
         zR/SQCw4hHw18kfO/AxnVWL4/TUh5NffUZkb1kR0=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 3/4] dt-bindings: Add power-efuse binding
Date:   Thu, 17 Feb 2022 02:44:43 -0800
Message-Id: <20220217104444.7695-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217104444.7695-1-zev@bewilderbeest.net>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
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
 .../devicetree/bindings/misc/power-efuse.yaml | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml

diff --git a/Documentation/devicetree/bindings/misc/power-efuse.yaml b/Documentation/devicetree/bindings/misc/power-efuse.yaml
new file mode 100644
index 000000000000..cadce15d2ce7
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/power-efuse.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/power-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic power efuse device
+
+maintainers:
+ - Zev Weiss <zev@bewilderbeest.net>
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

