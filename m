Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0096A487BFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbiAGSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:18:12 -0500
Received: from aposti.net ([89.234.176.197]:54290 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348785AbiAGSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:18:08 -0500
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
Subject: [PATCH v3 4/6] PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
Date:   Fri,  7 Jan 2022 18:17:21 +0000
Message-Id: <20220107181723.54392-5-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-1-paul@crapouillou.net>
References: <20220107181723.54392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of drivers create a dev_pm_ops struct with the system sleep
suspend/resume callbacks set to pm_runtime_force_suspend() and
pm_runtime_force_resume().

These drivers can now use the DEFINE_RUNTIME_DEV_PM_OPS() macro, which
will use pm_runtime_force_{suspend,resume}() as the system sleep
callbacks, while having the same dead code removal characteristic that
is already provided by DEFINE_SIMPLE_DEV_PM_OPS().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Notes:
    v2-v3: No change

 include/linux/pm.h         |  3 ++-
 include/linux/pm_runtime.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8279af2c538a..f7d2be686359 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -414,7 +414,8 @@ const struct dev_pm_ops __maybe_unused name = { \
  * .resume_early(), to the same routines as .runtime_suspend() and
  * .runtime_resume(), respectively (and analogously for hibernation).
  *
- * Deprecated. You most likely don't want this macro.
+ * Deprecated. You most likely don't want this macro. Use
+ * DEFINE_RUNTIME_DEV_PM_OPS() instead.
  */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 const struct dev_pm_ops __maybe_unused name = { \
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 016de5776b6d..4af454d29281 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -22,6 +22,20 @@
 					    usage_count */
 #define RPM_AUTO		0x08	/* Use autosuspend_delay */
 
+/*
+ * Use this for defining a set of PM operations to be used in all situations
+ * (system suspend, hibernation or runtime PM).
+ *
+ * Note that the behaviour differs from the deprecated UNIVERSAL_DEV_PM_OPS()
+ * macro, which uses the provided callbacks for both runtime PM and system
+ * sleep, while DEFINE_RUNTIME_DEV_PM_OPS() uses pm_runtime_force_suspend()
+ * and pm_runtime_force_resume() for its system sleep callbacks.
+ */
+#define DEFINE_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
+	_DEFINE_DEV_PM_OPS(name, pm_runtime_force_suspend, \
+			   pm_runtime_force_resume, suspend_fn, \
+			   resume_fn, idle_fn)
+
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
 
-- 
2.34.1

