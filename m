Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A265B4CE967
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 06:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiCFFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 00:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCFFxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 00:53:20 -0500
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E48E25D2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 21:52:27 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4KB9j62qkZz4xLFC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 05:52:26 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="R3pLfFH/"
Date:   Sun, 06 Mar 2022 05:52:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1646545941;
        bh=jlHvcCrmUJa3Tgqz2MiMzMxuvjdRv3ydQ/NyZc+5Npo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=R3pLfFH/NetUj6mPXDbbD8SQJCLX+gkdh8pi4P3/DIfBMMoccXIOkQbvv+qYorcPh
         I0G8ftBHaEgMVeDFu3BTku24W+oBLibBJPtOVoUBU0NnOmu51fML9+ehXtb9JQh4Ta
         oC762S1ljBSBDGwoOkdZqNIf5P8cFobNBN/iHj9Fo32MPrGEoncVBCo27JH+sf2JYI
         8jCO8VpwC7EL6yGIe8qRgQusJ8f8JYLYXgRPHmBlsv5QxjSwAZ/GFAOlTfhCArEbo7
         vBLFOaeDfwLxqD7kW0I84uOeZiRSt5BldujmMME7MDG/LCB51O/Q8445jsh26867vE
         VhRsQznCbra2A==
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
From:   David Cohen <dacohen@pm.me>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Cohen <dacohen@pm.me>
Reply-To: David Cohen <dacohen@pm.me>
Subject: [PATCH] PM: fix dynamic debug within pm_pr_debug()
Message-ID: <20220306055207.386821-1-dacohen@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_debug()
to filter pm debug messages based on pm_debug_messages_on flag.
According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
indirectly calls printk_deferred() within __pm_pr_debug() which doesn't
support dynamic debug, but pm_pr_debug() indirectly calls pr_debug()
which does support dynamic debug.

The problem is if we enable/disable dynamic debug inside __pm_pr_debug()
it will affect all pm_pr_debug() calls at once, so we can't individually
control them.

This patch changes __pm_pr_debug() implementation into macros to make
pr_debug() to be directly called by all pr_pm_debug() cases. As a direct
side effect all pr_pm_debug() can be individually controlled by dynamic
debug feature.

Signed-off-by: David Cohen <dacohen@pm.me>
---
 include/linux/suspend.h | 19 +++++++++++++++----
 kernel/power/main.c     | 29 -----------------------------
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 300273ff40cc..d727d3c867e3 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -542,22 +542,33 @@ static inline void unlock_system_sleep(void) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern bool pm_debug_messages_on;
-extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
+#define __pm_pr_dbg(fmt, ...)=09=09=09=09=09\
+=09do {=09=09=09=09=09=09=09\
+=09=09if (pm_debug_messages_on)=09=09=09\
+=09=09=09pr_debug("PM: " fmt, ##__VA_ARGS__);=09\
+=09} while(0)
+#define __pm_deferred_pr_dbg(fmt, ...)=09=09=09=09\
+=09do {=09=09=09=09=09=09=09\
+=09=09if (pm_debug_messages_on)=09=09=09\
+=09=09=09printk_deferred(KERN_DEBUG "PM: " fmt, ##__VA_ARGS__);=09\
+=09} while(0)
 #else
 #define pm_print_times_enabled=09(false)
 #define pm_debug_messages_on=09(false)

 #include <linux/printk.h>

-#define __pm_pr_dbg(defer, fmt, ...) \
+#define __pm_pr_dbg(fmt, ...) \
+=09no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
+#define __pm_deferred_pr_dbg(fmt, ...) \
 =09no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
 #endif

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


