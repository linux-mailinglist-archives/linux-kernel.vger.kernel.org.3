Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB8468F69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhLFCxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLFCxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:53:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42AC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:50:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t5so36907417edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T7T27+BciAvoEX+1ze0TGvZCEFhs6s8UvaBbKeqdMcY=;
        b=130e8kG8xbBKahQ78mgZ44+SYjW0d3RsrVFq+SKERvIu0rMBEzLM/ABDbQzKJKktnl
         CDZe4mCmXYgjDLjfRQVhwcrJTfmPy+L+lNXZCCAz/SFX4RempSXWVBW2aAZGXT74GVNa
         K3evjxzhtCOdC3e2+weV6eGxI9wLjytUnz3fhReq9+OO4PQAIfJWqxN/o+h2K6J26DK2
         Qqay8XuxAlYHSOHcKEK+sjubzsFGDpC1Ezo393Cf8lZFOip1s0TuDXYwAViNvyMChEw9
         JDDhuPsRSphl7DrUme8b7eK1wuYtUeu90a/EwFsbBYlaj2ST8ELoh5BL24i9E/niMk05
         AEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T7T27+BciAvoEX+1ze0TGvZCEFhs6s8UvaBbKeqdMcY=;
        b=i76yjmfrPOGp4LuPX5/N3s8dew7UiLYP7hY71UvRM63RqJ9v/8jotRZBxLuCAZbDG+
         3WQCTyfrG9dYzO6ElnbICCvLB7i/Y+yn6K1SLPTA3VjO0XYDMYMNF8Qy4vb93YazMgoJ
         8g0lJHmrPtNSuFBWtLBVU19ECZ186xzUsTV8uONZYJhFALx1hidSepecwxbMick/Our0
         qQCOY/WBig0xO5zBuUnuawbNQSYJUmou1k37Veq2BkwmJYGE/pk+9634b399gag111++
         B97Tm/p/DcOacgpnwyty7FGVgp5dh8rY/gfK3RoBvmVOVwjGyz6qTsOq8myszdFfw33K
         Z0tA==
X-Gm-Message-State: AOAM532El97ilpHFya3wq8HNwr19fvyR/9KYfJf4y38PEbqkkzOIajWN
        s16wAY/mOofIHV6Yu+QRWTN+ZKvaJKQCO5fLVjdH
X-Google-Smtp-Source: ABdhPJwqRdNLDOz+CTjWBdlDdIFYSWgDsg8IIzRHSTVfn36d/BJK+xOWXoB0pnwud7Dlk9M6FSmDW9Oo4NtUcK5eKwI=
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr41368275ejb.104.1638759005370;
 Sun, 05 Dec 2021 18:50:05 -0800 (PST)
MIME-Version: 1.0
References: <10e0cc00a83d4214b7bcfda62c36bb20@huawei.com>
In-Reply-To: <10e0cc00a83d4214b7bcfda62c36bb20@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:49:54 -0500
Message-ID: <CAHC9VhSbARHe61ZWb6VLj8kFJKX7109Eq4kXVD_HpMKc6tOGWQ@mail.gmail.com>
Subject: Re: [PATCH] audit: accelerate audit rule filter
To:     "zhaozixuan (C)" <zhaozixuan2@huawei.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 9:25 PM zhaozixuan (C) <zhaozixuan2@huawei.com> wrot=
e:
> >  On Mon, Nov 29, 2021 at 2:35 AM zhaozixuan (C) <zhaozixuan2@huawei.com=
> wrote:
> > > >On Tue, Nov 23, 2021 at 2:50 AM Zixuan Zhao <zhaozixuan2@huawei.com>=
 wrote:
