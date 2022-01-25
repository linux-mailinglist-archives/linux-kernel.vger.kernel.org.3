Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512ED49A890
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319465AbiAYDIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:35768 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3410822AbiAYCSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643077123; x=1674613123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fyE0Y1a6izA1HZIRgBBRJ9hch9fXCPSO/hVIlEG2PbU=;
  b=QdmkuhrXgI+pp9plla7UK+No9aheYQ9D1Kf9xdxVBH5GwYM1IkXLHJ30
   LD9FblTmUt2iqoWvNPbnJupsDlbZL0XxcM2EgM49xCRX0flQ38e8tM7bo
   ejCmTCqxH1K1uAWQYJqtau7v9TlG1Gdi48ryJdq0m68HwVuosL4N5CEUS
   Ra4f1eT0C/eR7Unr8oU8zNcVJGHQda9tIhRJFcGbMMXFOYdG085pulxTe
   ec0lseNODccKyUrhrxljBVNaKyuEW9gL19OZOrF1tQneNP9YOQKm+a1dY
   XjdINkRZ5LYLrMmQnj4GO1drYPocMnuvbF+3vbVJlyW0uHu7svOqzxyrC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245023793"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245023793"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:12:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="617443462"
Received: from kerguder-mobl.ger.corp.intel.com (HELO localhost) ([10.249.158.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:12:03 -0800
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
Subject: [PATCH v6 01/13] dt-bindings: Add generic bindings for PECI
Date:   Tue, 25 Jan 2022 02:10:52 +0100
Message-Id: <20220125011104.2480133-2-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125011104.2480133-1-iwona.winiarska@intel.com>
References: <20220125011104.2480133-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the PECI controller.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
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

