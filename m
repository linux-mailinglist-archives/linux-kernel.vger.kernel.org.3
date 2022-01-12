Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15348CEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiALXEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:04:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:63028 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbiALXDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642028634; x=1673564634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSFN2KIKKCHd2SnULm1earIz8BEZQNiEaKaK+hQz25A=;
  b=gEmiTQErdAHaam+BaPJIUpUa+ZUs4Ek7KzRcVMOLcCpZNIDDd5G47+Ev
   vJZ/W7I35zXyt+btA1o6FEomZl2d65CkYOa5JlM1X63mq0O3wFDcrQyhE
   zcoy9HR4jhkTtoHuUzddmIN38bIQhPo69oJ4aJGqZxt+uFKSEtg71i9ZZ
   n7p6nQaIE8C9qHmjorv7GaWRQMel0nPQKgXnFepq9PB7gDuP5+UqKakXl
   Ger7flsK+Abnq23I2IdiKvrJMYrfbs/GbENKULV7dVZFN3P9yhj+Motd1
   kLH4azq/pPSXvbJTxCPT5590iLO9ecyRXW/6+NQxWCLpM/2L2yE5eLURX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="223855460"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="223855460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:03:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="576736069"
Received: from kstefans-mobl.ger.corp.intel.com (HELO localhost) ([10.249.154.174])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:03:44 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/13] dt-bindings: Add generic bindings for PECI
Date:   Thu, 13 Jan 2022 00:02:35 +0100
Message-Id: <20220112230247.982212-2-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112230247.982212-1-iwona.winiarska@intel.com>
References: <20220112230247.982212-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the PECI controller.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/peci/peci-controller.yaml        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml

diff --git a/Documentation/devicetree/bindings/peci/peci-controller.yaml b/Documentation/devicetree/bindings/peci/peci-controller.yaml
new file mode 100644
index 000000000000..bbc3d3f3a929
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-controller.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/peci/peci-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Device Tree Bindings for PECI
+
+maintainers:
+  - Iwona Winiarska <iwona.winiarska@intel.com>
+
+description:
+  PECI (Platform Environment Control Interface) is an interface that provides a
+  communication channel from Intel processors and chipset components to external
+  monitoring or control devices.
+
+properties:
+  $nodename:
+    pattern: "^peci-controller(@.*)?$"
+
+  cmd-timeout-ms:
+    description:
+      Command timeout in units of ms.
+
+additionalProperties: true
+
+examples:
+  - |
+    peci-controller@1e78b000 {
+      reg = <0x1e78b000 0x100>;
+      cmd-timeout-ms = <500>;
+    };
+...
-- 
2.31.1

