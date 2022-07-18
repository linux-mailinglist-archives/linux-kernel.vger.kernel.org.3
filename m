Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE65577C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiGRHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:16:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CE11804
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:16:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id h62so19239146ybb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTgbojCl60puN/cEewYOxAr1hHsDequScTa2K7T5ZyM=;
        b=XkzeYNcRzpABXyXiaDj/XSL3DkKnblJpLdnnUHPNJ4QUgGyapkpkIa3KJvOioCX+S/
         IoD05JGqTb2VGCyN+Q2HPqTXINOElTCoeiOVztQcoMxvuIIIzku6VQVtvVcSs5Sbrny7
         OWpO77Ooa+Zaj3FqXyzMcWM940Yemtd2k/7fHDWBXH+39KqZ+vw7GSlGvr9tmu4GBbW+
         eBF3Ah2Gl0qg3Sx5HBCJ9v+cLMFZZ+86bBwSn2wJ6IgNwImUeLo2eAP2NWrAIAJqffMX
         IpMFR6yYrL/oQInlfhoDnpZ57Qpvjj+QbSYeC/aTt5JZjjd/5rJRvR18vTSSNT6SqkSa
         hO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTgbojCl60puN/cEewYOxAr1hHsDequScTa2K7T5ZyM=;
        b=LcTkgHwS12KHt/lrxFiiccm9b/LIXzbdsHnRR+mxA1UCPK5Ol2BgNDU8KKliJRMFzH
         YF9qmb/9/hqPwSkC1L2Nz47TwfMMoIT+w7zNpS8DeG2RIEVT6ZccQrMWD9IeSDasdiQy
         /0Y0f9TnmEx0xK9hOH6jwxBDCWrwzmhElvA0KRbJYalxRoDN7Q/2jY9ce6mhzas7HSGJ
         wmAns41xf4inxcauZmbK3XSTyBR0hLEoML5cOsrn4FCCNhJtQ+rcWhw6ar0fxPQXG0yN
         06/yxpVzWb60TvxrgMjcu5Btjvd1bNnh9p7alHmLBWuh6ngT2p+XLCLt18xjrDp4MtWO
         ml0Q==
X-Gm-Message-State: AJIora91sObJMK3/Vzvvxg2MHd3l0gavsNFOoG/sXT9YpDlD4D7Y+rec
        qQYB9DVJNxD3QIpTS2CvcJJLOSV6t3aJuXABpCviyg==
X-Google-Smtp-Source: AGRyM1vXDd9kub6MhF+ZlHXK1zUfZ9BpkhYPjv6xg3uCsDxdIr1DAtTkqNx3K+YB1lmfHV40hZJ9kbAxMo2QntWHy2o=
X-Received: by 2002:a25:2b03:0:b0:664:271f:924 with SMTP id
 r3-20020a252b03000000b00664271f0924mr26389896ybr.211.1658128585638; Mon, 18
 Jul 2022 00:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com> <20220713040430.25778-4-zhouchengming@bytedance.com>
In-Reply-To: <20220713040430.25778-4-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Jul 2022 09:16:13 +0200
Message-ID: <CAKfTPtAM1u5dA9+tfEipFUXFVB5xU+5cK4SBwN9rvQzSuRHn+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] sched/fair: maintain task se depth in set_task_rq()
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

On Wed, 13 Jul 2022 at 06:04, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Previously we only maintain task se depth in task_move_group_fair(),
> if a !fair task change task group, its se depth will not be updated,
> so commit eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")
> fix the problem by updating se depth in switched_to_fair() too.
>
> This patch move task se depth maintainence to set_task_rq(), which will be
> called when CPU/cgroup change, so its depth will always be correct.
>
> This patch is preparation for the next patch.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c  | 8 --------
>  kernel/sched/sched.h | 1 +
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2a3e12ead144..bf595b622656 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11539,14 +11539,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -       /*
> -        * Since the real-depth could have been changed (only FAIR
> -        * class maintain depth value), reset depth properly.
> -        */
> -       se->depth = se->parent ? se->parent->depth + 1 : 0;
> -#endif
> -
>         /* Synchronize entity with its cfs_rq */
>         update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>         attach_entity_load_avg(cfs_rq, se);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index aad7f5ee9666..8cc3eb7b86cd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1940,6 +1940,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>         set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
>         p->se.cfs_rq = tg->cfs_rq[cpu];
>         p->se.parent = tg->se[cpu];
> +       p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
>  #endif
>
>  #ifdef CONFIG_RT_GROUP_SCHED
> --
> 2.36.1
>
