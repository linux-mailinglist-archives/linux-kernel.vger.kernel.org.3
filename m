Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD394B157D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbiBJSpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:45:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbiBJSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:45:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F3110C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B2860B1B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675DFC004E1;
        Thu, 10 Feb 2022 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644518716;
        bh=wvfEGrY0MHLRsAYRmJL2epSHtuP9v2yQKNUUlZ2QWnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSGtudvL5+88wbnfNvDeamZnOhxKVfQ67KI3gpoNEo9k/3dam2ZBqZ5p2FoB4FC7B
         VQ1K4BwpPRUegCb0pzUcLT3sleSZNg1aUvZHTOhFEk427HrGWRfV/kJ8JzdWxz/shQ
         GMSC7OwVShs6UcsFE+uOz6BYSOmyNe5TRtl9vJUcTVH/dHgb+YXcDBY7R9UWLzYT1g
         DuHJx/rFuRymRvY6ioRzrG/oi29eo0oAcDDhM2uyNhR16jXxKDzFrRu9WtKH3eyUFZ
         AzdCTISHV/ksm2TADunckUUP3N1OgOT5mfx03DZuf5tUdrX6rVoMOUTH3IN5qNNqI8
         YNJfy32FpZEKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00A6A400FE; Thu, 10 Feb 2022 15:45:13 -0300 (-03)
Date:   Thu, 10 Feb 2022 15:45:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/6] perf lock: Random updates for the locking
 analysis (v2)
Message-ID: <YgVdOe/cqX/a3LIl@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
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

Em Wed, Jan 26, 2022 at 04:00:44PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> I have some updates in the perf lock command (focused on 'report').
> The main change is to add -c (or --combine-locks) option to aggregate
> results based on lock class name.
> 
>  * changes from v1)
>   - rebased onto recent acme/perf/core
>   - add Jiri's Acked-by

Thanks, applied.

- Arnaldo

 
> Without this option, the result deals with lock addresses so instances
> in the same lock class will have separate entries like below:
> 
>   # perf lock report
>                   Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns) 
> 
>          rcu_read_lock     251225          0               0               0               0               0 
>    &(ei->i_block_re...       8731          0               0               0               0               0 
>    &sb->s_type->i_l...       8731          0               0               0               0               0 
>    hrtimer_bases.lo...       5261          0               0               0               0               0 
>    hrtimer_bases.lo...       2626          0               0               0               0               0 
>    hrtimer_bases.lo...       1953          0               0               0               0               0 
>    hrtimer_bases.lo...       1382          0               0               0               0               0 
>    cpu_hotplug_lock...       1350          0               0               0               0               0 
>    hrtimer_bases.lo...       1273          0               0               0               0               0 
>    hrtimer_bases.lo...       1269          0               0               0               0               0 
>    hrtimer_bases.lo...       1198          0               0               0               0               0 
>    hrtimer_bases.lo...       1116          0               0               0               0               0 
>            &base->lock       1109          0               0               0               0               0 
>    hrtimer_bases.lo...       1067          0               0               0               0               0 
>    hrtimer_bases.lo...       1052          0               0               0               0               0 
>    hrtimer_bases.lo...        957          0               0               0               0               0 
>    hrtimer_bases.lo...        948          0               0               0               0               0 
>           css_set_lock        791          0               0               0               0               0 
>    hrtimer_bases.lo...        752          0               0               0               0               0 
>    &lruvec->lru_loc...        747          5           11254           56272           18317            1412 
>    hrtimer_bases.lo...        738          0               0               0               0               0 
>    &newf->file_lock...        706         15            1025           15388            2279             618 
>    hrtimer_bases.lo...        702          0               0               0               0               0 
>    hrtimer_bases.lo...        694          0               0               0               0               0 
>   ...
> 
> With -c option, the hrtimer_bases.lock would be combined into a single
> entry.  Also note that the lock names are correctly displayed now.
> 
>   # perf lock report -c
>                   Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns) 
>   
>          rcu_read_lock     251225          0               0               0               0               0 
>     hrtimer_bases.lock      39449          0               0               0               0               0 
>    &sb->s_type->i_l...      10301          1             662             662             662             662 
>       ptlock_ptr(page)      10173          2             701            1402             760             642 
>    &(ei->i_block_re...       8732          0               0               0               0               0 
>            &base->lock       6705          0               0               0               0               0 
>            &p->pi_lock       5549          0               0               0               0               0 
>    &dentry->d_lockr...       5010          4            1274            5097            1844             789 
>              &ep->lock       2750          0               0               0               0               0 
>    &(__futex_data.q...       2331          0               0               0               0               0 
>                 (null)       1878          0               0               0               0               0 
>       cpu_hotplug_lock       1350          0               0               0               0               0 
>       &____s->seqcount       1349          0               0               0               0               0 
>       &newf->file_lock       1001         15            1025           15388            2279             618 
>   ...
> 
> Maybe we can make it default later (with a config and --no-combine-locks).
> 
> You can get it from 'perf/lock-combine-v2' branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (6):
>   perf lock: Convert lockhash_table to use hlist
>   perf lock: Change type of lock_stat->addr to u64
>   perf lock: Sort map info based on class name
>   perf lock: Fix lock name length check for printing
>   perf lock: Add -c/--combine-locks option
>   perf lock: Carefully combine lock stats for discarded entries
> 
>  tools/perf/Documentation/perf-lock.txt |   4 +
>  tools/perf/builtin-lock.c              | 155 +++++++++++++++++++------
>  2 files changed, 124 insertions(+), 35 deletions(-)
> 
> 
> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog

-- 

- Arnaldo
