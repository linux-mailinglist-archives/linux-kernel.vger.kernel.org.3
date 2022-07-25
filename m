Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D1580610
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiGYVBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGYVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:01:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFC22B2F;
        Mon, 25 Jul 2022 14:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14C07B8110C;
        Mon, 25 Jul 2022 21:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92177C341C6;
        Mon, 25 Jul 2022 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658782895;
        bh=kj3SxkVzlgx5vGfy5x9aBo/9/7AY1z7twe5Lujc5cV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dX7n5rodFHFTDGcU0ojkDlfq/6Kd3Df2z4bgjyCVILloHC2aBR5KXoSOl+vF3xI12
         aCsyXRyg0fHEARvF0vaPFPIb+V3yAYLzuiIB/6ubPAUpLu24w5OdoAQCT8Y0zvcaBY
         YDja6o1FIdHaJZ2frm/sEgJZj0cLsROEjgA9se89Hu3Qp0fjtzexko8lq0fM9/dEkX
         WS6b49GLscQyVbmogVG79jViQX/nofkqVCmycvXUI9b8sYxy2SdoL2YUL0b2mIXWJz
         fXBf575vy6wTVrPkn52IYSpOkoRe5L/sYj16EG06aG/8C6lmUMDiTGd5tpEUQ5kZyT
         rPJ64/X87SbzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC95940374; Mon, 25 Jul 2022 18:01:32 -0300 (-03)
Date:   Mon, 25 Jul 2022 18:01:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCHSET 0/5] perf lock: Add contention subcommand (v2)
Message-ID: <Yt8ErPFUtSoGfrzM@kernel.org>
References: <20220725183124.368304-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725183124.368304-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 25, 2022 at 11:31:19AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> It's to add a new subcommand 'contention' (shortly 'con') to perf lock.
> 
> Changes in v2)
> * bugfix is merged already
> * fix build error in patch 2
> 
> The new subcommand is to handle the new lock:contention_{begin,end}
> tracepoints and shows lock type and caller address like below:
> 
>   $ perf lock contention
>    contended   total wait     max wait     avg wait         type   caller
> 
>          238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
>            1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
>           81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
>            2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
>           24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
>            2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
>            6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
>            1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
>            3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c
>    ...
> 
> where rwsem:R stands for read access (down_read) for a rw-semaphore.
> Other types of lock access is obvious and it doesn't detect optimistic
> spinning on mutex yet.  This is just a base work for lock contention
> analysis and more will come later.
> 
> You can get this from 'perf/lock-subcmd-v2' branch on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks, applied locally, pushed to tmp.perf/core, will go to perf/core
after further automated tests.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (5):
>   perf lock: Add flags field in the lock_stat
>   perf lock: Add lock aggregation enum
>   perf lock: Add 'contention' subcommand
>   perf lock: Add -k and -F options to 'contention' subcommand
>   perf lock: Support -t option for 'contention' subcommand
> 
>  tools/perf/Documentation/perf-lock.txt |  23 +-
>  tools/perf/builtin-lock.c              | 401 +++++++++++++++++++++++--
>  2 files changed, 390 insertions(+), 34 deletions(-)
> 
> 
> base-commit: 9fe9b252c7c022df8e503435e778f15c04dfa3bf
> -- 
> 2.37.1.359.gd136c6c3e2-goog

-- 

- Arnaldo
