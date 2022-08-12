Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7A591605
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiHLTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHLTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF74BB14EE;
        Fri, 12 Aug 2022 12:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB33617BA;
        Fri, 12 Aug 2022 19:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758D6C433D6;
        Fri, 12 Aug 2022 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333190;
        bh=czmIRbUic9xdaStbmKS6YTwsgeEBlcEnN6B9YAGis1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2+vGvljI8a7pc/y+kwD2/5wmNEvrbD6HkktObCcIWGJ6nJy4raLdRSfXDgkx5DZg
         HV0PHaopJqK0veXsKtsuP8cU5pjhQVcwO38qzZ96htdAHxTmtRA5SoPKgeeulgqZVq
         XDLRzqK7Fdaz0oFyAbqRZG5VqIdFpBLoMWK1x6YQubE7C7woQUToCcNTu2ld9TfCKm
         yq4PGASc2XT6YJWk7D3OSniLz8eWwMfcLDt/6tQ8vpOZYdEx/1itw7KjdLCDQZiOnt
         S6OrPq/apGo43y3R91eu696r/5jAdO/jAvmcNhLbQ59rG5x8m/qA/v4j2yKw9xtgTz
         En0iZaVLUxOSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2BA14035A; Fri, 12 Aug 2022 16:39:47 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:39:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        peterz@infradead.org, bp@alien8.de, namhyung@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        like.xu.linux@gmail.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 2/4] tools headers x86: Sync msr-index.h with kernel
 sources
Message-ID: <Yvasg/P0v23ymrDo@kernel.org>
References: <cover.1660217326.git.sandipan.das@amd.com>
 <ffb9a9f0aa46a4339bb61282e26810112700ae97.1660217326.git.sandipan.das@amd.com>
 <YvYQQr5VenglbpWM@krava>
 <94f483f5-c541-2a1e-87f6-a4105c30a045@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f483f5-c541-2a1e-87f6-a4105c30a045@amd.com>
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

Em Fri, Aug 12, 2022 at 02:33:46PM +0530, Sandipan Das escreveu:
> Hi Jiri,
> 
> On 8/12/2022 2:03 PM, Jiri Olsa wrote:
> > On Thu, Aug 11, 2022 at 06:16:47PM +0530, Sandipan Das wrote:
> >> Sync msr-index.h with the kernel sources by adding the new AMD Last Branch
> >> Record Extension Version 2 (LbrExtV2) MSRs.
> >>
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >> ---
> >>  tools/arch/x86/include/asm/msr-index.h | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
> >> index cc615be27a54..7f9eaf497947 100644
> >> --- a/tools/arch/x86/include/asm/msr-index.h
> >> +++ b/tools/arch/x86/include/asm/msr-index.h
> >> @@ -574,6 +574,9 @@
> >>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
> >>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
> >>  
> >> +/* AMD Last Branch Record MSRs */
> >> +#define MSR_AMD64_LBR_SELECT			0xc000010e
> > 
> > curious do we actualy use this in tools somewhere?
> > 
> > jirka
> > 
> 
> Commit 9dde6cadb92b ("tools arch x86: Sync the msr-index.h copy with the kernel sources")
> from Arnaldo says that adding these new MSR definitions in the tools headers allows the
> beautification scripts to pick up new entries which can be used for filtering MSR access
> traces.
> 
> E.g. one can trace the hardware LBR branch filter bits getting written to the LBR_SELECT
> MSR while recording branches.
> 
> $ perf record -j any,u true
> $ perf record -j any_call,u true
> 
> $ sudo perf trace -e msr:write_msr/max-stack=32/ --filter="msr == AMD64_LBR_SELECT"
> 
> [...]
> 224568.130 perf/9093 msr:write_msr(msr: AMD64_LBR_SELECT, val: 1)
>                                        do_trace_write_msr ([kernel.kallsyms])
>                                        do_trace_write_msr ([kernel.kallsyms])
>                                        native_write_msr ([kernel.kallsyms])
>                                        amd_pmu_lbr_enable_all ([kernel.kallsyms])
>                                        amd_pmu_v2_enable_all ([kernel.kallsyms])
>                                        x86_pmu_enable ([kernel.kallsyms])
>                                        ctx_resched ([kernel.kallsyms])
>                                        perf_event_exec ([kernel.kallsyms])
>                                        begin_new_exec ([kernel.kallsyms])
>                                        load_elf_binary ([kernel.kallsyms])
>                                        bprm_execve ([kernel.kallsyms])
>                                        do_execveat_common.isra.0 ([kernel.kallsyms])
>                                        __x64_sys_execve ([kernel.kallsyms])
>                                        do_syscall_64 ([kernel.kallsyms])
>                                        entry_SYSCALL_64 ([kernel.kallsyms])
>                                        execve (/usr/lib/x86_64-linux-gnu/libc.so.6)
> [...]
> 302748.439 perf/9126 msr:write_msr(msr: AMD64_LBR_SELECT, val: 229)
>                                        do_trace_write_msr ([kernel.kallsyms])
>                                        do_trace_write_msr ([kernel.kallsyms])
>                                        native_write_msr ([kernel.kallsyms])
>                                        amd_pmu_lbr_enable_all ([kernel.kallsyms])
>                                        amd_pmu_v2_enable_all ([kernel.kallsyms])
>                                        x86_pmu_enable ([kernel.kallsyms])
>                                        ctx_resched ([kernel.kallsyms])
>                                        perf_event_exec ([kernel.kallsyms])
>                                        begin_new_exec ([kernel.kallsyms])
>                                        load_elf_binary ([kernel.kallsyms])
>                                        bprm_execve ([kernel.kallsyms])
>                                        do_execveat_common.isra.0 ([kernel.kallsyms])
>                                        __x64_sys_execve ([kernel.kallsyms])
>                                        do_syscall_64 ([kernel.kallsyms])
>                                        entry_SYSCALL_64 ([kernel.kallsyms])
>                                        execve (/usr/lib/x86_64-linux-gnu/libc.so.6)
> [...]
> 
> I can add this example to the commit message in the next revision.

Right, you can reuse something from my messages updating this file or,
better, show an example like you did above, for the thing that you are
working at that moment :-)

One of the things we need to do is:

perf trace -e msr:write_msr/max-stack=32/ --filter-help

And then it should look what are the strings that can be used for that
specific msr:write_msr tracepoint.

Also have tab expansion in the --filter= part :-)

- Arnaldo
