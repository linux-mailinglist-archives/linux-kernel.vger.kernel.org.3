Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A946CBC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbhLHD5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLHD5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:57:13 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 19:53:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e136so2885168ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 19:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppZ1ZMh2tbrprX7ij3nrHOgh49PYJ0Gn/Ltq+B+5HQw=;
        b=h1DYm9QJnhpZFODIu0J/dztnesSqb3FW2EaNzDP8JIpvcKP1MtKxukGzIPdTPX7r+g
         XKn6qvG7zHs8cYN6AfYRhMDgvWxhQH+pOLAhyqk5MEZJ2wsNlNb3t+Omp8ahQ0LRLr77
         Zjk7cccbv1GR8Z57vn0loWVOHEplj1h9SgQC1gXvKeEgkxcXEVz499RExsekPAeuGK9+
         g1wIAvif2Zrf3vnHv7Vqy2PiFTk5vIJd3wVjbxeQ0Ko6DzGemoadMpED0y63qCKqTk33
         4os6DnK19phMQugRtW2iky346G8gG0/ybKE7zj3l2TsDX1207QUiD8Q1le0F9gNzxgX3
         NFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppZ1ZMh2tbrprX7ij3nrHOgh49PYJ0Gn/Ltq+B+5HQw=;
        b=ccC1U5Tn838QYcQ43XYPvYzzzPYjtx0zN8g2WzIIWMlOsPafcBoqUB7TIGnS0Sg3wu
         Ztekp1W8xcmLqyJjo0Tv0OnkUAYnFx39tv3LM88Rp/ArD/mfDOtPeB82nC0GdxAcyBE9
         W77z9MbHtY+zyFB2qJ0JpDut0MAMZDfaLDlDluhjmHwT/vMMSmw2XajlNRQpx0oiTjJg
         v/rxzukoz/MrXYpykuDc57+5hYMgRR3ujxpm1Y4NJKfgvstnvlF4Jb65CyKfeAAi7/G8
         i2tHTRPUwTVPZiqz62ufhcQCt7NKCcsbR5fZwLDLr7pS99ZVr5qzEh1EJm1LBooMhObf
         51Mw==
X-Gm-Message-State: AOAM533BNX7owZ8WvtN0VQcoMXnN7C4UcDeq98AGB29rRKGQkNH5eo05
        /huhFowfEgSB8FBQAYQ4psY4eBxWNrpyEh2ue3tXMg==
X-Google-Smtp-Source: ABdhPJwium3HpN7q2h3S58QH5aOC120aUSNy+7JhfjEJcVI1XWmvHHjillxS0XfgM8Xla2ypc2PNJLmSQFModAaOS8g=
X-Received: by 2002:a25:73c7:: with SMTP id o190mr55130557ybc.522.1638935621473;
 Tue, 07 Dec 2021 19:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com> <20211123051658.3195589-2-pcc@google.com>
 <CACT4Y+bNA7NocP_wG+FKVPKEygWWbq4E0Zrw5bn47KvCwgQXAg@mail.gmail.com> <CAG_fn=XnLANd=FBYuW_MvhCqZBGczfNqk0cBmQdXgra81LT+nA@mail.gmail.com>
In-Reply-To: <CAG_fn=XnLANd=FBYuW_MvhCqZBGczfNqk0cBmQdXgra81LT+nA@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 7 Dec 2021 19:53:29 -0800
Message-ID: <CAMn1gO452YHSVJv1cFXCVcWwq1rPbJC8rDTO-oWbv_Ts0iUf_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fs: use raw_copy_from_user() to copy mount() data
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Colin Ian King <colin.king@canonical.com>,
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
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:09 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 23, 2021 at 8:51 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, 23 Nov 2021 at 06:17, Peter Collingbourne <pcc@google.com> wrote:
> > >
> > > With uaccess logging the contract is that the kernel must not report
> > > accessing more data than necessary, as this can lead to false positive
> > > reports in downstream consumers. This generally works out of the box
> > > when instrumenting copy_{from,to}_user(), but with the data argument
> > > to mount() we use copy_from_user() to copy PAGE_SIZE bytes (or as
> > > much as we can, if the PAGE_SIZE sized access failed) and figure out
> > > later how much we actually need.
> > >
> > > To prevent this from leading to a false positive report, use
> > > raw_copy_from_user(), which will prevent the access from being logged.
> > > Recall that it is valid for the kernel to report accessing less
> > > data than it actually accessed, as uaccess logging is a best-effort
> > > mechanism for reporting uaccesses.
> > >
> > > Link: https://linux-review.googlesource.com/id/I5629b92a725c817acd9a861288338dd605cafee6
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > ---
> > >  fs/namespace.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index 659a8f39c61a..695b30e391f0 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -3197,7 +3197,12 @@ static void *copy_mount_options(const void __user * data)
> > >         if (!copy)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       left = copy_from_user(copy, data, PAGE_SIZE);
> > > +       /*
> > > +        * Use raw_copy_from_user to avoid reporting overly large accesses in
> > > +        * the uaccess buffer, as this can lead to false positive reports in
> > > +        * downstream consumers.
> > > +        */
> > > +       left = raw_copy_from_user(copy, data, PAGE_SIZE);
>
> I don't really like the idea of using raw_copy_from_user() anywhere.
> Right now users of instrumented.h can more or less assume they see all
> usercopy events, and removing the copy_from_user() call from here
> looks like a regression.
>
> Cannot the usercopy logger decide whether it wants to log the access
> based on the size (e.g. skip accesses >= PAGE_SIZE)?
> Will it help if we can instrument both sides of copy_from_user() (see
> the code here: https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/14103/4)?
>
> If not, maybe we can disable/enable uaccess logging for the current
> task around these accesses?

This seems reasonable, done in v3.

Peter
