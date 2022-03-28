Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A744E9BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiC1QJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiC1QJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:09:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700CDF66
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:08:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so21051868wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBo//AratQ/1DR4fP0bzg4nenvyeP6GXlQbluV1BOhc=;
        b=XoRtE3LbDm+CH0S0w1UL8cNidNH9c/yiiVgCMVGAYGVt6wIaqXs5FdiWCoF562dWHb
         3pekg79/oC6tqHTtzwARttfPPgjkfulsqIjUa7PjeNY56A/nVuFnjwN0hLj7V0yk/koL
         bbWXLvqHOXtwaAwituAHZcSoVTBP/UB1WWKhQJjObnlOYeW1Tnm8nhb45EfGswYQZtjY
         xauWER2vWgr689WCR4KnXkmExxofg/HGDmJ98KsziH+zahgZwwnp7t16VBzhxNFtML1B
         joEl9JQwS+1/wPjkKmIeucqGFjsPGi/EnyZY4hkHCjwiiafPuwVw+0zNJRsDgkFUlcL5
         zfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBo//AratQ/1DR4fP0bzg4nenvyeP6GXlQbluV1BOhc=;
        b=2yi7prhc5XsVOOpj6MdezM9v8C7hlmCJEb7AgHH6Xp9ojDoAyzsf1fz2xhWSsuWQJn
         OKH/GyRgU/IYhPSvaecLBYckGXH67oKovA3pmheirNz7gQpKP0xMW5dJqvOD1j6bhuPh
         b5+9LCxU0x979zC7Xkc2EquGfrcKxP3KcLtu9/xm1eSfTt6YYXGwKuhkleNyYphmKs8Q
         +CUajHNcXdPPI/xxHlL5zm8cybeQ2osdXQD/GPA0qwgw1mtwSY07KV7WxUHXn2OEaj3W
         MovkALZK0jfaCAhLHYsZcPYhLlEu/+mkJ2326Nez18cmwGQRmWbUycFHJ+AxyP/j2lql
         ECjw==
X-Gm-Message-State: AOAM531iLVnKZFXxt6oh7VVyqbc7GbivCxZdoDwYP5z3Y4JAFdjEFhxA
        05CoUu3P+YHZ+rptFseOZsLuAw==
X-Google-Smtp-Source: ABdhPJyK9REe77DLeIxajDtvqKHCMURYiVy3a6Am75pmR8Q+amNcLv2gAzuJXfV2V9PcVgOxsy6klw==
X-Received: by 2002:adf:f2c6:0:b0:203:f0ba:424c with SMTP id d6-20020adff2c6000000b00203f0ba424cmr24172746wrp.663.1648483687735;
        Mon, 28 Mar 2022 09:08:07 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3ffb:e284:5a57:b020])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm12134887wmj.34.2022.03.28.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:08:07 -0700 (PDT)
Date:   Mon, 28 Mar 2022 18:08:01 +0200
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
Message-ID: <YkHdYZrfcH5FzhG3@elver.google.com>
References: <Yjmn/kVblV3TdoAq@elver.google.com>
 <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
 <CANpmjNN4UjUTB5x6-2T-+b7MY=oAYn37MKvQy-4jYh6JDeJuKg@mail.gmail.com>
 <87k0clvrwh.fsf@email.froward.int.ebiederm.org>
 <Yjuai7yv7QrzgsZS@elver.google.com>
 <CACT4Y+ZxYfpTiTjoTUbyh7iDeAN9w0=RrKL40SU6nm187cTLow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZxYfpTiTjoTUbyh7iDeAN9w0=RrKL40SU6nm187cTLow@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:15AM +0100, Dmitry Vyukov wrote:
[...]
> > +                                       u32 _async;
> 
> Does it make sense to make this u8 and/or rename to flags? In case we
> will need to shove move info here in future.

See v0.3 below. I intend to send v1 next week after 5.18-rc1.

If there are any comments in the meantime, please shout.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Wed, 23 Mar 2022 13:36:45 +0100
Subject: [PATCH RFC] signal: Deliver SIGTRAP on perf event asynchronously if
 blocked

