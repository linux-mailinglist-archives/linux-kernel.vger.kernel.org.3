Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1814A4E5B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbiCWWK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiCWWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:10:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDACA15FE5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:09:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so4063879wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObE978HXyEgSQFsqvXjrKPb6MujhgttxcWer2JSVBR0=;
        b=KAcKsQlyvwi6tghyjHcdc4xieDiBlngnz4t5NM+neMgOQG3MNLxYVQ+yYHK0Q1O+Hb
         6Cl//LS653t10bORA278PHorYa2EMbQeHQ/lo4qsiTkmsB8V/5AiWx4ar04VHfCpNvhQ
         S2w6ZR4TuK8a1Pdd5jc4Cjrkd48plAHRMmMhqTvSql8JDU28F4ioOMd892lBlQewJvQj
         Tg1dmGyM/AbM0nn9rBtQOBOrs66EP36RckiERmE/oXuHPp1snTWBKBR8OR3DGXdZU/o1
         PLt9rTRAgFcQz/50YWcaXWkMjQqolDCYqnx0NbPEq2AcXktjsacbmXsLudbCWYfq0duP
         X+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObE978HXyEgSQFsqvXjrKPb6MujhgttxcWer2JSVBR0=;
        b=2Jiub3YW4ZqhyMm1g2x8D4MOqqdKM+PcaaO8M5azfu/r/PwO0cb9IuWtb80q+BJoXL
         nfeNpwNfFguITAcch+vRXHgBDGLI/4tEF1bdHZ6wRgVy3mT4RwipNNplulydLV/CMais
         VYDDRYJxpjJ/ebCIRQjP3YLh7EpAVn+CsAHJEowzWTINYVKER+5EiyybNDJymskqbFWj
         FaXX2J3aRAr5aB/mZWRUdPfSuVN2wSR0q4UL8aXsn/9QOhtnKN4bAsz8Sl3XluW301Iq
         8rEYPYFd4eU2+s3Tn8H8uDfHNILBevPwV+QfAVNkCv+Q2XPs1GqFy95o8lim6ytZtStj
         vbOg==
X-Gm-Message-State: AOAM532ZjEZ7HYvCGiqd5UuuNF6IPEZJlsvopO78xBNNXeuWpWypUGmb
        MAGa24R+t+HTQf0E9rUDzPaOtQ==
X-Google-Smtp-Source: ABdhPJzRu6wasOLMAct/2nVuCCfl1yC4egnZzMakLdvC6jTEXI33vSSkrch714zv7uuCA+xs4NMx1A==
X-Received: by 2002:adf:ec41:0:b0:1ed:beee:6f8f with SMTP id w1-20020adfec41000000b001edbeee6f8fmr1792806wrn.110.1648073361146;
        Wed, 23 Mar 2022 15:09:21 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:f72e:62ff:6724:9dc0])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0038c7d1086a7sm4806134wmq.1.2022.03.23.15.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:09:20 -0700 (PDT)
Date:   Wed, 23 Mar 2022 23:09:15 +0100
From:   Marco Elver <elver@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
Message-ID: <Yjuai7yv7QrzgsZS@elver.google.com>
References: <Yjmn/kVblV3TdoAq@elver.google.com>
 <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
 <CANpmjNN4UjUTB5x6-2T-+b7MY=oAYn37MKvQy-4jYh6JDeJuKg@mail.gmail.com>
 <87k0clvrwh.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0clvrwh.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:06PM -0500, Eric W. Biederman wrote:
> Marco Elver <elver@google.com> writes:
[...]
> > Not quite. We need it to be synchronous, because we need to know the
> > precise instruction and potentially do some other stuff _before_
> > subsequent instructions.
> >
> > A compromise might be to deliver synchronously normally, but when
> > blocked deliver asynchronously. But if the signal was delivered
> > asynchronously, we need to let the signal handler know delivery was
> > asynchronous, so that our tracing logic can recover and give up at
> > that point.
> >
> > To do this indication if it was asynchronous, we probably need to
> > extend siginfo_t once more. Would that be reasonable?
> 
> So the idea is to use normal signal delivery but to set a flag
> to indicate that the signal was blocked at the time it was sent?
> 
> It should be possible to add another field that takes a non-zero
> value.  On older kernels it should always have a value of zero so it
> should be safe.
> 
> It might also be possible to simply ignore the signal if it is blocked.
> 
> In either case it will probably take a little bit of care to get the
> races out.

