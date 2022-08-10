Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DB58F216
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiHJSEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHJSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:04:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5600A2AE1E;
        Wed, 10 Aug 2022 11:04:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE9BA11FB;
        Wed, 10 Aug 2022 11:04:21 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBC0E3F5A1;
        Wed, 10 Aug 2022 11:04:20 -0700 (PDT)
Message-ID: <151b17e9-5342-69e0-aea3-ec5b14bf5d83@arm.com>
Date:   Wed, 10 Aug 2022 13:04:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, vschneid@redhat.com,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220728221043.4161903-1-jeremy.linton@arm.com>
 <20220728221043.4161903-2-jeremy.linton@arm.com>
 <3a5e7abd-9361-11ba-978d-8e8bae00ea31@arm.com>
 <6f565c2d-e7cb-f5a2-0b38-995c9cd2deec@arm.com>
 <64ba1dfb-a475-e667-b59d-57e5d1e5ff1f@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <64ba1dfb-a475-e667-b59d-57e5d1e5ff1f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/10/22 09:32, Lukasz Luba wrote:
> 
> 
> On 8/10/22 15:08, Jeremy Linton wrote:
>> Hi,
>>
>> On 8/10/22 07:29, Lukasz Luba wrote:
>>> Hi Jeremy,
>>>
>>> +CC Valentin since he might be interested in this finding
>>> +CC Ionela, Dietmar
>>>
>>> I have a few comments for this patch.
>>>
>>>
>>> On 7/28/22 23:10, Jeremy Linton wrote:
>>>> PCC regions utilize a mailbox to set/retrieve register values used by
>>>> the CPPC code. This is fine as long as the operations are
>>>> infrequent. With the FIE code enabled though the overhead can range
>>>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>>>> based machines.
>>>>
>>>> So, before enabling FIE assure none of the registers used by
>>>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>>>> enable a module parameter which can also disable it at boot or module
>>>> reload.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>   drivers/acpi/cppc_acpi.c       | 41 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>>>   include/acpi/cppc_acpi.h       |  5 +++++
>>>>   3 files changed, 61 insertions(+), 4 deletions(-)
>>>
>>>
>>> 1. You assume that all platforms would have this big overhead when
>>>     they have the PCC regions for this purpose.
>>>     Do we know which version of HW mailbox have been implemented
>>>     and used that have this 2-11% overhead in a platform?
>>>     Do also more recent MHU have such issues, so we could block
>>>     them by default (like in your code)?
>>
>> Well, the mailbox nature of PCC pretty much assures its "slow", 
>> relative the alternative of providing an actual register.  If a 
>> platform provides direct access to say MHU registers, then of course 
>> they won't actually be in a PCC region and the FIE will remain on.
>>
>>
>>>
>>> 2. I would prefer to simply change the default Kconfig value to 'n' for
>>>     the ACPI_CPPC_CPUFREQ_FIE, instead of creating a runtime
>>>     check code which disables it.
>>>     We have probably introduce this overhead for older platforms with
>>>     this commit:
>>
>> The problem here is that these ACPI kernels are being shipped as 
>> single images in distro's which expect them to run on a wide range of 
>> platforms (including x86/amd in this case), and preform optimally on 
>> all of them.
>>
>> So the 'n' option basically is saying that the latest FIE code doesn't 
>> provide a befit anywhere?
> 
> How we define the 'benefit' here - it's a better task utilization.
> How much better it would be vs. previous approach with old-style FIE?
> 
> TBH, I haven't found any test results from the development of the patch
> set. Maybe someone could point me to the test results which bring
> this benefit of better utilization.
> 
> In the RFC I could find that statement [1]:
> 
> "This is tested with some hacks, as I didn't have access to the right
> hardware, on the ARM64 hikey board to check the overall functionality
> and that works fine."
> 
> There should be a rule that such code is tested on a real server with
> many CPUs under some stress-test.
> 
> Ionela do you have some test results where this new FIE feature
> introduces some better & meaningful accuracy improvement to the
> tasks utilization?
> 
> With this overhead measured on a real server platform I think
> it's not worth to keep it 'y' in default.
> 
> The design is heavy, as stated in the commit message:
> "    On an invocation of cppc_scale_freq_tick(), we schedule an irq work
>      (since we reach here from hard-irq context), which then schedules a
>      normal work item and cppc_scale_freq_workfn() updates the per_cpu
>      arch_freq_scale variable based on the counter updates since the last
>      tick.
> "
> 
> As you said Jeremy, this mailbox would always be with overhead. IMO
> untill we cannot be sure we have some powerful new HW mailbox, this
> feature should be disabled.


Right, the design of the feature would be completely different if it 
were a simple register read to get the delivered perf avoiding all the 
jumping around you quoted.

Which sorta implies that its not really fixable as is, which IMHO means 
that 'n' isn't really strong enough, it should probably be under 
CONFIG_EXPERT as well if such a change were made to discourage its use.

> 
> [1] 
> https://lore.kernel.org/lkml/cover.1594289009.git.viresh.kumar@linaro.org/

