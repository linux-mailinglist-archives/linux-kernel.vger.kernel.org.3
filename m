Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A027B4ADCE6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381083AbiBHPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381035AbiBHPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:37:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A489C06129A;
        Tue,  8 Feb 2022 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644334665; x=1675870665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Yo3RSdxZoSESUoiGGWNuInvhxAPd9fHeAO96RDn9zc=;
  b=XehmkZ0H81ar4Dt20qFZDxHmh1jY1gLU8f5E2l3HRLrKGuWJT0vPPPW6
   y7aLqIgS8m3h1ESp/HQ6I4xbFALIVtiKhoK+6LcOfKCVyKNdgJb8fqw29
   FRtOOUZDcamJG8bAmykuVlP0zY0FVKkkSB2YGWI5SKO71LvlSpa+gc9pO
   /eX8/KRTAn86tVmenzn6eS1N9ym/IPH736mic3Z7UFo2YkNTBxAJD/1td
   88bZj/Am18repYczTKWN8z6A4+VLu+2msl/wUCJqDX+RGA72ehPlXGU/X
   G/VxH7448bvN5cUU9aUcez4IqLRHPw1WcXqz+vEfuCfSPMd0EKeR95GFd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248918550"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248918550"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:37:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="628921880"
Received: from mgorzkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.139.232])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:37:38 -0800
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
Subject: [PATCH v8 01/13] dt-bindings: Add generic bindings for PECI
Date:   Tue,  8 Feb 2022 16:36:27 +0100
Message-Id: <20220208153639.255278-2-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208153639.255278-1-iwona.winiarska@intel.com>
References: <20220208153639.255278-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.34.1

