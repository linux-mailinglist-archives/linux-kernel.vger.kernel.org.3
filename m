Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2271346D8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhLHQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbhLHQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:49:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91846C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:46:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so4589216wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fHM3/2H7BSCtMWwY7I7dT+1DmYgUsVBQxLBVSImrVec=;
        b=FGtMB7T5C+z5RUKc3QkFegXpFaASA2zVPCEE3M/TYtOpTGry9i5itJyfstj2uqaerg
         PywmKc5p9reHCkDCtB9tlz+GmtQ/WrIQHay8/BDQPk/6NnMVEs9QtOUWZbTDVXvjW8EY
         NkJfczSnFc0y6DvY9zscpeLTpU6p6cC/x7uf7P0cAcbQvhIHBBXCBKDmsRvLeJPMZZYj
         QqBvItbsNzkyn98/72DfiZjB4DOBsqsNsIZbYxM7dXGlDGIh8pNGL/QfK9880XMs6upo
         SUCUHdS1mEQhm31hGIKIvPCYQmrDwwj7CO7ekf6Arh/cjYogEN10v9A2X2XDI9PyKo2q
         wJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fHM3/2H7BSCtMWwY7I7dT+1DmYgUsVBQxLBVSImrVec=;
        b=ISV7N46WzwiVA8K7Z4m8JNEyj7ezrRDVjJRDqhCS1A64LHwgV46H9LZUIECB8gVnWd
         eQfZRyB/g5TM9Ru13CpZFLFOrUDXBo+8tLNnIO4HuQL8oWUmY+eC3fs+ReRyIkSF1qhf
         01DxDUsHV7UQN5W5pBzt5pC12SohFjKnjcR++EoI1sM3xsQ9YV47r9tpMRbwfgySCMOo
         RlCz7iCQC1IZdGriYIWW3T3oFzzRRZzks6OAs+E+gQWrGTVzy1QETzOETLhvpA6ov9aU
         Nn/N8rJ5hLRqdpQlrXrFGcfcOWdj5PgTnYPhyKm9youxmUJecBgKnCyMWXCzipiLzb8w
         jNVg==
X-Gm-Message-State: AOAM5312/SPbkv7yWDxntewmnGGtVTbDnZe2OwX96z5beIfp1CFJlR7U
        ZilvTW3CvR+fDsXRUdh2rbSq3w==
X-Google-Smtp-Source: ABdhPJyUjtVaR/01IcrWRbP9GzsjbNsXndSRnprtndHOPZQA2VQTK2ZHSvQPF3PTiE9HyNFEaj+VLg==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr17656722wmj.156.1638981975743;
        Wed, 08 Dec 2021 08:46:15 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:44b0:9ed5:7ad0:b441])
        by smtp.gmail.com with ESMTPSA id j8sm3058148wrh.16.2021.12.08.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:46:15 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:46:08 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v3 2/6] uaccess-buffer: add core code
Message-ID: <YbDhUHoE67Uh6hj1@elver.google.com>
References: <20211208044808.872554-1-pcc@google.com>
 <20211208044808.872554-3-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208044808.872554-3-pcc@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:48PM -0800, Peter Collingbourne wrote:
