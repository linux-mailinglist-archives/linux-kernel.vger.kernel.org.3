Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0355F27C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiF2AlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF2AlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:41:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607E1117E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:41:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so7738744wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sH5nJRSOe0Tkz3VwqFx1wGFGxKHppF/1AKWNqQwJXXQ=;
        b=RgCpcrqhGtAhBQ2W2wz/07D8yS95WPCbLdxpPRfyKXiRmG63r+DQZ4BnFDpAzK632q
         RUyerbjqSxwwsvwMm0XuT8A+z02v9zSMGZB0HnHk8vw7yuCC3u5bUJEbgJ+Dc2LvB6RT
         HI2KwLCblfUabMbNYT+0wCHnefiiFi3m/l0RCFalOH6KtjFusu+3GJhO9P/T1wOBLwy5
         pVkQyjYBOpFXP6K7Fg+tsq72i1jL9HLxpniSHYe1c/J2bvjlk0kXSgQ+Olpi2FxAPXVk
         DjoalwOJaAGCjXV//R5MhGuX1OFljc2/G6begpzkfDLoWmUKjtch8xh4Q56GWUIhz5Oo
         8KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sH5nJRSOe0Tkz3VwqFx1wGFGxKHppF/1AKWNqQwJXXQ=;
        b=a6SS0JI7+xBTPsgHJcodsdoF5xU/zhErR7Pl53AFRqScuYBRHkAFu3TOFFxgVpWDTQ
         /XGjFpiXSYDm96pRkMUnS6EQY7U+CKzuHdU+Ueb616OGcExy7vmBm79esoiUA3mG6WjW
         Y8q9zTF3iOCRz6UUosMsTs2EaNGruaRdipa8kceYNdRU3Zrxc0R6xHzvlEZHSmDNd14d
         6gCJcTfqZn1GIPwesikvPFFVIR7/Obl298wMIBaaimdsnvKqNKWuFE0/J+Qhe/6748lF
         B0KpAvyObVZV9d3AcY5dC86KR1SAvtIR9MjsyENrV/ONttu/sASylqRqKGAfA27R5afT
         VC0w==
X-Gm-Message-State: AJIora+rgQA2ydVzGStb1rzN4VRNwJ6yPBpCsscxlnBRFzY5aS5Nh6O4
        CmL+YYGBuL6ufwDCQq+tSN6v3qaQTBg61L7ggo/FJg==
X-Google-Smtp-Source: AGRyM1vJswSIV69z/d1ZBxbXRNnE8acBsFQnx7GZfIc5L7OHOf/2LcjPS4FZC9SGjMGHu1AxcJQmeXoVp8CDSg22EYo=
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr587702wms.57.1656463278307; Tue, 28 Jun
 2022 17:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-5-wuyun.abel@bytedance.com> <CABk29NuXvCTkbQ=MdX5F+YswhOAPZSAQTAXn7B_uuKRr4=XVnQ@mail.gmail.com>
 <73ab0143-b518-c0b5-328e-c8f3ec7013ed@bytedance.com>
In-Reply-To: <73ab0143-b518-c0b5-328e-c8f3ec7013ed@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 28 Jun 2022 17:41:06 -0700
Message-ID: <CABk29Ns8C6iQJHkJNAhNOm2=CVjApicK5Y5teUSMjb2ncEx4_w@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] sched/fair: remove useless check in select_idle_core
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Jun 27, 2022 at 8:51 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
>
> On 6/28/22 7:42 AM, Josh Don Wrote:
> > On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>
> >> The function only gets called when sds->has_idle_cores is true which can
> >> be possible only when sched_smt_present is enabled.
> >>
> >> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> >> ---
> >>   kernel/sched/fair.c | 3 ---
> >>   1 file changed, 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index aba1dad19574..1cc86e76e38e 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6256,9 +6256,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> >>          bool idle = true;
> >>          int cpu;
> >>
> >> -       if (!static_branch_likely(&sched_smt_present))
> >> -               return __select_idle_cpu(core, p);
> >> -
> >
> > The static branch is basically free; although you're right that we
> > currently don't take !smt_present branch direction here, it doesn't
> > seem harmful to leave this check in case assumptions change about when
> > we call select_idle_core().
>
> I was thinking that it would be better to align with select_idle_smt
> that the caller do the check if necessary.

The difference there though is that select_idle_smt() is called
directly under the sched_smt_active() check, whereas the
select_idle_core() is a few nested function calls away (and relies on
has_idle_core rather than sched_smt_active() directly). So it is a bit
harder to codify this expectation. Since we're using a static_branch
here, I don't see a strong reason to remove it.

> >
> >>          for_each_cpu(cpu, cpu_smt_mask(core)) {
> >>                  if (!available_idle_cpu(cpu)) {
> >>                          idle = false;
> >> --
> >> 2.31.1
> >>