With SIGTRAP on perf events, we have encountered termination of
processes due to user space attempting to block delivery of SIGTRAP.
Consider this case:

    <set up SIGTRAP on a perf event>
    ...
    sigset_t s;
    sigemptyset(&s);
    sigaddset(&s, SIGTRAP | <and others>);
    sigprocmask(SIG_BLOCK, &s, ...);
    ...
    <perf event triggers>

When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
will force the signal, but revert back to the default handler, thus
terminating the task.

This makes sense for error conditions, but not so much for explicitly
requested monitoring. However, the expectation is still that signals
generated by perf events are synchronous, which will no longer be the
case if the signal is blocked and delivered later.

To give user space the ability to clearly distinguish synchronous from
asynchronous signals, introduce siginfo_t::si_perf_flags and
TRAP_PERF_FLAG_ASYNC (opted for flags in case more binary information is
required in future).

The resolution to the problem is then to (a) no longer force the signal
(avoiding the terminations), but (b) tell user space via si_perf_flags
if the signal was synchronous or not, so that such signals can be
handled differently (e.g. let user space decide to ignore or consider
the data imprecise).

The alternative of making the kernel ignore SIGTRAP on perf events if
the signal is blocked may work for some usecases, but likely causes
issues in others that then have to revert back to interception of
sigprocmask() (which we want to avoid). [ A concrete example: when using
breakpoint perf events to track data-flow, in a region of code where
signals are blocked, data-flow can no longer be tracked accurately.
When a relevant asynchronous signal is received after unblocking the
signal, the data-flow tracking logic needs to know its state is
imprecise. ]

Link: https://lore.kernel.org/all/Yjmn%2FkVblV3TdoAq@elver.google.com/
Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/arm/kernel/signal.c           |  1 +
 arch/arm64/kernel/signal.c         |  1 +
 arch/arm64/kernel/signal32.c       |  1 +
 arch/m68k/kernel/signal.c          |  1 +
 arch/sparc/kernel/signal32.c       |  1 +
 arch/sparc/kernel/signal_64.c      |  1 +
 arch/x86/kernel/signal_compat.c    |  2 ++
 include/linux/compat.h             |  1 +
 include/linux/sched/signal.h       |  2 +-
 include/uapi/asm-generic/siginfo.h |  7 +++++++
 kernel/events/core.c               |  4 ++--
 kernel/signal.c                    | 18 ++++++++++++++++--
 12 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index c532a6041066..8111147f7c42 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -708,6 +708,7 @@ static_assert(offsetof(siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x14);
 static_assert(offsetof(siginfo_t, si_perf_data)	== 0x10);
 static_assert(offsetof(siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(siginfo_t, si_perf_flags) == 0x18);
 static_assert(offsetof(siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x10);
 static_assert(offsetof(siginfo_t, si_call_addr)	== 0x0c);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index d8aaf4b6f432..fd55d1848a2b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1010,6 +1010,7 @@ static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
 static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
 static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf_flags) == 0x24);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x18);
 static_assert(offsetof(siginfo_t, si_call_addr)	== 0x10);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index d984282b979f..4700f8522d27 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -487,6 +487,7 @@ static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf_flags)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_call_addr)	== 0x0c);
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 338817d0cb3f..74ee1e3013d7 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -625,6 +625,7 @@ static inline void siginfo_build_tests(void)
 	/* _sigfault._perf */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x10);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x14);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_flags) != 0x18);
 
 	/* _sigpoll */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 6cc124a3bb98..90ff7ff94ea7 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -780,5 +780,6 @@ static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf_flags)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 2a78d2af1265..6eeb766987d1 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -590,5 +590,6 @@ static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
 static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
 static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf_flags) == 0x24);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index b52407c56000..879ef8c72f5c 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -149,8 +149,10 @@ static inline void signal_compat_build_tests(void)
 
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_flags) != 0x24);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_flags) != 0x18);
 
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1c758b0e0359..01fddf72a81f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -235,6 +235,7 @@ typedef struct compat_siginfo {
 				struct {
 					compat_ulong_t _data;
 					u32 _type;
+					u32 _flags;
 				} _perf;
 			};
 		} _sigfault;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b6ecb9fc4cd2..9924fe7559a0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -320,7 +320,7 @@ int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
 
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
 int force_sig_pkuerr(void __user *addr, u32 pkey);
