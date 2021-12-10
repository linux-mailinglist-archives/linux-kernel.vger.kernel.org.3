Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739E646F96D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhLJDC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhLJDCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:02:54 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5CC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 18:59:19 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso8341679otj.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 18:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oR5yi2Dt6ut/KBLMokUqn2HlHJKR3awzFiIDuGNCYkQ=;
        b=HcPwxI+Gf3l93aA+HI3/SdhKH5pPXn8AuaM9kip+lau3S+UmKzLk8JZ7zRk7hTGruc
         Fddg2kWPpnrc21ovPoCebuZfBxK8OYTgSTGLXwEiP/kYv04k893DMwB7oDCv3bTdgL5z
         05tCQav7YQrWXg9h0L2EBswGA0fjOBlJ+fHGr6yp7Nr173AyH0vaAaLoFIeaqIeSvP+G
         ktZrmT4tBbBbMP+6X0JzrXy1FBA6Z3PmpwTmjE4DXGuUNDnRX2joYrG2yzIHQRBvrHmK
         HOE9JExxDZG8dgnBeLV3NQyIGeZuxxqJTetm4e5DO5k3eTcn2ww7VfT4uZPe4RH0lMkX
         JZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oR5yi2Dt6ut/KBLMokUqn2HlHJKR3awzFiIDuGNCYkQ=;
        b=YoExTgFGnv873HDgFli0N7CZPIOwuhRVS+8dp+szSMDIQrI7phlG9YMFCLGes1eWAs
         0FL3WUSNKCuACdIfUdk+oYTkk4MDDxvIAbdc/l7bKGeDoiI7pELhrH6OXgw4RSKCVERJ
         jaNxj2qfWq9arJHAPfk4ZoMNtmZKc8HPYZblHemNu7KMFBS71z7IOPrx5Asz1YQByx9M
         edDXjW9Uo9Q+aER383FRcLwbgVIe7/3whc3D0jEbZoFlhBhEt1NkPGRMBhSsL0fmv/bw
         DEc+rWSXJXAKXc3hqbmkEsdcxFKVnwRILA7jlqM4tYxG8d7MXnDJTObbHUahXOPTYmSq
         WBVg==
X-Gm-Message-State: AOAM532twQC9eJmKYDYs9nziXws21c3su+OBTG+NYjObMTn6wc7C3YO+
        mdP8T8+WO8rpSloWYGYSvd59ceE/d6kQjDz6UrE7bQ==
X-Google-Smtp-Source: ABdhPJwUi8bFgH5J1GDOd1Hjy8QQ5dVCzeN5670TxpIvojplCc+VJnlsJcRNvCW9mGzFFjd56KWRP/SnJC5MeOTNHZs=
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr9189067otl.137.1639105158762;
 Thu, 09 Dec 2021 18:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-4-pcc@google.com>
 <CACT4Y+ZYLUf7bvd2H45Jq1PHihdfZe0z4txxqzuiE9GnzP1X6A@mail.gmail.com> <CAMn1gO4C=wWBuRz6viu4R1SsKgOJh8Ax6KH2Nd6wGUc=25Lakw@mail.gmail.com>
In-Reply-To: <CAMn1gO4C=wWBuRz6viu4R1SsKgOJh8Ax6KH2Nd6wGUc=25Lakw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Dec 2021 03:59:07 +0100
Message-ID: <CACT4Y+ZrCJPaWr_FZ7gLmSVJahAESpjLvDK6sT+AodDDMHTWRw@mail.gmail.com>
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

On Thu, 9 Dec 2021 at 22:42, Peter Collingbourne <pcc@google.com> wrote:
> > > With uaccess logging the contract is that the kernel must not report
> > > accessing more data than necessary, as this can lead to false positive
> > > reports in downstream consumers. This generally works out of the box
> > > when instrumenting copy_{from,to}_user(), but with the data argument
> > > to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
> > > much as we can, if the PAGE_SIZE sized access failed) and figure out
> > > later how much we actually need.
> > >
> > > To prevent this from leading to a false positive report, use
> > > copy_from_user_nolog(), which will prevent the access from being logged.
> > > Recall that it is valid for the kernel to report accessing less
> > > data than it actually accessed, as uaccess logging is a best-effort
> > > mechanism for reporting uaccesses.
> > >
> > > Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > ---
> > >  fs/namespace.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index 659a8f39c61a..8f5f2aaca64e 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -31,6 +31,7 @@
> > >  #include <uapi/linux/mount.h>
> > >  #include <linux/fs_context.h>
> > >  #include <linux/shmem_fs.h>
> > > +#include <linux/uaccess-buffer.h>
> > >
> > >  #include "pnode.h"
> > >  #include "internal.h"
> > > @@ -3197,7 +3198,12 @@ static void *copy_mount_options(const void __user * data)
> > >         if (!copy)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       left = copy_from_user(copy, data, PAGE_SIZE);
> > > +       /*
> > > +        * Use copy_from_user_nolog to avoid reporting overly large accesses in
> > > +        * the uaccess buffer, as this can lead to false positive reports in
> > > +        * downstream consumers.
> > > +        */
> > > +       left = copy_from_user_nolog(copy, data, PAGE_SIZE);
> >
> > A late idea...
> > Maybe it's better to log them with a new UACCESS_BUFFER_FLAG_OVERREAD
> > flag. Better for user-space, at least can detect UAFs by checking the
> > first byte. And a more logical kernel annotation (maybe will be used
> > in some other tools? or if we ever check user tags in the kernel).
> >
> > Probably not too important today since we use this only in 2 places,
> > but longer term may be better.
>
> I'm not sure about this. The overreads are basically an implementation
> detail of the kernel, so I'm not sure it makes sense to expose them. A
> scheme where we expose all overreads wouldn't necessarily help with
> UAF, because what if for example the kernel reads *behind* the
> user-provided pointer? I guess it could lead to false positives.

If user-space uses logging to check addressability, then it can safely
check only the first byte (right? there must be at least 1 byte passed
by user-space at that address). And that's enough to detect UAFs.

> > Btw, what's the story with BPF accesses? Can we log them theoretically?
> >
> > Previously the comment said:
> >
> > +       /*
> > +        * Avoid copy_from_user() here as it may leak information about the BPF
> > +        * program to userspace via the uaccess buffer.
> > +        */
> >
> > but now it says something very generic:
> >
> > /*
> > * Avoid logging uaccesses here as the BPF program may not be following
> > * the uaccess log rules.
> > */
>
> Yes we should be able to log them theoretically, but we don't need to
> do that now. See my reply here:
>
> https://lore.kernel.org/all/CAMn1gO5B5Q3hfN6kugv2wmdFGNhJb75iRX1zmCkw3wnueN1dtg@mail.gmail.com/#:~:text=This%20comment%20was,the%20comment%20accordingly.

I see. These could be marked with another flag.
I don't have a strong opinion about this. But I am mentioning this
because my experience is that it's better to expose more raw info from
kernel in these cases, rather than hardcoding policies into kernel
code (what's ignored/why/when) b/c a delay from another kernel change
to wide deployment is 5+ years and user-space code may need to detect
and deal with all various versions of the kernel logic.
Say, fuzzing may still want to know about the mount options (rather
than no signal that the kernel reads at least something at that
address). But adding them later with a flag is not really a backwards
compatible change b/c you now have addressability checking code that's
not checking the new flag and will produce false positives.
