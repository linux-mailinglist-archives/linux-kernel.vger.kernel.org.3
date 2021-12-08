Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4F46D029
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhLHJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLHJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:38:36 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:35:04 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q25so3462252oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4h8BNPE5Daxrg+r8GD8bDmKBbuZ/lfdXaIzv9x6f8s=;
        b=Rd8OE1d+TXrV8PEo0x3cJPjD0IZ+NgfQ4rTH1KI9bYmyEylK+w6dsmOGH6/LB32wVk
         XVDcsBqgnMqLSeKingfjnSsjL+Nqe/Dz+uxaOECegTK2KJqA2YMTQyDd3iGSjacJxw8e
         QyNG6ZR9sokoyIYKr7kz5LkIWkkYLdMXeOSlqEG3OVAmnutXrIMU0lKVV27QYZZSnnmQ
         Odq5ghW7V31yfVZoDhwohqsr2df814A6XIQPgJqgI89L3cRum5fbSvF8g+A6LGKZGgSs
         cTq5wnatwGXHAQM/orChkksHUAdI9xi7Qf13Ff+dyb5IqGFKWmmmYT0brNQKTWKYFGi7
         3xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4h8BNPE5Daxrg+r8GD8bDmKBbuZ/lfdXaIzv9x6f8s=;
        b=hrXLtNES8qQNERaBJjJKQLvbk3uwv8qsREKROSYVDiiqpmIhb4QBD2JYJhrYpysjmQ
         ThJ4dvt0xpn6+cEYpLIFEP5Sf9ZfUxlUBXut+yjx5K+QXx9iVrJfp/8B/HtusKeDNu43
         r+FFMkf/xpD+Cy+KpG1hIdJ0Qry91M6X3Ha0zi2aiIBub97K4M4LjMmU0v+cnRXM6UM1
         Ggy+WbzRbr2wzLntOf+MdQc+3iBHIAy8X2esXsc2zGsXN7luepZICx/H/ydHm1NoKZCO
         v2NqD3Zeu7ni7K1GLNZDmcIfOvXPXNRyMkQcsvZnU+k7KoyhobQe8fd+szLp5pclTjlf
         x/lw==
X-Gm-Message-State: AOAM532wY26HRtPl0UeI+JIU24c8lE8oAUZyyeF2bQuGVEH67IJ1yMqS
        YIxcMg3FN8LTeHhgr8fHQf9Sf+8xiuQ0C4H+dgkeqg==
X-Google-Smtp-Source: ABdhPJxGRWzQ61Nu5mi3BAMA70mJOk2GPQbwnH1PfNkGi2oCFHiNW4WHkD1qoadUaJzqSyKlASX7gSHxWaDZqP3qwMs=
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr10252468oiv.160.1638956103721;
 Wed, 08 Dec 2021 01:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-4-pcc@google.com>
In-Reply-To: <20211208044808.872554-4-pcc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Dec 2021 10:34:52 +0100
Message-ID: <CACT4Y+ZYLUf7bvd2H45Jq1PHihdfZe0z4txxqzuiE9GnzP1X6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] fs: use copy_from_user_nolog() to copy mount() data
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
> With uaccess logging the contract is that the kernel must not report
> accessing more data than necessary, as this can lead to false positive
> reports in downstream consumers. This generally works out of the box
> when instrumenting copy_{from,to}_user(), but with the data argument
> to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
> much as we can, if the PAGE_SIZE sized access failed) and figure out
> later how much we actually need.
>
> To prevent this from leading to a false positive report, use
> copy_from_user_nolog(), which will prevent the access from being logged.
> Recall that it is valid for the kernel to report accessing less
> data than it actually accessed, as uaccess logging is a best-effort
> mechanism for reporting uaccesses.
>
> Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  fs/namespace.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 659a8f39c61a..8f5f2aaca64e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -31,6 +31,7 @@
>  #include <uapi/linux/mount.h>
>  #include <linux/fs_context.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/uaccess-buffer.h>
>
>  #include "pnode.h"
>  #include "internal.h"
> @@ -3197,7 +3198,12 @@ static void *copy_mount_options(const void __user * data)
>         if (!copy)
>                 return ERR_PTR(-ENOMEM);
>
> -       left = copy_from_user(copy, data, PAGE_SIZE);
> +       /*
> +        * Use copy_from_user_nolog to avoid reporting overly large accesses in
> +        * the uaccess buffer, as this can lead to false positive reports in
> +        * downstream consumers.
> +        */
> +       left = copy_from_user_nolog(copy, data, PAGE_SIZE);

A late idea...
Maybe it's better to log them with a new UACCESS_BUFFER_FLAG_OVERREAD
flag. Better for user-space, at least can detect UAFs by checking the
first byte. And a more logical kernel annotation (maybe will be used
in some other tools? or if we ever check user tags in the kernel).

Probably not too important today since we use this only in 2 places,
but longer term may be better.

Btw, what's the story with BPF accesses? Can we log them theoretically?

Previously the comment said:

+       /*
+        * Avoid copy_from_user() here as it may leak information about the BPF
+        * program to userspace via the uaccess buffer.
+        */

but now it says something very generic:

/*
* Avoid logging uaccesses here as the BPF program may not be following
* the uaccess log rules.
*/






>         /*
>          * Not all architectures have an exact copy_from_user(). Resort to
> --
> 2.34.1.173.g76aa8bc2d0-goog
