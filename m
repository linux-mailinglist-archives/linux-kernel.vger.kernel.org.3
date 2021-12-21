Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B027E47C4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLUREt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:04:49 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:33719 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLUREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:04:48 -0500
Received: by mail-qk1-f171.google.com with SMTP id de30so13240734qkb.0;
        Tue, 21 Dec 2021 09:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkeG2f5bWgJA7egEwWasqjCslzwydExHXWSA5u3OJ+c=;
        b=d6IT+Wr5YxKA6a96bC+Nkkqqtj5L9El49aHRAZNGyBaRl89Zzq3pbz9sdZzJSXQtSZ
         ZTtPKjRnifu24YCNM0qMPgL8PV06hrTYpmUWoRuyBDYtJUuzc4TB4zVWqA/YeKBa/zyp
         tE5X3SEtBapKGiQrJ7sZO7EB0twXz2gocP/VcBirYTSAEm3GIQGuagTvZ/zB919uvLT+
         TlS3kYEjBTrCszOUOTXBOB+1ygtblweGcodPWNM8EidOJxJJ4N5wH+E6QX8AqOkutEx0
         cxbfPIuqKNn6TSRpUTQcSNiXQl1QS/hioSxrFQ0N2oMiYyCVCn6H5D8gID6zYXAoKL+c
         yO7w==
X-Gm-Message-State: AOAM532TuGs7Eyr/gDXqKX9uvBBlo2oS0bCUzblRsY73yLju/pzG/iqM
        5/yRMetsRYs7of7gjAj0ZjpAi8PKJezskCpwt4th7D0F
X-Google-Smtp-Source: ABdhPJxAr1sXeGBqk5l8MAq3FGSsFjT5AwOQwnZE9tGzZ8TIYcKrcmP/2uN5PEkwLgM6ks+m5xWs/eWrdcgOf5OFcrA=
X-Received: by 2002:a37:b182:: with SMTP id a124mr2726436qkf.135.1640106287644;
 Tue, 21 Dec 2021 09:04:47 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien> <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
In-Reply-To: <87wnk0s0tf.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Dec 2021 18:04:36 +0100
Message-ID: <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 11:10 PM Francisco Jerez <currojerez@riseup.net> wrote:
>
> Julia Lawall <julia.lawall@inria.fr> writes:
>
> > On Sat, 18 Dec 2021, Francisco Jerez wrote:

[cut]

> > I did some experiements with forcing different frequencies.  I haven't
> > finished processing the results, but I notice that as the frequency goes
> > up, the utilization (specifically the value of
> > map_util_perf(sg_cpu->util) at the point of the call to
> > cpufreq_driver_adjust_perf in sugov_update_single_perf) goes up as well.
> > Is this expected?
> >
>
> Actually, it *is* expected based on our previous hypothesis that these
> workloads are largely latency-bound: In cases where a given burst of CPU
> work is not parallelizable with any other tasks the thread needs to
> complete subsequently, its overall runtime will decrease monotonically
> with increasing frequency, therefore the number of instructions executed
> per unit of time will increase monotonically with increasing frequency,
> and with it its frequency-invariant utilization.

But shouldn't these two effects cancel each other if the
frequency-invariance mechanism works well?
