Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768C52A57C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiEQO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbiEQO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:58:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2A4AE26;
        Tue, 17 May 2022 07:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5EEEB815BB;
        Tue, 17 May 2022 14:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A254C385B8;
        Tue, 17 May 2022 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652799520;
        bh=Ipn8N4o9Jfm/MZB7j03N4zlphLa6crIZTDLFLXzINtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDpMkf5hgaI8P24Jai5Sd58wxQ2YjkJFy7PJJmzySvKcVOOEv/JIroKoZKtSjYEEI
         EV3LaQJxI5Mh6LJcSHehG8ly9jUkAFvujY/30YnZJnX1TAe4TQzxL1uBj8lKlFXMVa
         L0DGWdi5910RhUSG+EwO/JYztZCAd0FMmTiJ0XTcRhjSmZrnvVGoRPLzlL0RJgBccm
         Mv1qkvb5oYZjD36BZ1GmGXVwk3+jV1dvrqc44i11IrOfgTrca09UgoDK0+X+rzuDhB
         o4gL+mv41rAFBBHJqWlrX9yahWeQWrslJYU8GGnYlvGAq89oOllycYAMKyEBN1nMxS
         nMM/dh60HsXoQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19EEC400B1; Tue, 17 May 2022 11:58:38 -0300 (-03)
Date:   Tue, 17 May 2022 11:58:38 -0300
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
Subject: Re: [PATCH v2 0/2] perf: arm64: Tools support for Dwarf unwinding
 through SVE functions
Message-ID: <YoO4Hiue7PmJ9KOS@kernel.org>
References: <20220517102005.3022017-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 17, 2022 at 11:20:01AM +0100, James Clark escreveu:
> Changes since v1:
> 
>   * Split patchset into kernel side and Perf tool changes

Thanks, now I'll wait for the kernel side to be merged.

- Arnaldo
 
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
> 
> Thanks
> James
> 
> James Clark (4):
>   perf tools: arm64: Copy perf_regs.h from the kernel
>   perf tools: Use dynamic register set for Dwarf unwind
>   perf tools: arm64: Decouple Libunwind register names from Perf
>   perf tools: arm64: Add support for VG register
> 
>  tools/arch/arm64/include/uapi/asm/perf_regs.h |  7 +-
>  tools/perf/arch/arm64/util/perf_regs.c        | 34 +++++++++
>  tools/perf/arch/arm64/util/unwind-libunwind.c | 73 +------------------
>  tools/perf/util/evsel.c                       |  2 +-
>  tools/perf/util/perf_regs.c                   |  2 +
>  5 files changed, 45 insertions(+), 73 deletions(-)
> 
> -- 
> 2.28.0

-- 

- Arnaldo