> Add the core code to support uaccess logging. Subsequent patches will
> hook this up to the arch-specific kernel entry and exit code for
> certain architectures.
> 
> Link: https://linux-review.googlesource.com/id/I6581765646501a5631b281d670903945ebadc57d
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
> v3:
> - performance optimizations for entry/exit code
> - don't use kcur == NULL to mean overflow
> - fix potential double free in clone()
> - don't allocate a new kernel-side uaccess buffer for each syscall
> - fix uaccess buffer leak on exit
> - fix some sparse warnings
> 
> v2:
> - New interface that avoids multiple syscalls per real syscall and
>   is arch-generic
> - Avoid logging uaccesses done by BPF programs
> - Add documentation
> - Split up into multiple patches
> - Various code moves, renames etc as requested by Marco
> 
>  fs/exec.c                            |   3 +
>  include/linux/instrumented-uaccess.h |   6 +-
>  include/linux/sched.h                |   5 ++
>  include/linux/uaccess-buffer-info.h  |  46 ++++++++++
>  include/linux/uaccess-buffer.h       | 112 +++++++++++++++++++++++
>  include/uapi/linux/prctl.h           |   3 +
>  include/uapi/linux/uaccess-buffer.h  |  27 ++++++
>  kernel/Makefile                      |   1 +
>  kernel/bpf/helpers.c                 |   7 +-
>  kernel/fork.c                        |   4 +
>  kernel/signal.c                      |   4 +-
>  kernel/sys.c                         |   6 ++
>  kernel/uaccess-buffer.c              | 129 +++++++++++++++++++++++++++
>  13 files changed, 350 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/uaccess-buffer-info.h
>  create mode 100644 include/linux/uaccess-buffer.h
>  create mode 100644 include/uapi/linux/uaccess-buffer.h
>  create mode 100644 kernel/uaccess-buffer.c
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 537d92c41105..c9975e790f30 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -65,6 +65,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/io_uring.h>
>  #include <linux/syscall_user_dispatch.h>
> +#include <linux/uaccess-buffer.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -1313,6 +1314,8 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	me->personality &= ~bprm->per_clear;
>  
>  	clear_syscall_work_syscall_user_dispatch(me);
> +	uaccess_buffer_set_descriptor_addr_addr(0);
> +	uaccess_buffer_free(current);
>  
>  	/*
>  	 * We have to apply CLOEXEC before we change whether the process is
> diff --git a/include/linux/instrumented-uaccess.h b/include/linux/instrumented-uaccess.h
> index ece549088e50..b967f4436d15 100644
> --- a/include/linux/instrumented-uaccess.h
> +++ b/include/linux/instrumented-uaccess.h
> @@ -2,7 +2,8 @@
>  
>  /*
>   * This header provides generic wrappers for memory access instrumentation for
> - * uaccess routines that the compiler cannot emit for: KASAN, KCSAN.
> + * uaccess routines that the compiler cannot emit for: KASAN, KCSAN,
> + * uaccess buffers.
>   */
>  #ifndef _LINUX_INSTRUMENTED_UACCESS_H
>  #define _LINUX_INSTRUMENTED_UACCESS_H
> @@ -11,6 +12,7 @@
>  #include <linux/kasan-checks.h>
>  #include <linux/kcsan-checks.h>
>  #include <linux/types.h>
> +#include <linux/uaccess-buffer.h>
>  
>  /**
>   * instrument_copy_to_user - instrument reads of copy_to_user
> @@ -27,6 +29,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>  	kasan_check_read(from, n);
>  	kcsan_check_read(from, n);
> +	uaccess_buffer_log_write(to, n);
>  }
>  
>  /**
> @@ -44,6 +47,7 @@ instrument_copy_from_user(const void *to, const void __user *from, unsigned long
>  {
>  	kasan_check_write(to, n);
>  	kcsan_check_write(to, n);
> +	uaccess_buffer_log_read(from, n);
>  }
>  
>  #endif /* _LINUX_INSTRUMENTED_UACCESS_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 78c351e35fec..7c5278d7b57d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -34,6 +34,7 @@
>  #include <linux/rseq.h>
>  #include <linux/seqlock.h>
>  #include <linux/kcsan.h>
> +#include <linux/uaccess-buffer-info.h>
>  #include <asm/kmap_size.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> @@ -1484,6 +1485,10 @@ struct task_struct {
>  	struct callback_head		l1d_flush_kill;
>  #endif
>  
> +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> +	struct uaccess_buffer_info	uaccess_buffer;
> +#endif
> +
>  	/*
>  	 * New fields for task_struct should be added above here, so that
>  	 * they are included in the randomized portion of task_struct.
> diff --git a/include/linux/uaccess-buffer-info.h b/include/linux/uaccess-buffer-info.h
> new file mode 100644
> index 000000000000..15e2d8f7c074
> --- /dev/null
> +++ b/include/linux/uaccess-buffer-info.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UACCESS_BUFFER_INFO_H
> +#define _LINUX_UACCESS_BUFFER_INFO_H
> +
> +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> +
> +struct uaccess_buffer_info {
> +	/*
> +	 * The pointer to pointer to struct uaccess_descriptor. This is the
> +	 * value controlled by prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR).
> +	 */
> +	struct uaccess_descriptor __user *__user *desc_ptr_ptr;
> +
> +	/*
> +	 * The pointer to struct uaccess_descriptor read at syscall entry time.
> +	 */
> +	struct uaccess_descriptor __user *desc_ptr;
> +
> +	/*
> +	 * A pointer to the kernel's temporary copy of the uaccess log for the
> +	 * current syscall. We log to a kernel buffer in order to avoid leaking
> +	 * timing information to userspace.
> +	 */
> +	struct uaccess_buffer_entry *kbegin;
> +
> +	/*
> +	 * The position of the next uaccess buffer entry for the current
> +	 * syscall, or NULL if we are not logging the current syscall.
> +	 */
> +	struct uaccess_buffer_entry *kcur;
> +
> +	/*
> +	 * A pointer to the end of the kernel's uaccess log.
> +	 */
> +	struct uaccess_buffer_entry *kend;
> +
> +	/*
> +	 * The pointer to the userspace uaccess log, as read from the
> +	 * struct uaccess_descriptor.
> +	 */
> +	struct uaccess_buffer_entry __user *ubegin;
> +};
> +
> +#endif
> +
> +#endif  /* _LINUX_UACCESS_BUFFER_INFO_H */
> diff --git a/include/linux/uaccess-buffer.h b/include/linux/uaccess-buffer.h
> new file mode 100644
> index 000000000000..f2f46db274f3
> --- /dev/null
> +++ b/include/linux/uaccess-buffer.h
> @@ -0,0 +1,112 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UACCESS_BUFFER_H
> +#define _LINUX_UACCESS_BUFFER_H
> +
> +#include <linux/sched.h>
> +#include <uapi/linux/uaccess-buffer.h>
> +
> +#include <asm-generic/errno-base.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER

