Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C945A0C85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiHYJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbiHYJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:26:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA6B6B8EB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BdGxFPL+KIjC21nQmAX2fmTz8ytQukNeGAle/8e6kIU=; b=ab80gZrN8TMd/Waalzztpddtqh
        Jf6ePkBfIX3m5JgX4qf1Si4kdzGAI8G4X+d+4+VuTC7gsy+rq+9BXQjJ2Ww3kAnakaAE9i54luaRW
        o67REmBuocLyb8+5Bq538wmog6zUeO7zWJOdFjJMoTli53qnjyb+4L5TRW92nZCVYxKpShGmCeVDc
        /WtkV/SY9xuCHtdfpV2YGvGrJsfVPchDPlOJD6CC42c3BjRPcxfhvHmBw/neuro7B7he2X6Vc2ZJp
        erPHCisJVI1FXMSZSO/RFsiGqt5NZBbxrWwBOx8Tz1qRQeDOWM1BwES3fe3z7XDvogY1jgngUtIu5
        6VWKYo+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR980-00H8Gx-9L; Thu, 25 Aug 2022 09:26:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2074298014D; Thu, 25 Aug 2022 11:26:19 +0200 (CEST)
Date:   Thu, 25 Aug 2022 11:26:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, namhyung.kim@kernel.org, irogers@google.com
Subject: Re: [PATCH] perf/x86/intel/uncore: fix broken read_counter() for SNB
 IMC PMU
Message-ID: <YwdAOwS7AK/KrOfJ@worktop.programming.kicks-ass.net>
References: <20220803160031.1379788-1-eranian@google.com>
 <4cad9f06-f24d-a6e6-477b-5a00f64600ed@linux.intel.com>
 <CABPqkBSGXwm_OFWt9tDq2WuXpuLtOJzekhiqH=c0_rOX6ZM2=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSGXwm_OFWt9tDq2WuXpuLtOJzekhiqH=c0_rOX6ZM2=g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:28:36PM -0700, Stephane Eranian wrote:
> On Thu, Aug 4, 2022 at 6:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2022-08-03 12:00 p.m., Stephane Eranian wrote:
> > > Existing code was generating bogus counts for the SNB IMC bandwidth counters:
> > >
> > > $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
> > >      1.000327813           1,024.03 MiB  uncore_imc/data_reads/
> > >      1.000327813              20.73 MiB  uncore_imc/data_writes/
> > >      2.000580153         261,120.00 MiB  uncore_imc/data_reads/
> > >      2.000580153              23.28 MiB  uncore_imc/data_writes/
> > >
> > > The problem was introduced by commit:
> > >   07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")
> > >
> > > Where the read_counter callback was replace to point to the generic
> > > uncore_mmio_read_counter() function.
> > >
> > > The SNB IMC counters are freerunnig 32-bit counters laid out contiguously in
> > > MMIO. But uncore_mmio_read_counter() is using a readq() call to read from
> > > MMIO therefore reading 64-bit from MMIO. Although this is okay for the
> > > uncore_perf_event_update() function because it is shifting the value based
> > > on the actual counter width to compute a delta, it is not okay for the
> > > uncore_pmu_event_start() which is simply reading the counter  and therefore
> > > priming the event->prev_count with a bogus value which is responsible for
> > > causing bogus deltas in the perf stat command above.
> > >
> > > The fix is to reintroduce the custom callback for read_counter for the SNB
> > > IMC PMU and use readl() instead of readq(). With the change the output of
> > > perf stat is back to normal:
> > > $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
> > >      1.000120987             296.94 MiB  uncore_imc/data_reads/
> > >      1.000120987             138.42 MiB  uncore_imc/data_writes/
> > >      2.000403144             175.91 MiB  uncore_imc/data_reads/
> > >      2.000403144              68.50 MiB  uncore_imc/data_writes/
> > >
> > > Signed-off-by: Stephane Eranian <eranian@google.com>
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> Any further comments?

Got lost in the holiday pile-up, applied!
