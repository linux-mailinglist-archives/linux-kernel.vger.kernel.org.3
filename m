Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F064E53515C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbiEZPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiEZPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:23:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF48DE300;
        Thu, 26 May 2022 08:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 615C9B82109;
        Thu, 26 May 2022 15:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B4CC385A9;
        Thu, 26 May 2022 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653578617;
        bh=6IZVvCtc7AKK6GVlmV/StJi7IokuGgZrQ4pffitComI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWLh3x8hTHfc3XVWzw0drhsYAdxY7X78BlpxOCN5/C3Gex4UdWsK3fx/RlQ26bLEY
         oNNlA+PfF9nwIs9qpw/co8Y60+N+nrZCjg+rBegpXKwkY5OlCkariD5DmOwArOsAZN
         4+zeCESL3GKwxXAYyKCQsNRWakMIPb8mlptX6lN7SbQi0AxByIzbY0nk992z+RyDm6
         8TRCak9QOoRnBxwvhJ7yZMNShV3QfQmpPsk2Ni74fLbbj4aAVjnJOVNLRfj52IeEGv
         4PsyfMBpIieNKAg9R45lTvluE+XHguYsXoVZnskrfGuHuPc57XiQVb7F4KC+gOZfoB
         LW5tglrTkpngg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 055ED4036D; Thu, 26 May 2022 12:23:33 -0300 (-03)
Date:   Thu, 26 May 2022 12:23:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/5] perf: arm64: Tools support for Dwarf unwinding
 through SVE functions
Message-ID: <Yo+bdSMUOkd1N4HE@kernel.org>
References: <20220525154114.718321-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525154114.718321-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 25, 2022 at 04:41:09PM +0100, James Clark escreveu:
> Changes since v2:
>   * Add commit to fix header include path to use Perf's copy
>   * Apply Leo's review tags
> 
> When SVE registers are pushed onto the stack the VG register is required to
> unwind because the stack offsets would vary by the SVE register width at the
> time when the sample was taken.
> 
> The patches ("[PATCH v2 0/2] perf: arm64: Kernel support for Dwarf unwinding
> through SVE functions") add support for sampling the VG register to the kernel
> and the docs. This is the patchset to add support to userspace perf.
> 
> A small change is also required to libunwind or libdw depending on which
> unwinder is used, and these will be published later. Without these changes Perf
> continues to work with both libraries, although the VG register is still not
> used for unwinding. 

Thanks, applied.

- Arnaldo

 
> Thanks
> James
> 
> James Clark (5):
>   perf tools: arm64: Use perf's copy of kernel headers
>   perf tools: arm64: Copy perf_regs.h from the kernel
>   perf tools: Use dynamic register set for Dwarf unwind
>   perf tools: arm64: Decouple Libunwind register names from Perf
>   perf tools: arm64: Add support for VG register
> 
>  tools/arch/arm64/include/uapi/asm/perf_regs.h |  7 +-
>  tools/perf/arch/arm64/util/perf_regs.c        | 34 +++++++++
>  tools/perf/arch/arm64/util/unwind-libunwind.c | 73 +------------------
>  tools/perf/util/evsel.c                       |  2 +-
>  tools/perf/util/libunwind/arm64.c             |  2 +-
>  tools/perf/util/perf_regs.c                   |  2 +
>  6 files changed, 46 insertions(+), 74 deletions(-)
> 
> -- 
> 2.28.0

-- 

- Arnaldo
