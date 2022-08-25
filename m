Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E575A193F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiHYS6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiHYS6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:58:35 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF0B99DF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:58:34 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id o198so6854278vko.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7YDYCQHSBDpfPcxFyrtge8IJaGSkkqVYbuEOPNj4bao=;
        b=Cpu65Erb9Cr5aIOAbnzvt4NdElljYzWZOUOZKPhuZcy/+sXjdM4RZMH4gi0pkHzqqv
         Gqc4/R0Jsdok38r1G38RhWPpl4MQ1Gnjcw84dR5629gWFdWLMpXCZwQsTPaEEbbyIx4g
         ggsozZNMuqpjRCq072jmVXMGbtL0aflAdsB7ZoV8OspMR9vPLhgLko+t7FSTbzBwrJuy
         WmPv6pIAJm028MDfxlbJNAlE2ZK8+czTlPcu6uUMgRP/6DVzNrYAjU+fgOto4c0VEeXw
         sx0x8D4+zuJ/90G8yQ5ytSX0PZIwuUEYknPEsiGpAoP++z6uvzOnqchpUbsrfUDQWATI
         XqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7YDYCQHSBDpfPcxFyrtge8IJaGSkkqVYbuEOPNj4bao=;
        b=yqrJjt30ZQKfCMxvWU4zaipwnBGVBC69UO/o2isOWPdV1Sc3y4i4J8smq2LIZzaR2v
         TqjKD2S815wmFxxbwfUK/3NEiNupXDvS4s6wMIeNmRKR0vBLEbomlApZl+ni9IxcpQiv
         OpiWH+DGVuRi9ENq1pmIg5QVc8MltD7Scj90k48BYvrNmQh04KaunLXAA83Ru8Cvj1zR
         HkNPtx6B82GvK38s5ugM1BLnxe3QFO612ceFfhzPVjBkD01VEgegfhkW19Qyi9KQ7PgI
         vFEQ990EExNM5YrQS/H6dGUkP7BHSArvXko5Y9BFu2qHjK5M0tGLRIAISX91SIbd78PR
         V22g==
X-Gm-Message-State: ACgBeo0vhA6NyR7Spg+2J39bOFVwjVUuA+m85KtJBu+MxtSO3VMhL2e3
        oupJRx9zB44Sum1K/Z5N+LFO6egwz249FGEw9hEKY0IVW+U=
X-Google-Smtp-Source: AA6agR5oSKVcEjXbMAuH4CrBVEAMK4dJrMXAIhw5Pz8Pxop7cwzCRzyl6A4oi2Kha1hSKP9za1ON6M6eW7dzfsihHWk=
X-Received: by 2002:a1f:a958:0:b0:378:d584:dd0e with SMTP id
 s85-20020a1fa958000000b00378d584dd0emr2069306vke.17.1661453913753; Thu, 25
 Aug 2022 11:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220803160031.1379788-1-eranian@google.com> <4cad9f06-f24d-a6e6-477b-5a00f64600ed@linux.intel.com>
 <CABPqkBSGXwm_OFWt9tDq2WuXpuLtOJzekhiqH=c0_rOX6ZM2=g@mail.gmail.com> <YwdAOwS7AK/KrOfJ@worktop.programming.kicks-ass.net>
In-Reply-To: <YwdAOwS7AK/KrOfJ@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 25 Aug 2022 11:58:22 -0700
Message-ID: <CABPqkBTfZhWDte_eV9EOOSfHter5=qNqTvdoH=692vVQYX8UHw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: fix broken read_counter() for SNB
 IMC PMU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, namhyung.kim@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 2:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 03:28:36PM -0700, Stephane Eranian wrote:
> > On Thu, Aug 4, 2022 at 6:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > >
> > >
> > >
> > > On 2022-08-03 12:00 p.m., Stephane Eranian wrote:
> > > > Existing code was generating bogus counts for the SNB IMC bandwidth counters:
> > > >
> > > > $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
> > > >      1.000327813           1,024.03 MiB  uncore_imc/data_reads/
> > > >      1.000327813              20.73 MiB  uncore_imc/data_writes/
> > > >      2.000580153         261,120.00 MiB  uncore_imc/data_reads/
> > > >      2.000580153              23.28 MiB  uncore_imc/data_writes/
> > > >
> > > > The problem was introduced by commit:
> > > >   07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")
> > > >
> > > > Where the read_counter callback was replace to point to the generic
> > > > uncore_mmio_read_counter() function.
> > > >
> > > > The SNB IMC counters are freerunnig 32-bit counters laid out contiguously in
> > > > MMIO. But uncore_mmio_read_counter() is using a readq() call to read from
> > > > MMIO therefore reading 64-bit from MMIO. Although this is okay for the
> > > > uncore_perf_event_update() function because it is shifting the value based
> > > > on the actual counter width to compute a delta, it is not okay for the
> > > > uncore_pmu_event_start() which is simply reading the counter  and therefore
> > > > priming the event->prev_count with a bogus value which is responsible for
> > > > causing bogus deltas in the perf stat command above.
> > > >
> > > > The fix is to reintroduce the custom callback for read_counter for the SNB
> > > > IMC PMU and use readl() instead of readq(). With the change the output of
> > > > perf stat is back to normal:
> > > > $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
> > > >      1.000120987             296.94 MiB  uncore_imc/data_reads/
> > > >      1.000120987             138.42 MiB  uncore_imc/data_writes/
> > > >      2.000403144             175.91 MiB  uncore_imc/data_reads/
> > > >      2.000403144              68.50 MiB  uncore_imc/data_writes/
> > > >
> > > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > >
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > >
> > Any further comments?
>
> Got lost in the holiday pile-up, applied!

Thanks.
