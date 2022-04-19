Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC35073F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbiDSQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354743AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7F15A3C;
        Tue, 19 Apr 2022 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386348; x=1681922348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4WGCF2s5f5KuKam370PTpkZM1RS4K0r/UhQwRsUGzE=;
  b=E1tcpFe6vw2bIexL/9lB51PyBWvWcYilfcf9T6MDHEh3ElmHon1spcFC
   0S6sNINV0qRzee/2pQm7pv5oMc7W6pD3IPnKgKXgOwfV7KWMGAepqn9Ay
   C2fzU9htqfKc3k4FREqnl+7F1LvqJQ1W2qAydycwsB1cDgRYYyAz78Hk0
   iluawMprjKoJqSv5xASQxL8EA+AI/OG/oV8JHcZPjCTuxsKkch38AIZ3H
   W2lzLJpVuK9FowkGQhDD8EoQGpD6svXpIw6WZJ2xocA37QoPpq3SXhdz/
   CVgQfm8X6wKgrfjKWys5tfa6sZ+ZMvg/ihEE4GHkat8Z4v4aMJeoNd/Lu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702528"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802139"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:07 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v3 04/11] platform/x86/intel/ifs: Add stub driver for In-Field Scan
Date:   Tue, 19 Apr 2022 09:38:52 -0700
Message-Id: <20220419163859.2228874-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cloud Service Providers that operate fleets of servers have reported
[1] occasions where they can detect that a CPU has gone bad due to
effects like electromigration, or isolated manufacturing defects.
However, that detection method is A/B testing seemingly random
application failures looking for a pattern. In-Field Scan (IFS) is
a driver for a platform capability to load a crafted 'scan image'
to run targeted low level diagnostics outside of the CPU's architectural
error detection capabilities.

[1]: https://www.youtube.com/watch?v=QMF3rqhjYuM

Kconfig for this driver selects CONFIG_INTEL_IFS_DEVICE so the base
kernel will be built with code to create the device to which this driver
will attach.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Not using module_platform_driver() for this simple stub because
later patches need to add init()/exit() functions.
---
 drivers/platform/x86/intel/ifs/Kconfig  | 14 ++++++++++++
 drivers/platform/x86/intel/ifs/Makefile |  4 ++++
 drivers/platform/x86/intel/ifs/core.c   | 29 +++++++++++++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 drivers/platform/x86/intel/ifs/core.c

diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
index 51325b699563..0aa5ecc5ef42 100644
--- a/drivers/platform/x86/intel/ifs/Kconfig
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -1,2 +1,16 @@
 config INTEL_IFS_DEVICE
 	bool
+
+config INTEL_IFS
+	tristate "Intel In Field Scan"
+	depends on X86 && 64BIT && SMP
+	select INTEL_IFS_DEVICE
+	help
+	  Enable support for the In Field Scan capability in select
+	  CPUs. The capability allows for running low level tests via
+	  a scan image distributed by Intel via Github to validate CPU
+	  operation beyond baseline RAS capabilities. To compile this
+	  driver as a module, choose M here. The module will be called
+	  intel_ifs.
+
+	  If unsure, say N.
diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index 12c2f5ce9925..bf8adc57892c 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1 +1,5 @@
 obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
+
+obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
+
+intel_ifs-objs			:= core.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
new file mode 100644
index 000000000000..eb34b877dac0
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static struct platform_driver intel_ifs_driver = {
+	.driver = {
+		.name = "intel_ifs",
+	},
+};
+
+static int __init ifs_init(void)
+{
+	return platform_driver_register(&intel_ifs_driver);
+}
+
+static void __exit ifs_exit(void)
+{
+	platform_driver_unregister(&intel_ifs_driver);
+}
+
+module_init(ifs_init);
+module_exit(ifs_exit);
+
+MODULE_ALIAS("platform:intel_ifs*");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel In Field Scan (IFS) driver");
-- 
2.35.1

