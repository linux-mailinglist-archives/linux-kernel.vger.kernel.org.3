Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08774700F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbhLJMtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhLJMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:49:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16804C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:45:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q3so14725863wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9sJ/j648CjFEfYYwmgaJqm9n6E4hQ0hf+GgdNuFCf40=;
        b=sQ33cLM/SB7/dDXToTvBL6uRbSdkQ7Dv+ReEuw5JZ4N0AYWrCSXvVysI7vatB8NC6n
         r080596tnsP0VpHOxetN5gLwYR9KuvzItFpnfSnAtIbPq92BXcSArmILNKdMw1GGvosT
         tD7qDJgsTW4ysjAKkpJLKj1zknbrTkfhU0xApgNbkEBcQbdx8ADpiB/Z1xuvZzcRRuTR
         9l8RLMxxWdzM2C08C2z9rUy3kFY23KREWnrO/6FLTVuAPraTcuq9XWXpvPlSsuguggZe
         TsXHYTK2mMaPP3Oa4PZMYvv65A+EtDh0H/xj6p+cj953DhEPK5fr+QCXeDUBn37fizif
         SqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9sJ/j648CjFEfYYwmgaJqm9n6E4hQ0hf+GgdNuFCf40=;
        b=Id7YXe99yRmk6TD+kp1Z/CyyIHRkhErHv6TcvWgYCGdqi5v314E6XwpV6dCrMubAlx
         62v4vp0UoTBOFhZBJVgrmjEsY7p64sdunminT6rhHgGd6fg7ORhOeOwRpnnG9xAMXYvt
         eW+xT/Xc9kS46w4ngG5/z8pD0uQ37Tt9sC1avysfBjPvCvFsAdyJP2CZvuhVBHJzisjy
         9Z6mDxqGQo8d8oiC9OFJJZZ5RxzMQfOUqKD4LPevRvufFpS0JODcmnFWONXbCMY1kawI
         W1kLR06Y9P7zeCLe0Zy7fEucreWRuLXX/sKJ3XJB0krEJv6VQFUIIvl/abK2xICnbibi
         aloA==
X-Gm-Message-State: AOAM532YESUoB6DlfJ5aCQHkKdTOMJZ/Gr/JqkZbGAstk/RX5mpSv0wT
        pbx1oKAvNZD5n+llFcOiRGhA3w==
X-Google-Smtp-Source: ABdhPJzgwrU/FmdlgYUrQ/W8IMfKbcwMAFyGKzuIXPCW6S7KdWuS0DbWzGfFTnCRWPoPE2mUxZ5jXA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr14235805wrm.280.1639140335457;
        Fri, 10 Dec 2021 04:45:35 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:13f9:8295:8923:1942])
        by smtp.gmail.com with ESMTPSA id g4sm2425890wro.12.2021.12.10.04.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:45:34 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:45:27 +0100
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
Subject: Re: [PATCH v4 1/7] include: split out uaccess instrumentation into a
 separate header
Message-ID: <YbNL579AHDIg3PH5@elver.google.com>
References: <20211209221545.2333249-1-pcc@google.com>
 <20211209221545.2333249-2-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209221545.2333249-2-pcc@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:15PM -0800, Peter Collingbourne wrote:
