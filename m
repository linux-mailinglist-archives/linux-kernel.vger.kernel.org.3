Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705A589737
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiHDEzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiHDEz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:55:29 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9742A186C4;
        Wed,  3 Aug 2022 21:55:28 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-10ee900cce0so11151143fac.5;
        Wed, 03 Aug 2022 21:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5Znvp4bZBNpUhIR7zlvHoT8ljG2idXAwtie2scktUnw=;
        b=WR5w5EdOr9m9XdqAeJcFPrOogj8Q6wZCOe+H+6hX1QVdN3rDvB1BjRCgE6DViCXlBu
         xaNPv13xmwEQ137vXPTfAScwCdG2BXjavi6I8WiLLDhV0U3gYVumTsZJ4F0e98ly4eYn
         3Lp38RAUDtH8GvMp33LKcz0273i/e0iM5zdTz9Q0MpkcwXLFBSaEUxU7NmSnj5yD91ls
         CX4H+2XdSWtWWijYyfUpncTs046NRgZYLaBU0tOOGhgMHp03KHrc5kVlQBHs/LpEVmJU
         YSWv2giAc+olWmIt3Q2E+naZnqXauUoaEHrv0OOztQN5v/TVudVIdSrMgZMkdxJmJnNn
         1eqQ==
X-Gm-Message-State: ACgBeo25bV74qhmtWx0f5EX/t8+iAdF4SiIcVWY55tgadkkAIkiB1/Dm
        JuiSkMrlKMb4R/ilYOl3n1ynB8qONSOI/D8wKdI=
X-Google-Smtp-Source: AA6agR56bf6DsAPcQfTKWDVtk4OMqRDfhheUN4GoM7PSLn4Hftqb8Cj+UMkon2KfXE0ZsNFg4fmrW26XSL6KZe/m7+0=
X-Received: by 2002:a05:6870:a182:b0:10b:efbe:e65d with SMTP id
 a2-20020a056870a18200b0010befbee65dmr3496926oaf.5.1659588927936; Wed, 03 Aug
 2022 21:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220721043644.153718-1-namhyung@kernel.org> <YupFEkzCDxpFUyeD@gmail.com>
In-Reply-To: <YupFEkzCDxpFUyeD@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 3 Aug 2022 21:55:17 -0700
Message-ID: <CAM9d7cjhVwRhVTiJM6hX8Y75SGJhpwYgMtSc_9PB0tzysJjVgQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf lock: Add contention subcommand (v1)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Wed, Aug 3, 2022 at 2:51 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Namhyung Kim <namhyung@kernel.org> wrote:
>
> > Hello,
> >
> > It's to add a new subcommand 'contention' (shortly 'con') to perf lock.
> >
> > The new subcommand is to handle the new lock:contention_{begin,end}
> > tracepoints and shows lock type and caller address like below:
> >
> >   $ perf lock contention
> >    contended   total wait     max wait     avg wait         type   caller
> >
> >          238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
> >            1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
> >           81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
> >            2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
> >           24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
> >            2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
> >            6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
> >            1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
> >            3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c
> >    ...
>
> Wouldn't it also be useful to display a lock contention percentage value,
> the ratio of fastpath vs. contended/wait events?
>
> That's usually the first-approximation metric to see how contended
> different locks are, and the average wait time quantifies it.

Yeah, that'd be nice to have.  But it requires some action in the fast path
which I don't want because I'd like to use this in production.  So these
new tracepoints were added only in the slow path.

Instead, I think we can display the ratio of (total) contended time vs.
wall clock time.  What do you think?

Thanks,
Namhyung
