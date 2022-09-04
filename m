Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE15AC6BF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiIDVmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiIDVmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:21 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673892C65C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:18 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a9so3885262ilh.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a7DZCtJXdhSHu/g5l+Gfz3Grwf1u1lU78G+9NH5FV+4=;
        b=Jkkv7Uh7bMpbU+r6NlVBVYvbcfasFu4S18WrtPiOTovRP/fBU0eokGYClnWQb7wddC
         DJ2DbVzsV7l0UCuqjr+/R6KQlSzLD5J92WNj7XSoVVY8gqVI9s5+LywRHe/BNZ0ZDJCc
         DBl/2kKsA3D/oCquCqonuGQe5CgfatnSAtbCiKvVrFPbB6oGvCcBuFm2/uYygIQIwATx
         /9hnZoDjFPUZ988quw0t0Q6f4uHxj8Y7bfuMSk0/m2vgl7WvaETEtWFom2mBW8A8JJcp
         dzHb6d84REzzsRPCW3uadJ6MxO4TQxHz/Xw5lgx7Ma3qC+o1NzDn+smeH30H24e+PkJ2
         LgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a7DZCtJXdhSHu/g5l+Gfz3Grwf1u1lU78G+9NH5FV+4=;
        b=tBth5ul36jYskDfM2HIfCC2pu67MUnlqzLZ9E3xM3UwaDFG4pqlPCfTFkdZRve3trX
         kkbZ8pMmMxjHuaRv5q2Bvx8luhmbF1yXUmvNtV8ukK+jIvjij5oTqIBIp8Lmv4nSQUY5
         GFrI69v3dcg46VNCxfNKXJb5iqo2NY1XKpWEQHX51ozaz2KuFAKPDdJhf44/r+C/jnTE
         jA+0YHqBDqcwqpMDNAp/XZ+VejoZR52nWj4rPFxaPccNABRv0Tj8RmAGa9dLsWwOJ1gc
         W444idQmP7x1iAzE3NTxUdMa6o3AKXyimbSWhK55+m07LdX+0Se7OFTlkStjLaP6QFas
         kg6A==
X-Gm-Message-State: ACgBeo13+7wkuKx2vT/1mzC/XCnpQHYKi3/glAYMom6YSDt/z1zIJ9m7
        USHjjgaBT1Dx/nHu5hJIKH8=
X-Google-Smtp-Source: AA6agR7hw62bgxem2HOBZn5lz7k1Ka/rS42TkERRx352o8pyZNwU2vSuXFqs3ENfjD7w6M0xKnvuiQ==
X-Received: by 2002:a92:cdae:0:b0:2f1:8d4e:403e with SMTP id g14-20020a92cdae000000b002f18d4e403emr4891ild.129.1662327737641;
        Sun, 04 Sep 2022 14:42:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:17 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 08/57] dyndbg: add test_dynamic_debug module
Date:   Sun,  4 Sep 2022 15:40:45 -0600
Message-Id: <20220904214134.408619-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 MAINTAINERS              |  2 ++
 lib/Kconfig.debug        | 10 ++++++
 lib/Makefile             |  1 +
 lib/test_dynamic_debug.c | 70 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 lib/test_dynamic_debug.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 41762df1be0c..c4465981df31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7222,6 +7222,8 @@ M:	Jason Baron <jbaron@akamai.com>
 S:	Maintained
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
+M:	Jim Cromie <jim.cromie@gmail.com>
+F:	lib/test_dynamic_debug.c
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 183c37502119..5bf7897d9095 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2587,6 +2587,16 @@ config TEST_STATIC_KEYS
 
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
index f0a855eed891..c893114029b8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
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
2.37.2

