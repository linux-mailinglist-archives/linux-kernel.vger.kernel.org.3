Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8933559E77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiFXQTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFXQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:19:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD03C706;
        Fri, 24 Jun 2022 09:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04336B82A3A;
        Fri, 24 Jun 2022 16:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A52C34114;
        Fri, 24 Jun 2022 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656087577;
        bh=GnA2DvgsL+gQNtgqEkQiuBzC52en4llzdKBJm8+xA+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBSCYA++i4drdNWk7WOxnlwBOuQciWAF6BO0ytM/YimhZTMCdBUQ8Udwp6qWqtvt+
         o930I08vAlMr4o0cDKOSGwuoH8FIxmOzf169ZgPZrcXYDWoxR3jzaVc1Lwh7k7dOqb
         ynaIvE1+yAHkBfMes2OOCHCMi4CHaFrnRLjW3zO5darGHGnaVmkCXO33ckdTk45A9T
         eG9wQTbqpuup6X3Tr+9AOGqSd3mSUxnysYoA7Q+HMF2VOeKEkOmnkl7g4x94AWAK0l
         dYeWUgquSpHuQTatsOqAATVnxsI07oxZnoHLOpclybqTr6ivaBfivGDHUmgikqUSp4
         KhRYgek4rb74g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F24824096F; Fri, 24 Jun 2022 13:19:34 -0300 (-03)
Date:   Fri, 24 Jun 2022 13:19:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rrichter@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Subject: Re: [PATCH v6 0/8] perf/amd: Zen4 IBS extensions support (tool
 changes)
Message-ID: <YrXkFii1Fme9e1AE@kernel.org>
References: <20220604044519.594-1-ravi.bangoria@amd.com>
 <CAM9d7ci9Th4Aye51G+X5F12BiDXTnffZdj-A+HGRfUX_nWuQdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci9Th4Aye51G+X5F12BiDXTnffZdj-A+HGRfUX_nWuQdw@mail.gmail.com>
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

Em Mon, Jun 06, 2022 at 04:46:57PM -0700, Namhyung Kim escreveu:
> On Fri, Jun 3, 2022 at 9:46 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> > Ravi Bangoria (8):
> >   perf record ibs: Warn about sampling period skew
> >   perf tool: Parse pmu caps sysfs only once
> >   perf headers: Pass "cpu" pmu name while printing caps
> >   perf headers: Store pmu caps in an array of strings
> >   perf headers: Record non-cpu pmu capabilities
> >   perf/x86/ibs: Add new IBS register bits into header
> >   perf tool ibs: Sync amd ibs header file
> >   perf script ibs: Support new IBS bits in raw trace dump
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied the series to perf/core, except for "[PATCH v6 6/8]
perf/x86/ibs: Add new IBS register bits into header", that is outside
tools/.

- Arnaldo

