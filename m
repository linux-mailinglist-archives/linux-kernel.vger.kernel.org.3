Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5544E5905F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiHKRgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiHKRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:36:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465F7436B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d187so8428562iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J3hK7bUI023BnYR4sokXeCwLdQ8v4VG+y38uaGcbPRI=;
        b=hSowz9/2jsMCZlK2hxcyHg+ly/WMitvlPhPgvi48wXW+wp9apszWtaE7CmE3FdkeX7
         /Ct/1I+GK6VNgjVcqHN2FERRy7+GEdYwVoAWtEO8QSeWZY1mHwx7QxPSWPfHkeIqWZ8v
         rENttebV32dxfjhvadFhwdFKZCVAhhznGKjPtMOuU4DGgAtoBPHAWS701JRXJbJkXJlU
         sBgp13wx5262WeJlUVHgit78gNU+LC59uJq3CaAFg6+RiHVyMtxCwQT47jwqaiXSazBH
         tODUBokISJquzVxb1qgsBCg4IOMQqqQpoidXKA3quemzP6y/4kY++yaWITXOzrKvs6mn
         M7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J3hK7bUI023BnYR4sokXeCwLdQ8v4VG+y38uaGcbPRI=;
        b=HiUl7s3OBh5SvRTpaHVMdJN0TP5/FHKNiQ6hY++PVue+sjd00U9Oa4XOJcYEZRatyA
         BJRreeT0fPVB1etZ1T9pi0u0HYimxIEl2qt/t5fDP0FX3lRIDDF4yTP6R8S1xW38RymY
         IQXY17MoLRgkyKb8NGpTy0rsD2oDvSEQlC0x2lM/HtK6Gj9bFacAtSt890GIzHbfyvav
         TuG2l/LMOQubtdtenX6uGKiY99kQZVxDuBWMI02ggJtavcnq545RJ98yvOIsr8sogg6/
         nW/QNqlWPHkHmH0rU7SVKlgfy6zmf+upfmVjUXGVGyor23ftfvYRNIuQR+eoXqvijDFA
         5TJQ==
X-Gm-Message-State: ACgBeo37iViV4iV+OhtkKPfYY0cNo9pPZbK4+8HpcySFdzM31/odWvqJ
        37J1umIzdxyrxVyqAn5Ea4BdRxeAKHU=
X-Google-Smtp-Source: AA6agR7k8Vjqm6J1QbziFiPV2MC1HNzjJwAlXNTWMI2nBZoxym4QRvKDZMfJt2YUfOUx+64k6GR2ew==
X-Received: by 2002:a05:6602:2dc9:b0:67c:410:29f5 with SMTP id l9-20020a0566022dc900b0067c041029f5mr151929iow.39.1660239361646;
        Thu, 11 Aug 2022 10:36:01 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:36:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 08/11] dyndbg: add test_dynamic_debug module
Date:   Thu, 11 Aug 2022 11:35:38 -0600
Message-Id: <20220811173541.2901122-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple module to allow testing DYNAMIC_DEBUG behavior.  It
calls do_prints() from module-init, and with a sysfs-node.

  dmesg -C
  dmesg -w &
  modprobe test_dynamic_debug dyndbg=+p
  echo 1 > /sys/module/dynamic_debug/parameters/verbose

  cat /sys/module/test_dynamic_debug/parameters/do_prints
  echo module test_dynamic_debug +mftl > /proc/dynamic_debug/control
  echo junk > /sys/module/test_dynamic_debug/parameters/do_prints

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 MAINTAINERS              |  2 ++
 lib/Kconfig.debug        | 10 ++++++
 lib/Makefile             |  1 +
 lib/test_dynamic_debug.c | 70 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 lib/test_dynamic_debug.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..a14fc4b6a10b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7093,6 +7093,8 @@ M:	Jason Baron <jbaron@akamai.com>
 S:	Maintained
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
+M:	Jim Cromie <jim.cromie@gmail.com>
+F:	lib/test_dynamic_debug.c
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..ca5978e1d18a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2529,6 +2529,16 @@ config TEST_STATIC_KEYS
 
 	  If unsure, say N.
 
+config TEST_DYNAMIC_DEBUG
+	tristate "Test DYNAMIC_DEBUG"
+	depends on DYNAMIC_DEBUG
+	help
+	  This module registers a tracer callback to count enabled
+	  pr_debugs in a 'do_debugging' function, then alters their
+	  enablements, calls the function, and compares counts.
+
+	  If unsure, say N.
+
 config TEST_KMOD
 	tristate "kmod stress tester"
 	depends on m
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc..9c316df868de 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
+obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
new file mode 100644
index 000000000000..ba3882ca3e48
--- /dev/null
+++ b/lib/test_dynamic_debug.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kernel module for testing dynamic_debug
+ *
+ * Authors:
+ *      Jim Cromie	<jim.cromie@gmail.com>
+ */
+
+#define pr_fmt(fmt) "test_dd: " fmt
+
+#include <linux/module.h>
+
+static void do_prints(void); /* device under test */
+
+/* run tests by reading or writing sysfs node */
+
+static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
+{
+	do_prints();
+	return 0;
+}
+
+static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
+{
+	do_prints();
+	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+}
+
+static const struct kernel_param_ops param_ops_do_prints = {
+	.set = param_set_do_prints,
+	.get = param_get_do_prints,
+};
+
+module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
+
+static void do_alpha(void)
+{
+	pr_debug("do alpha\n");
+}
+static void do_beta(void)
+{
+	pr_debug("do beta\n");
+}
+
+static void do_prints(void)
+{
+	do_alpha();
+	do_beta();
+}
+
+static int __init test_dynamic_debug_init(void)
+{
+	pr_debug("init start\n");
+
+	do_prints();
+
+	pr_debug("init done\n");
+	return 0;
+}
+
+static void __exit test_dynamic_debug_exit(void)
+{
+	pr_debug("exiting\n");
+}
+
+module_init(test_dynamic_debug_init);
+module_exit(test_dynamic_debug_exit);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.37.1

