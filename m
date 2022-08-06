Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B535558B499
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbiHFIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiHFIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:39:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6860315A1D;
        Sat,  6 Aug 2022 01:39:14 -0700 (PDT)
Date:   Sat, 06 Aug 2022 08:39:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659775152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqnPLVOiUJspOSEA+5W369mUY9XMls2pNuEzg/CYNIo=;
        b=Fefs8iFfqKHOpX3D6oJPjiUtsKAczGprsTSjmZf0ISkE9be1+wFhcUiB5vX/fwXqthYJTB
        vCp0H7UKCYZXjWlW2/9az/SVZddxtoW313a9g0pqwKcNpDi1BBqlNg6G5yM1Ca3Ptht1O9
        QvyGRSfA2k1lWycXQMxNa39qYiRVyfChWp596mRDYkooEhrOk+C6uNWo3lToZYxmQmHafd
        k6maZtgzV/98kXTThW9dhhqccZvF62mIgVntvTyyiFXlDDDWzJ7CcauROY9trpak/2aQh7
        cB8kINjJbLtAWTrBTVy022df8ma89Jdt0umsRRrz86ZO1B7J1ELmQtz97m4CRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659775152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqnPLVOiUJspOSEA+5W369mUY9XMls2pNuEzg/CYNIo=;
        b=cxatV6G9/90W0STud3djXFzEDKSUoYmIY+m2yjVype4pZyKzHiVHCskpQs2HNNACQ68Ez8
        WDcCk+eyndwY40Bg==
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-timers: Make do_clock_gettime() static
Cc:     Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220719085620.30567-1-jslaby@suse.cz>
References: <20220719085620.30567-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <165977515065.15455.14618598258481879751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Commit-ID:     221f9d9cdf429df8c3843b4291f4f412fde11543
Gitweb:        https://git.kernel.org/tip/221f9d9cdf429df8c3843b4291f4f412fde=
11543
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Tue, 19 Jul 2022 10:56:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 06 Aug 2022 10:33:54 +02:00

posix-timers: Make do_clock_gettime() static

do_clock_gettime() is used only in posix-stubs.c, so make it static. It avoids
a compiler warning too:
time/posix-stubs.c:73:5: warning: no previous prototype for =E2=80=98do_clock=
_gettime=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220719085620.30567-1-jslaby@suse.cz

---
 kernel/time/posix-stubs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index fcb3b21..90ea5f3 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -70,7 +70,7 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 	return do_sys_settimeofday64(&new_tp, NULL);
 }
=20
-int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
+static int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 {
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -90,6 +90,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec=
64 *tp)
=20
 	return 0;
 }
+
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 		struct __kernel_timespec __user *, tp)
 {
