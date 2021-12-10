Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B0470152
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhLJNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbhLJNQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:16:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F055C061746;
        Fri, 10 Dec 2021 05:12:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 232D0B827F5;
        Fri, 10 Dec 2021 13:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A709C00446;
        Fri, 10 Dec 2021 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639141960;
        bh=xeC3EkvUFHpiDr5FgrRv5JNGrk2OmtdVcSw4zbaTxnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joM5WuPGODNozSFBwpKpEBgfUvelhwB0O3Ct2j1/6wQo5PB5dWEvrprDGrRvZFx1P
         V9+k0lfaGrMrWwa4HijseDsysjOwFnNln68GnSKBLt/3wChkKvjbW+sA/g5Z5b4qOh
         z8j6k5KgSPzB4pYzlK0J1u0Laanuc/HyPxu6q1RxnuHW6R7gROVuKJFZ9yhtlPrHZ+
         3Rao80/eYVnRINqGOAqwJLHv1LeG26zXmRjrolJddMQd1ize2h/KiZQ9sNfr0jVX8P
         zh7UzKt1Mx15XfBBhBushG0DnqAl5tL5P/GaOyAxVqUzvEEIw8MxwyjOO64CzCfyZQ
         DECDEWFR0ZlwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F1419405D8; Fri, 10 Dec 2021 10:12:37 -0300 (-03)
Date:   Fri, 10 Dec 2021 10:12:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dbueso@suse.de>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        dvhart@infradead.org, alistair23@gmail.com,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
Message-ID: <YbNSRcSrAaurqDEv@kernel.org>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 09:58:52AM +1000, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
> 
> This also converts the futex calls to be y2038 safe (when built for a
> 5.1+ kernel).
> 
> This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
> "Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"".
> 
> The original commit was reverted as including linux/time_types.h would
> fail to compile on older kernels. This commit doesn't include
> linux/time_types.h to avoid this issue.

The reverted commit had:

    Reviewed-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Davidlohr Bueso <dbueso@suse.de>

Does that stands for this new patch?

Thanks,

- Arnaldo
 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alistair Francis <alistair23@gmail.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-riscv@lists.infradead.org
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  tools/perf/bench/futex.h | 52 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
> index ebdc2b032afc..385d2bdfaa9f 100644
> --- a/tools/perf/bench/futex.h
> +++ b/tools/perf/bench/futex.h
> @@ -8,6 +8,7 @@
>  #ifndef _FUTEX_H
>  #define _FUTEX_H
>  
> +#include <errno.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> @@ -28,7 +29,17 @@ struct bench_futex_parameters {
>  };
>  
>  /**
> - * futex_syscall() - SYS_futex syscall wrapper
> + * This is copied from linux/time_types.h.
> + * We copy this here to avoid compilation failures when running
> + * on systems that don't ship with linux/time_types.h.
> + */
> +struct __kernel_old_timespec {
> +	__kernel_old_time_t	tv_sec;		/* seconds */
> +	long			tv_nsec;	/* nanoseconds */
> +};
> +
> +/**
> + * futex_syscall() - __NR_futex syscall wrapper
>   * @uaddr:	address of first futex
>   * @op:		futex op code
>   * @val:	typically expected value of uaddr, but varies by op
> @@ -49,14 +60,49 @@ static inline int
>  futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
>  	      volatile u_int32_t *uaddr2, int val3, int opflags)
>  {
> -	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3);
> +#if defined(__NR_futex_time64)
> +	if (sizeof(*timeout) != sizeof(struct __kernel_old_timespec)) {
> +		int ret = syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout,
> +				  uaddr2, val3);
> +	if (ret == 0 || errno != ENOSYS)
> +		return ret;
> +	}
> +#endif
> +
> +#if defined(__NR_futex)
> +	if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
> +		return syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3);
> +
> +	if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
> +		struct __kernel_old_timespec ts32;
> +
> +		ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;
> +		ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> +
> +		return syscall(__NR_futex, uaddr, op | opflags, val, ts32, uaddr2, val3);
> +	} else if (!timeout) {
> +		return syscall(__NR_futex, uaddr, op | opflags, val, NULL, uaddr2, val3);
> +	}
> +#endif
> +
> +	errno = ENOSYS;
> +	return -1;
>  }
>  
>  static inline int
>  futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t val, int nr_requeue,
>  			 volatile u_int32_t *uaddr2, int val3, int opflags)
>  {
> -	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2, val3);
> +#if defined(__NR_futex_time64)
> +	int ret =  syscall(__NR_futex_time64, uaddr, op | opflags, val, nr_requeue,
> +			   uaddr2, val3);
> +	if (ret == 0 || errno != ENOSYS)
> +		return ret;
> +#endif
> +
> +#if defined(__NR_futex)
> +	return syscall(__NR_futex, uaddr, op | opflags, val, nr_requeue, uaddr2, val3);
> +#endif
>  }
>  
>  /**
> -- 
> 2.31.1

-- 

- Arnaldo
