Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D205908B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiHKWZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiHKWZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63FD90C79;
        Thu, 11 Aug 2022 15:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 235516153E;
        Thu, 11 Aug 2022 22:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3928EC433D6;
        Thu, 11 Aug 2022 22:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660256738;
        bh=Ju5fw6M4oF7Kaa6Ojd7ycLcKYwPg9N5EWmJlDUgLLYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+yLRJDgrq2OPVuDKo41fFXEwx/yrwkjyCPnh1GM16+Aq8llcjOYjexEbC1IBw+RI
         rKYZQ+Rh49gpCWt/BYC8WqfbNmLQjZRwHqUNAPR5T0Wcru8rNsPQkdjGMs4IIH/wYZ
         Cn4x35fAswbCXuz+YwJ6UyppE9stwdnHVftuso3B4/ZkNEkNIMT8PZaWanML0175b7
         X6wXYtOpUQRZCNiW3ZIl7q7SfWhmzwwpVTPZg7YaNqA4GpPTa/G3Lnuw2oiFJpPuMw
         MwLrcfRlAtBfME9YlCejK7St3I3YTV0pm+cZrdKiNCqfg0KOWJ12WVdsBR/rATi7qf
         nxMlBJd37w11Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1FE94035A; Thu, 11 Aug 2022 19:25:35 -0300 (-03)
Date:   Thu, 11 Aug 2022 19:25:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/15] perf c2c: Support data source and display for
 Arm64
Message-ID: <YvWB32rTsOHirOb4@kernel.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
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

Em Thu, Aug 11, 2022 at 02:24:36PM +0800, Leo Yan escreveu:
> Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> us to detect cache line contention and transfers.
> 
> This patch set has been rebased on the acme/perf/core branch with the latest
> commit b39c9e1b101d ("perf machine: Fix missing free of
> machine->kallsyms_filename").
> 
> To make building success, a compilation fixing commit [1] has been sent
> to LKML, this patch set is dependent on it.  This patch set has been verified
> for both x86 perf memory events and Arm SPE events.
> 
> [1] https://lore.kernel.org/lkml/20220811044341.426796-1-leo.yan@linaro.org/

So, I tentatively applied this set after applying the patch for
<asm/sysreg.h>, and its all now out in tmp.perf/core in my git tree,
please check.

I'm doing the usual set of container build tests, but any additional
checking, including on the committer note I added to the first patch in
this series, claryfing it is not really a "sync" with the kernel
headers, is more than welcome.

- Arnaldo
 
> Changes from v5:
> * Removed the patch "perf: Add SNOOP_PEER flag to perf mem data struct"
>   (Arnaldo);
> * Removed the patch "perf arm-spe: Don't set data source if it's not a
>   memory operation" which has been merged in the mainline kernel, so can
>   dismiss merging conflict.
> * Rebased on the latest acme perf/core branch, no any code change
>   compared to previous version.
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
> 
> Ali Saidi (2):
>   perf tools: sync addition of PERF_MEM_SNOOPX_PEER
>   perf arm-spe: Use SPE data source for neoverse cores
> 
> Leo Yan (13):
>   perf mem: Print snoop peer flag
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
>  tools/include/uapi/linux/perf_event.h         |   2 +-
>  tools/perf/Documentation/perf-c2c.txt         |  31 +-
>  tools/perf/builtin-c2c.c                      | 454 ++++++++++++++----
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 +
>  tools/perf/util/arm-spe.c                     | 130 ++++-
>  tools/perf/util/mem-events.c                  |  46 +-
>  tools/perf/util/mem-events.h                  |   3 +
>  8 files changed, 547 insertions(+), 132 deletions(-)
> 
> -- 
> 2.34.1

-- 

- Arnaldo
