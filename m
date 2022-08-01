Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4C586B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiHAMod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiHAMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:44:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A3C43333;
        Mon,  1 Aug 2022 05:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC5F61154;
        Mon,  1 Aug 2022 12:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA35C433D6;
        Mon,  1 Aug 2022 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659356969;
        bh=wQPlnOBKLUu2iVhWWb5NoWsKOqr0w9KrM8psmRXpxWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPumKYa4Nnt/xfqIKRSrhMiJv69+aGMQcazBQMcHG3z/fh9BvG2sPDHzm/7OrcXHb
         txhsxGGQ/IZnxTF7lvSJdM3lG4MJvGOShsC6J1Rbn5C9zUt4N/ewBAQ7y0cvT4IpSQ
         vIPYBeTgsShJnDqfY5w41zEFyjF883G2lqaHXxOH2L7T6hQ5xG2PdGUqUFjkGxlWq1
         cCuedFsDTKlUsMy7IROD7iyo2u7qHDP7hpTBqyax4yofNEglw4rbuLR4v5FjMJUv+j
         cFcq8epYT6njDXTD9pmpoKypgblz00ICGQRkiWjhrbNqXRpMqJShB2ZaQ6UEhqVW61
         rE83RLJ5VydOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C973640736; Mon,  1 Aug 2022 09:29:26 -0300 (-03)
Date:   Mon, 1 Aug 2022 09:29:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Stephane Eranian <eranian@google.com>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 0/3] perf lock contention: Add BPF support (v1)
Message-ID: <YufHJpDvhsYg3btG@kernel.org>
References: <20220729200756.666106-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729200756.666106-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 29, 2022 at 01:07:53PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This patchset adds -b/--use-bpf option and others to use BPF to
> collect kernel lock contention stats.  With this option it doesn't
> require a separate `perf lock record` step.  Basic filtering on cpu
> (with -a or -C option) and on task (with -p and --tid option) is
> supported as usual.
> 
>   $ sudo perf lock con -a -b sleep 1
>      contended   total wait     max wait     avg wait         type   caller
> 
>             42    192.67 us     13.64 us      4.59 us     spinlock   queue_work_on+0x20
>             23     85.54 us     10.28 us      3.72 us     spinlock   worker_thread+0x14a
>              6     13.92 us      6.51 us      2.32 us        mutex   kernfs_iop_permission+0x30
>              3     11.59 us     10.04 us      3.86 us        mutex   kernfs_dop_revalidate+0x3c
>              1      7.52 us      7.52 us      7.52 us     spinlock   kthread+0x115
>              1      7.24 us      7.24 us      7.24 us     rwlock:W   sys_epoll_wait+0x148
>              2      7.08 us      3.99 us      3.54 us     spinlock   delayed_work_timer_fn+0x1b
>              1      6.41 us      6.41 us      6.41 us     spinlock   idle_balance+0xa06
>              2      2.50 us      1.83 us      1.25 us        mutex   kernfs_iop_lookup+0x2f
>              1      1.71 us      1.71 us      1.71 us        mutex   kernfs_iop_getattr+0x2c
> 
> It seems my system had some contentions on the workqueue spinlock and
> the kernfs mutex.
> 
> The code is available at perf/lock-bpf-v1 branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (3):
>   perf lock: Pass machine pointer to is_lock_function()
>   perf lock: Use BPF for lock contention analysis
>   perf lock: Implement cpu and task filters for BPF
> 
>  tools/perf/Documentation/perf-lock.txt        |  22 ++
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-lock.c                     | 226 ++++++++----------
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_lock_contention.c         | 181 ++++++++++++++
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 170 +++++++++++++
>  tools/perf/util/lock-contention.h             | 140 +++++++++++
>  7 files changed, 614 insertions(+), 128 deletions(-)
>  create mode 100644 tools/perf/util/bpf_lock_contention.c
>  create mode 100644 tools/perf/util/bpf_skel/lock_contention.bpf.c
>  create mode 100644 tools/perf/util/lock-contention.h
> 
> -- 
> 2.37.1.455.g008518b4e5-goog

-- 

- Arnaldo
