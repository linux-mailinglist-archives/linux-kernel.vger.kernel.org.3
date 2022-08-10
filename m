Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81B258ED77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiHJNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHJNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:37:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E9642CA;
        Wed, 10 Aug 2022 06:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BE29B81C11;
        Wed, 10 Aug 2022 13:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3E5C433D6;
        Wed, 10 Aug 2022 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660138655;
        bh=BCT9siJ0phFlpvN0VulM+8XMMYtLtAqqfNjnsK71SuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1gnsfxYkIRAlDn1A0U+6+kXrAKQYdKnfLBnu7T5hbxy+yK625eckli+X+7KiuCjf
         6BYgu2BW97ptwgF4zmqS/wr77JacLkRao4KPWUGN+aTm/sMe0B3QGmUOafqAOT9aQD
         9bH6yOcSshqKrcwoXmtGRH1RxSpMIZoLR/8H299hBAfyeQtE8mKWO1abHy95bsML0N
         Fkk18wHDhx+L3S3E4z6guw02aRCDZnQzqxERxb0Cv6dGpZ7ucHFdnGprph56ImEDwa
         5RHSMy1aAl4FGfnTvzQyNl35VWhor3i5ty4ltI24H5Hzc9sKw7TUhZ5GrACNgCErmu
         gCUAE4M2g/3Fg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E8044035A; Wed, 10 Aug 2022 10:37:32 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:37:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/17] perf c2c: Support data source and display for
 Arm64
Message-ID: <YvO0nAZ1znppjKjZ@kernel.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
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

Em Sat, Jun 04, 2022 at 12:28:03PM +0800, Leo Yan escreveu:
> Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> us to detect cache line contention and transfers.
> 
> This patch set includes Ali's patch set v9 "perf: arm-spe: Decode SPE
> source and use for perf c2c" [1] and rebased on the latest perf core
> banch with latest commit 1bcca2b1bd67 ("perf vendor events intel:
> Update metrics for Alderlake").
> 
> Patches 01-05 comes from Ali's patch set to support data source for Arm
> SPE for neoverse cores.

Leo, please remove touching the kernel perf_event.h on the first patch,
I see it doesn't affect the kernel right now as it is done just from
synthesizing perf records from hw trace data, and we haven't received
any review comment from Peter Zijlstra (I think he is in vacations).

Also please refresh it:

⬢[acme@toolbox perf]$        git am ./v5_20220604_leo_yan_perf_c2c_support_data_source_and_display_for_arm64.mbx
Applying: perf: Add SNOOP_PEER flag to perf mem data struct
Applying: perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Applying: perf mem: Print snoop peer flag
Applying: perf arm-spe: Don't set data source if it's not a memory operation
error: patch failed: tools/perf/util/arm-spe.c:387
error: tools/perf/util/arm-spe.c: patch does not apply
Patch failed at 0004 perf arm-spe: Don't set data source if it's not a memory operation
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf]$

- Arnaldo
 
> Patches 06-17 are patches from patch set v4 for support perf c2c peer
> display for Arm64 [2].
> 
> This patch set has been verified for both x86 perf memory events and Arm
> SPE events.
> 
> [1] https://lore.kernel.org/lkml/20220517020326.18580-1-alisaidi@amazon.com/
> [2] https://lore.kernel.org/lkml/20220530114036.3225544-1-leo.yan@linaro.org/
> 
> Changes from v4:
> * Included Ali's patch set for adding data source in Arm SPE samples;
> * Added Ian's ACK and Ali's review and test tags;
> * Update document for the default peer dispaly for Arm64 (Ali).
> 
> Changes from v3:
> * Changed to display remote and local peer accesses (Joe);
> * Fixed the usage info for display types (Joe);
> * Do not display HITM dimensions when use 'peer' display, and HITM
>   display doesn't show any 'peer' dimensions (James);
> * Split to smaller patches for adding dimensions of peer operations;
> * Updated documentation to reflect the latest GUI and stdio.
> 
> Changes from v2:
> * Updated patch 04 to account metrics for both cache level and ld_peer
>   for PEER flag;
> * Updated document for metric 'rmt_hit' which is accounted for all
>   remote accesses (include remote DRAM and any upward caches).
> 
> Changes from v1:
> * Updated patches 01, 02 and 03 to support 'N/A' metrics for store
>   operations, so can align with the patch set [1] for store samples.
> 
> 
> Ali Saidi (3):
>   perf: Add SNOOP_PEER flag to perf mem data struct
>   perf tools: sync addition of PERF_MEM_SNOOPX_PEER
>   perf arm-spe: Use SPE data source for neoverse cores
> 
> Leo Yan (14):
>   perf mem: Print snoop peer flag
>   perf arm-spe: Don't set data source if it's not a memory operation
>   perf mem: Add statistics for peer snooping
>   perf c2c: Output statistics for peer snooping
>   perf c2c: Add dimensions for peer load operations
>   perf c2c: Add dimensions of peer metrics for cache line view
>   perf c2c: Add mean dimensions for peer operations
>   perf c2c: Use explicit names for display macros
>   perf c2c: Rename dimension from 'percent_hitm' to
>     'percent_costly_snoop'
>   perf c2c: Refactor node header
>   perf c2c: Refactor display string
>   perf c2c: Sort on peer snooping for load operations
>   perf c2c: Use 'peer' as default display for Arm64
>   perf c2c: Update documentation for new display option 'peer'
> 
>  include/uapi/linux/perf_event.h               |   2 +-
>  tools/include/uapi/linux/perf_event.h         |   2 +-
>  tools/perf/Documentation/perf-c2c.txt         |  31 +-
>  tools/perf/builtin-c2c.c                      | 454 ++++++++++++++----
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 +
>  tools/perf/util/arm-spe.c                     | 140 +++++-
>  tools/perf/util/mem-events.c                  |  46 +-
>  tools/perf/util/mem-events.h                  |   3 +
>  9 files changed, 550 insertions(+), 141 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
