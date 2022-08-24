Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B059FCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiHXOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiHXOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5887AE74;
        Wed, 24 Aug 2022 07:04:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A0F21FB;
        Wed, 24 Aug 2022 07:04:53 -0700 (PDT)
Received: from [10.57.15.162] (unknown [10.57.15.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 714C53FAF5;
        Wed, 24 Aug 2022 07:04:46 -0700 (PDT)
Message-ID: <0d49c40d-02af-5190-76b0-e88f3622ab7a@arm.com>
Date:   Wed, 24 Aug 2022 15:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: Change FIE default
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.or, lenb@kernel.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-3-jeremy.linton@arm.com>
 <20220824061430.3aflygc4gno5j47y@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220824061430.3aflygc4gno5j47y@vireshk-i7>
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

Hi Viresh,

+CC Dietmar, Morten and Souvik

On 8/24/22 07:14, Viresh Kumar wrote:
> On 18-08-22, 16:16, Jeremy Linton wrote:
>> FIE is mostly implemented as PCC mailboxes on arm machines.  This was
>> enabled by default without any data suggesting that it does anything
>> but hurt system performance. Lets change the default to 'n' until
>> hardware appears which clearly benefits.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/cpufreq/Kconfig.arm | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 954749afb5fe..ad66d8f15db0 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -22,7 +22,7 @@ config ACPI_CPPC_CPUFREQ
>>   config ACPI_CPPC_CPUFREQ_FIE
>>   	bool "Frequency Invariance support for CPPC cpufreq driver"
>>   	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
>> -	default y
>> +	default n
>>   	help
>>   	  This extends frequency invariance support in the CPPC cpufreq driver,
>>   	  by using CPPC delivered and reference performance counters.
> 
> Why is this required after we have the first patch in ?
> 

There are a few issues with this ACPI_CPPC_CPUFREQ_FIE solution:
1. The design is very heavy and that kernel thread can be ~512 util
    (that's what we have been told by one of our partners from servers'
    world)
2. The HW & FW design is not suited for this task. Newer HW will just
    have AMU counters (on Arm64) for FIE
3. The patches haven't been tested in terms of performance overhead
    AFAIK. Although, it affects existing Arm64 servers with their
    workloads.
4. AFAIK non of our server partners wasn't complaining about issues with
    old FIE mechanism.

In our team we are not allowed to send code that we cannot prove in many
ways.

I would just not compile this at all (or even revert this feature).
If someone compiled in this by accident - make sure we disable it
after checks like in the patch 1/2. I'll add also some comments
to that patch.

Regards,
Lukasz



