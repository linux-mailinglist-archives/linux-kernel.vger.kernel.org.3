Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB64ADA17
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358148AbiBHNih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349830AbiBHNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:38:36 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5702CC03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:38:35 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v186so50039116ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aozwudC/vcOos+T4XrEal3CEC5loh3pS7gEJzCAbFj4=;
        b=CuYzNlzSPt8K8Zsw3zfLs5dxCxu8+1M+XWAuVWoAnmMbstSM6hUICL5HKQKvX0d83w
         3mb1Lm/9oHX7KTaRSiM+AwRiqI7xM0DXk864rOLprebh9kOrGLGu/GQmApDcWwQ0ob2D
         fcUX6XSrIIFBHcXTTWhvlpV5WdLv79T02lz2wJhOsJtB2T21LTTn7igH6ouD0b84zivY
         l8wSOg+k9V/SWuzjKLfIq8RSm34RCJG79GskXIa1HlJNuosZcNzSYbtiNOpU/SnekFio
         wm103hivl5xIjGy4n8NJUZgu6HOs4Fq/7uEvR/1JhhIAyuhPsSK2ZCEKkk7eA4x7ylbR
         GmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aozwudC/vcOos+T4XrEal3CEC5loh3pS7gEJzCAbFj4=;
        b=sbxMe2yECjGO9pl/ogK2yetscy7witDFSCDqcvFQftC2EumP3VacVsZPePs7L7H4Ff
         PWPLidysbdb4FNiFY9Ab6V+jpoJWTWlVQSiIFvughCVHAtMffZvFAq9XOMDZfoFG1Htf
         w98iVO1fzP4V3AkJiPVd/4EggxRaBU0P9LZjG+SYGrsEbVzshR+xZrGYdyQaLVpSJtPS
         UNQzM+KBsahbJz8sc/1EWT4u9VcGRiO+F+lurleLenCzJtcT7ozCtjB71wcltJ6dRJ+G
         h9ZRJ+jhDATKeRSTIzN70ajWNSHIzl4P2PkBWQqxdibODVFM2OwiKS0KS2ANjY8YkzbW
         nyUw==
X-Gm-Message-State: AOAM5339vJf/ZbhhMxm3ryIgd6tYCGlDUtB2O4ppUWJoFA1KioRYGxOA
        VjbhbtagFyU+Cwe0s+ltGSTxKkvBhb3wLlf6wo3TeQ==
X-Google-Smtp-Source: ABdhPJwSy59oJ9AowR7zc65h3SA4WN4a8jjdgrW+5kfjLgRCZasyMpfVwYw0YDKZvLQR6oMK/3ezqo9+5PGKlJE+/yg=
X-Received: by 2002:a25:cc54:: with SMTP id l81mr4366915ybf.236.1644327514316;
 Tue, 08 Feb 2022 05:38:34 -0800 (PST)
MIME-Version: 1.0
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn> <1644324666-15947-4-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1644324666-15947-4-git-send-email-yangtiezhu@loongson.cn>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 14:38:22 +0100
Message-ID: <CANpmjNOySkeK6u-JieNBQ4DmAO3LogdZ6gXv1Noz8jUOi3ThDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] panic: unset panic_on_warn inside panic()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 8 Feb 2022 at 13:51, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> In the current code, the following three places need to unset
> panic_on_warn before calling panic() to avoid recursive panics:
>
> kernel/kcsan/report.c: print_report()
> kernel/sched/core.c: __schedule_bug()
> mm/kfence/report.c: kfence_report_error()
>
> In order to avoid copy-pasting "panic_on_warn = 0" all over the
> places, it is better to move it inside panic() and then remove
> it from the other places.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  kernel/panic.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 55b50e0..95ba825 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -185,6 +185,16 @@ void panic(const char *fmt, ...)
>         int old_cpu, this_cpu;
>         bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>
> +       if (panic_on_warn) {
> +               /*
> +                * This thread may hit another WARN() in the panic path.

Alas, this may actually fix another problem: doing a panic() not from
a WARN(), but then hitting a WARN() along in the panic path. So
"another WARN" is irrelevant, just "a WARN" would be enough to break
things.

> +                * Resetting this prevents additional WARN() from panicking the
> +                * system on this thread.  Other threads are blocked by the
> +                * panic_mutex in panic().
> +                */
> +               panic_on_warn = 0;
> +       }
> +
>         /*
>          * Disable local interrupts. This will prevent panic_smp_self_stop
>          * from deadlocking the first cpu that invokes the panic, since
> @@ -576,16 +586,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>         if (regs)
>                 show_regs(regs);
>
> -       if (panic_on_warn) {
> -               /*
> -                * This thread may hit another WARN() in the panic path.
> -                * Resetting this prevents additional WARN() from panicking the
> -                * system on this thread.  Other threads are blocked by the
> -                * panic_mutex in panic().
> -                */
> -               panic_on_warn = 0;
> +       if (panic_on_warn)
>                 panic("panic_on_warn set ...\n");
> -       }
>
>         if (!regs)
>                 dump_stack();
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1644324666-15947-4-git-send-email-yangtiezhu%40loongson.cn.
