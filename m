Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D614EF817
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348772AbiDAQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350917AbiDAQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:38:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B5CB008
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:19:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o5so5932256ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTQ+8nHLfi+YFFcta17BAmF8ZCVZ9zcPvzKqqA+2KFY=;
        b=I000Q9g3yyVnGiV/P5M1/MzK+Q7YY6AXSWeK8NNLoUYuYWPabI8hMhI9mQMVE8cA9c
         Mr6UhaoThyFv7TiXcdgYKkJql8PV4S4DgjRRBlUDNdWyLKgZZhIFp3sbadQB6C3WUeQe
         lpPGU4yMCC0ndgjXvT3z07X+MiSe+EdTXnCfiE/6qnA2Vfyr3nHfvHlI5mW/E/HdDSPd
         3pli7viRfgbBQ1p7ZOcfji2N+G1q8XwTpoxOa4lN4smeoKJKF9dsDjMy4+qGD/DPLNNw
         CPDQJCLBxbp4+H8GZZ5Wd6uraHvEx9bHMjLgKNs67jU9f2PZSTbO3s8/QiAnzSXUpPKl
         yUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTQ+8nHLfi+YFFcta17BAmF8ZCVZ9zcPvzKqqA+2KFY=;
        b=jkW8u2xVvJPIrEYTR7xfDF8LlAwoLeGW787hhE3HxNN0Yl0iiD2XC0UcVeF5HIsGsD
         gDikYis6ffWkWRfNY1VI2S3aQohJWy2FMtt2N/l//LjJBwqMSB3M4wyzwpdQvVcCDrLo
         OGGmwQN0kkl4RBijMRu/L1envWUTazbwYJ+zB6xtarlFwyNH4yRHnbuEgTUOWrUO1nCd
         UE/PPmT5+SDw8ythISNxRVagmUtghArRWaBQagwLO6QgrZm3GuKMpm8/lPzPf/24vNFy
         QludEyigJV3l0b5qOHGqJhkiNPGGc12IHyqZE3S+yit0sUgdy+o6NbsH3dHYiccW2rSP
         WM9g==
X-Gm-Message-State: AOAM531owXLsHIBrOMjg/GgRSXnlHG9iuLBnxgZ/n8PaL+4vmT/X0Dkq
        +qM04sdFifIOyVIPOdIYK4j66QfTyG+KHHYqBNfrBQ==
X-Google-Smtp-Source: ABdhPJzFq8r+sFolA7YwP5uKAYxPzOaiimx3ijq5H/H+wf0ATiwefnMlyeMIAyplUeB4jTkjjdXm2AQ89wHytBhhGk8=
X-Received: by 2002:a25:e749:0:b0:633:93d4:4b66 with SMTP id
 e70-20020a25e749000000b0063393d44b66mr9271093ybh.553.1648829968227; Fri, 01
 Apr 2022 09:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com>
In-Reply-To: <1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 1 Apr 2022 09:19:17 -0700
Message-ID: <CAJuCfpH3mzLi4bhaLUYLDDXA6uVM5Pn67aXyPefseEsAYDatSA@mail.gmail.com>
Subject: Re: [PATCH] psi: Fix trigger being fired unexpectedly at initial
To:     Hailong Liu <liuhailong@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        aniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Mar 31, 2022 at 10:10 PM Hailong Liu
<liuhailong@linux.alibaba.com> wrote:
>
> When a trigger being created, its win.start_value and win.start_time are
> reset to zero. If group->total[PSI_POLL][t->state] has accumulated before,
> this trigger will be fired unexpectedly in the next period, even if its
> growth time does not reach its threshold.
>
> So set the window of the new trigger to the current state value.

Makes sense to me. Thanks!

>
> Signed-off-by: Hailong Liu <liuhailong@linux.alibaba.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a4fa3aadfcba..5a49a8c8783e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1117,7 +1117,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>         t->state = state;
>         t->threshold = threshold_us * NSEC_PER_USEC;
>         t->win.size = window_us * NSEC_PER_USEC;
> -       window_reset(&t->win, 0, 0, 0);
> +       window_reset(&t->win, sched_clock(),
> +                       group->total[PSI_POLL][t->state], 0);
>
>         t->event = 0;
>         t->last_event_time = 0;
> --
> 2.19.1.6.gb485710b
>
