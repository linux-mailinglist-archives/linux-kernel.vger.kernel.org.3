Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9319D505BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbiDRPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbiDRPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:53:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA03BB;
        Mon, 18 Apr 2022 08:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E63B80E12;
        Mon, 18 Apr 2022 15:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF9C385A1;
        Mon, 18 Apr 2022 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650296386;
        bh=L4TwukCazJJxirH/NADVnJR9xCpzOg3FMtBzbhJ2d4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwzOeYXox9cTChujjKBkG45GDBTH6d0RIXbSU1/0JxYyV9bXtv6KMueFxmipS/bnC
         /OOStebVSOAh4xFukADUy1K8lpmMlcXbytBLgWsZ5KKf5vgVrnROT95f3X3BMRYdVB
         fv+y6U7zHXeMxLg8QK3cy1VfA48VgitsBPlNr1PsuOJxeW9dTacYjVC/+dy4ePaHwL
         XE7Pk9uoriP7Yz3bgSdO8gbnEAsDQJbxUuIt1VqW7wEnvri32COb2e7T5oK3QuCu1D
         YlOGd8LpUoqvT/Zc4T4ObqjlPctACSra93jGHvG+3P2pUxbYaTh2rxCHZ3WElWbToL
         Fo8uLFRg31SHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8438440407; Mon, 18 Apr 2022 12:39:42 -0300 (-03)
Date:   Mon, 18 Apr 2022 12:39:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
Message-ID: <Yl2GPvQOxFtgvZHl@kernel.org>
References: <20220413210503.3256922-1-irogers@google.com>
 <20220413210503.3256922-3-irogers@google.com>
 <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
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

Em Thu, Apr 14, 2022 at 11:03:03AM -0400, Liang, Kan escreveu:
> 
> 
> On 4/13/2022 5:04 PM, Ian Rogers wrote:
> > Events were generated from 01.org using:
> > https://github.com/intel/event-converter-for-linux-perf
> > 
> > Signed-off-by: Ian Rogers<irogers@google.com>
> > ---
> >   tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
> >   .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
> >   .../x86/sapphirerapids/floating-point.json    |  218 +++
> >   .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
> >   .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
> >   .../arch/x86/sapphirerapids/other.json        |  329 +++++
> >   .../arch/x86/sapphirerapids/pipeline.json     | 1271 +++++++++++++++++
> >   .../x86/sapphirerapids/virtual-memory.json    |  225 +++
> 
> Thank you very much Ian for the patches. They all looks good to me.
> 
>     Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Next time please reply with the Reviewed-by to the cover letter (PATCH
00/14) so that the b4 tool can collect the Reviewed-by to all the
patches.

- Arnaldo
 
> BTW: I think the uncore events for SPR are also published in 01.org.
> Do you have plan to add them later?
