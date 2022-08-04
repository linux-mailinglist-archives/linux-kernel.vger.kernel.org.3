Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCD589A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiHDKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbiHDKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:00:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D96CD6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:00:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p8so18844350plq.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xEcIvnsbZUdlFBjyUR9fIf/N3w9Hl5PIUeXssxyl3nU=;
        b=BrmNKweclJGGnTyk8LTo2IlzmSWZIdEI3A5CI74mxEW5hGv3nV3kNpXiCMqPjDrM9b
         elTr+PgPu0j25KT+BXUvp1o8benxSLDUXBtAWzG+2fRCAyY0uFyHqo3eN1bduOoj0ZaE
         4RTS5BjxcmmgMa79sxR3ryi+J1JFiePAm0+dxYmygIOgoVoYPPrwS7IlACmqbomr439e
         Du4KVsmfunB0TBHvOMtxtdhhxlLnOtMl00RjUIRiSUsXfB1qQOcEfgs8+vVPFX1VZEeh
         puvzKZxHT5uBsG/m6o/PSxnZtCUo9twYE6PdxVaQrMENHai04FPDVBI2Rt7a/HQQsiAB
         OTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xEcIvnsbZUdlFBjyUR9fIf/N3w9Hl5PIUeXssxyl3nU=;
        b=GvSDDLDibkYI/g2fDYRy6pPM2Vs3sSRdeIytbgpRq7c8DGI3CiQ1Ya90ELVKgu3Zq7
         XJGW2N0oWB5z4FaN3A2Edrfo4LsIKLDOi6//oFC6ih2E0iHTZlbLQ1YtMQi4yPwglHXu
         KswaBMuUa2c+tJ+e4A1XnR+29oYs8ErwPjcEOIUsVkOCTpzC4umnbcZpOeRf9TTqdAXu
         OAKL19tBRqRYaqMKIuPiQf7aXNMEYlw1fs8oX6a5wTdoK2xcHFl2Dtoh10+PwGsJUDab
         wVjzGF9KskWprM8YnPXzNX209kEzhYfGQ1ob4EZFcNj/sXFCMoX/guisDn2jSjVYz6VD
         GPUQ==
X-Gm-Message-State: ACgBeo2/y30olafNu9XjW+vkxiNyMC+3SEx5WpmTe9OrfIu9LljhDui5
        t1nfwluPS40tA0eCoJTp3FCwGl0oHLYiEtdRFpQ=
X-Google-Smtp-Source: AA6agR6Zdj2hsmBo/hkifFtUIwMKR1IUkjwsS+vUGU5/tUea/PuIuiut51yMGLuy/91oGE8CBPjmJzLfUBYiLIG2hNg=
X-Received: by 2002:a17:902:c406:b0:16e:df76:5267 with SMTP id
 k6-20020a170902c40600b0016edf765267mr1204050plk.8.1659607211344; Thu, 04 Aug
 2022 03:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com> <8e7d75d4-613e-f35e-e932-323789666fb1@huawei.com>
 <4dde05be-8470-5984-0a30-ba077b9fe6bd@bytedance.com>
In-Reply-To: <4dde05be-8470-5984-0a30-ba077b9fe6bd@bytedance.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 4 Aug 2022 17:59:59 +0800
Message-ID: <CADjb_WQA7av8xCiUkTAHn2tQbGPeed1sMD=WWJ3DfCG-aRhKSA@mail.gmail.com>
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 3:11 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
>
> On 7/14/22 2:19 PM, Yicong Yang Wrote:
> > On 2022/7/12 16:20, Abel Wu wrote:
> >> When SIS_UTIL is enabled, SIS domain scan will be skipped if
> >> the LLC is overloaded. Since the overloaded status is checked
> >> in the load balancing at LLC level, the interval is llc_size
> >> miliseconds. The duration might be long enough to affect the
> >> overall system throughput if idle cores are out of reach in
> >> SIS domain scan.
> >>
> >> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> >> ---
> >>   kernel/sched/fair.c | 15 +++++++++------
> >>   1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index a78d2e3b9d49..cd758b3616bd 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>      struct sched_domain *this_sd;
> >>      u64 time = 0;
> >>
> >> -    this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> >> -    if (!this_sd)
> >> -            return -1;
> >> -
> >>      cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >>
> >> -    if (sched_feat(SIS_PROP) && !has_idle_core) {
> >> +    if (has_idle_core)
> >> +            goto scan;
> >> +
> >> +    if (sched_feat(SIS_PROP)) {
> >>              u64 avg_cost, avg_idle, span_avg;
> >>              unsigned long now = jiffies;
> >>
> >> +            this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> >> +            if (!this_sd)
> >> +                    return -1;
> >> +
> >
> > I don't follow the change here. True that this_sd is used only in SIS_PROP, but it seems irrelevant with your
> > commit. Does the position of this make any performance difference?
>
> No, this change doesn't make much difference to performance. Are
> you suggesting that I should make this a separate patch?
>
I took a look at this patch again before I start a OLTP test. I
thought the position change of
dereference sd_llc might not be closely connected with current change
as Yicong mentioned.
Besides, after moving the dereference inside SIS_PROP, we might do
cpumask_and() no matter whether
sd_llc is valid or not, which might be of extra cost?

thanks,
Chenyu

> Thanks,
> Abel
>
> >
> > Thanks.
> >
> >>              /*
> >>               * If we're busy, the assumption that the last idle period
> >>               * predicts the future is flawed; age away the remaining
> >> @@ -6436,7 +6439,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>                              return -1;
> >>              }
> >>      }
> >> -
> >> +scan:
> >>      for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>              if (has_idle_core) {
> >>                      i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>



-- 
Thanks,
Chenyu
