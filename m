Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4A46F61E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhLIVqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLIVqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:46:18 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D2FC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:42:44 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w1so6663054ilh.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbugMu5CR5PhrqT+DkiH/HvuEbZr+QL+N/jCLQ7fpHs=;
        b=XgaAcfdAGG8aAk6eFmNrQ+e6nqpznueqCvH9hgw4JSt3wzaSmsNxNkLWS30A3daJAZ
         BbUUCNx+wjU9O0T2WX893H8TZqJAa+5eBPuaZnWrP3wPlPJSPKK8lEcUXS3z0yJEgw8o
         BTLHiDbutlolUytjfGGSobpyxOE+gR3PctrGN7dVrh676aaKPrvlIvn/OXAqUFQ1MvAc
         2xcu/dY33RwARE86lkW+uijXuBssipbekWFdUECClNj1u196L+z22HmJkHNqpMqyLDYn
         +b3n2nvVse0v9n2oO3r58StgC9j9aqGboYrQLNf46QcodiaGF/zP3FFi6x5P+5LqZVM1
         A6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbugMu5CR5PhrqT+DkiH/HvuEbZr+QL+N/jCLQ7fpHs=;
        b=HjuDTLF9syB/NRmKBdMCg2FRlRRC766Y6YbC3EC4y0/OCfvgBSUIILBoIpwTuPyWp/
         39vgRtTY1eFW2L5J0/YwZpyp7dlEKS4UN2jlHgmTwaGMTC+2twLLScaPCnTy3HlMYGg4
         21tzM4zPvpVu0312MQAn/oVdMBmLDTgO+8bIfK8V3XpDuNUAynuCjCXODSOpyGFk4tA3
         6BgdTYC7WxXzuacERVCYowLoiQuiJ2ar4Jhxggb0xsE5O8hdATrcBu0pzdI0v9HfDfrh
         ZZMCnPrj1d0glcTumpQHHiE0OAJRpMMwt4FWflbTRcP8Eu2ZJTyAJdci5fCK69/Cht+e
         RRbw==
X-Gm-Message-State: AOAM532K9fn0Kb1u+JZzkpO9hvUXLuI68VcZeIFUn5ZC3ebCDB4lwrx2
        sDUl2XSO2ckPNCcFsCjJahXZMRH0q5zC0kvOcF8NIw==
X-Google-Smtp-Source: ABdhPJyLbIkaIpJOMUGjxPv9NAwCkF61V6Fo4Tll7A1Ype0wTp5ZXa1qcdi6tS8RW1IOcQ9B+qehQ8KR6cvg5fyF4K0=
X-Received: by 2002:a05:6e02:1586:: with SMTP id m6mr17631944ilu.146.1639086163707;
 Thu, 09 Dec 2021 13:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-4-pcc@google.com>
 <CACT4Y+ZYLUf7bvd2H45Jq1PHihdfZe0z4txxqzuiE9GnzP1X6A@mail.gmail.com>
In-Reply-To: <CACT4Y+ZYLUf7bvd2H45Jq1PHihdfZe0z4txxqzuiE9GnzP1X6A@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 9 Dec 2021 13:42:32 -0800
Message-ID: <CAMn1gO4C=wWBuRz6viu4R1SsKgOJh8Ax6KH2Nd6wGUc=25Lakw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] fs: use copy_from_user_nolog() to copy mount() data
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Dec 8, 2021 at 1:35 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 8 Dec 2021 at 05:48, Peter Collingbourne <pcc@google.com> wrote:
> >
> > With uaccess logging the contract is that the kernel must not report
> > accessing more data than necessary, as this can lead to false positive
> > reports in downstream consumers. This generally works out of the box
> > when instrumenting copy_{from,to}_user(), but with the data argument
> > to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
> > much as we can, if the PAGE_SIZE sized access failed) and figure out
> > later how much we actually need.
> >
> > To prevent this from leading to a false positive report, use
> > copy_from_user_nolog(), which will prevent the access from being logged.
> > Recall that it is valid for the kernel to report accessing less
> > data than it actually accessed, as uaccess logging is a best-effort
> > mechanism for reporting uaccesses.
> >
> > Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> >  fs/namespace.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 659a8f39c61a..8f5f2aaca64e 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -31,6 +31,7 @@
> >  #include <uapi/linux/mount.h>
> >  #include <linux/fs_context.h>
> >  #include <linux/shmem_fs.h>
> > +#include <linux/uaccess-buffer.h>
> >
> >  #include "pnode.h"
> >  #include "internal.h"
> > @@ -3197,7 +3198,12 @@ static void *copy_mount_options(const void __user * data)
> >         if (!copy)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       left = copy_from_user(copy, data, PAGE_SIZE);
> > +       /*
> > +        * Use copy_from_user_nolog to avoid reporting overly large accesses in
> > +        * the uaccess buffer, as this can lead to false positive reports in
> > +        * downstream consumers.
> > +        */
> > +       left = copy_from_user_nolog(copy, data, PAGE_SIZE);
>
> A late idea...
> Maybe it's better to log them with a new UACCESS_BUFFER_FLAG_OVERREAD
> flag. Better for user-space, at least can detect UAFs by checking the
> first byte. And a more logical kernel annotation (maybe will be used
> in some other tools? or if we ever check user tags in the kernel).
>
> Probably not too important today since we use this only in 2 places,
> but longer term may be better.

I'm not sure about this. The overreads are basically an implementation
detail of the kernel, so I'm not sure it makes sense to expose them. A
scheme where we expose all overreads wouldn't necessarily help with
UAF, because what if for example the kernel reads *behind* the
user-provided pointer? I guess it could lead to false positives.

> Btw, what's the story with BPF accesses? Can we log them theoretically?
>
> Previously the comment said:
>
> +       /*
> +        * Avoid copy_from_user() here as it may leak information about the BPF
> +        * program to userspace via the uaccess buffer.
> +        */
>
> but now it says something very generic:
>
> /*
> * Avoid logging uaccesses here as the BPF program may not be following
> * the uaccess log rules.
> */

Yes we should be able to log them theoretically, but we don't need to
do that now. See my reply here:

https://lore.kernel.org/all/CAMn1gO5B5Q3hfN6kugv2wmdFGNhJb75iRX1zmCkw3wnueN1dtg@mail.gmail.com/#:~:text=This%20comment%20was,the%20comment%20accordingly.

Peter