Kernel-doc comments for each of the below would be useful (if __ prefixed
functions are implementation details, they can be left as-is).

> +
> +static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
> +{
> +	return test_task_syscall_work(tsk, UACCESS_BUFFER_ENTRY);
> +}
> +
> +void __uaccess_buffer_syscall_entry(void);
> +static inline void uaccess_buffer_syscall_entry(void)
> +{
> +	__uaccess_buffer_syscall_entry();
> +}
> +
> +void __uaccess_buffer_syscall_exit(void);
> +static inline void uaccess_buffer_syscall_exit(void)
> +{
> +	__uaccess_buffer_syscall_exit();
> +}
> +
> +bool __uaccess_buffer_pre_exit_loop(void);
> +static inline bool uaccess_buffer_pre_exit_loop(void)
> +{
> +	if (!test_syscall_work(UACCESS_BUFFER_ENTRY))
> +		return false;
> +	return __uaccess_buffer_pre_exit_loop();
> +}
> +
> +void __uaccess_buffer_post_exit_loop(void);
> +static inline void uaccess_buffer_post_exit_loop(bool pending)
> +{
> +	if (pending)
> +		__uaccess_buffer_post_exit_loop();
> +}
> +
> +static inline int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
> +{
> +	current->uaccess_buffer.desc_ptr_ptr =
> +		(struct uaccess_descriptor __user * __user *)addr;
> +	if (addr)
> +		set_syscall_work(UACCESS_BUFFER_ENTRY);
> +	else
> +		clear_syscall_work(UACCESS_BUFFER_ENTRY);
> +	return 0;
> +}
> +
> +size_t copy_from_user_nolog(void *to, const void __user *from, size_t len);

