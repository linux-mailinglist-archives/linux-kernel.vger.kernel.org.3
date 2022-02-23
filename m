Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C714C05CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiBWAPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBWAPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:15:44 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BB4A90C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:15:15 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p19so44622288ybc.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgvgyHG6Euxw7Jq3yMjqlRWxbggEShS+kdasxbz+u3Y=;
        b=gv9BIVVLkzCaJM9XhQMB7O7ZEuMTkylj1mOJtX6VvNBW86PfYskXe3jmdpUrgrdTFg
         e5QkJUnYhyoovcF/cQlx1gczJZr6km72uAMK2KIcPe3vC/tQjRSme4pDHJqk90zkOJJk
         4qxxUg/gCnFyhzbfxG7xY7dCuM4RwNyIjWB8ZXFuZjJx6ZPkc2NddydyKZSh2nEYWrqB
         XdKPf12u4paUnazNuwgemJILjdmpDIxY6357Oi0kgxnvR8FMOQHWFU/g2IvTG35r/W+z
         CBXmxmyXZw1EiS7tZ1SFnaOf5SGYeL/yxiABa0L0XaxPnfXUvPGg+Fx0x1WvnEUFHu2c
         q6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgvgyHG6Euxw7Jq3yMjqlRWxbggEShS+kdasxbz+u3Y=;
        b=0j8CO2NfNe4k6LZJuY1M/QmYA3EdAy0Ldr/O0VHVFUrzWcAKxn/410nbErT11DmLpA
         hjkcjFmyXT8wpJjZyNRx1yoOqGqndb2jnPydV3JBEyTrkSCN8o3+VZZvEuzrsVFUm5ZT
         tJmDdxJkRP3CyyMCsOGD4xAPIPjl+Eiozp6yemclpNleFh8sJaasKphYQ2mZCo1lsHo9
         W4y7Pkbq3b0VTxeuwosnLotH3qPZ1oalc/Iw+amtVMAkMPA2YDVA2mDV71aF6/OKK6iK
         llmATWK0nWH41cNhevrJUxYspKye+F3qWKriyk4x2abSoReC9p60x/0ekge3ugsCK3dg
         Pt7A==
X-Gm-Message-State: AOAM531YNN7HZ2gdmIG3EkjLwi0n4LRV2z4vKftxv4oPbIaMggfvxDrh
        4tqscBq+BaRfqS+DU6hO18nthJnFx4JJ3bdR7+pP/fzoXPkvPZB+
X-Google-Smtp-Source: ABdhPJxp0SxLcYYvmNL3AKcc4CDie00Qb1dbzY5fAvWnY4412DtSCTFOxi1Zxcq3jSi3a4zsDLAvEAH1dDGFowtzAVc=
X-Received: by 2002:a25:da47:0:b0:61d:9af4:c834 with SMTP id
 n68-20020a25da47000000b0061d9af4c834mr26488243ybf.441.1645575314006; Tue, 22
 Feb 2022 16:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
 <CAEe=Sxmow-jx60cDjFMY7qi7+KVc+BT++BTdwC5+G9E=1soMmQ@mail.gmail.com>
In-Reply-To: <CAEe=Sxmow-jx60cDjFMY7qi7+KVc+BT++BTdwC5+G9E=1soMmQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Feb 2022 16:15:03 -0800
Message-ID: <CAJuCfpEMr8+i99L23J3tjKq9LHAPTDa3JtNnUre587HaWcNS5w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Tim Murray <timmurray@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
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

On Tue, Feb 22, 2022 at 11:47 AM Tim Murray <timmurray@google.com> wrote:
>
> On Mon, Feb 21, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
> > It would be cool to have some numbers here.
>
> Are there any numbers beyond what Suren mentioned that would be
> useful? As one example, in a trace of a camera workload that I opened
> at random to check for drain_local_pages stalls, I saw the kworker
> that ran drain_local_pages stay at runnable for 68ms before getting
> any CPU time. I could try to query our trace corpus to find more
> examples, but they're not hard to find in individual traces already.
>
> > If the draining is too slow and dependent on the current CPU/WQ
> > contention then we should address that. The original intention was that
> > having a dedicated WQ with WQ_MEM_RECLAIM would help to isolate the
> > operation from the rest of WQ activity. Maybe we need to fine tune
> > mm_percpu_wq. If that doesn't help then we should revise the WQ model
> > and use something else. Memory reclaim shouldn't really get stuck behind
> > other unrelated work.
>
> In my experience, workqueues are easy to misuse and should be
> approached with a lot of care. For many workloads, they work fine 99%+
> of the time, but once you run into problems with scheduling delays for
> that workqueue, the only option is to stop using workqueues. If you
> have work that is system-initiated with minimal latency requirements
> (eg, some driver heartbeat every so often, devfreq governors, things
> like that), workqueues are great. If you have userspace-initiated work
> that should respect priority (eg, GPU command buffer submission in the
> critical path of UI) or latency-critical system-initiated work (eg,
> display synchronization around panel refresh), workqueues are the
> wrong choice because there is no RT capability. WQ_HIGHPRI has a minor
> impact, but it won't solve the fundamental problem if the system is
> under heavy enough load or if RT threads are involved. As Petr
> mentioned, the best solution for those cases seems to be "convert the
> workqueue to an RT kthread_worker." I've done that many times on many
> different Android devices over the years for latency-critical work,
> especially around GPU, display, and camera.
>
> In the drain_local_pages case, I think it is triggered by userspace
> work and should respect priority; I don't think a prio 50 RT task
> should be blocked waiting on a prio 120 (or prio 100 if WQ_HIGHPRI)
> kworker to be scheduled so it can run drain_local_pages. If that's a
> reasonable claim, then I think moving drain_local_pages away from
> workqueues is the best choice.

Ok, sounds like I should not spend time on WQ_HIGHPRI and go directly
to kthread_create_worker_on_cpu approach suggested by Petr.
