Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941E58ED25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiHJN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiHJN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:26:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295562F005;
        Wed, 10 Aug 2022 06:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBDE3B81C83;
        Wed, 10 Aug 2022 13:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61641C433D7;
        Wed, 10 Aug 2022 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660138005;
        bh=iCSYzze/A6AJ5yd6akWKrnvCXX2lZs4kWIkzBHKActI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAYlHda1fDZ2XlRszconMlRg/CjsuLcJqruiZVVYoWaP352LYvLpUhAeWKmdiXT6t
         zFYFVnIRuDjYXhxpJheBbxPrkBPMNbqgV0T339OHfn6VtZFjTZyfjE7eMtQB3R3qsC
         VdbRUR0EG4g6shLOTvqf2aLrdQHIho8DwKfHc6fcwVmbRXPRDbIuWG8caIpkQVIN0a
         0ERDLKJAaixE28V92g1JCKxqanUlEyrzu3TT+HGC4cv7QRXFlJ+1iJvJRlmJCdWDFO
         mdlKxeyMWodE3wmeR9cWAdw0S8N8w4PCwTyK/JpOLy4y5unkSZ7wclIagBlpkw6vOS
         +RKAtLOuxL0rQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 43D3E4035A; Wed, 10 Aug 2022 10:26:43 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:26:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Subject: Re: [PATCH v2 00/14] perf mem/c2c: Add support for AMD
Message-ID: <YvOyE6840exUm9BV@kernel.org>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
 <Ys1cfZgL4TyWazRm@krava>
 <YtV9kwfulEVWuaXR@kernel.org>
 <CA+JHD91X9_dMV-sXho_L9k326-Eneor4ZeOtw_WgWNtHbKzWxg@mail.gmail.com>
 <ef9034a6-c4b2-ff82-a56c-bd7df2d10884@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef9034a6-c4b2-ff82-a56c-bd7df2d10884@amd.com>
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

Em Fri, Jul 22, 2022 at 07:51:27AM +0530, Ravi Bangoria escreveu:
> On 21-Jul-22 10:54 PM, Arnaldo Carvalho de Melo wrote:
> > On Mon, Jul 18, 2022, 12:34 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >> Em Tue, Jul 12, 2022 at 01:35:25PM +0200, Jiri Olsa escreveu:
> >>> On Thu, Jun 16, 2022 at 05:06:23PM +0530, Ravi Bangoria wrote:
> >>>> Perf mem and c2c tools are wrappers around perf record with mem load/
> >>>> store events. IBS tagged load/store sample provides most of the
> >>>> information needed for these tools. Enable support for these tools on
> >>>> AMD Zen processors based on IBS Op pmu.

> >>>> Ravi Bangoria (14):
> >>>>   perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
> >>>>   perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
> >>>>   perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
> >>>>   perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
> >>>>   perf/x86/amd: Support PERF_SAMPLE_ADDR
> >>>>   perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
> >>>>   perf tool: Sync include/uapi/linux/perf_event.h header
> >>>>   perf tool: Sync arch/x86/include/asm/amd-ibs.h header
> >>>>   perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
> >>>>   perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
> >>>>   perf mem/c2c: Add load store event mappings for AMD
> >>>>   perf mem/c2c: Avoid printing empty lines for unsupported events
> >>>>   perf mem: Use more generic term for LFB
> >>>>   perf script: Add missing fields in usage hint

> >>> tools part looks good to me

> >>> Acked-by: Jiri Olsa <jolsa@kernel.org>

> >> What about the kernel bits? PeterZ? Is this in some tip branch?

> Peter, Would you able to pick this up for next merge window? Please
> note that, one dependency patch needs to be applied first from "IBS
> Zen4 enhancement" series:
 
> [PATCH v6 6/8] perf/x86/ibs: Add new IBS register bits into header
> https://lore.kernel.org/lkml/20220604044519.594-7-ravi.bangoria@amd.com

It is there already:

⬢[acme@toolbox perf]$ git log --oneline torvalds/master | grep -m1 "Add new IBS register bits into header"
326ecc15c61c349c perf/x86/ibs: Add new IBS register bits into header
⬢[acme@toolbox perf]$

but not the other patches in this series:

⬢[acme@toolbox perf]$ git log --oneline torvalds/master | grep -m1 "amd: Support PERF_SAMPLE_PHY_ADDR"
⬢[acme@toolbox perf]$

- Arnaldo
