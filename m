Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AC4BB9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiBRNBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiBRNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:01:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3982B4614;
        Fri, 18 Feb 2022 05:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7550D60FF6;
        Fri, 18 Feb 2022 13:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB52BC340EC;
        Fri, 18 Feb 2022 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645189281;
        bh=4FwYxBWrEupe0hGtGoQssphvx94RtmIN5fix0AGiO2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLs58+ZO/yhkcYn0Go79HTlZ5S9Fjc5irYIbEoVcCKEDyzGoklWSBTLd5qbMOkAET
         DZtVivQi3X1PKBBs6KGmpMbA+joxSzhJWlBZUN9HujrjnWaIcykYXQNww+97BOectN
         Wh2gN0OnQs8K9bLigaFuwEen1rGY1KRwtpRZamDMHtMAMe8+iG37lTT0VKSqXbz+sK
         /N5PXe7uvm1yoA9ym3luwTgOP8cPd7duyvkaHQcMJdUG4Mnkp8B17I9zpHl99aYxaV
         GbdnVBJnWIYCSWV2SMb40urh8fn5mXmUyAqG1M2CE+N9DU/u1l5WaMImvXQb+EEwQR
         j6SczgA/INB/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9533B400FE; Fri, 18 Feb 2022 10:01:19 -0300 (-03)
Date:   Fri, 18 Feb 2022 10:01:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     zhengjun.xing@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf tools: fix failed to use cpu list for uncore events
Message-ID: <Yg+Yn16Xyzqc2kRr@kernel.org>
References: <20220218093127.1844241-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218093127.1844241-1-zhengjun.xing@linux.intel.com>
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

Em Fri, Feb 18, 2022 at 05:31:27PM +0800, zhengjun.xing@linux.intel.com escreveu:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> The 'perf record' and 'perf stat' commands have supported the option
> '-C/--cpus' to count or collect only on the list of CPUs provided.
> commit 1d3351e631fc ("perf tools: Enable on a list of CPUs for hybrid")
> add it to be supported for hybrid. For hybrid support, it checks the
> cpu list are available on hybrid PMU. But when we test only uncore
> events(or events not in cpu_core and cpu_atom), there is a bug:
> 
> Before:
>  # perf stat -C0  -e uncore_clock/clockticks/ sleep 1
>    failed to use cpu list 0
> 
> In this case, for uncore event, its pmu_name is not cpu_core or cpu_atom,
> so in evlist__fix_hybrid_cpus, perf_pmu__find_hybrid_pmu should return
> NULL,both events_nr and unmatched_count should be 0 ,then the cpu list
> check function evlist__fix_hybrid_cpus return -1 and the error "failed
> to use cpu list 0" will happen. Bypass "events_nr=0" case then the issue
> is fixed.

Thanks, applied.

- Arnaldo

