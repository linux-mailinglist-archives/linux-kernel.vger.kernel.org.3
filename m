Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09114D91CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbiCOAym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbiCOAyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:54:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1B56408
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:53:30 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id u10so34226469ybd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lt0v7qfbVpJojnUOhECKbKcm+J8TaXSARb8f4EqcGus=;
        b=NcJ6GT95IjwjOR7fg7I2dPoT6cEPdP1s+9cl39gfmvOwsEl2UnzXJarwaW1cc++OVX
         KHYLbpajhxSkWOJMf6E6thHYEY00b2jEfloVh68OtUQ6gNsSYcTSEoIBonYeALJjQVXr
         Nkb7EYO/A2YmRdwwwChRxUj5mR4zAwCyOe9SIXqYT9E5HkOQPJV4L2JUU1w/OKr+WPTG
         Gq63PI1Aor1xMWg/54p8qQHyMOIVl25kvZrKgCkh5WHuXBSAG2l9fMIhUG0Ga/xbPUn5
         gbz90cMjvnOwNBqsXiSQpP4veUZmlZNleYMN+BzxHLV2oEXAHy/H6JvbkWxHULOyHek6
         2ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lt0v7qfbVpJojnUOhECKbKcm+J8TaXSARb8f4EqcGus=;
        b=ZBhy3VPtu83S2O9HTmR6cpGdJuvd25hz99pnbePSeN5bd5M5pE3J7wwUfy6ZxGvynL
         d0XI+r/35jvJWbjIXgTaNbW7AFkozuMVct56I5Bt87frtKlBF3XP5cmL2LIHqivXgGfx
         QalYhHjSPxYMGCp866Lp9eFlmdMmVm05Sut6oj+QNYIp2bsP5ce7hE+9ulyRfscXSvfl
         a8qaR+NeIOl5cDckIw2ejZ7brBtQg6fAP3Rc+TsxaZnpV8HmM2rce4IXiE9iGNoCFa7c
         8YiLcZbYJJj9mEyQAVbjgGKaMizbu7omuITeFNTWD/K3VHRDPOQlnWie548NiahzCDzg
         3Cyg==
X-Gm-Message-State: AOAM530ajqCwRPQZQhK3oa6l05F260VBZLBSgovYxb2rQwL40hDmIiDW
        eiKf7KYiEshiOZLglEoxXizrCZv7nTcw6uo2W1cbZg==
X-Google-Smtp-Source: ABdhPJy0vYhjKSzdR0l5rAiUKL5fMH1KKdSvw6k6L3Ir0xxhcUJUvlYtieHxEMduFKB1QfoHPL7UYmdRKZTdH7/O4FU=
X-Received: by 2002:a25:c708:0:b0:628:d9f2:c0a6 with SMTP id
 w8-20020a25c708000000b00628d9f2c0a6mr22439300ybe.464.1647305609377; Mon, 14
 Mar 2022 17:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org> <20220311161406.23497-6-vincent.guittot@linaro.org>
In-Reply-To: <20220311161406.23497-6-vincent.guittot@linaro.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 14 Mar 2022 17:53:18 -0700
Message-ID: <CABk29Numf595wF6PiLd673TmFt6AV9qTEsWP7tSf2xPOKcGgLQ@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>, qperret@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>
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

Hi Vincent,

On Fri, Mar 11, 2022 at 8:21 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
[snip]
> +
> +static void check_preempt_from_idle(struct cfs_rq *cfs, struct sched_entity *se)
> +{
> +       struct sched_entity *next;
> +
> +       if (se->latency_weight <= 0)
> +               return;
> +
> +       if (cfs->nr_running <= 1)
> +               return;

I don't quite understand this nr_running check.

> +       /*
> +        * When waking from idle, we don't need to check to preempt at wakeup
> +        * the idle thread and don't set next buddy as a candidate for being
> +        * picked in priority.
> +        * In case of simultaneous wakeup from idle, the latency sensitive tasks
> +        * lost opportunity to preempt non sensitive tasks which woke up
> +        * simultaneously.
> +        */
> +
> +       if (cfs->next)
> +               next = cfs->next;
> +       else
> +               next = __pick_first_entity(cfs);
> +
> +       if (next && wakeup_preempt_entity(next, se) == 1)
> +               set_next_buddy(se);
> +}
> +

What's the motivation to do this with the next buddy vs using wakeup
entity placement to achieve a similar result? The latter would also
more generically work when we aren't transitioning from idle. It also
doesn't suffer from some slight weirdness here in the interaction with
core scheduling, where rq->curr can be idle despite the presence of
runnable tasks if the cpu is forced idle.
