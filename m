Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434E4F4E56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588904AbiDFARr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387486AbiDEOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:32:16 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D815719
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:13:50 -0700 (PDT)
Received: from [192.168.137.80] (unknown [182.2.74.86])
        by gnuweeb.org (Postfix) with ESMTPSA id E4BB47E342;
        Tue,  5 Apr 2022 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1649164430;
        bh=byKY6UTz0fK6TWtlSIwQIIwJ8VY6Tz2PXZQNSc6FFwU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=qB9fXD5WlGBLJdi9FAcUvNx+Ou3+3qfnjcgD/3mYB9HWK/dVCRD7WzbNjjVWn6QEz
         pWq1umCtX/WFdk2IpK3S6P+oYfjCd4hJlDFEY1fgxeyLhJEZ7umI2rPaluveg/dokC
         eoG5noGnIYZ0JX1yVB45+Ont8l6x9d/SGFO0VMD9aqhKwYdyKefDbJLwfW+DFD/ILP
         fmQyW6Iyl6Xp66LL64kwBUJwZ93lWoVJrSx7/EXedy8WTwUPp9RlyG4lboi12Hn9Y6
         nmBDsvuUx6yR3Inx8i0sx87KlKgQ22fh56HhGddv5aigM2ptQfceZlfiMIpmEhezkk
         wrDIQQkcCg/Ow==
Message-ID: <675544de-3369-e26e-65ba-3b28fff5c126@gnuweeb.org>
Date:   Tue, 5 Apr 2022 20:13:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
 <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
In-Reply-To: <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 7:21 PM, Dietmar Eggemann wrote:
> Tried to recreate the issue but no success so far. I used you config
> file, clang-14 and a Xeon CPU E5-2690 v2 (2 sockets 40 CPUs) with 20
> two-level cgoupv1 taskgroups '/X/Y' with 'hackbench (10 groups, 40 fds)
> + idling' running in all '/X/Y/'.
> 
> What userspace are you running?

HP Laptop, Intel i7-1165G7, 8 CPUs, with 16 GB of RAM. Ubuntu 21.10. Just for
daily workstation. Compiling kernel, browsing and coding stuff.

> There seemed to be some pressure on your machine when it happened?

Yeah, might be, I don't fully remember the activity at the time it
happened, though.

>> <6>[13420.623334][    C7] perf: interrupt took too long (2530 > 2500),
>> lowering kernel.perf_event_max_sample_rate to 78900
> 
> Maybe you could split the SCHED_WARN_ON so we know which signal causes this?

OK, I will apply the diff on top of 5.18-rc1 and will start using it for daily
routine tomorrow morning. Let's see if I can hit this bug again. Will send an
update later...

Thank you.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..0d45e09e5bfc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3350,9 +3350,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq
> *cfs_rq)
>           * Make sure that rounding and/or propagation of PELT values never
>           * break this.
>           */
> -       SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> -                     cfs_rq->avg.util_avg ||
> -                     cfs_rq->avg.runnable_avg);
> +       SCHED_WARN_ON(cfs_rq->avg.load_avg);
> +       SCHED_WARN_ON(cfs_rq->avg.util_avg);
> +       SCHED_WARN_ON(cfs_rq->avg.runnable_avg);
> 
>          return true;
>   }
> 
> [...]


-- 
Ammar Faizi
