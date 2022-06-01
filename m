Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF153AB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356227AbiFAQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356215AbiFAQph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:45:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93D9E9C5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:45:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd25so3005340edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sm/cES+pkDaSks5uDugp823Ct/h/91frIrCS39haBeI=;
        b=U+W2VnjjiSr/t1zwPDQhof68HxSYrjuFmU4KxvbNwAxMXa7BqM5kLE36ZdtINvTa34
         ojgk21vPuSmXj7NWL6elHx902k/NPV1EXQtsu1yPF8OkeGmVnGeJAX/sH0BCmE4pp1ZT
         26spaIH9P5OU5fZ1Ek/Wd5EQ3UMh+JGqR4Idc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sm/cES+pkDaSks5uDugp823Ct/h/91frIrCS39haBeI=;
        b=C6oK/lADatJGv2gizzaR3P6jTdyZgqiYRFQG2YKJ8Vr9sZyFBzYROJyIRGkrtSephT
         55HQjTE7EgiY2QPXDRufjDvHxZ+aS/GcYVNUXyqlMRRm5AnmE+G/W5g+l2IanP8y/L8u
         nTArpyU7KfHiv2zaD6bc/zqH749j5FBizt6zl/OekwrXCtAwUjRaA7KD9XYTjLSSkjuU
         RXgtEHXIgRjBb/WcoFFzN59bUZTY0/Ta24qrB4kPI4hhQfKk4A+2HMknJz84Ybjo+kdL
         pekWzrMMi1I4yjud7YTKCnExhv6kAgLJ1XYbWcrWuwr0vf939EDTyIY783LMF/cSwtK7
         qH6Q==
X-Gm-Message-State: AOAM5302XM8+UhbwB7E+ZN4PXRsRXzncgnEVfrkZ8hinrI/hcEI+XFUU
        4a009U3eG3Xy7wySXvKM6NjuC3TP6t1GyJQ1
X-Google-Smtp-Source: ABdhPJytSaqkurplieDvHUsPkYO4PfJ4ovBzQ+A4Ycv9jZIYoZrAisLUpjbo5UPdrT+27r/PHuxfNg==
X-Received: by 2002:a05:6402:330:b0:42d:cd47:89f3 with SMTP id q16-20020a056402033000b0042dcd4789f3mr617862edw.301.1654101934520;
        Wed, 01 Jun 2022 09:45:34 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906110f00b006fe98c7c7a9sm903586eja.85.2022.06.01.09.45.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 09:45:32 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso3409341wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:45:32 -0700 (PDT)
X-Received: by 2002:a7b:c409:0:b0:397:8536:d558 with SMTP id
 k9-20020a7bc409000000b003978536d558mr295369wmi.38.1654101932086; Wed, 01 Jun
 2022 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
In-Reply-To: <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 09:45:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
Message-ID: <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 6:20 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> Dynamic memory allocation is needed to modify .data and specify the per
> namespace parameter. The new sysctl API is allowed to get rid of the
> need for such modification.

Ok, this is looking better. That said, a few comments:

>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index ef313ecfb53a..833b670c38f3 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -68,26 +68,94 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>         return ret;
>  }
>
> +static inline void *data_from_ns(struct ctl_context *ctx, struct ctl_table *table);
> +
> +static int ipc_sys_open(struct ctl_context *ctx, struct inode *inode, struct file *file)
> +{
> +       struct ipc_namespace *ns = current->nsproxy->ipc_ns;
> +
> +       // For now, we only allow changes in init_user_ns.
> +       if (ns->user_ns != &init_user_ns)
> +               return -EPERM;
> +
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +       int index = (ctx->table - ipc_sysctls);
> +
> +       switch (index) {
> +               case IPC_SYSCTL_SEM_NEXT_ID:
> +               case IPC_SYSCTL_MSG_NEXT_ID:
[...]

I don't think you actually even compile-tested this, because you're
using these IPC_SYSCTL_SEM_NEXT_ID etc enums before you even declared
them later in the same file.

> +static ssize_t ipc_sys_read(struct ctl_context *ctx, struct file *file,
> +                    char *buffer, size_t *lenp, loff_t *ppos)
> +{
> +       struct ctl_table table = *ctx->table;
> +       table.data = data_from_ns(ctx, ctx->table);
> +       return table.proc_handler(&table, 0, buffer, lenp, ppos);
> +}

Can we please fix the names and the types of this new 'ctx' structure?

Yes, yes, I know the old legacy "sysctl table" is horribly named, and
uses "ctl_table".

But let's just write it out. It's not some random control table for
anything. It's a very odd and specific thing: "sysctl". Let's use the
full name.

Also, Please just make that "ctl_data" member in that "ctl_context"
struct not just have a real name, but a real type. Make it literally
be

    struct ipc_namespace *ipc_ns;

and if we end up with other things wanting other pointers, just add a
new one (or make a union if we care about the size of that allocation,
which I don't see any reason we'd do when it's literally just like a
couple of pointers in size).

There is no reason to have some pseudo-generic "void *ctl_data" that
makes it ambiguous and allows for type confusion and isn't
self-documenting. I'd rather have a properly typed pointer that is
just initialized to NULL and is not always used or needed, but always
has a clear case for *what* it would be used for.

Yes, yes, we have f_private etc for things that are really very very
generic and have arbitrary users. But 'sysctl' is not that kind of
truly generic use.

I wish we didn't have that silly "create a temporary ctl_table entry"
either, and I wish it was properly named. But it's not worth the
pointless churn to fix old bad interfaces. But the new ones should
have better names, and try to avoid those bad old decisions.

But yeah, I think this all is a step in the right direction. And maybe
some of those cases and old 'ctl_table' things can be migrated to just
using individual read() functions entirely. The whole 'ctl_table'
model was broken, and came from the bad old days with an actual
'sysctl()' system call.

Because I think it would be lovely if people would move away from the
'sysctl table' approach entirely for cases where that makes sense, and
these guys that already need special handling are very much in that
situation.

          Linus
