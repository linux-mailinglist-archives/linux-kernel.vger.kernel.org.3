Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD3E4C0240
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiBVTrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiBVTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:47:39 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E2B1AA6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:47:13 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id w4so787579vsq.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OXelgpgEN6TKz3C8orHccpNYtVFASdQJguRZzrhCw4=;
        b=Xmb1/NVtOZZnlcQeIzmTv9K64XnBoxbqbhWtBF7HzEM5ReTl05OlN0NkhauKMalSnD
         aVKmB0bz0+Gm1d3Wc9HQB9+0NIvnz4G3jNeKcig1d+zYIAtoxhZ+Ag/E6GDdwghDQ2NH
         uikMNsfl5lxInO6zpZzoiOeCJirM2uoXoJ6p458HO1h8EsiscBZSdGH7J5BOrbC0USmI
         C7TO8fuKHE/u7veRNHsg7PHeFcKvCD6Kg56dj4YnoC74VeWPUoi+KkxFzPxedCLzpUBC
         0xFYUuklqWaXFGBGN6wbTYEnF6MVofR++Ux3oERR5TARRSgCfAZZ4CsLVRb+ceVle3dU
         oiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OXelgpgEN6TKz3C8orHccpNYtVFASdQJguRZzrhCw4=;
        b=L6Xc3SUZdCKLeUnQ4kDJDprQvLySQA6RSA09wDjcFv4JCffRK+klQZL2eKEITGDATM
         WC9dN344PhY4SaBplV5kRmkQb1O+/jivaBJt4zkwHkk8W3ipVK4fvzp1V4yCouwMN6CP
         05b7o3LaTCcZYj4Iacn10JTgWGF+P4CvYPUeydSjqH6pE5828+vrtlJzPnUSL2u3TrBR
         LeDMH9pjaZPTqLl/4mC2OnBQBcRxb/hjSZX3Z6X8UjlsUwj9M2s+A23wpZQwfn369Gor
         qpJY/QaZ0y3QWEmabK3GivoKHeolYblpUzlMlFOdWV4BobUs+xjCTVey1HYB/J8OTxQ6
         RbUA==
X-Gm-Message-State: AOAM531Qxm3TJE4VXySj7bDaU2LghYV/Q6i2iUpHq/8aaaLV/zrgABQh
        HM5lt5sAT3XZJ/1ZM6EQzqjj79ikq5ZyRxHDOFeQwA==
X-Google-Smtp-Source: ABdhPJwH/SrX147JAYYJi48lKdfjSxyT5HuUX4VE7s0KYkofb5VKBePz/iWrfaDrwwqN4/iKJbV9+yuG619W3E2t+ng=
X-Received: by 2002:a05:6102:53b:b0:31c:d:8d8b with SMTP id
 m27-20020a056102053b00b0031c000d8d8bmr8321517vsa.22.1645559232490; Tue, 22
 Feb 2022 11:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20220219174940.2570901-1-surenb@google.com> <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
In-Reply-To: <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
From:   Tim Murray <timmurray@google.com>
Date:   Tue, 22 Feb 2022 11:47:01 -0800
Message-ID: <CAEe=Sxmow-jx60cDjFMY7qi7+KVc+BT++BTdwC5+G9E=1soMmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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

On Mon, Feb 21, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
> It would be cool to have some numbers here.

Are there any numbers beyond what Suren mentioned that would be
useful? As one example, in a trace of a camera workload that I opened
at random to check for drain_local_pages stalls, I saw the kworker
that ran drain_local_pages stay at runnable for 68ms before getting
any CPU time. I could try to query our trace corpus to find more
examples, but they're not hard to find in individual traces already.

> If the draining is too slow and dependent on the current CPU/WQ
> contention then we should address that. The original intention was that
> having a dedicated WQ with WQ_MEM_RECLAIM would help to isolate the
> operation from the rest of WQ activity. Maybe we need to fine tune
> mm_percpu_wq. If that doesn't help then we should revise the WQ model
> and use something else. Memory reclaim shouldn't really get stuck behind
> other unrelated work.

In my experience, workqueues are easy to misuse and should be
approached with a lot of care. For many workloads, they work fine 99%+
of the time, but once you run into problems with scheduling delays for
that workqueue, the only option is to stop using workqueues. If you
have work that is system-initiated with minimal latency requirements
(eg, some driver heartbeat every so often, devfreq governors, things
like that), workqueues are great. If you have userspace-initiated work
that should respect priority (eg, GPU command buffer submission in the
critical path of UI) or latency-critical system-initiated work (eg,
display synchronization around panel refresh), workqueues are the
wrong choice because there is no RT capability. WQ_HIGHPRI has a minor
impact, but it won't solve the fundamental problem if the system is
under heavy enough load or if RT threads are involved. As Petr
mentioned, the best solution for those cases seems to be "convert the
workqueue to an RT kthread_worker." I've done that many times on many
different Android devices over the years for latency-critical work,
especially around GPU, display, and camera.

In the drain_local_pages case, I think it is triggered by userspace
work and should respect priority; I don't think a prio 50 RT task
should be blocked waiting on a prio 120 (or prio 100 if WQ_HIGHPRI)
kworker to be scheduled so it can run drain_local_pages. If that's a
reasonable claim, then I think moving drain_local_pages away from
workqueues is the best choice.
