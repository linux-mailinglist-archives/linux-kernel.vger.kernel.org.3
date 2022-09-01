Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104D45AA2ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiIAWWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiIAWWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:22:01 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6FA3473;
        Thu,  1 Sep 2022 15:19:35 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id F2BBE220D;
        Fri,  2 Sep 2022 00:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662070754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFD+0mrv3jpvtYWREXPyq1wWMmEP8gipYWNhSEthauI=;
        b=oNNfzaxeanq1HoAf+vPwChOwaGCEVCu3KYV1OE/511BdJsIt/utKnfzGoKyx44xEkUW8bg
        pRYRGg5vyAb7NLJnjHIE49UFaBBpczMHCCWihArQ6L2FMSxpaXGSOfHm1gvaahW1moew13
        AurmHTvzWtkQMV3hmjRp2Zcz4oy9eWLASnuPCJVSFirZh1OAIPqVHF8ZuJGnrelUjFCudz
        EU8Aa/nqFSxUvRMnWSAtHoRMPfP0sl6IQzds/Ony9ZkCEhkjdttsBpYQVuMdLxjBJ47Dj5
        li6F/WYGVYmqzXB4Qw7s3GtfEozvYCW7HAEAmDCPmUA0BGk1cILpeSBZ7gtY1A==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
Date:   Fri,  2 Sep 2022 00:18:52 +0200
Message-Id: <20220901221857.2600340-16-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901221857.2600340-1-michael@walle.cc>
References: <20220901221857.2600340-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a schema for the NVMEM layout on Kontron's sl28 boards.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - add custom select
 - add description
 - add "additionalProperties: false", I wasn't sure if all the
   subnodes needs it. I'd say yes, but the brcm,nvram binding
   doesn't have them neither.

 .../nvmem/layouts/kontron,sl28-vpd.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
new file mode 100644
index 000000000000..0c180f29e880
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description:
+  The vital product data (VPD) of the sl28 boards contains a serial
+  number and a base MAC address. The actual MAC addresses for the
+  on-board ethernet devices are derived from this base MAC address by
+  adding an offset.
+
+# We need a select here so we don't match all nodes with 'user-otp'
+select:
+  properties:
+    compatible:
+      contains:
+        const: kontron,sl28-vpd
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: kontron,sl28-vpd
+      - const: user-otp
+
+  serial-number:
+    type: object
+    description: The board's serial number
+
+  base-mac-address:
+    type: object
+    description:
+      Base MAC address for all on-module network interfaces. The first
+      argument of the phandle will be treated as an offset.
+
+    properties:
+      "#nvmem-cell-cells":
+        const: 1
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+      otp-1 {
+          compatible = "kontron,sl28-vpd", "user-otp";
+
+          serial_number: serial-number {
+          };
+
+          base_mac_address: base-mac-address {
+              #nvmem-cell-cells = <1>;
+          };
+      };
+
+...
-- 
2.30.2

