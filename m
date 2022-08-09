Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB75758DE68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbiHISPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346033AbiHISMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:12:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FC2614D;
        Tue,  9 Aug 2022 11:05:16 -0700 (PDT)
Date:   Tue, 09 Aug 2022 18:04:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660068297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKrc8Gg3/X/0lWK8erZcRz5+UN0K7i+Xijnu+m+yDso=;
        b=WudOYxv50CsLok2ERouZc5GaOj1CIdtq1sdIePudurb/sB2a/Nf7ReFYyIUFKdo1xeTK1P
        njShlf8veSxuYyvu9obghQgG4JOrPKgRrfxpnwh5bqOCR1d4Hq6udvQSlE4lzhyG7XLemT
        cOTrfSUV8Jh93PGDLeq6mm+LSV1vxulX862kTwclh2ZYdE0NhlBn24d8PrA3tE1HBLBZLG
        QnorQ3E4lKe5UxFx1f1TGoPrAacvpO9OI8tkgZxn2hWbC2Bd3QE7P2Euwxm/xfoF38HIzz
        oce9VVPDF/HUGFuYF4Zuh18cor0tpXxEL45x9sbQGRDzNtX3uU1pfoMyoTiZZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660068297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKrc8Gg3/X/0lWK8erZcRz5+UN0K7i+Xijnu+m+yDso=;
        b=1jbcd0+qRhJ/kENrLwUq/Ud/4Im5sxdbTclrAyZoxu68ev3xKFhAKlbg9LLS5bgHjB+Ias
        RqZRKXHbQV9r9SBg==
From:   "tip-bot2 for Youngmin Nam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time: Correct the prototype of
 ns_to_kernel_old_timeval and ns_to_timespec64
Cc:     Youngmin Nam <youngmin.nam@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220712094715.2918823-1-youngmin.nam@samsung.com>
References: <20220712094715.2918823-1-youngmin.nam@samsung.com>
MIME-Version: 1.0
Message-ID: <166006829573.15455.10106358361686609629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     46dae32fe625a75f549c3a70edc77b778197bb05
Gitweb:        https://git.kernel.org/tip/46dae32fe625a75f549c3a70edc77b778197bb05
Author:        Youngmin Nam <youngmin.nam@samsung.com>
AuthorDate:    Tue, 12 Jul 2022 18:47:15 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Aug 2022 20:02:13 +02:00

time: Correct the prototype of ns_to_kernel_old_timeval and ns_to_timespec64

In ns_to_kernel_old_timeval() definition, the function argument is defined
with const identifier in kernel/time/time.c, but the prototype in
include/linux/time32.h looks different.

- The function is defined in kernel/time/time.c as below:
  struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)

- The function is decalared in include/linux/time32.h as below:
  extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);

Because the variable of arithmethic types isn't modified in the calling scope,
there's no need to mark arguments as const, which was already mentioned during 
review (Link[1) of the original patch.

Likewise remove the "const" keyword in both definition and declaration of
ns_to_timespec64() as requested by Arnd (Link[2]).

Fixes: a84d1169164b ("y2038: Introduce struct __kernel_old_timeval")
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/20220712094715.2918823-1-youngmin.nam@samsung.com
Link[1]: https://lore.kernel.org/all/20180310081123.thin6wphgk7tongy@gmail.com/
Link[2]: https://lore.kernel.org/all/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com/

---
 include/linux/time64.h | 2 +-
 kernel/time/time.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 2fb8232..f1bcea8 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -145,7 +145,7 @@ static inline s64 timespec64_to_ns(const struct timespec64 *ts)
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-extern struct timespec64 ns_to_timespec64(const s64 nsec);
+extern struct timespec64 ns_to_timespec64(s64 nsec);
 
 /**
  * timespec64_add_ns - Adds nanoseconds to a timespec64
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b2..526257b 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -449,7 +449,7 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
+struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec)
 {
 	struct timespec64 ts = ns_to_timespec64(nsec);
 	struct __kernel_old_timeval tv;
@@ -503,7 +503,7 @@ EXPORT_SYMBOL(set_normalized_timespec64);
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-struct timespec64 ns_to_timespec64(const s64 nsec)
+struct timespec64 ns_to_timespec64(s64 nsec)
 {
 	struct timespec64 ts = { 0, 0 };
 	s32 rem;
