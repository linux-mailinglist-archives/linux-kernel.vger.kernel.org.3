Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A378046D014
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhLHJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:31:40 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E53C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:28:08 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so2110091otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Bdv1wVZitHdkwvd9N2hen98Yzs4kDehX4GWMlrow5E=;
        b=g5ISx6g3oY/3qGA+ICD++4hXTFvqoFpsFA3aSuqlDPpXbptbcYCcH6Sg0ZdHTguYGf
         NNVEidCRQVOq9L7N6wzHcQ1nEbB68+kilIxW+lRTnAy2yPcFhBDvrBPbe5c/GG2hEaWA
         Kh2dr8hvbMOz5WLdc73jGiiYfwxCDWIZu+TNLRviTsacWxNWJ+ggWUWatHpn4y5ASLLB
         vkYTIIC5wanQ7J0A5zzubuslB9LCItNnOhL37KvAD3ys37KMkg0yD5jzen1DmsPrdZzV
         6KP3SGU/IOF89MeItYC1DLtd4VURvsQ0WzefCsVCQzEfzoRMu4WskNWFtOIR1Z9+79yl
         1m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Bdv1wVZitHdkwvd9N2hen98Yzs4kDehX4GWMlrow5E=;
        b=DP5prsXXh7zI5OHl+0yS7bwaShvrzz25K3wm56ls+yWZoaBiK7Bmed/Q/WxC5AlCLs
         iCgy9kQzXTT2C8GeKoDtfo9hT8LyzdC37IBLi0HDds1ci9FVrmu1sdwB/VFWiOgsQnu3
         xKOxbzAI9e+05LXWCqkWKt9u2LH3h2slClyUPQyfuZJNgVbHFR+8bXMxR4YU9kYNU8/H
         DjV1Lw+emvZEOKY/xo8bpSNPitkAMWh03Ey60zREojq9W/ONrPRdAVXEgk5qfLxXOEtF
         04KmyNoZ5lvEQDA0Qldq0ufbGTCql/EbNAV7Qj3NA+weNnRZqrlW0fXD+RsMwAvpKI6Z
         nuJg==
X-Gm-Message-State: AOAM5301XKFJMO6oeUSQYccgE7wHMZx9HIFuKGnp+E5Vedp2iCjg4Op1
        BieMgeZdznWhkPjwsnsxLagouK4Ydgroz/40Gu0DOA==
X-Google-Smtp-Source: ABdhPJy8qPC9r88IhCOlGNijYmunVav4DkgYMslpZk5FeBDJglznr+89usTxjVzp3A8gIxio53fRuNQ5BpLFStDLooQ=
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr39299475otq.196.1638955687415;
 Wed, 08 Dec 2021 01:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-2-pcc@google.com>
In-Reply-To: <20211208044808.872554-2-pcc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Dec 2021 10:27:56 +0100
Message-ID: <CACT4Y+bLvQWb-wcq26NJtzhXiKf0G3tDbS2RtejDS7aLdiD=sA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] include: split out uaccess instrumentation into a
 separate header
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 at 05:48, Peter Collingbourne <pcc@google.com> wrote:
>
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

Acked-by: Dmitry Vyukov <dvyukov@google.com>

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
> +       kasan_check_read(from, n);
> +       kcsan_check_read(from, n);
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
> +       kasan_check_write(to, n);
> +       kcsan_check_write(to, n);
> +}
> +
> +#endif /* _LINUX_INSTRUMENTED_UACCESS_H */
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 42faebbaa202..b68f415510c7 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -102,38 +102,4 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
>         kcsan_check_atomic_read_write(v, size);
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
> -       kasan_check_read(from, n);
> -       kcsan_check_read(from, n);
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
> -       kasan_check_write(to, n);
> -       kcsan_check_write(to, n);
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
