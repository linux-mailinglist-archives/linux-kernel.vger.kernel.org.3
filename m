Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C9584443
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiG1Qfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiG1Qfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:35:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849B33E1B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:35:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 6so1919034pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=DGH/ADNWRj6r2yvM5lWVMtdH7AnTnLk1zsQLNxUiERs=;
        b=PlQMb3HOXrHmmUeK89x8IwSTx7cf8i+CJzpbg03OhvPvP//V5uEGqpH4EE6RJSt7aO
         qcm3JD9scJG7GL3mkbr0rquI2/nKivKICGR8rSfkC1O6lepdzsT9ojvUW/hz4mgNyGWD
         nf3G5zBto8zzl+bZBQG5DTocjbTPjhsvsgj1yv/1fvO6NHBSOsyg91vapH9ka5XRNYlx
         /rgyxkIQgV3xeA1T4dCz0KaThAv369sOLRUlZTKsochq5FpemdwkAvA1VTPEPG5+MOPt
         rVnpBPswwz3fGxkWRmuk6+uEn//BqRTa98hec7vVjcUfrwbwFMN65DItPq6x0plG7rXU
         TF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=DGH/ADNWRj6r2yvM5lWVMtdH7AnTnLk1zsQLNxUiERs=;
        b=BqTvKmnS7FjzXylOaEmT3OX48c1FhvTrVRqbmFDnSSuX1TJYMUhMbH63Lb5b64kMUl
         br/zg6+vmShvg0H7irQXRbfV22j4BhW/AiwzJ28I2zKxtmM2E0Lr8vu558rg1iT8F1VS
         EPxwBf06nWzhakzLiFZH0ZHPDiahZt6TzEp7/vFzzfS7ZA6hxKVjZ84kCZF0YAWceRoM
         +NtAHEjOCvpyaDob7LtlgEqt5jeLl/v1BkxjPSHNM7YNXC6tQQ6eTk1//v0e03ENtCXL
         UzTHZf/5cDi04/51S432TuBETpcLOrAmJ8pVrKV31dKiWpOco+L7oc6iLHOHBSya1wPk
         WSPQ==
X-Gm-Message-State: AJIora/RO+E3BUS/BcrM+LSngG3WLoNxBA+aZQ9F0wWKstUa39XskczY
        NoLbX51qMxqbC6PjJ5l3BavULVnzLlU=
X-Google-Smtp-Source: AGRyM1tVq/cZMXBGj2asAm8vKLZ0SV+5BwE3iTzrHQoKswFiZo0fGAEQk4xg+PcvPCQBw0m4J7Febg==
X-Received: by 2002:a05:6a00:1946:b0:52a:e551:2241 with SMTP id s6-20020a056a00194600b0052ae5512241mr26951731pfk.29.1659026129548;
        Thu, 28 Jul 2022 09:35:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a2a8200b001f3009a5ccfsm4028763pjd.54.2022.07.28.09.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:35:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 06:35:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending them
 to exit()
Message-ID: <YuK6zzmlFJ376UeD@slm.duckdns.org>
References: <20220727115327.2273547-1-vschneid@redhat.com>
 <20220727115327.2273547-2-vschneid@redhat.com>
 <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
 <xhsmhedy5ecdg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhedy5ecdg.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:54:19AM +0100, Valentin Schneider wrote:
> On 28/07/22 01:13, Lai Jiangshan wrote:
> > Quick review before going to sleep.
> >
> 
> Thanks!
> 
> > On Wed, Jul 27, 2022 at 7:54 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >> @@ -1806,8 +1806,10 @@ static void worker_enter_idle(struct worker *worker)
> >>         /* idle_list is LIFO */
> >>         list_add(&worker->entry, &pool->idle_list);
> >>
> >> -       if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
> >> -               mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
> >> +       if (too_many_workers(pool) && !delayed_work_pending(&pool->idle_reaper_work))
> >> +               mod_delayed_work(system_unbound_wq,
> >> +                                &pool->idle_reaper_work,
> >> +                                IDLE_WORKER_TIMEOUT);
> >
> > system_unbound_wq doesn't have a rescuer.
> >
> > A new workqueue with a rescuer needs to be created and used for
> > this purpose.
> >
> 
> Right, I think it makes sense for those work items to be attached to a
> WQ_MEM_RECLAIM workqueue. Should I add that as a workqueue-internal
> thing?

I don't understand why this would need MEM_RECLAIM when it isn't sitting in
the memory reclaim path. Nothing in mm side can wait on this.

> > Since WORKER_DIE is set, the worker can be possible freed now
> > if there is another source to wake it up.
> >
> 
> My understanding for having reap_worker() be "safe" to use outside of
> raw_spin_lock_irq(pool->lock) is that pool->idle_list is never accessed
> outside of the pool->lock, and wake_up_worker() only wakes a worker that
> is in that list. So with destroy_worker() detaching the worker from
> pool->idle_list under pool->lock, I'm not aware of a codepath other than
> reap_worker() that could wake it up.

There actually are spurious wakeups. We can't depend on there being no
wakeups than ours.

Thanks.

-- 
tejun
