Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7FC4E72BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358589AbiCYMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358957AbiCYMII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:08:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31DEBD4C9B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:06:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2DE12FC;
        Fri, 25 Mar 2022 05:06:33 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5712E3F73B;
        Fri, 25 Mar 2022 05:06:30 -0700 (PDT)
Message-ID: <df54651e-ecd9-5812-70aa-138190fa7426@arm.com>
Date:   Fri, 25 Mar 2022 13:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched: dynamic config sd_flags if described in DT
Content-Language: en-US
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
 <68df2f49-9b74-7ea2-0178-be55824b3c89@arm.com>
 <SL2PR06MB3082DBB58303601F73FB77D3BD119@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <73b491fe-b5e8-ebca-081e-fa339cc903e1@arm.com>
 <SL2PR06MB3082FAA7900ED3664838B48CBD189@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <SL2PR06MB3082FAA7900ED3664838B48CBD189@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 07:45, 王擎 wrote:

[...]

>> Now, if you want to move ShPR from MC to DIE then a custom topology
>> table should do it, i.e. you don't have to change any generic task
>> scheduler code.
>>
>> static inline int cpu_cpu_flags(void)
>> {
>>        return SD_SHARE_PKG_RESOURCES;
>> }
>>
>> static struct sched_domain_topology_level custom_topology[] = {
>> #ifdef CONFIG_SCHED_SMT
>>         { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
>> #endif
>>
>> #ifdef CONFIG_SCHED_CLUSTER
>>         { cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
>> #endif
>>
>> #ifdef CONFIG_SCHED_MC
>>         { cpu_coregroup_mask, SD_INIT_NAME(MC) },
>>                             ^^^^
>> #endif
>>         { cpu_cpu_mask, cpu_cpu_flags, SD_INIT_NAME(DIE) },
>>                         ^^^^^^^^^^^^^
>>         { NULL, },
>> };
>>
>> set_sched_topology(custom_topology);
> 
> However, due to the limitation of GKI, we cannot change the sd topology
> by ourselves. But we can configure CPU and cache topology through DT.

IMHO, mainline can't do anything here. You should talk to your Android
platform provider in this case. Android concepts like Generic Kernel
Image (GKI) are normally not discussed here.

From mainline perspective we're OK with scheduling such a system flat,
e.g. only with a single MC SD [CPU0..CPU7] for each CPU.
It could be that the Phantom SD is still needed for additional
proprietary or Android add-ons though?

In case you would remove `clusterX` from your DT cpu-map (Phantom SD
information, i.e. the reason for why you have e.g. for CPU0: `MC (ShPR)
[CPU0..CPU3] and DIE [CPU0..CPU7]`) , you should see the natural
topology: only `MC (ShPR) [CPU0..CPU7]`.

> So why not get the ShPR from DT first? If not configured, use the default.

I'm not convinced that mainline will accept a change which is necessary
for a out-of-tree tweak (Phantom SD).

>>> *CLS[0-1][2-3](SD_SHARE_PKG_RESOURCES)
>>
>> But why do you want to have yet another SD underneath MC for CPU0-CPU3?
>> sd_llc is assigned to the highest ShPR SD, which would be DIE.
> 
> We want do something from the shared L2 cache(for complex, like walt), 
> you can ignore it here and talk about it when we done.

I assume you refer to the proprietary load-tracking mechanism `Window
Assisted Load Tracking` (WALT) here? It's also not in mainline.