copy_from_user() has unsigned long for @len and also return type. I'd
make them match.

> +
> +void uaccess_buffer_free(struct task_struct *tsk);
> +
> +void __uaccess_buffer_log_read(const void __user *from, unsigned long n);
> +static inline void uaccess_buffer_log_read(const void __user *from, unsigned long n)
> +{
> +	if (unlikely(test_syscall_work(UACCESS_BUFFER_EXIT)))
> +		__uaccess_buffer_log_read(from, n);
> +}
> +
> +void __uaccess_buffer_log_write(void __user *to, unsigned long n);
> +static inline void uaccess_buffer_log_write(void __user *to, unsigned long n)
> +{
> +	if (unlikely(test_syscall_work(UACCESS_BUFFER_EXIT)))
> +		__uaccess_buffer_log_write(to, n);
> +}
> +
> +#else
> +
> +static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
> +{
> +	return false;
> +}
> +static inline void uaccess_buffer_syscall_entry(void)
> +{
> +}
> +static inline void uaccess_buffer_syscall_exit(void)
> +{
> +}
> +static inline bool uaccess_buffer_pre_exit_loop(void)
> +{
> +	return false;
> +}
> +static inline void uaccess_buffer_post_exit_loop(bool pending)
> +{
> +}
> +static inline int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
> +{
> +	return -EINVAL;
> +}
> +static inline void uaccess_buffer_free(struct task_struct *tsk)
> +{
> +}
> +
> +#define copy_from_user_nolog(to, from, len) copy_from_user(to, from, len)

"#define copy_from_user_nolog copy_from_user" ?

