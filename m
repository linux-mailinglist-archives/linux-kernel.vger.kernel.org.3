Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31697485855
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiAESbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:31:20 -0500
Received: from aposti.net ([89.234.176.197]:41834 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242985AbiAESat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:30:49 -0500
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
Subject: [PATCH v2 5/6] PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
Date:   Wed,  5 Jan 2022 18:29:38 +0000
Message-Id: <20220105182939.106885-6-paul@crapouillou.net>
In-Reply-To: <20220105182939.106885-1-paul@crapouillou.net>
References: <20220105182939.106885-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to EXPORT[_GPL]_SIMPLE_DEV_PM_OPS, but for users with runtime-PM
suspend/resume callbacks.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Notes:
    v2: No change

 include/linux/pm_runtime.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 4af454d29281..a7f862a26c03 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -36,6 +36,13 @@
 			   pm_runtime_force_resume, suspend_fn, \
 			   resume_fn, idle_fn)
 
+#define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
+	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
+			   suspend_fn, resume_fn, idle_fn, "")
+#define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
+	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
+			   suspend_fn, resume_fn, idle_fn, "_gpl")
+
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
 
-- 
2.34.1

