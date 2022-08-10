Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B058F1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiHJRn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiHJRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:43:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 744ED832FC;
        Wed, 10 Aug 2022 10:43:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2E1F11FB;
        Wed, 10 Aug 2022 10:43:26 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD303F67D;
        Wed, 10 Aug 2022 10:43:26 -0700 (PDT)
Message-ID: <167502fa-d0ac-c834-170f-0f0d4e912819@arm.com>
Date:   Wed, 10 Aug 2022 12:43:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in PCC
 regions
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, vschneid@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220728221043.4161903-1-jeremy.linton@arm.com>
 <20220728221043.4161903-2-jeremy.linton@arm.com>
 <3a5e7abd-9361-11ba-978d-8e8bae00ea31@arm.com> <YvOpy69JkluN4ITK@arm.com>
Content-Language: en-US
In-Reply-To: <YvOpy69JkluN4ITK@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/10/22 07:51, Ionela Voinescu wrote:
> Hi folks,
> 
> On Wednesday 10 Aug 2022 at 13:29:08 (+0100), Lukasz Luba wrote:
>> Hi Jeremy,
>>
>> +CC Valentin since he might be interested in this finding
>> +CC Ionela, Dietmar
>>
>> I have a few comments for this patch.
>>
>>
>> On 7/28/22 23:10, Jeremy Linton wrote:
>>> PCC regions utilize a mailbox to set/retrieve register values used by
>>> the CPPC code. This is fine as long as the operations are
>>> infrequent. With the FIE code enabled though the overhead can range
>>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>>> based machines.
>>>
>>> So, before enabling FIE assure none of the registers used by
>>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>>> enable a module parameter which can also disable it at boot or module
>>> reload.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>    drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>>>    drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>>    include/acpi/cppc_acpi.h       |  5 +++++
>>>    3 files changed, 61 insertions(+), 4 deletions(-)
>>
>>
>> 1. You assume that all platforms would have this big overhead when
>>     they have the PCC regions for this purpose.
>>     Do we know which version of HW mailbox have been implemented
>>     and used that have this 2-11% overhead in a platform?
>>     Do also more recent MHU have such issues, so we could block
>>     them by default (like in your code)?
>>
>> 2. I would prefer to simply change the default Kconfig value to 'n' for
>>     the ACPI_CPPC_CPUFREQ_FIE, instead of creating a runtime
>>     check code which disables it.
>>     We have probably introduce this overhead for older platforms with
>>     this commit:
>>
>> commit 4c38f2df71c8e33c0b64865992d693f5022eeaad
>> Author: Viresh Kumar <viresh.kumar@linaro.org>
>> Date:   Tue Jun 23 15:49:40 2020 +0530
>>
>>      cpufreq: CPPC: Add support for frequency invariance
>>
>>
>>
>> If the test server with this config enabled performs well
>> in the stress-tests, then on production server the config may be
>> set to 'y' (or 'm' and loaded).
>>
>> I would vote to not add extra code, which then after a while might be
>> decided to bw extended because actually some HW is actually capable (so
>> we could check in runtime and enable it). IMO this create an additional
>> complexity in our diverse configuration/tunnable space in our code.
>>
> 
> I agree that having CONFIG_ACPI_CPPC_CPUFREQ_FIE default to no is the
> simpler solution but it puts the decision in the hands of platform
> providers which might result in this functionality not being used most
> of the times, if at all. This being said, the use of CPPC counters is
> meant as a last resort for FIE, if the platform does not have AMUs. This
> is why I recommended this to default to no in the review of the original
> patches.
> 
> But I don't see these runtime options as adding a lot of complexity
> and therefore agree with the idea of this patch, versus the config
> change above, with two design comments:
>   - Rather than having a check for fie_disabled in multiple init and exit
>     functions I think the code should be slightly redesigned to elegantly
>     bail out of most functions if cppc_freq_invariance_init() failed.

I'm not sure what that would look like, I will have to mess with it a 
bit more, but as you can see its really just the two init entry points 
(one for the module, and one for the registered cpufreq), and their 
associated exit's which I'm not sure I see a way to simplify that short 
of maybe creating a second cpufreq_driver table, which replaces the 
.init calls with ones which include cppc_cpufreq_cpu_fie_init. The 
alternative is runtime setting the .init to switch between an init with 
FIE and one without. I'm not sure that clarifies what is happening in 
the code, and I thought in general dynamic runtime dispatch was to be 
avoided in the ACPI code when possible. Neither choice of course affects 
actual runtime because they are both firing during module load/unload.


>   - Given the multiple options to disable this functionality (config,
>     PCC check), I don't see a need for a module parameter or runtime user
>     input, unless we make that overwrite all previous decisions, as in: if
>     CONFIG_ACPI_CPPC_CPUFREQ_FIE=y, even if cppc_perf_ctrs_in_pcc(), if
>     the fie_disabled module parameter is no, then counters should be used
>     for FIE.

Tristating the module parameter with default=detect, ON, OFF is a 
reasonable idea, and one I considered, but ignored because in the hisi 
quirk case even with ON it will have to be OFF, so it really ends up 
with 4 states default=detect, request ON, ON, OFF.

I'm good with any of this if people feel strongly about it.

> 
> Thanks,
> Ionela.
> 
> 
>> When we don't compile-in this, we should fallback to old-style
>> FIE, which has been used on these old platforms.
>>
>> BTW (I have to leave it here) the first-class solution for those servers
>> is to implement AMU counters, so the overhead to retrieve this info is
>> really low.
>>
>> Regards,
>> Lukasz


Thanks for looking at this!
