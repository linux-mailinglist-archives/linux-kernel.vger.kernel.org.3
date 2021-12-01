Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BC4656A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbhLATnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbhLATnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:43:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A656C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:39:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v1so106201123edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJYPB6eBM68pLfDabQaaDXwo4O1CIe69huMermV2IMg=;
        b=RIaeKUHkHlahJDiKQiuQE4wTkO4v9yRv/idYgLudgd9Bz0HMRmsmwNStT84g/CMzvt
         MP8WNBWldjB11IYD1C62ePvV8EJY+mAaLYlrT2x7SwOuJI+ifxrTfDJh1FgnOD76+RrG
         MYS+opkEagfQ/Mo7wleRMCIvBANKySVTRX4purjEMoC06hBULlynYtzibcX7bNL5hyGQ
         X/AP5pZAor4k9zRpfKa6o8OTmtpz+VQyuPO1p5YK6gK3W66G5A8X8IP4ADFv4qLyxltb
         UFxOnhYtiAijc8H7HXn/pLc1Y4JgGfB92IYXF78J57gGk6e/a26cOyMV76kkSFqdDQzn
         9ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJYPB6eBM68pLfDabQaaDXwo4O1CIe69huMermV2IMg=;
        b=1w8EeeXoxmMKL6RR3zYQENWOkwxFekBbFxExYMfddTOZpFl5x7olykamhvK3InLAwv
         mfBDSAYIM2y5/I60OOoboSSlutYfseuJFmMAsMbSHT0tVGfKkdW/VnIB0WRAvaApjROZ
         70aVMDWkglk1JjuN2KDDzlF7BhI8R1rx1LZ80V94zp5XOsNAwySugevAl8jJ66cxfjzB
         dCTe9MYt3SSuQwVqNSEfoWnf6xR4crYaGYR98Agbw2iqiY0PolPXjVDJFGkPmKx3dR3q
         ssS87RSjULDMXSS+qxlxB7Ibyv98CCRB42xadS6ygu7NoH8FFLFL64/ER65r7Bo/xZxO
         /AIQ==
X-Gm-Message-State: AOAM531Drps99it1mz/70VE/q+8X3Cgd0Gyqz27szi/GC5h5qCU+SrQ1
        3OXXgMEZ23MgeWdypbZ6nPVdBEH2L/0caR7SzJ3e
X-Google-Smtp-Source: ABdhPJzhRcSz8AGQ9loCNEUue4TCo9HseWXCRrAqiM7pYfpX0ZYcimQfT9p0hkNhA62YEZy9bJ1xiDU9MMJ84J4UyKY=
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr10810710edd.213.1638387576627;
 Wed, 01 Dec 2021 11:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20211123075001.3676-1-zhaozixuan2@huawei.com> <CAHC9VhS-pPDWBRX-6q7aj1Fj5oU0M2vgJC0ipTStczYGkFVvwg@mail.gmail.com>
 <4aac209c744848a38bb2003d601083e4@huawei.com>
In-Reply-To: <4aac209c744848a38bb2003d601083e4@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Dec 2021 14:39:25 -0500
Message-ID: <CAHC9VhQegCi7UfzKPxGP_bwuOvJTVZ4V5o991Q0Y=U85d5s0Vg@mail.gmail.com>
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

