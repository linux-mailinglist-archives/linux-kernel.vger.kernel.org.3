Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370CD579F73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiGSNUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbiGSNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:18:59 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D59A56D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:36:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31d85f82f0bso138860147b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCfJFx5+9t7zwmktNvgA730bgIszZnZzMDdjmo+tKe4=;
        b=XGtY3fC1OreQwQb/nbMxhpoHrZhi2980v2hp3hP4LBFvGctv+oU78/TWXaL5jmo0MR
         CplxLA/97OiTTlnBPatb1GNdfZ75QEPR6OTCo/+oey6SI1wuJ9o/uwPVx9kNao2xg8Xq
         wG1l+h0sGCXeFNHV2orMKX65/Z+88bBk13NS/0QPEp+sJGWakL2PW/Y0G1Vpcmkve1zP
         SBuW4R0LqHS8swphj9QIvbDs2IYfuAKEjcQlxg6Zjr1AaokTiCGlpuIHrbUWkXT9lzHG
         moPzSO6hOziQ1aZg2E72iT+uxz8rW/0BRWd5dilo9Icad8EZmsd6wyFauJdH10taU7hk
         14IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCfJFx5+9t7zwmktNvgA730bgIszZnZzMDdjmo+tKe4=;
        b=WTF+OwnCxFVHA6tdnjFibRpIoStpaXcqU1RDseaeg0OUZpU1hMwccMvaMNiEwEzrDI
         SNDLBpJ7eVU/e4A3qKuzlcSCnPqRXCyrr9yeUfiDrTOAUAJiDjX/miU7X7TTUIwb6ZHL
         /8I0fA/Am3sVXve7RLBbWeWjQ6jWRb1g9TG5gMppOM1vv5Rav9CEi2iySdMJdzw1R2xM
         ao+CTqh4HOYJUItMKct6RH+e5A/QXutfooXVvANdM2Zpy/VbroWCN4v5TrOozyp73J/E
         yoD4nnYr/9BL8MDePyFfk9IDulomNFtPL5eJ+OWnl397B3U3MK2d14T0ZyrFD305+qyU
         u5xQ==
X-Gm-Message-State: AJIora846cxSJI5Z/V0DEnpWkQ9u3WIaP4ssnWtV3BusvZzPCgu5OtEr
        D0sNzIyKMVdp1muVOdyNfJX5zeTtdGz8el3glMCi6A==
X-Google-Smtp-Source: AGRyM1tsAUi462ws43U4jFzQFzoO8VmAHR0wxvdWNantg2j+gMp93WcTt/n2oduNUu++hQBB9cNFVSC6ZwYi/9k1H9Y=
X-Received: by 2002:a81:4319:0:b0:31d:92c4:9e5f with SMTP id
 q25-20020a814319000000b0031d92c49e5fmr35477297ywa.359.1658234165366; Tue, 19
 Jul 2022 05:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com> <20220713040430.25778-9-zhouchengming@bytedance.com>
In-Reply-To: <20220713040430.25778-9-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jul 2022 14:35:53 +0200
Message-ID: <CAKfTPtB7BNBG_VTxKfHrb40MzMcnZHsVau7mp8EJev7M=9JHzQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] sched/fair: fix load tracking for new forked
 !fair task
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 06:05, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> New forked !fair task will set its sched_avg last_update_time to
> the pelt_clock of cfs_rq, after a while in switched_to_fair():
>
> switched_to_fair
>   attach_task_cfs_rq
>     attach_entity_cfs_rq
>       update_load_avg
>         __update_load_avg_se(now, cfs_rq, se)
>
> the delta (now - sa->last_update_time) will contribute/decay sched_avg
> depends on the task running/runnable status at that time.
>
> This patch don't set sched_avg last_update_time of new forked !fair
> task, leave it to 0. So later in update_load_avg(), we don't need to
> contribute/decay the wrong delta (now - sa->last_update_time).

As mentioned in patch 7, I think it's wrong to not decay the init
value of !fair task because they become obsolete if not used quickly
(so we are decaying them)

It would be better to not set them at all in the case of !fair task

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 51fc20c161a3..50f65a2ede32 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -849,22 +849,8 @@ void post_init_entity_util_avg(struct task_struct *p)
>
>         sa->runnable_avg = sa->util_avg;
>
> -       if (p->sched_class != &fair_sched_class) {
> -               /*
> -                * For !fair tasks do:
> -                *
> -               update_cfs_rq_load_avg(now, cfs_rq);
> -               attach_entity_load_avg(cfs_rq, se);
> -               switched_from_fair(rq, p);
> -                *
> -                * such that the next switched_to_fair() has the
> -                * expected state.
> -                */
> -               se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
> -               return;
> -       }
> -
> -       attach_entity_cfs_rq(se);
> +       if (p->sched_class == &fair_sched_class)
> +               attach_entity_cfs_rq(se);
>  }
>
>  #else /* !CONFIG_SMP */
> --
> 2.36.1
>
