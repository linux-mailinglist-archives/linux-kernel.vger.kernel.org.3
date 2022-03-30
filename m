Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54B4EC8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbiC3Pu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbiC3PuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:50:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACCD72E095
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:48:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4945223A;
        Wed, 30 Mar 2022 08:48:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256963F73B;
        Wed, 30 Mar 2022 08:48:36 -0700 (PDT)
Message-ID: <5dc3a40e-f071-3ac8-4bf0-f555b9d94ff1@arm.com>
Date:   Wed, 30 Mar 2022 17:48:34 +0200
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
 <5a5381cd-813d-7cef-9948-01c3e5e910ef@arm.com>
 <YkNjGOtG6eb4N8mI@lorien.usersys.redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <YkNjGOtG6eb4N8mI@lorien.usersys.redhat.com>
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

On 29/03/2022 21:50, Phil Auld wrote:
> On Tue, Mar 29, 2022 at 08:55:08PM +0200 Dietmar Eggemann wrote:
>> On 29/03/2022 17:20, Phil Auld wrote:
>>> On Tue, Mar 29, 2022 at 04:02:22PM +0200 Dietmar Eggemann wrote:
>>>> On 22/03/2022 17:03, Phil Auld wrote:

[...]

>>> This instance is an HPE Apollo 70 set to smt-4.  I believe it's ThunderX2
>>> chips.
>>>
>>> ARM (CN9980-2200LG4077-Y21-G) 
>> I'm using the same processor just with ACPI/PPTT.
>>
> 
> Maybe I'm misinformed about these systems having no PPTT...  
> 
> I'm reclaiming the system. Is there a way I can tell from userspace?

# cat /sys/firmware/acpi/tables/PPTT > pptt.dat
# iasl -d pptt.dat
# vim pptt.dsl

[...]

>> so no SMT sched domain. The MPIDR-based topology fallback code in
>> store_cpu_topology() forces `cpuid_topo->thread_id  = -1`.
> 
> Right. So since I'm getting SMT it must not have package_id == -1.
> In which case you should be able to reproduce it because it must
> be that the call the update_siblings_masks() is required.  That
> appears to only be called from store_cpu_topology() which is
> after the scheduler has already setup the core pointers.
> 
> The fix could be the same but I should reword the commit message
> since it should effect all SMT arm systems I'd think.
> 
> Or maybe the ACPI topology code should call update_sibling_masks(). 
>>
>> IMHO this is why on my machine I don't see this issue while running:
>>
>> root@oss-apollo7007:~# stress-ng --prctl 256 -t 60
>> stress-ng: info:  [2388042] dispatching hogs: 256 prctl
>>
>> Is there something I miss in my setup to provoke this issue?
>>
> 
> Make sure you have a stress-ng that is new enough and built against
> headers that have the CORE_SCHED prctls defined.

Ah, I was using a pretty old version 0.11.07. Now I switched to 0.13.12
which includes:

  9038e442b92d - stress-prctl: add Linux 5.14 PR_SCHED_CORE prctl

To get SCHED_CORE activated in stress-prctl.c, as a quick hack, I had to
add the definitions of PR_SCHED_CORE, PR_SCHED_CORE_GET, etc. to this file.

Now the issue you described triggers on this machine immediately.
