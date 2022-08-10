Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E623D58EDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiHJOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiHJOIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:08:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202086F554;
        Wed, 10 Aug 2022 07:08:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977861FB;
        Wed, 10 Aug 2022 07:08:20 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2B13F67D;
        Wed, 10 Aug 2022 07:08:19 -0700 (PDT)
Message-ID: <6f565c2d-e7cb-f5a2-0b38-995c9cd2deec@arm.com>
Date:   Wed, 10 Aug 2022 09:08:14 -0500
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
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <3a5e7abd-9361-11ba-978d-8e8bae00ea31@arm.com>
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

On 8/10/22 07:29, Lukasz Luba wrote:
> Hi Jeremy,
> 
> +CC Valentin since he might be interested in this finding
> +CC Ionela, Dietmar
> 
> I have a few comments for this patch.
> 
> 
> On 7/28/22 23:10, Jeremy Linton wrote:
>> PCC regions utilize a mailbox to set/retrieve register values used by
>> the CPPC code. This is fine as long as the operations are
>> infrequent. With the FIE code enabled though the overhead can range
>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>> based machines.
>>
>> So, before enabling FIE assure none of the registers used by
>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>> enable a module parameter which can also disable it at boot or module
>> reload.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>   include/acpi/cppc_acpi.h       |  5 +++++
>>   3 files changed, 61 insertions(+), 4 deletions(-)
> 
> 
> 1. You assume that all platforms would have this big overhead when
>     they have the PCC regions for this purpose.
>     Do we know which version of HW mailbox have been implemented
>     and used that have this 2-11% overhead in a platform?
>     Do also more recent MHU have such issues, so we could block
>     them by default (like in your code)?

Well, the mailbox nature of PCC pretty much assures its "slow", relative 
the alternative of providing an actual register.  If a platform provides 
direct access to say MHU registers, then of course they won't actually 
be in a PCC region and the FIE will remain on.


> 
> 2. I would prefer to simply change the default Kconfig value to 'n' for
>     the ACPI_CPPC_CPUFREQ_FIE, instead of creating a runtime
>     check code which disables it.
>     We have probably introduce this overhead for older platforms with
>     this commit:

The problem here is that these ACPI kernels are being shipped as single 
images in distro's which expect them to run on a wide range of platforms 
(including x86/amd in this case), and preform optimally on all of them.

So the 'n' option basically is saying that the latest FIE code doesn't 
provide a befit anywhere?


> 
> commit 4c38f2df71c8e33c0b64865992d693f5022eeaad
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Jun 23 15:49:40 2020 +0530
> 
>      cpufreq: CPPC: Add support for frequency invariance
> 
> 
> 
> If the test server with this config enabled performs well
> in the stress-tests, then on production server the config may be
> set to 'y' (or 'm' and loaded).
> 
> I would vote to not add extra code, which then after a while might be
> decided to bw extended because actually some HW is actually capable (so
> we could check in runtime and enable it). IMO this create an additional
> complexity in our diverse configuration/tunnable space in our code.
> 
> When we don't compile-in this, we should fallback to old-style
> FIE, which has been used on these old platforms.
> 
> BTW (I have to leave it here) the first-class solution for those servers
> is to implement AMU counters, so the overhead to retrieve this info is
> really low.
> 
> Regards,
> Lukasz

