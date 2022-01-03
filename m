Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E794836E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiACSfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:35:02 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235740AbiACSfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:35:00 -0500
X-Greylist: delayed 836 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:34:55 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKXWJ983520;
        Mon, 3 Jan 2022 10:20:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234033;
        bh=cfkDVUC04N1/5TKLzChdaVzjxjk6gzgwbrbQoSLvShw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=3bO7fBxepM4+/51f0L5qyw/bOgsjQRd0fcDGjKx7c40y65UfrwqkoWMcaCES5BrN+
         nKUb6uagsnHUTHJSULqwvRKsCgqW8BQWZINOK9KZcOlVzVOOcxk9pax4Xeml/9DZvT
         0x29XgMTtXonYouglW8+Jearv13ejCZnKViYIIzsICH7kNq1p/nA+R+VO/fleXM9jM
         NLDHVByAShijXnZLRxOBLlC4QnB/7SJBCrgGxHWHjkv2liiZMYy0VVqqqEINsP+j34
         gyu9RYX96ayZW6dsA+FKzRMPlkU/qOGHtc9saAcEGyQonMqzGiG/z4oHRqhE1bbP0H
         CEKRA26oxA4nw==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKXpq983519;
        Mon, 3 Jan 2022 10:20:33 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        linux-security-module@vger.kernel.org
Subject: [RFC PATCH 3/8] signals: Use a helper function to test if a signal is a real-time signal.
Date:   Mon,  3 Jan 2022 10:19:51 -0800
Message-Id: <20220103181956.983342-4-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than testing against SIGRTMIN/SIGRTMAX directly, use this
helper to determine if a signal is a real-time signal.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 include/linux/signal.h     | 8 ++++++++
 kernel/signal.c            | 6 +++---
 kernel/time/posix-timers.c | 3 ++-
 security/apparmor/ipc.c    | 4 ++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index c66d4f520228..a730f3d4615e 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -53,6 +53,14 @@ enum siginfo_layout {
 
 enum siginfo_layout siginfo_layout(unsigned sig, int si_code);
 
+/* Test if 'sig' is a realtime signal.  Use this instead of testing
+ * SIGRTMIN/SIGRTMAX directly.
+ */
+static inline int realtime_signal(unsigned long sig)
+{
+	return (sig >= SIGRTMIN) && (sig <= SIGRTMAX);
+}
+
 /*
  * Define some primitives to manipulate sigset_t.
  */
diff --git a/kernel/signal.c b/kernel/signal.c
index 94b1828ae973..a2f0e38ba934 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1065,7 +1065,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 
 static inline bool legacy_queue(struct sigpending *signals, int sig)
 {
-	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
+	return !realtime_signal(sig) && sigismember(&signals->signal, sig);
 }
 
 static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
@@ -1108,7 +1108,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	 * make sure at least one signal gets delivered and don't
 	 * pass on the info struct.
 	 */
-	if (sig < SIGRTMIN)
+	if (!realtime_signal(sig))
 		override_rlimit = (is_si_special(info) || info->si_code >= 0);
 	else
 		override_rlimit = 0;
@@ -1144,7 +1144,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			break;
 		}
 	} else if (!is_si_special(info) &&
-		   sig >= SIGRTMIN && info->si_code != SI_USER) {
+		   realtime_signal(sig) && info->si_code != SI_USER) {
 		/*
 		 * Queue overflow, abort.  We may abort if the
 		 * signal was rt and sent by user using something
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1cd10b102c51..6afb98eadd1d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -442,7 +442,8 @@ static struct pid *good_sigevent(sigevent_t * event)
 		fallthrough;
 	case SIGEV_SIGNAL:
 	case SIGEV_THREAD:
-		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
+		/* Signal 0 is a valid signal, just not here. */
+		if (!valid_signal(event->sigev_signo) || event->sigev_signo == 0)
 			return NULL;
 		fallthrough;
 	case SIGEV_NONE:
diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index fe36d112aad9..8149b989b665 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -130,9 +130,9 @@ int aa_may_ptrace(struct aa_label *tracer, struct aa_label *tracee,
 
 static inline int map_signal_num(int sig)
 {
-	if (sig > SIGRTMAX)
+	if (!valid_signal(sig))
 		return SIGUNKNOWN;
-	else if (sig >= SIGRTMIN)
+	else if (realtime_signal(sig))
 		return sig - SIGRTMIN + SIGRT_BASE;
 	else if (sig < MAXMAPPED_SIG)
 		return sig_map[sig];
-- 
2.30.2