So I gave the "synchronous if possible, but if async let handler know"
version a shot (below). As long as we know if the signal being delivered
is asynchronous we're good, and not terminating the process.

Does that look more reasonable?

Thanks,
-- Marco

------ >8 ------

 arch/arm/kernel/signal.c           |  1 +
 arch/arm64/kernel/signal.c         |  1 +
 arch/arm64/kernel/signal32.c       |  1 +
 arch/m68k/kernel/signal.c          |  1 +
 arch/sparc/kernel/signal32.c       |  1 +
 arch/sparc/kernel/signal_64.c      |  1 +
 arch/x86/kernel/signal_compat.c    |  2 ++
 include/linux/compat.h             |  1 +
 include/linux/sched/signal.h       |  2 +-
 include/uapi/asm-generic/siginfo.h |  2 ++
 kernel/events/core.c               |  4 ++--
 kernel/signal.c                    | 16 ++++++++++++++--
 12 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index c532a6041066..5ba4e1d0813d 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -708,6 +708,7 @@ static_assert(offsetof(siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x14);
 static_assert(offsetof(siginfo_t, si_perf_data)	== 0x10);
 static_assert(offsetof(siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(siginfo_t, si_perf_async) == 0x18);
 static_assert(offsetof(siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x10);
 static_assert(offsetof(siginfo_t, si_call_addr)	== 0x0c);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index d8aaf4b6f432..a6a3bf49ed53 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1010,6 +1010,7 @@ static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
 static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
 static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf_async) == 0x24);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x18);
 static_assert(offsetof(siginfo_t, si_call_addr)	== 0x10);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index d984282b979f..0f72cdadd43e 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -487,6 +487,7 @@ static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf_async)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_call_addr)	== 0x0c);
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 338817d0cb3f..c6332727f82f 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -625,6 +625,7 @@ static inline void siginfo_build_tests(void)
 	/* _sigfault._perf */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x10);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x14);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_async) != 0x18);
 
 	/* _sigpoll */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 6cc124a3bb98..b127649ac224 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -780,5 +780,6 @@ static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf_async)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 2a78d2af1265..dfa42d9347d8 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -590,5 +590,6 @@ static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
 static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
 static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf_async) == 0x24);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index b52407c56000..1f1ccbc476d1 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -149,8 +149,10 @@ static inline void signal_compat_build_tests(void)
 
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_async) != 0x24);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_async) != 0x18);
 
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1c758b0e0359..36684b97075d 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -235,6 +235,7 @@ typedef struct compat_siginfo {
 				struct {
 					compat_ulong_t _data;
 					u32 _type;
+					u32 _async;
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
index 3ba180f550d7..835eea023630 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -99,6 +99,7 @@ union __sifields {
 			struct {
 				unsigned long _data;
 				__u32 _type;
+				__u32 _async;
 			} _perf;
 		};
 	} _sigfault;
@@ -164,6 +165,7 @@ typedef struct siginfo {
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
 #define si_perf_data	_sifields._sigfault._perf._data
 #define si_perf_type	_sifields._sigfault._perf._type
+#define si_perf_async	_sifields._sigfault._perf._async
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
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
index 38602738866e..9f8d1ed88dcb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1804,7 +1804,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 }
 #endif
 
-int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
+int send_sig_perf(void __user *addr, u32 type, u64 sig_data)
 {
 	struct kernel_siginfo info;
 
@@ -1816,7 +1816,16 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
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
+	info.si_perf_async = sigismember(&current->blocked, info.si_signo);
+
+	return send_sig_info(info.si_signo, &info, current);
 }
 
 /**
@@ -3429,6 +3438,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_perf_data = from->si_perf_data;
 		to->si_perf_type = from->si_perf_type;
+		to->si_perf_async = from->si_perf_async;
 		break;
 	case SIL_CHLD:
 		to->si_pid = from->si_pid;
@@ -3506,6 +3516,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		to->si_addr = compat_ptr(from->si_addr);
 		to->si_perf_data = from->si_perf_data;
 		to->si_perf_type = from->si_perf_type;
+		to->si_perf_async = from->si_perf_async;
 		break;
 	case SIL_CHLD:
 		to->si_pid    = from->si_pid;
@@ -4719,6 +4730,7 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_pkey);
 	CHECK_OFFSET(si_perf_data);
 	CHECK_OFFSET(si_perf_type);
+	CHECK_OFFSET(si_perf_async);
 
 	/* sigpoll */
 	CHECK_OFFSET(si_band);
-- 
2.35.1.894.gb6a874cedc-goog

