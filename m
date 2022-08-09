Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FB58E067
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbiHITof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbiHITnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6A26AEE;
        Tue,  9 Aug 2022 12:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FED7B81611;
        Tue,  9 Aug 2022 19:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D832FC433D6;
        Tue,  9 Aug 2022 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660074216;
        bh=gB1N5dx7Tf66OfEkK97h5Nlh1Hc+Rpu083l/PlcCGTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIfRDkI58pXgb4dKbp03ExC4xCvf6X6BjXvJuIhNDZtPLj1fez076tM5jiYQv6DPw
         ZpxDBCBK7BKFiN8WsoeiPLPbi/5wOpcuYSSkjuVNPhhPUrznO7eWYq3J+ZG3o/+DS/
         kGLglyMsd8E2RY3mzjeU2sI24KC/7HK3m8q8YSXzETDmcL562sWrsarvBwYGLpTUJh
         ITWqVD8GbzSYS6L5mvxXfyFoWP/Cxn0sH+jWS3JmryrGrCGJVnzsvBQzzTCTrVNoBP
         R24TWanmd+ydBa5SbvPgoDiPDGtjMMWfUd9hb4B4Efbuo2d6qFwVEWVmILnrwthBZg
         70SbDrPAE7RZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27FC14035A; Tue,  9 Aug 2022 16:43:33 -0300 (-03)
Date:   Tue, 9 Aug 2022 16:43:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 0/3] Remove bad uncore filter/events
Message-ID: <YvK45Ya+gs9hUwoy@kernel.org>
References: <20220805013856.1842878-1-irogers@google.com>
 <3f85d0f9-921f-4f5c-7b5c-8a8e1773512a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f85d0f9-921f-4f5c-7b5c-8a8e1773512a@linux.intel.com>
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

Em Fri, Aug 05, 2022 at 10:45:31AM -0400, Liang, Kan escreveu:
> 
> 
> On 2022-08-04 9:38 p.m., Ian Rogers wrote:
> > The event converter scripts at:
> > https://github.com/intel/event-converter-for-linux-perf
> > passes Filter values from data on 01.org that is bogus in a perf command
> > line and can cause perf to infinitely recurse in parse events. Remove
> > such events or filter using the updated patch:
> > https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/afd779df99ee41aac646eae1ae5ae651cda3394d
> > 
> > v3. Removed filters rather than events in some cases as Suggested-by:
> >     Liang, Kan <kan.liang@linux.intel.com>
> > v2. Manually fixed a broken \\Inbound\\ ivytown event.
> > 
> > Ian Rogers (3):
> >   perf vendor events: Remove bad broadwellde uncore events
> >   perf vendor events: Remove bad ivytown uncore events
> >   perf vendor events: Remove bad jaketown uncore events
> > 
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kan
> 
> >  .../arch/x86/broadwellde/uncore-cache.json    | 97 -------------------
> >  .../arch/x86/broadwellde/uncore-other.json    | 13 ---
> >  .../arch/x86/ivytown/uncore-cache.json        | 90 -----------------
> >  .../arch/x86/ivytown/uncore-interconnect.json |  1 -
> >  .../arch/x86/ivytown/uncore-other.json        | 13 ---
> >  .../arch/x86/ivytown/uncore-power.json        | 19 ----
> >  .../arch/x86/jaketown/uncore-cache.json       | 30 ------
> >  .../arch/x86/jaketown/uncore-other.json       | 13 ---
> >  .../arch/x86/jaketown/uncore-power.json       | 11 ---
> >  9 files changed, 287 deletions(-)
> > 

-- 

- Arnaldo