-int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
+int send_sig_perf(void __user *addr, u32 type, u64 sig_data);
 
 int force_sig_ptrace_errno_trap(int errno, void __user *addr);
 int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 3ba180f550d7..ffbe4cec9f32 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -99,6 +99,7 @@ union __sifields {
 			struct {
 				unsigned long _data;
 				__u32 _type;
+				__u32 _flags;
 			} _perf;
 		};
 	} _sigfault;
@@ -164,6 +165,7 @@ typedef struct siginfo {
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
 #define si_perf_data	_sifields._sigfault._perf._data
 #define si_perf_type	_sifields._sigfault._perf._type
+#define si_perf_flags	_sifields._sigfault._perf._flags
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
@@ -270,6 +272,11 @@ typedef struct siginfo {
  * that are of the form: ((PTRACE_EVENT_XXX << 8) | SIGTRAP)
  */
 
+/*
+ * Flags for si_perf_flags if SIGTRAP si_code is TRAP_PERF.
+ */
+#define TRAP_PERF_FLAG_ASYNC (1u << 0)
+
 /*
  * SIGCHLD si_codes
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57c7197838db..8f2f251465e9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6533,8 +6533,8 @@ static void perf_sigtrap(struct perf_event *event)
 	if (current->flags & PF_EXITING)
 		return;
 
-	force_sig_perf((void __user *)event->pending_addr,
-		       event->attr.type, event->attr.sig_data);
+	send_sig_perf((void __user *)event->pending_addr,
+		      event->attr.type, event->attr.sig_data);
 }
 
 static void perf_pending_event_disable(struct perf_event *event)
diff --git a/kernel/signal.c b/kernel/signal.c
index 38602738866e..c230a531b169 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1804,7 +1804,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 }
 #endif
 
-int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
+int send_sig_perf(void __user *addr, u32 type, u64 sig_data)
 {
 	struct kernel_siginfo info;
 
@@ -1816,7 +1816,18 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
 	info.si_perf_data = sig_data;
 	info.si_perf_type = type;
 
-	return force_sig_info(&info);
+	/*
+	 * Signals generated by perf events should not terminate the whole
+	 * process if SIGTRAP is blocked, however, delivering the signal
+	 * asynchronously is better than not delivering at all. But tell user
+	 * space if the signal was asynchronous, so it can clearly be
+	 * distinguished from normal synchronous ones.
+	 */
+	info.si_perf_flags = sigismember(&current->blocked, info.si_signo) ?
+				     TRAP_PERF_FLAG_ASYNC :
+				     0;
+
+	return send_sig_info(info.si_signo, &info, current);
 }
 
 /**
@@ -3429,6 +3440,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_perf_data = from->si_perf_data;
 		to->si_perf_type = from->si_perf_type;
+		to->si_perf_flags = from->si_perf_flags;
 		break;
 	case SIL_CHLD:
 		to->si_pid = from->si_pid;
@@ -3506,6 +3518,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		to->si_addr = compat_ptr(from->si_addr);
 		to->si_perf_data = from->si_perf_data;
 		to->si_perf_type = from->si_perf_type;
+		to->si_perf_flags = from->si_perf_flags;
 		break;
 	case SIL_CHLD:
 		to->si_pid    = from->si_pid;
@@ -4719,6 +4732,7 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_pkey);
 	CHECK_OFFSET(si_perf_data);
 	CHECK_OFFSET(si_perf_type);
+	CHECK_OFFSET(si_perf_flags);
 
 	/* sigpoll */
 	CHECK_OFFSET(si_band);
-- 
2.35.1.1021.g381101b075-goog