> > > >> We used lat_syscall of lmbench3 to test the performance impact of
> > > >> this patch. We changed the number of rules and run lat_syscall wit=
h
> > > >> 1000 repetitions at each test. Syscalls measured by lat_syscall ar=
e
> > > >> not monitored by rules.
> > > >>
> > > >> Before this optimization:
> > > >>
> > > >>              null     read    write     stat    fstat      open
> > > >>   0 rules  1.87ms   2.74ms   2.56ms   26.31ms  4.13ms   69.66ms
> > > >>  10 rules  2.15ms   3.13ms   3.32ms   26.99ms  4.16ms   74.70ms
> > > >>  20 rules  2.45ms   3.97ms   3.82ms   27.05ms  4.60ms   76.35ms
> > > >>  30 rules  2.64ms   4.52ms   3.95ms   30.30ms  4.94ms   78.94ms
> > > >>  40 rules  2.83ms   4.97ms   4.23ms   32.16ms  5.40ms   81.88ms
> > > >>  50 rules  3.00ms   5.30ms   4.84ms   33.49ms  5.79ms   83.20ms
> > > >> 100 rules  4.24ms   9.75ms   7.42ms   37.68ms  6.55ms   93.70ms
> > > >> 160 rules  5.50ms   16.89ms  12.18ms  51.53ms  17.45ms  155.40ms
> > > >>
> > > >> After this optimization:
> > > >>
> > > >>              null     read    write     stat    fstat      open
> > > >>   0 rules  1.81ms   2.84ms   2.42ms  27.70ms   4.15ms   69.10ms
> > > >>  10 rules  1.97ms   2.83ms   2.69ms  27.70ms   4.15ms   69.30ms
> > > >>  20 rules  1.72ms   2.91ms   2.41ms  26.49ms   3.91ms   71.19ms
> > > >>  30 rules  1.85ms   2.94ms   2.48ms  26.27ms   3.97ms   71.43ms
> > > >>  40 rules  1.88ms   2.94ms   2.78ms  26.85ms   4.08ms   69.79ms
> > > >>  50 rules  1.86ms   3.17ms   3.08ms  26.25ms   4.03ms   72.32ms
> > > >> 100 rules  1.84ms   3.00ms   2.81ms  26.25ms   3.98ms   70.25ms
> > > >> 160 rules  1.92ms   3.32ms   3.06ms  26.81ms   4.57ms   71.41ms
> > > >>
> > > >> As the result shown above, the syscall latencies increase as  the
> > > >> number  of rules increases, while with the patch the latencies rem=
ain stable.
> > > >>  This could help when a user adds many audit rules for purposes
> > > >> (such as  attack tracing or process behavior recording) but suffer=
s
> > > >> from low performance.
> > > >
> > > >I have general concerns about trading memory and complexity for perf=
ormance gains, but beyond that the numbers you posted above don't yet make =
sense to me.
> > >
> > > Thanks for your reply.
> > >
> > > The memory cost of this patch is less than 4KB (1820 bytes on x64 and
> > >  3640 bytes on compatible x86_64) which is trivial in many cases.
> > >  Besides, syscalls are called frequently on a system so a small
> > > optimization could bring a good income.
> >
> > The tradeoff still exists, even though you feel it is worthwhile.
> >
> > > >Why are the latency increases due to rule count not similar across t=
he different syscalls? For example, I would think that if the increase in s=
yscall latency was > >directly attributed to the audit rule processing then=
 the increase on the "open" syscall should be similar to that of the "null"=
 syscall.  In other phrasing, if we > >can process 160 rules in ~4ms in the=
 "null" case, why does it take us ~86ms in the "open" case?
> > >
> > > As to the test result, we did some investigations and concluded two
> > >  reasons:
> > > 1. The chosen rule sets were not very suitable. Though they were not
> > > hit  by syscalls being measured, some of them were hit by other
> > > processes,  which reduced the system performance and affected the tes=
t
> > > result; 2. The routine of lat_syscall is much more complicated than w=
e
> > > thought. It  called many other syscalls during the test, which may
> > > cause the result  not to be linear.
> > >
> > > Due to the reasons above, we did another test. We modified audit rule
> > > sets  and made sure they wouldn't be hit at runtime. Then, we added
> > >  ktime_get_real_ts64 to auditsc.c to record the time of executing
> > > __audit_syscall_exit. We ran "stat" syscall 10000 times for each rule
> > > set  and recorded the time interval. The result is shown below:
> > >
> > > Before this optimization:
> > >
> > > rule set          time
> > >   0 rules     3843.96ns
> > >   1 rules    13119.08ns
> > >  10 rules    14003.13ns
> > >  20 rules    15420.18ns
> > >  30 rules    17284.84ns
> > >  40 rules    19010.67ns
> > >  50 rules    21112.63ns
> > > 100 rules    25815.02ns
> > > 130 rules    29447.09ns
> > >
> > > After this optimization:
> > >
> > >  rule set          time
> > >   0 rules     3597.78ns
> > >   1 rules    13498.73ns
> > >  10 rules    13122.57ns
> > >  20 rules    12874.88ns
> > >  30 rules    14351.99ns
> > >  40 rules    14181.07ns
> > >  50 rules    13806.45ns
> > > 100 rules    13890.85ns
> > > 130 rules    14441.45ns
> > >
> > > As the result showed, the interval is linearly increased before
> > > optimization while the interval remains stable after optimization.
> > > Note  that audit skips some operations if there are no rules, so ther=
e
> > > is a gap  between 0 rule and 1 rule set.
> >
> > It looks like a single rule like the one below could effectively disabl=
e this optimization, is that correct?
> >
> >   % auditctl -a exit,always -F uid=3D1001
> >   % auditctl -l
> >   -a always,exit -S all -F uid=3D1001
>
> Yes, rules like this one which monitors all syscalls could disable the
>  optimization. The number of the global array could exponentially increas=
e
>  if we want to handle more audit fields. However, we don't that kind of
>  rule is practical because they might generate a great number of logs and
>  even lead to log loss.

Before we merge something like this I think we need a better
understand of typical audit filter rules used across the different
audit use cases.  This patch is too much of a band-aid to merge
without a really good promise that it will help most of the real world
audit deployments.

--=20
paul moore
www.paul-moore.com
