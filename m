Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2607578679
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiGRPew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGRPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD986569;
        Mon, 18 Jul 2022 08:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C8E8B80D28;
        Mon, 18 Jul 2022 15:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C711C341C0;
        Mon, 18 Jul 2022 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658158486;
        bh=RMoDhmY243Y2k6Q55CUBlgIKYuk5ilAsoqbAUK4xFrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nK5oiA3J0kXnU5Yz1/n+8fi7r8+5V9WnEpYeWIIbjtHhYNcesGh3c16VWBY2xVsuW
         a+YSpb48IxYvI4W5W9Sw7DTeK9Ic8Xjho+cTCj3P7ty9+sbO2nPdP9ErLKvJB8T/qh
         xWVLjjnqtDTFU4cWHgtwVl1MLJUu5Fut0EG/nBVSKUmWcDVhp1iU/CoUbniR9Wz67Y
         Bv6K+GfEd5o/7PuyBSICp3Eo50ipMOtaR+KBi6CqK33gT18WBOZiKLtVoVfJZl27vT
         CLPlf8cm3qqDbcTQO/kzQi5X+eBXJvWlGKa98eii/N7EKOrpkSkeGQoZKfWAdvrWnq
         6kk1naGvJbiYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E60740374; Mon, 18 Jul 2022 12:34:43 -0300 (-03)
Date:   Mon, 18 Jul 2022 12:34:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, eranian@google.com, irogers@google.com,
        jmario@redhat.com, leo.yan@linaro.org, alisaidi@amazon.com,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 00/14] perf mem/c2c: Add support for AMD
Message-ID: <YtV9kwfulEVWuaXR@kernel.org>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
 <Ys1cfZgL4TyWazRm@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1cfZgL4TyWazRm@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 12, 2022 at 01:35:25PM +0200, Jiri Olsa escreveu:
> On Thu, Jun 16, 2022 at 05:06:23PM +0530, Ravi Bangoria wrote:
> > Perf mem and c2c tools are wrappers around perf record with mem load/
> > store events. IBS tagged load/store sample provides most of the
> > information needed for these tools. Enable support for these tools on
> > AMD Zen processors based on IBS Op pmu.
> > 
> > There are some limitations though: Only load/store instructions provide
> > mem/c2c information. However, IBS does not provide a way to choose a
> > particular type of instruction to tag. This results in many non-LS
> > instructions being tagged which appear as N/A. IBS, being an uncore pmu
> > from kernel point of view[1], does not support per process monitoring.
> > Thus, perf mem/c2c on AMD are currently supported in per-cpu mode only.
> > 
> > Example:
> >   $ sudo ./perf mem record -- -c 10000
> >   ^C[ perf record: Woken up 227 times to write data ]
> >   [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]
> > 
> >   $ sudo ./perf mem report -F mem,sample,snoop
> >   Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
> >   Memory access                  Samples  Snoop
> >   N/A                             700620  N/A
> >   L1 hit                          126675  N/A
> >   L2 hit                             424  N/A
> >   L3 hit                             664  HitM
> >   L3 hit                              10  N/A
> >   Local RAM hit                        2  N/A
> >   Remote RAM (1 hop) hit            8558  N/A
> >   Remote Cache (1 hop) hit             3  N/A
> >   Remote Cache (1 hop) hit             2  HitM
> >   Remote Cache (2 hops) hit            10  HitM
> >   Remote Cache (2 hops) hit             6  N/A
> >   Uncached hit                         4  N/A
> > 
> > Prepared on amd/perf/core (9886142c7a22) + IBS Zen4 enhancement patches[2]
> > 
> > [1]: https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com
> > [2]: https://lore.kernel.org/lkml/20220604044519.594-1-ravi.bangoria@amd.com
> > 
> > v1: https://lore.kernel.org/lkml/20220525093938.4101-1-ravi.bangoria@amd.com
> > v1->v2:
> >  - Instead of defining macros to extract IBS register bits, use existing
> >    bitfield definitions. Zen4 has introduced additional set of bits in
> >    IBS registers which this series also exploits and thus this series
> >    now depends on IBS Zen4 enhancement patchset.
> >  - Add support for PERF_SAMPLE_WEIGHT_STRUCT. While opening a new event,
> >    perf tool starts with a set of attributes and goes on reverting some
> >    attributes in a predefined order until it succeeds or run out or all
> >    attempts. Here, 1st attempt includes WEIGHT_STRUCT and exclude_guest
> >    which always fails because IBS does not support guest filtering. The
> >    problem however is, perf reverts WEIGHT_STRUCT but keeps trying with
> >    exclude_guest. Thus, although, this series enables WEIGHT_STRUCT
> >    support from kernel, using it from the perf tool need more changes.
> >    I'll try to address this bug later.
> >  - Introduce __PERF_SAMPLE_CALLCHAIN_EARLY to hint generic perf driver
> >    that physical address is set by arch pmu driver and should not be
> >    overwritten.
> > 
> > 
> > Ravi Bangoria (14):
> >   perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
> >   perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
> >   perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
> >   perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
> >   perf/x86/amd: Support PERF_SAMPLE_ADDR
> >   perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
> >   perf tool: Sync include/uapi/linux/perf_event.h header
> >   perf tool: Sync arch/x86/include/asm/amd-ibs.h header
> >   perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
> >   perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
> >   perf mem/c2c: Add load store event mappings for AMD
> >   perf mem/c2c: Avoid printing empty lines for unsupported events
> >   perf mem: Use more generic term for LFB
> >   perf script: Add missing fields in usage hint
> 
> tools part looks good to me
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

What about the kernel bits? PeterZ? Is this in some tip branch?

- Arnaldo
