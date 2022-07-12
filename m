Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061A571A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiGLM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiGLM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:57:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4344AC071;
        Tue, 12 Jul 2022 05:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED44B81868;
        Tue, 12 Jul 2022 12:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70A8C341CD;
        Tue, 12 Jul 2022 12:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657630657;
        bh=cW1C3A28y7M0Wa7SoYZtf30sJKBFXl9X73+ZlF8Vvt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUTSW/a1JicHdPlFQb9l3h71/9LnyigR59l49n/v7oBw2LeaxBY2ck+TU73EjTcsN
         pIDqblBd2L2CT2/ESo9U06JvrbnQ3VSrbu7sRMchdmQJHbabKRG3sRhv0x0IsOHJ8r
         yV/0n4mH4rwH0q0AjQxMSQYWG6EmM41NQ/StJpX41vizngigb6gjzLGULuzBn6I5Vg
         A5mNZYxpLG+HpnIfguVS2HWXDnALEcFE8TRH9TAF23mh/yDrw+vQxSGJ2nAjEUdEQ9
         wbZQWSpb0mZtAaAoEw0EOBoxiTLUf94PYLpDeWn9HJaqcigAefcHZ6RKzSn6eyfnXy
         95z5EU8Nh5g4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B13E40374; Tue, 12 Jul 2022 09:57:34 -0300 (-03)
Date:   Tue, 12 Jul 2022 09:57:34 -0300
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
Subject: Re: [PATCHSET 0/7] perf lock: New lock contention tracepoints
 support (v4)
Message-ID: <Ys1vvte9izUxDAO/@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 15, 2022 at 09:32:15AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> Kernel v5.19 will have a new set of tracepoints to track lock
> contentions for various lock types.  Unlike tracepoints in LOCKDEP and
> LOCK_STAT, it's hit only for contended locks and lock names are not
> available.  So it needs to collect stack traces and display the caller
> function instead.

Applied to tmp.perf/core, performing some further tests and then will
push to perf/core.

Thanks for you work on this!

- Arnaldo
 
> Changes in v4)
>  * add Acked-by from Ian
>  * more comments on trace_lock_handler
>  * don't create stats in the contention_end handler
>  
> Changes in v3)
>  * fix build error
>  * support data from different kernels/machines
>  * skip bad stat unless there's actual bad ones
>  
> Changes in v2)
>  * add Acked-by from Ian
>  * print time with a unit for compact output
>  * add some comments  (Ian)
>  * remove already applied patch
>  
> This patchset merely adds support for the new tracepoints to the
> existing perf lock commands.  So there's no change to the user.  Later
> I'll add new a sub-command dedicated to the tracepoints to make use of
> the additional information.
> 
> Example output:
> 
>   $ sudo perf lock record -a sleep 3
> 
>   $ perf lock report -F acquired,contended,avg_wait,wait_total
> 
>                   Name   acquired  contended     avg wait    total wait
> 
>    update_blocked_a...         40         40      3.61 us     144.45 us
>    kernfs_fop_open+...          5          5      3.64 us      18.18 us
>     _nohz_idle_balance          3          3      2.65 us       7.95 us
>    tick_do_update_j...          1          1      6.04 us       6.04 us
>     ep_scan_ready_list          1          1      3.93 us       3.93 us
>   ...
> 
> You can find the code in the 'perf/lock-contention-v4' branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (7):
>   perf lock: Print wait times with unit
>   perf lock: Allow to use different kernel symbols
>   perf lock: Skip print_bad_events() if nothing bad
>   perf lock: Add lock contention tracepoints record support
>   perf lock: Handle lock contention tracepoints
>   perf record: Allow to specify max stack depth of fp callchain
>   perf lock: Look up callchain for the contended locks
> 
>  tools/perf/Documentation/perf-lock.txt   |   7 +
>  tools/perf/Documentation/perf-record.txt |   5 +
>  tools/perf/builtin-lock.c                | 426 ++++++++++++++++++++++-
>  tools/perf/util/callchain.c              |  18 +-
>  4 files changed, 434 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
> -- 
> 2.36.1.476.g0c4daa206d-goog

-- 

- Arnaldo