> In an upcoming change we are going to add uaccess instrumentation
> that uses inline access to struct task_struct from the
> instrumentation routines. Because instrumentation.h is included
> from many places including (recursively) from sched.h this would
> otherwise lead to a circular dependency. Break the dependency by
> moving uaccess instrumentation routines into a separate header,
> instrumentation-uaccess.h.
> 
> Link: https://linux-review.googlesource.com/id/I625728db0c8db374e13e4ebc54985ac5c79ace7d
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/instrumented-uaccess.h | 49 ++++++++++++++++++++++++++++
>  include/linux/instrumented.h         | 34 -------------------
>  include/linux/uaccess.h              |  2 +-
>  lib/iov_iter.c                       |  2 +-
>  lib/usercopy.c                       |  2 +-
>  5 files changed, 52 insertions(+), 37 deletions(-)
>  create mode 100644 include/linux/instrumented-uaccess.h
> 
> diff --git a/include/linux/instrumented-uaccess.h b/include/linux/instrumented-uaccess.h
> new file mode 100644
> index 000000000000..ece549088e50
> --- /dev/null
> +++ b/include/linux/instrumented-uaccess.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This header provides generic wrappers for memory access instrumentation for
> + * uaccess routines that the compiler cannot emit for: KASAN, KCSAN.
> + */
> +#ifndef _LINUX_INSTRUMENTED_UACCESS_H
> +#define _LINUX_INSTRUMENTED_UACCESS_H
> +
> +#include <linux/compiler.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +#include <linux/types.h>
> +
> +/**
> + * instrument_copy_to_user - instrument reads of copy_to_user
> + *
> + * Instrument reads from kernel memory, that are due to copy_to_user (and
> + * variants). The instrumentation must be inserted before the accesses.
> + *
> + * @to destination address
> + * @from source address
> + * @n number of bytes to copy
> + */
> +static __always_inline void
> +instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> +{
> +	kasan_check_read(from, n);
> +	kcsan_check_read(from, n);
> +}
> +
> +/**
> + * instrument_copy_from_user - instrument writes of copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants). The instrumentation should be inserted before the accesses.
> + *
> + * @to destination address
> + * @from source address
> + * @n number of bytes to copy
> + */
> +static __always_inline void
> +instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
> +{
> +	kasan_check_write(to, n);
> +	kcsan_check_write(to, n);
> +}
> +
> +#endif /* _LINUX_INSTRUMENTED_UACCESS_H */
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 42faebbaa202..b68f415510c7 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -102,38 +102,4 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
>  	kcsan_check_atomic_read_write(v, size);
>  }
>  
> -/**
> - * instrument_copy_to_user - instrument reads of copy_to_user
> - *
> - * Instrument reads from kernel memory, that are due to copy_to_user (and
> - * variants). The instrumentation must be inserted before the accesses.
> - *
> - * @to destination address
> - * @from source address
> - * @n number of bytes to copy
> - */
> -static __always_inline void
> -instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> -{
> -	kasan_check_read(from, n);
> -	kcsan_check_read(from, n);
> -}
> -
> -/**
> - * instrument_copy_from_user - instrument writes of copy_from_user
> - *
> - * Instrument writes to kernel memory, that are due to copy_from_user (and
> - * variants). The instrumentation should be inserted before the accesses.
> - *
> - * @to destination address
> - * @from source address
> - * @n number of bytes to copy
> - */
> -static __always_inline void
> -instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
> -{
> -	kasan_check_write(to, n);
> -	kcsan_check_write(to, n);
> -}
> -
>  #endif /* _LINUX_INSTRUMENTED_H */
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index ac0394087f7d..c0c467e39657 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -3,7 +3,7 @@
>  #define __LINUX_UACCESS_H__
>  
>  #include <linux/fault-inject-usercopy.h>
> -#include <linux/instrumented.h>
> +#include <linux/instrumented-uaccess.h>
>  #include <linux/minmax.h>
>  #include <linux/sched.h>
>  #include <linux/thread_info.h>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 66a740e6e153..3f9dc6df7102 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -12,7 +12,7 @@
>  #include <linux/compat.h>
>  #include <net/checksum.h>
>  #include <linux/scatterlist.h>
> -#include <linux/instrumented.h>
> +#include <linux/instrumented-uaccess.h>
>  
>  #define PIPE_PARANOIA /* for now */
>  
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index 7413dd300516..1cd188e62d06 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bitops.h>
>  #include <linux/fault-inject-usercopy.h>
> -#include <linux/instrumented.h>
> +#include <linux/instrumented-uaccess.h>
>  #include <linux/uaccess.h>
>  
>  /* out-of-line parts */
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
