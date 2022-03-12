Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00CB4D6C75
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 05:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiCLEiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 23:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLEiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 23:38:09 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938115A20E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 20:37:03 -0800 (PST)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4KFqlL1BRmz4wx4D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:37:02 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fDlvTRj2"
Date:   Sat, 12 Mar 2022 04:36:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1647059817;
        bh=UdpFS6g8t/sfigVRjnlG7mj5G3nr7GIWn+0FHNn7FF8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=fDlvTRj2emWHiPwixHIo73iFx69Q7zlCSQAfiLI1jI5nmcAH6lwcEUYsPsNgTb7W9
         ginjFqWZchzpUsItj1rxInLib4pY2H/pa7epX08lNb08AyONIsLd+/0tWxI5+KJ44W
         5jmlOya7Pp5OnwhRhLVeBP2nWXNHCdFwyBBcFx81LRguBnck+Eg6fOKqnLxiRaeebX
         SimeLd1Jq2SPqSOpIcgm4DPvtWILHC3XZLsy0lJaA3tT5ExeANHvGf1Ko0bKV7PAFr
         nBQ/YxJqyePN5VLVPDrb9+aTxWs2ooIQsJVFpGysDfw9vH8+5CVfSMLFapKR7Xw4sS
         RE8myk2/9PAHg==
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
From:   David Cohen <dacohen@pm.me>
Cc:     David Cohen <dacohen@pm.me>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: David Cohen <dacohen@pm.me>
Subject: [PATCH v2] PM: fix dynamic debug within pm_pr_debug()
Message-ID: <20220312043624.40732-1-dacohen@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
pr_debug() to be directly called by all pm_pr_debug() cases. As a direct
side effect all pm_pr_debug() can be individually controlled by dynamic
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


