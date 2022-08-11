Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013AD58F88B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiHKHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:45:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77D828E1E;
        Thu, 11 Aug 2022 00:45:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C2B8113E;
        Thu, 11 Aug 2022 00:45:15 -0700 (PDT)
Received: from [10.57.15.253] (unknown [10.57.15.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 400D03F5A1;
        Thu, 11 Aug 2022 00:45:12 -0700 (PDT)
Message-ID: <cf34fb7a-ba5f-112f-93d1-36fe9a26f2f4@arm.com>
Date:   Thu, 11 Aug 2022 08:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, vschneid@redhat.com,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220728221043.4161903-1-jeremy.linton@arm.com>
 <20220728221043.4161903-2-jeremy.linton@arm.com>
 <3a5e7abd-9361-11ba-978d-8e8bae00ea31@arm.com>
 <4da7cd19-4b98-9360-922f-d625c4ec55e0@arm.com>
 <a7248e0c-f8cc-a7f1-f241-75faa7219961@arm.com>
 <2d0fc5d7-d484-f64c-fe50-18d18ad95fa2@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2d0fc5d7-d484-f64c-fe50-18d18ad95fa2@arm.com>
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



On 8/10/22 16:32, Pierre Gondois wrote:
> 
> 
> On 8/10/22 16:37, Lukasz Luba wrote:
>>
>>
>> On 8/10/22 15:30, Jeremy Linton wrote:
>>> Hi,
>>>
>>> On 8/10/22 07:29, Lukasz Luba wrote:
>>>> Hi Jeremy,
>>>>
>>>> +CC Valentin since he might be interested in this finding
>>>> +CC Ionela, Dietmar
>>>>
>>>> I have a few comments for this patch.
>>>>
>>>>
>>>> On 7/28/22 23:10, Jeremy Linton wrote:
>>>>> PCC regions utilize a mailbox to set/retrieve register values used by
>>>>> the CPPC code. This is fine as long as the operations are
>>>>> infrequent. With the FIE code enabled though the overhead can range
>>>>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>>>>> based machines.
>>>>>
>>>>> So, before enabling FIE assure none of the registers used by
>>>>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>>>>> enable a module parameter which can also disable it at boot or module
>>>>> reload.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> ---
>>>>>    drivers/acpi/cppc_acpi.c       | 41 
>>>>> ++++++++++++++++++++++++++++++++++
>>>>>    drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>>>>    include/acpi/cppc_acpi.h       |  5 +++++
>>>>>    3 files changed, 61 insertions(+), 4 deletions(-)
>>>>
>>>>
>>>> 1. You assume that all platforms would have this big overhead when
>>>>      they have the PCC regions for this purpose.
>>>>      Do we know which version of HW mailbox have been implemented
>>>>      and used that have this 2-11% overhead in a platform?
>>>>      Do also more recent MHU have such issues, so we could block
>>>>      them by default (like in your code)?
>>>
>>> I posted that other email before being awake and conflated MHU with AMU
>>> (which could potentially expose the values directly). But the CPPC code
>>> isn't aware of whether a MHU or some other mailbox is in use. Either
>>> way, its hard to imagine a general mailbox with a doorbell/wait for
>>> completion handshake will ever be fast enough to consider running at the
>>> granularity this code is running at. If there were a case like that, the
>>> kernel would have to benchmark it at runtime to differentiate it from
>>> something that is talking over a slow link to a slowly responding mgmt
>>> processor.
>>
>> Exactly, I'm afraid the same, that we would never get such fast
>> mailbox-based platform. Newer platforms would just use AMU, so
>> completely different code and no one would even bother to test if
>> their HW mailbox is fast-enough for this FIE purpose ;)
> 
> To add some platform information, the following platforms are using
> CPPC through PCC channels (so mailboxes):
> - Cavium ThunderX2
> - Ampere eMAG
> - Ampere Altra
> 
> Fwiw, I can confirm the cppc_fie kthread can represent a significant load,
> with a utilization between 2% and 30%.
> 

Thank you Pierre for the test results. I have been also told about some
platform under stress-test having cppc_fie kthread "up to 50% CPU
utilization". I don't know how many additional wake-ups they would see.

We also don't know if the tasks utilization thanks to that feature on
these machine is noticeable better (or if it was an issue at the
begging).

These numbers are not acceptable on a server.
