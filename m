Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D654E5FED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiCXIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348816AbiCXIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:09:11 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F899AE63
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:07:39 -0700 (PDT)
Date:   Thu, 24 Mar 2022 08:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1648109256;
        bh=Aof6LmdJY1v75LpCNBvCRmk7t2mbNOHkydhSgp6jXZs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=dR5r52xBsQx1fRlPZHdnKj31hFLvyhRwJpIPl/wcfRZVqBgpripdgWf36XcmU1gXL
         IXi7qEsqCQOsYRKdgONgX4sXuLo5p9HwSWFO89IwlNrv+mS4pEzTtIpAYMWFidwjUA
         V0A2Nk1DMe7ERWs9TT0r95VK5T4Pvsn5xeJpFwwphx8/Y+f9V+tQNSQ3uJhSBN0Anq
         9Ki3ARkDez9KX1Fm5SEyYqypQLR2eypsaia0M8897To2d2laxx00dlwzFtDhDA7r16
         cAWG6aGIOQsf3HeZwCy3u6wPsRykn7TSk8/UnBZSdEIEvjZjheBmQNV2LvfUPDrsgv
         4nKwbGAn+lkTg==
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
From:   David Cohen <dacohen@pm.me>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Cohen <dacohen@pm.me>
Reply-To: David Cohen <dacohen@pm.me>
Subject: [PATCH v3 2/2] PM: enable dynamic debug support within pm_pr_dbg()
Message-ID: <20220324080653.454333-3-dacohen@pm.me>
In-Reply-To: <20220324080653.454333-1-dacohen@pm.me>
References: <20220324080653.454333-1-dacohen@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pm_pr_dbg() is used to filter kernel pm debug messages based
on pm_debug_messages_on flag. The problem is if we enable/disable this
flag it will affect all pm_pr_dbg() calls at once, so we can't
individually control them.

This patch changes pm_pr_dbg() implementation as such:
 - If pm_debug_messages_on is enabled, print the message.
 - If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is
   enabled, only print the messages explicitly enabled on
   /sys/kernel/debug/dynamic_debug/control.
 - If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is
   disabled, don't print the message.

Signed-off-by: David Cohen <dacohen@pm.me>
---
 include/linux/suspend.h | 44 ++++++++++++++++++++++++++++++++++++-----
 kernel/power/main.c     | 29 ---------------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 300273ff40cc..70f2921e2e70 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -542,22 +542,56 @@ static inline void unlock_system_sleep(void) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern bool pm_debug_messages_on;
-extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
+static inline int pm_dyn_debug_messages_on(void)
+{
+#ifdef CONFIG_DYNAMIC_DEBUG
+=09return 1;
+#else
+=09return 0;
+#endif
+}
+#ifndef pr_fmt
+#define pr_fmt(fmt) "PM: " fmt
+#endif
+#define __pm_pr_dbg(fmt, ...)=09=09=09=09=09\
+=09do {=09=09=09=09=09=09=09\
+=09=09if (pm_debug_messages_on)=09=09=09\
+=09=09=09printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);=09\
+=09=09else if (pm_dyn_debug_messages_on())=09=09\
+=09=09=09pr_debug(fmt, ##__VA_ARGS__);=09\
+=09} while (0)
+#define __pm_deferred_pr_dbg(fmt, ...)=09=09=09=09\
+=09do {=09=09=09=09=09=09=09\
+=09=09if (pm_debug_messages_on)=09=09=09\
+=09=09=09printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);=09\
+=09} while (0)
 #else
 #define pm_print_times_enabled=09(false)
 #define pm_debug_messages_on=09(false)

 #include <linux/printk.h>

-#define __pm_pr_dbg(defer, fmt, ...) \
-=09no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
+#define __pm_pr_dbg(fmt, ...) \
+=09no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define __pm_deferred_pr_dbg(fmt, ...) \
+=09no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif

+/**
+ * pm_pr_dbg - print pm sleep debug messages
+ *
+ * If pm_debug_messages_on is enabled, print message.
+ * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled=
,
+ *=09print message only from instances explicitly enabled on dynamic debug=
's
+ *=09control.
+ * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is disable=
d,
+ *=09don't print message.
+ */
 #define pm_pr_dbg(fmt, ...) \
-=09__pm_pr_dbg(false, fmt, ##__VA_ARGS__)
+=09__pm_pr_dbg(fmt, ##__VA_ARGS__)

 #define pm_deferred_pr_dbg(fmt, ...) \
-=09__pm_pr_dbg(true, fmt, ##__VA_ARGS__)
+=09__pm_deferred_pr_dbg(fmt, ##__VA_ARGS__)

 #ifdef CONFIG_PM_AUTOSLEEP

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 7e646079fbeb..5242bf2ee469 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -545,35 +545,6 @@ static int __init pm_debug_messages_setup(char *str)
 }
 __setup("pm_debug_messages", pm_debug_messages_setup);

-/**
- * __pm_pr_dbg - Print a suspend debug message to the kernel log.
- * @defer: Whether or not to use printk_deferred() to print the message.
- * @fmt: Message format.
- *
- * The message will be emitted if enabled through the pm_debug_messages
- * sysfs attribute.
- */
-void __pm_pr_dbg(bool defer, const char *fmt, ...)
-{
-=09struct va_format vaf;
-=09va_list args;
-
-=09if (!pm_debug_messages_on)
-=09=09return;
-
-=09va_start(args, fmt);
-
-=09vaf.fmt =3D fmt;
-=09vaf.va =3D &args;
-
-=09if (defer)
-=09=09printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
-=09else
-=09=09printk(KERN_DEBUG "PM: %pV", &vaf);
-
-=09va_end(args);
-}
-
 #else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
--
2.35.1


