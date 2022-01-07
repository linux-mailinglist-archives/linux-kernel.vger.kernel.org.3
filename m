Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39A3487BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348742AbiAGSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:18:03 -0500
Received: from aposti.net ([89.234.176.197]:54274 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240888AbiAGSSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:18:02 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/6] PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
Date:   Fri,  7 Jan 2022 18:17:20 +0000
Message-Id: <20220107181723.54392-4-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-1-paul@crapouillou.net>
References: <20220107181723.54392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are defined conditionally, according to CONFIG_PM:
- if CONFIG_PM is enabled, these macros resolve to
  DEFINE_SIMPLE_DEV_PM_OPS(), and the dev_pm_ops symbol will be
  exported.

- if CONFIG_PM is disabled, these macros will result in a dummy static
  dev_pm_ops to be created with the __maybe_unused flag. The dev_pm_ops
  will then be discarded by the compiler, along with the provided
  callback functions if they are not used anywhere else.

In the second case, the symbol is not exported, which should be
perfectly fine - users of the symbol should all use the pm_ptr() or
pm_sleep_ptr() macro, so the dev_pm_ops marked as "extern" in the
client's code will never be accessed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Notes:
    v2: Remove useless empty line
    v3: - Reorder the code to have non-private macros together in the file
        - Add comment about the necesity to use the new export macro when
          the dev_pm_ops has to be exported

 include/linux/pm.h | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8e13387e70ec..8279af2c538a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
+#include <linux/export.h>
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
@@ -357,14 +358,42 @@ struct dev_pm_ops {
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #endif
 
+#define _DEFINE_DEV_PM_OPS(name, \
+			   suspend_fn, resume_fn, \
+			   runtime_suspend_fn, runtime_resume_fn, idle_fn) \
+const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
+}
+
+#ifdef CONFIG_PM
+#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
+			   runtime_resume_fn, idle_fn, sec) \
+	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
+			   runtime_resume_fn, idle_fn); \
+	_EXPORT_SYMBOL(name, sec)
+#else
+#define _EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn, \
+			   runtime_resume_fn, idle_fn, sec) \
+static __maybe_unused _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
+					 resume_fn, runtime_suspend_fn, \
+					 runtime_resume_fn, idle_fn)
+#endif
+
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
+ *
+ * If the underlying dev_pm_ops struct symbol has to be exported, use
+ * EXPORT_SIMPLE_DEV_PM_OPS() or EXPORT_GPL_SIMPLE_DEV_PM_OPS() instead.
  */
 #define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops name = { \
-	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-}
+	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
+
+#define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "")
+#define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL, "_gpl")
 
 /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-- 
2.34.1

