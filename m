Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5248487BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348741AbiAGSRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:17:47 -0500
Received: from aposti.net ([89.234.176.197]:54164 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240782AbiAGSRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:17:39 -0500
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
Subject: [PATCH v3 1/6] PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
Date:   Fri,  7 Jan 2022 18:17:18 +0000
Message-Id: <20220107181723.54392-2-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-1-paul@crapouillou.net>
References: <20220107181723.54392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deprecated UNIVERSAL_DEV_PM_OPS() macro uses the provided callbacks
for both runtime PM and system sleep, which is very likely to be a
mistake, as a system sleep can be triggered while a given device is
already PM-suspended, which would cause the suspend callback to be
called twice.

The amount of users of UNIVERSAL_DEV_PM_OPS() is also tiny (16
occurences) compared to the number of places where
SET_SYSTEM_SLEEP_PM_OPS() is used with pm_runtime_force_suspend() and
pm_runtime_force_resume(), which makes me think that none of these cases
are actually valid.

As the new macro DEFINE_UNIVERSAL_DEV_PM_OPS() which was introduced to
replace UNIVERSAL_DEV_PM_OPS() is currently unused, remove it before
someone starts to use it in yet another invalid case.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Notes:
    v2: No change
    v3: - Keep UNIVERSAL_DEV_PM_OPS deprecated
        - Rework commit message

 include/linux/pm.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e1e9402180b9..02f059d814bb 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -366,6 +366,12 @@ static const struct dev_pm_ops name = { \
 	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
+/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops __maybe_unused name = { \
+	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+}
+
 /*
  * Use this for defining a set of PM operations to be used in all situations
  * (system suspend, hibernation or runtime PM).
@@ -378,20 +384,9 @@ static const struct dev_pm_ops name = { \
  * suspend and "early" resume callback pointers, .suspend_late() and
  * .resume_early(), to the same routines as .runtime_suspend() and
  * .runtime_resume(), respectively (and analogously for hibernation).
+ *
+ * Deprecated. You most likely don't want this macro.
  */
-#define DEFINE_UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-static const struct dev_pm_ops name = { \
-	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-}
-
-/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops __maybe_unused name = { \
-	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-}
-
-/* Deprecated. Use DEFINE_UNIVERSAL_DEV_PM_OPS() instead. */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-- 
2.34.1

