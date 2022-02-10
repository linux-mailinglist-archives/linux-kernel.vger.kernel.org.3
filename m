Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353894B154F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiBJSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:35:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiBJSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:35:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F86192
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:35:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACBE4B8250C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0310BC340EB;
        Thu, 10 Feb 2022 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644518103;
        bh=WgRDaKWAfHp62EhSRpyG96mSmkZMXuwQRlLHqLS1jYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grtMUOHsLFuCnier4WJ3LWpdZIhLbI2geCqFrSrGo0uMC0lvvgUEz5nxuRGxOnnvx
         09EHgFyO0hOjMAH9yt0rq+JvkysbWGoSVeB/d/iWu82URj23sNueMgEBkqvIXZ/SMY
         7oSEQxYZQS5MCS199sbw9SclU6GFNcFGL0FLumqCttYTP17LsjwQqw8ByMOkMead4s
         spNav8XH0ZVlOYPzcA9FghEY0EQ7KVrIjfn8oe1WDfCaC8++PNfSTv64iz2+4zUACs
         ZbRGU5I86jqWrIapVQAh2gutlud7KgrolZcY5ICiIatwms9kyai264vxbUUKveOfoF
         Z6EANKh0Yb01g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D984400FE; Thu, 10 Feb 2022 15:34:59 -0300 (-03)
Date:   Thu, 10 Feb 2022 15:34:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/4] Handle chroot tasks properly (v2)
Message-ID: <YgVa0/B7MUKRz88C@kernel.org>
References: <20220202070828.143303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202070828.143303-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 01, 2022 at 11:08:24PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> I found that perf tools don't work well with tasks in a chroot.  The
> filenames in MMAP record are from the root directory of the task so
> it's different than what it sees from outside.
> 
>  * changes in v2)
>   - add Jiri's Acked-by
>   - split stderr setup for objdump

Applied 1/4 to perf/urgent, its already upstream.

The others are bit big for this time, so I've added it to perf/core.

Thanks,

- Arnaldo
 
> I've tested it with a simple program (myprog - statically built) which
> just consumes cpu cycles in a loop for a while (default 1 sec, can by
> overridden by a command-line argument).
> 
>   # cd $HOME
>   # mkdir -p myroot/bin
>   # cp myprog myroot/bin
> 
>   # perf record chroot myroot myprog
>   # perf report -D | grep MMAP | grep myprog
>   2084916774977911 0xa2e4 [0x70]: PERF_RECORD_MMAP2 3363818/3363818: \
>   [0x401000(0x80000) @ 0x1000 fe:01 4346398 2543719070]: r-xp /bin/myprog
> 
> So it's reported as /bin/myprog and then it's unable to symbolize the
> samples.  It seems hard to fix it for the above use case as the record
> ended after the task exited.  It cannot know the root directory of the
> task anymore.  But we can fix it for real-time use cases like perf top
> or pipe-mode at least.
> 
> I tested it again with the following command.
> 
>   # perf record -o- chroot myroot myprog | perf report -i-
>   ...
>   #
>   # Overhead  Command  Shared Object      Symbol                          
>   # ........  .......  .................  ................................
>   #
>       46.02%  myprog   myprog             [.] 0x000000000000178a
>       36.71%  myprog   myprog             [.] 0x0000000000001792
>       17.12%  myprog   myprog             [.] 0x000000000000178e
>        0.05%  myprog   myprog             [.] 0x0000000000001796
>        0.05%  chroot   ld-2.33.so         [.] intel_check_word.constprop.0
> 
> The symbols are not resolved because it failed to load the symbol
> table as it didn't find the file in the given path.
> 
> So I modified the code to try a new name prepended with the task's
> root directory when it's not "/".  With this change, I can see the
> symbols of myprog.  In fact, it depends on timing if perf report hits
> the file before the task is gone.  Increasing the loop time to 3 sec
> helped it to get symbols reliably.
> 
>   # perf record -o- chroot myroot myprog 3 | perf report -i-
>   ...
>   #
>   # Overhead  Command  Shared Object      Symbol                       
>   # ........  .......  .................  .............................
>   #
>       99.83%  myprog   myprog             [.] loop
>        0.04%  chroot   [kernel.kallsyms]  [k] fxregs_fixup
>        0.04%  chroot   [kernel.kallsyms]  [k] rsm_load_seg_32
>        0.03%  chroot   [kernel.kallsyms]  [k] show_cpuinfo_cur_freq
>        0.01%  myprog   [kernel.kallsyms]  [k] alarmtimer_fired
> 
> 
> I also found that perf inject and perf annotate need the similar changes.
> 
> You can get it from 'perf/dso-chroot-v2' branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf annotate: Set error stream of objdump process for TUI
>   perf tools: Try chroot'ed filename when opening dso/symbol
>   perf inject: Try chroot directory when reading build-id
>   perf annotate: Try chroot filename for objdump
> 
>  tools/perf/builtin-inject.c | 10 ++++++++++
>  tools/perf/util/annotate.c  | 11 +++++++++++
>  tools/perf/util/dso.c       | 15 +++++++++++++--
>  tools/perf/util/dsos.c      | 13 +++++++++++++
>  tools/perf/util/symbol.c    | 10 ++++++++++
>  tools/perf/util/util.c      | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/util.h      |  2 ++
>  7 files changed, 90 insertions(+), 2 deletions(-)
> 
> 
> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> -- 
> 2.35.0.rc2.247.g8bbb082509-goog

-- 

- Arnaldo
