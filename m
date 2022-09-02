Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04175AADFD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiIBMC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiIBMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:02:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74462C0B4D;
        Fri,  2 Sep 2022 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nz8Tz1uBfArPzrTbA5QgwTqK/y15M7AwWAm6DXoAXqU=; b=dzVLQ+ITUI1Ov9D5o9xTJSFt4p
        mOLLn0YcKkRuViRI7VyEeyozgdZF/Ar3cklopmx5UjHmQN06fE1jcQrHLEj3c6IkgcR0zXMSe7pTT
        MVVH6hjfs6xWx2kY+E/QnrRFhgdovhsxlKSW7Et1l3omPAhJ1aPenTCMV046kwQdRio4GiRZgrQTV
        JKc8liKe3U90Li+tPS589EaZAnOaYeVpOZkYZml5FHMw8HFf0Z0v1qQFLJNzZXy9EdDHVwAL2+wxi
        HRThC6s5E5XUhR2/bKLs9DtLgLqBoxRDwBF1yHVuPxoX67ocDXH+fFRogakH6JGm0TB1w0KNPbo7x
        Yd2EBW6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU5Mz-008evC-BL; Fri, 02 Sep 2022 12:01:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84B75300413;
        Fri,  2 Sep 2022 14:01:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63AD520853050; Fri,  2 Sep 2022 14:01:55 +0200 (CEST)
Date:   Fri, 2 Sep 2022 14:01:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RESEND v4] perf/core: Fix reentry problem in
 perf_output_read_group
Message-ID: <YxHws5sL16hz4ZKc@hirez.programming.kicks-ass.net>
References: <20220902082918.179248-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902082918.179248-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 04:29:18PM +0800, Yang Jihong wrote:
> perf_output_read_group may respond to IPI request of other cores and invoke
> __perf_install_in_context function. As a result, hwc configuration is modified.
> causing inconsistency and unexpected consequences.
> 
> Interrupts are not disabled when perf_output_read_group reads PMU counter.
> In this case, IPI request may be received from other cores.
> As a result, PMU configuration is modified and an error occurs when
> reading PMU counter:
> 
>                    CPU0                                         CPU1
>                                                     __se_sys_perf_event_open
>                                                       perf_install_in_context
> perf_output_read_group                                  smp_call_function_single
>   for_each_sibling_event(sub, leader) {                   generic_exec_single
>     if ((sub != event) &&                                   remote_function
>         (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
> <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
> __perf_install_in_context
>   ctx_resched
>     event_sched_out
>       armpmu_del
>         ...
>         hwc->idx = -1; // event->hwc.idx is set to -1
> ...
> <exit IPI>
>             sub->pmu->read(sub);
>               armpmu_read
>                 armv8pmu_read_counter
>                   armv8pmu_read_hw_counter
>                     int idx = event->hw.idx; // idx = -1
>                     u64 val = armv8pmu_read_evcntr(idx);
>                       u32 counter = ARMV8_IDX_TO_COUNTER(idx); // invalid counter = 30
>                       read_pmevcntrn(counter) // undefined instruction
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---

Right; thanks for reminding me. I had hoped you'd pick up and test the
extra assertion some, but I'll just do that on top.