On Mon, Nov 29, 2021 at 2:35 AM zhaozixuan (C) <zhaozixuan2@huawei.com> wro=
te:
> >On Tue, Nov 23, 2021 at 2:50 AM Zixuan Zhao <zhaozixuan2@huawei.com> wro=
te:
> >> We used lat_syscall of lmbench3 to test the performance impact of this
> >> patch. We changed the number of rules and run lat_syscall with 1000
> >> repetitions at each test. Syscalls measured by lat_syscall are not
> >> monitored by rules.
> >>
> >> Before this optimization:
> >>
> >>              null     read    write     stat    fstat      open
> >>   0 rules  1.87ms   2.74ms   2.56ms   26.31ms  4.13ms   69.66ms
> >>  10 rules  2.15ms   3.13ms   3.32ms   26.99ms  4.16ms   74.70ms
> >>  20 rules  2.45ms   3.97ms   3.82ms   27.05ms  4.60ms   76.35ms
> >>  30 rules  2.64ms   4.52ms   3.95ms   30.30ms  4.94ms   78.94ms
> >>  40 rules  2.83ms   4.97ms   4.23ms   32.16ms  5.40ms   81.88ms
> >>  50 rules  3.00ms   5.30ms   4.84ms   33.49ms  5.79ms   83.20ms
> >> 100 rules  4.24ms   9.75ms   7.42ms   37.68ms  6.55ms   93.70ms
> >> 160 rules  5.50ms   16.89ms  12.18ms  51.53ms  17.45ms  155.40ms
> >>
> >> After this optimization:
> >>
> >>              null     read    write     stat    fstat      open
> >>   0 rules  1.81ms   2.84ms   2.42ms  27.70ms   4.15ms   69.10ms
> >>  10 rules  1.97ms   2.83ms   2.69ms  27.70ms   4.15ms   69.30ms
> >>  20 rules  1.72ms   2.91ms   2.41ms  26.49ms   3.91ms   71.19ms
> >>  30 rules  1.85ms   2.94ms   2.48ms  26.27ms   3.97ms   71.43ms
> >>  40 rules  1.88ms   2.94ms   2.78ms  26.85ms   4.08ms   69.79ms
> >>  50 rules  1.86ms   3.17ms   3.08ms  26.25ms   4.03ms   72.32ms
> >> 100 rules  1.84ms   3.00ms   2.81ms  26.25ms   3.98ms   70.25ms
> >> 160 rules  1.92ms   3.32ms   3.06ms  26.81ms   4.57ms   71.41ms
> >>
> >> As the result shown above, the syscall latencies increase as  the
> >> number  of rules increases, while with the patch the latencies remain =
stable.
> >>  This could help when a user adds many audit rules for purposes (such
> >> as  attack tracing or process behavior recording) but suffers from low
> >> performance.
> >
> >I have general concerns about trading memory and complexity for performa=
nce gains, but beyond that the numbers you posted above don't yet make sens=
e to me.
>
> Thanks for your reply.
>
> The memory cost of this patch is less than 4KB (1820 bytes on x64 and
>  3640 bytes on compatible x86_64) which is trivial in many cases.
>  Besides, syscalls are called frequently on a system so a small
>  optimization could bring a good income.

The tradeoff still exists, even though you feel it is worthwhile.

> >Why are the latency increases due to rule count not similar across the d=
ifferent syscalls? For example, I would think that if the increase in sysca=
ll latency was >directly attributed to the audit rule processing then the i=
ncrease on the "open" syscall should be similar to that of the "null" sysca=
ll.  In other phrasing, if we >can process 160 rules in ~4ms in the "null" =
case, why does it take us ~86ms in the "open" case?
>
> As to the test result, we did some investigations and concluded two
>  reasons:
> 1. The chosen rule sets were not very suitable. Though they were not hit
>  by syscalls being measured, some of them were hit by other processes,
>  which reduced the system performance and affected the test result;
> 2. The routine of lat_syscall is much more complicated than we thought. I=
t
>  called many other syscalls during the test, which may cause the result
>  not to be linear.
>
> Due to the reasons above, we did another test. We modified audit rule set=
s
>  and made sure they wouldn't be hit at runtime. Then, we added
>  ktime_get_real_ts64 to auditsc.c to record the time of executing
>  __audit_syscall_exit. We ran "stat" syscall 10000 times for each rule se=
t
>  and recorded the time interval. The result is shown below:
>
> Before this optimization:
>
> rule set          time
>   0 rules     3843.96ns
>   1 rules    13119.08ns
>  10 rules    14003.13ns
>  20 rules    15420.18ns
>  30 rules    17284.84ns
>  40 rules    19010.67ns
>  50 rules    21112.63ns
> 100 rules    25815.02ns
> 130 rules    29447.09ns
>
> After this optimization:
>
>  rule set          time
>   0 rules     3597.78ns
>   1 rules    13498.73ns
>  10 rules    13122.57ns
>  20 rules    12874.88ns
>  30 rules    14351.99ns
>  40 rules    14181.07ns
>  50 rules    13806.45ns
> 100 rules    13890.85ns
> 130 rules    14441.45ns
>
> As the result showed, the interval is linearly increased before
>  optimization while the interval remains stable after optimization. Note
>  that audit skips some operations if there are no rules, so there is a ga=
p
>  between 0 rule and 1 rule set.

It looks like a single rule like the one below could effectively
disable this optimization, is that correct?

  % auditctl -a exit,always -F uid=3D1001
  % auditctl -l
  -a always,exit -S all -F uid=3D1001

--
paul moore
www.paul-moore.com
