Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8304B4B8705
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiBPLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:47:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBPLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:47:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E446171;
        Wed, 16 Feb 2022 03:46:58 -0800 (PST)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzGQ00WYyz67gXC;
        Wed, 16 Feb 2022 19:46:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 12:46:56 +0100
Received: from [10.47.81.42] (10.47.81.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 11:46:55 +0000
Message-ID: <8c582e45-0954-a2ea-764a-4dd78a464988@huawei.com>
Date:   Wed, 16 Feb 2022 11:46:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
To:     Will Deacon <will@kernel.org>
CC:     Leo Yan <leo.yan@linaro.org>, Marco Elver <elver@google.com>,
        "Thomas Richter" <tmricht@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <dvyukov@google.com>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
 <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
 <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
 <20220215143459.GB7592@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220215143459.GB7592@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.42]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> Sorry, I haven't had time to look at this (or the thousands of other mails
> in my inbox) lately.
> 

Thanks

> I don't recall all of the details, but basically hw_breakpoint really
> doesn't work well on arm/arm64 -- the sticking points are around handling
> the stepping and whether to step into or over exceptions. Sadly, our ptrace
> interface (which is what is used by GDB) is built on top of hw_breakpoint,
> so we can't just rip it out and any significant changes are pretty risky.
> 
> What I would like to happen is that we rework our debug exception handling
> as outlined by [1] so that kernel debug is better defined and the ptrace
> interface can interact directly with the debug architecture instead of being
> funnelled through hw_breakpoint. Once we have that, I think we could try to
> improve hw_breakpoint much more comfortably (or at least defeature it
> considerably without having to worry about breaking GDB). I started this a
> couple of years ago, but I haven't found time to get back to it for ages.
> 
> Anyway, to this specific test...
> 
> When we hit a break/watchpoint the faulting PC points at the instruction
> which faulted and the exception is reported before the instruction has had
> any other side-effects (e.g. if a watchpoint triggers on a store, then
> memory will not have been updated when the watchpoint handler runs), so if
> we were to return as usual after reporting the exception to perf then we
> would just hit the same break/watchpoint again and we'd get stuck. GDB
> handles stepping over the faulting instruction, but for perf (and assumedly
> these tests), the kernel is expected to handle the step. This handling
> amounts to disabling the break/watchpoint which we think we hit and then
> attempting a hardware single-step. During the step we could run into more
> break/watchpoints on the same instruction, so we'll keep disabling things
> until we eventually manage to complete the step, which is signalled by a
> specific type of debug exception. At this point, we re-enable the
> break/watchpoints and we're good.
> 
> Signals make this messy, as the step logic will step_into_  the signal
> handler -- we have to do this, otherwise we would miss break/watchpoints
> triggered by the signal handler if we had disabled them for the step.
> However, it means that when we return back from the signal handler we will
> run back into the break/watchpoint which we initially stepped over. When
> perf uses SIGTRAP to notify userspace that we hit a break/watchpoint,
> then we'll get stuck because we'll step into the handler every time.
> 
> Hopefully that clears things up a bit. Ideally, the kernel wouldn't
> pretend to handle this stepping at all for arm64 as it adds a bunch of
> complexity, overhead to our context-switch and I don't think the current
> behaviour is particularly useful.
> 

Right, so what I am hearing altogether is that for now we should just 
skip this test.

And since the kernel does not seem to advertise this capability we need 
to disable for specific architectures.

Thanks,
John

> [1]https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> .

