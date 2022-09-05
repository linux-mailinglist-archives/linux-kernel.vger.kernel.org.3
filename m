Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C925AD6EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiIEPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiIEPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:54:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512065E67F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:54:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j14so13687316lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=axcq0cGN9BhyHQpt/85tTBoyR2tAVPcLTBqmW6py4bI=;
        b=EvKjans9FGr8FG9rT4gME7E5YvWEzwRQWFIpr6VbBeoqQQ/lrmcozd/n7Jx2My49u/
         WIYXH42xflcqzXMRtcLQFeTbBysLQTiCL6qZsPlgYqM/KDa6GfchSfU9BNefXVIc9zjP
         2lDKkO7bmYDNHJSeeSrsOV5DHjslnOzDKfxgXTKcocDN+V0pddXvHXp6I9w32JXk6gwX
         Q6RN0xuAd2JjMVVqmLoWwcVQBd6hOhx5w0SEmGLFfBjxM61XoASGcRT5ViAORx2+kABU
         gflXFeFMvrg9DoA0TsRBCbsw9k3y11iWHtfpFs7y0YfbTtZ00fvNhCiE9hXFuP0qf6f/
         aRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=axcq0cGN9BhyHQpt/85tTBoyR2tAVPcLTBqmW6py4bI=;
        b=Cqmq1F0CHoCE1u2L9bMKkYPDFODaifRFB1uICOwgf0ZwSbQ8Gc8LNePC+K243i58Hv
         8ujSVdNVmzG3X/X9odFDoJgCbhctj+nuzDgttOC+PUAIc7a9YDwMriTMlnOt8b5JMLCC
         r2qmk9epnJEaH4NJTC3UrmUq9vBfyN5SkDvTGQRf+54pyLcb5Xpv7bAuDaCcqeiNateC
         HTTqEY9piAqR/SQELWBJdhKhDbG2CVB/g+Lmv1xbnTyMwKMQANpg+137LBOiutpRHlCg
         c+DPsig77aZkLZx5SdvYHidHFOL/iGe/1GkYhTVEpiJJBKBz9B+b3W48+UARd8pSsZnW
         aKfg==
X-Gm-Message-State: ACgBeo3MHE/PZ1C7QKyZ4zbHu6LLvpyWE0iNm0xgCwP5yIAVq5zr2lrX
        B1OLuxTtyQ6yL1iQVCprdx3zEn3QXDgSfW383ZCgiQ==
X-Google-Smtp-Source: AA6agR4/5He9Y3Z7G1/htuFab9D5EBSz11P00unv5/mdq5+/IKf2s7S3N+YLnud3GaNs7zq/EGDj1cz0w1kwEevaVVU=
X-Received: by 2002:a05:6512:118b:b0:492:e3c4:a164 with SMTP id
 g11-20020a056512118b00b00492e3c4a164mr17965949lfr.598.1662393242431; Mon, 05
 Sep 2022 08:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220902100057.404817-1-elver@google.com>
In-Reply-To: <20220902100057.404817-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 5 Sep 2022 17:53:50 +0200
Message-ID: <CACT4Y+ZCzoK9+3qKOzXSHvZ5cfaXpYXbBL+R9bicapOuRpUNFQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Allow restricted kernel breakpoints on user addresses
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Fri, 2 Sept 2022 at 12:01, Marco Elver <elver@google.com> wrote:
>
> Allow the creation of restricted breakpoint perf events that also fire
> in the kernel (!exclude_kernel), if:
>
>   1. No sample information is requested; samples may contain IPs,
>      registers, or other information that may disclose kernel addresses.
>
>   2. The breakpoint (viz. data watchpoint) is on a user address.
>
> The rules constrain the allowable perf events such that no sensitive
> kernel information can be disclosed.
>
> Despite no explicit kernel information disclosure, the following
> questions may need answers:
>
>  1. Is obtaining information that the kernel accessed a particular
>     user's known memory location revealing new information?
>     Given the kernel's user space ABI, there should be no "surprise
>     accesses" to user space memory in the first place.
>
>  2. Does causing breakpoints on user memory accesses by the kernel
>     potentially impact timing in a sensitive way?
>     Since hardware breakpoints trigger regardless of the state of
>     perf_event_attr::exclude_kernel, but are filtered in the perf
>     subsystem, this possibility already exists independent of the
>     proposed change.

I don't see how this gives userspace any new information.
As you noted userspace already should know what userspace addresses
kernel accesses. Additionally since the breakpoint fires anyway (just
filtered out), the fact of it firing should be easily recoverable from
the timing side-channel already. So:

Acked-by: Dmitry Vyukov <dvyukov@google.com>


> Signed-off-by: Marco Elver <elver@google.com>
> ---
>
> Changelog
> ~~~~~~~~~
>
> v1:
> * Rebase.
>
> RFC: https://lkml.kernel.org/r/20220601093502.364142-1-elver@google.com
> ---
>  include/linux/perf_event.h |  8 +-------
>  kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a784e055002e..907b0e3f1318 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1367,13 +1367,7 @@ static inline int perf_is_paranoid(void)
>         return sysctl_perf_event_paranoid > -1;
>  }
>
> -static inline int perf_allow_kernel(struct perf_event_attr *attr)
> -{
> -       if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
> -               return -EACCES;
> -
> -       return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
> -}
> +extern int perf_allow_kernel(struct perf_event_attr *attr);
>
>  static inline int perf_allow_cpu(struct perf_event_attr *attr)
>  {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2621fd24ad26..75f5705b6892 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3176,6 +3176,12 @@ static int perf_event_modify_attr(struct perf_event *event,
>                 return -EOPNOTSUPP;
>         }
>
> +       if (!event->attr.exclude_kernel) {
> +               err = perf_allow_kernel(attr);
> +               if (err)
> +                       return err;
> +       }
> +
>         WARN_ON_ONCE(event->ctx->parent_ctx);
>
>         mutex_lock(&event->child_mutex);
> @@ -12037,6 +12043,38 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
>         return is_capable || ptrace_may_access(task, ptrace_mode);
>  }
>
> +/*
> + * Check if unprivileged users are allowed to set up breakpoints on user
> + * addresses that also count when the kernel accesses them.
> + */
> +static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
> +{
> +       if (attr->type != PERF_TYPE_BREAKPOINT)
> +               return false;
> +
> +       /*
> +        * The sample may contain IPs, registers, or other information that may
> +        * disclose kernel addresses or timing information. Disallow any kind of
> +        * additional sample information.
> +        */
> +       if (attr->sample_type)
> +               return false;
> +
> +       /*
> +        * Only allow kernel breakpoints on user addresses.
> +        */
> +       return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
> +}
> +
> +int perf_allow_kernel(struct perf_event_attr *attr)
> +{
> +       if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
> +           !perf_allow_kernel_breakpoint(attr))
> +               return -EACCES;
> +
> +       return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
> +}
> +
>  /**
>   * sys_perf_event_open - open a performance event, associate it to a task/cpu
>   *
> --
> 2.37.2.789.g6183377224-goog
>
