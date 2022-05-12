Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A5524971
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352095AbiELJwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiELJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:52:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F348B3ED02
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:52:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94A0106F;
        Thu, 12 May 2022 02:52:11 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D23F53F66F;
        Thu, 12 May 2022 02:52:10 -0700 (PDT)
Message-ID: <bd746cf0-0fdd-1ee6-d394-67fffb5d9b58@arm.com>
Date:   Thu, 12 May 2022 11:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arch_topology: support parsing cluster_id from DT
Content-Language: en-US
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1651739735-51884-1-git-send-email-wangqing@vivo.com>
 <f7d6d1ec-e95d-9c7a-db7c-e1445f6ff8fe@arm.com>
 <SL2PR06MB308201D7F0352006E5E20A29BDC89@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <SL2PR06MB308201D7F0352006E5E20A29BDC89@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 11:38, 王擎 wrote:
> 
>>> From: Wang Qing <wangqing@vivo.com>

[...]

>> Would have to be cluster_id = -1. 0 is a valid 2. level cluster.
>> Otherwise you're not removing the CLS data from CPU4 to CPU7 in the
>> `Armv9 with L2 complexes` cpu-map example I used for testing:
>>
>>                 cpu-map {
>>                         cluster0 {
>>                                 cluster0 {
>>                                         core0 {
>>                                                 cpu = <&cpu0>;
>>                                         };
>>                                         core1 {
>>                                                 cpu = <&cpu1>;
>>                                         };
>>                                 };
>>                                 cluster1 {
>>                                         core0 {
>>                                                 cpu = <&cpu2>;
>>                                         };
>>                                         core1 {
>>                                                 cpu = <&cpu3>;
>>                                         };
>>                                 };
>>                         };
>>                         cluster1 {
>>                                 core0 {
>>                                         cpu = <&cpu4>;
>>                                 };
>>                                 core1 {
>>                                         cpu = <&cpu5>;
>>                                 };
>>                                 core2 {
>>                                         cpu = <&cpu6>;
>>                                 };
>>                         };
>>                         cluster2 {
>>                                 core0 {
>>                                         cpu = <&cpu7>;
>>                                 };
>>                         };
>>                 };

[...]

>> Looks like you also need to adapt update_siblings_masks() to only set
>> cpu in &cpu_topo->thread_sibling and &cpuid_topo->thread_sibling when
>> `cpu_topo->thread_id != -1`.
>>
>> @@ -723,11 +723,11 @@ void update_siblings_masks(unsigned int cpuid)
>>                 cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
>>                 cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
>>
>> -               if (cpuid_topo->core_id != cpu_topo->core_id)
>> -                       continue;
>> -
>> -               cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
>> -               cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
>> +               if (cpu_topo->thread_id != -1 &&
>> +                   cpuid_topo->core_id == cpu_topo->core_id) {
>> +                       cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
>> +                       cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
>> +
> 
> This seems like another problem?

I don't think so. If you run a system with the cpu-map mentioned above
you get:

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
SMT        <-- !!!
CLS
MC

root@e125579:~# cat /proc/schedstat | awk '{print $1 " " $2 }' | grep
^[cd] | head -5
cpu0 0
domain0 05 <-- !!!
domain1 07 <-- !!!
domain2 0f
domain3 ff

So you get an unwanted SMT level for CPU0-3 and messed-up cpumasks
without this change.