> +
> +static inline void uaccess_buffer_log_read(const void __user *from,
> +					   unsigned long n)
> +{
> +}
> +static inline void uaccess_buffer_log_write(void __user *to, unsigned long n)
> +{
> +}
> +
> +#endif
> +
> +#endif  /* _LINUX_UACCESS_BUFFER_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index bb73e9a0b24f..74b37469c7b3 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -272,4 +272,7 @@ struct prctl_mm_map {
>  # define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
>  # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
>  
> +/* Configure uaccess logging feature */
> +#define PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR	63
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/include/uapi/linux/uaccess-buffer.h b/include/uapi/linux/uaccess-buffer.h
> new file mode 100644
> index 000000000000..bf10f7c78857
> --- /dev/null
> +++ b/include/uapi/linux/uaccess-buffer.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_UACCESS_BUFFER_H
> +#define _UAPI_LINUX_UACCESS_BUFFER_H
> +
> +#include <linux/types.h>
> +
> +/* Location of the uaccess log. */
> +struct uaccess_descriptor {
> +	/* Address of the uaccess_buffer_entry array. */
> +	__u64 addr;
> +	/* Size of the uaccess_buffer_entry array in number of elements. */
> +	__u64 size;
> +};
> +
> +/* Format of the entries in the uaccess log. */
> +struct uaccess_buffer_entry {
> +	/* Address being accessed. */
> +	__u64 addr;
> +	/* Number of bytes that were accessed. */
> +	__u64 size;
> +	/* UACCESS_BUFFER_* flags. */
> +	__u64 flags;
> +};
> +
> +#define UACCESS_BUFFER_FLAG_WRITE	1 /* access was a write */
> +
> +#endif /* _UAPI_LINUX_UACCESS_BUFFER_H */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 186c49582f45..d4d9be5146c3 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -114,6 +114,7 @@ obj-$(CONFIG_KCSAN) += kcsan/
>  obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
>  obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
>  obj-$(CONFIG_CFI_CLANG) += cfi.o
> +obj-$(CONFIG_HAVE_ARCH_UACCESS_BUFFER) += uaccess-buffer.o
>  
>  obj-$(CONFIG_PERF_EVENTS) += events/
>  
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 649f07623df6..ab6520a633ef 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -15,6 +15,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/proc_ns.h>
>  #include <linux/security.h>
> +#include <linux/uaccess-buffer.h>
>  
>  #include "../../lib/kstrtox.h"
>  
> @@ -637,7 +638,11 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
>  BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
>  	   const void __user *, user_ptr)
>  {
> -	int ret = copy_from_user(dst, user_ptr, size);
> +	/*
> +	 * Avoid logging uaccesses here as the BPF program may not be following
> +	 * the uaccess log rules.
> +	 */
> +	int ret = copy_from_user_nolog(dst, user_ptr, size);
>  
>  	if (unlikely(ret)) {
>  		memset(dst, 0, size);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3244cc56b697..8be2ca528a65 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -96,6 +96,7 @@
>  #include <linux/scs.h>
>  #include <linux/io_uring.h>
>  #include <linux/bpf.h>
> +#include <linux/uaccess-buffer.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -754,6 +755,7 @@ void __put_task_struct(struct task_struct *tsk)
>  	delayacct_tsk_free(tsk);
>  	put_signal_struct(tsk->signal);
>  	sched_core_free(tsk);
> +	uaccess_buffer_free(tsk);
>  
>  	if (!profile_handoff_task(tsk))
>  		free_task(tsk);
> @@ -890,6 +892,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	if (memcg_charge_kernel_stack(tsk))
>  		goto free_stack;
>  
> +	uaccess_buffer_free(orig);
> +
>  	stack_vm_area = task_stack_vm_area(tsk);
>  
>  	err = arch_dup_task_struct(tsk, orig);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a629b11bf3e0..69bf21518bd0 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -45,6 +45,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/cgroup.h>
>  #include <linux/audit.h>
> +#include <linux/uaccess-buffer.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/signal.h>
> @@ -1031,7 +1032,8 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  	if (sig_fatal(p, sig) &&
>  	    !(signal->flags & SIGNAL_GROUP_EXIT) &&
>  	    !sigismember(&t->real_blocked, sig) &&
> -	    (sig == SIGKILL || !p->ptrace)) {
> +	    (sig == SIGKILL ||
> +	     !(p->ptrace || uaccess_buffer_maybe_blocked(p)))) {
>  		/*
>  		 * This signal will be fatal to the whole group.
>  		 */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8fdac0d90504..c71a9a9c0f68 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -42,6 +42,7 @@
>  #include <linux/version.h>
>  #include <linux/ctype.h>
>  #include <linux/syscall_user_dispatch.h>
> +#include <linux/uaccess-buffer.h>
>  
>  #include <linux/compat.h>
>  #include <linux/syscalls.h>
> @@ -2530,6 +2531,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
>  		break;
>  #endif
> +	case PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = uaccess_buffer_set_descriptor_addr_addr(arg2);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/kernel/uaccess-buffer.c b/kernel/uaccess-buffer.c
> new file mode 100644
> index 000000000000..088e43f7611c
> --- /dev/null
> +++ b/kernel/uaccess-buffer.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for uaccess logging via uaccess buffers.
> + *
> + * Copyright (C) 2021, Google LLC.
> + */
> +
> +#include <linux/compat.h>
> +#include <linux/mm.h>
> +#include <linux/prctl.h>
> +#include <linux/ptrace.h>
> +#include <linux/sched.h>
> +#include <linux/signal.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/uaccess-buffer.h>
> +
> +static void uaccess_buffer_log(unsigned long addr, unsigned long size,
> +			      unsigned long flags)
> +{
> +	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> +	struct uaccess_buffer_entry *entry = buf->kcur;
> +
> +	if (entry == buf->kend || unlikely(uaccess_kernel()))
> +		return;
> +	entry->addr = addr;
> +	entry->size = size;
> +	entry->flags = flags;
> +
> +	++buf->kcur;
> +}
> +
> +void __uaccess_buffer_log_read(const void __user *from, unsigned long n)
> +{
> +	uaccess_buffer_log((unsigned long)from, n, 0);
> +}
> +EXPORT_SYMBOL(__uaccess_buffer_log_read);
> +
> +void __uaccess_buffer_log_write(void __user *to, unsigned long n)
> +{
> +	uaccess_buffer_log((unsigned long)to, n, UACCESS_BUFFER_FLAG_WRITE);
> +}
> +EXPORT_SYMBOL(__uaccess_buffer_log_write);
> +
> +bool __uaccess_buffer_pre_exit_loop(void)
> +{
> +	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> +	struct uaccess_descriptor __user *desc_ptr;
> +	sigset_t tmp_mask;
> +
> +	if (get_user(desc_ptr, buf->desc_ptr_ptr) || !desc_ptr)
> +		return false;
> +
> +	current->real_blocked = current->blocked;
> +	sigfillset(&tmp_mask);
> +	set_current_blocked(&tmp_mask);
> +	return true;
> +}
> +
> +void __uaccess_buffer_post_exit_loop(void)
> +{
> +	spin_lock_irq(&current->sighand->siglock);
> +	current->blocked = current->real_blocked;
> +	recalc_sigpending();
> +	spin_unlock_irq(&current->sighand->siglock);
> +}
> +
> +void uaccess_buffer_free(struct task_struct *tsk)
> +{
> +	struct uaccess_buffer_info *buf = &tsk->uaccess_buffer;
> +
> +	kfree(buf->kbegin);
> +	clear_syscall_work(UACCESS_BUFFER_EXIT);
> +	buf->kbegin = buf->kcur = buf->kend = NULL;
> +}
> +
> +void __uaccess_buffer_syscall_entry(void)
> +{
> +	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> +	struct uaccess_descriptor desc;
> +
> +	if (get_user(buf->desc_ptr, buf->desc_ptr_ptr) || !buf->desc_ptr ||
> +	    put_user(0, buf->desc_ptr_ptr) ||
> +	    copy_from_user(&desc, buf->desc_ptr, sizeof(desc)))
> +		return;
> +
> +	if (desc.size > 1024)
> +		desc.size = 1024;
> +
> +	if (buf->kend - buf->kbegin != desc.size)
> +		buf->kbegin =
> +			krealloc_array(buf->kbegin, desc.size,
> +				       sizeof(struct uaccess_buffer_entry),
> +				       GFP_KERNEL);
> +	if (!buf->kbegin)
> +		return;
> +
> +	set_syscall_work(UACCESS_BUFFER_EXIT);
> +	buf->kcur = buf->kbegin;
> +	buf->kend = buf->kbegin + desc.size;
> +	buf->ubegin =
> +		(struct uaccess_buffer_entry __user *)(unsigned long)desc.addr;
> +}
> +
> +void __uaccess_buffer_syscall_exit(void)
> +{
> +	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> +	u64 num_entries = buf->kcur - buf->kbegin;
> +	struct uaccess_descriptor desc;
> +
> +	clear_syscall_work(UACCESS_BUFFER_EXIT);
> +	desc.addr = (u64)(unsigned long)(buf->ubegin + num_entries);
> +	desc.size = buf->kend - buf->kcur;
> +	buf->kcur = NULL;
> +	if (copy_to_user(buf->ubegin, buf->kbegin,
> +			 num_entries * sizeof(struct uaccess_buffer_entry)) == 0)
> +		(void)copy_to_user(buf->desc_ptr, &desc, sizeof(desc));
> +}
> +
> +size_t copy_from_user_nolog(void *to, const void __user *from, size_t len)
> +{
> +	size_t retval;
> +
> +	clear_syscall_work(UACCESS_BUFFER_EXIT);
> +	retval = copy_from_user(to, from, len);
> +	if (current->uaccess_buffer.kcur)
> +		set_syscall_work(UACCESS_BUFFER_EXIT);
> +	return retval;
> +}
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
