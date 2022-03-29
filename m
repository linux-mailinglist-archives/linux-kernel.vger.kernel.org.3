Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720074EB3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbiC2S46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiC2S44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:56:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C7622E953
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:55:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97C423A;
        Tue, 29 Mar 2022 11:55:11 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17AFA3F718;
        Tue, 29 Mar 2022 11:55:09 -0700 (PDT)
Message-ID: <5a5381cd-813d-7cef-9948-01c3e5e910ef@arm.com>
Date:   Tue, 29 Mar 2022 20:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arch/arm64: Fix topology initialization for core
 scheduling
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220322160304.26229-1-pauld@redhat.com>
 <1a546197-872b-7762-68ac-d5e6bb6d19aa@arm.com>
 <YkMjqfBSyT3NOrWB@lorien.usersys.redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <YkMjqfBSyT3NOrWB@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2022 17:20, Phil Auld wrote:
> On Tue, Mar 29, 2022 at 04:02:22PM +0200 Dietmar Eggemann wrote:
>> On 22/03/2022 17:03, Phil Auld wrote:

[...]

>> I assume this is for a machine which relies on MPIDR-based setup
>> (package_id == -1)? I.e. it doesn't have proper ACPI/(DT) data for
>> topology setup.
> 
> Yes, that's my understanding. No PPTT.
> 
>>
>> Tried on a ThunderX2 by disabling parse_acpi_topology() but then I end
>> up with a machine w/o SMT, so `stress-ng --prctl N` doesn't show this issue.
>>
>> Which machine were you using?
> 
> This instance is an HPE Apollo 70 set to smt-4.  I believe it's ThunderX2
> chips.
> 
> ARM (CN9980-2200LG4077-Y21-G) 
I'm using the same processor just with ACPI/PPTT.

# sudo dmidecode -t 4 | grep "Part Number"
	Part Number: CN9980-2200LG4077-21-Y-G
	Part Number: CN9980-2200LG4077-21-Y-G

# cat /sys/devices/system/cpu/cpu0/topology/thread_siblings
0,32,64,96

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
SMT
MC
NUMA

But no matter whether I disable parse_acpi_topology() or just force
`cpu_topology[cpu].package_id = -1` in this function, I always end up with:

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
MC
NUMA

# cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
0

so no SMT sched domain. The MPIDR-based topology fallback code in
store_cpu_topology() forces `cpuid_topo->thread_id  = -1`.

IMHO this is why on my machine I don't see this issue while running:

root@oss-apollo7007:~# stress-ng --prctl 256 -t 60
stress-ng: info:  [2388042] dispatching hogs: 256 prctl

Is there something I miss in my setup to provoke this issue?

[...]
