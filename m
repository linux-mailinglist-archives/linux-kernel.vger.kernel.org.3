Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6828E52B7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiERKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiERKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:34:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AA4426F8;
        Wed, 18 May 2022 03:34:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CCF723A;
        Wed, 18 May 2022 03:34:46 -0700 (PDT)
Received: from [192.168.1.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1DF3F718;
        Wed, 18 May 2022 03:34:43 -0700 (PDT)
Message-ID: <16566ef8-15d3-bf1b-37f2-c0b94b0493bc@arm.com>
Date:   Wed, 18 May 2022 12:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/5] ACPI: CPPC: Check _OSC for flexible address space
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        dietmar.eggemann@arm.com, sudeep.holla@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
References: <20220518090901.2724518-1-pierre.gondois@arm.com>
 <20220518094243.6oxbdmf226jvqoef@viresh-thinkpad>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20220518094243.6oxbdmf226jvqoef@viresh-thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/22 11:42, Viresh Kumar wrote:
> On 18-05-22, 11:08, Pierre Gondois wrote:
>> ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
>>    Starting with ACPI Specification 6.2, all _CPC registers can be in
>>    PCC, System Memory, System IO, or Functional Fixed Hardware address
>>    spaces. OSPM support for this more flexible register space scheme is
>>    indicated by the “Flexible Address Space for CPPC Registers” _OSC bit
>>
>> Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
>> - PCC or Functional Fixed Hardware address space if defined
>> - SystemMemory address space (NULL register) if not defined
>>
>> Add the corresponding _OSC bit and check it when parsing _CPC objects.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/acpi/bus.c       | 18 ++++++++++++++++++
>>   drivers/acpi/cppc_acpi.c |  9 +++++++++
>>   include/linux/acpi.h     |  2 ++
>>   3 files changed, 29 insertions(+)
> 
> It would be much useful to get a cover letter for this series with
> what you have changed since the previous version. It is almost
> impossible to find that out otherwise.
> 

Yes indeed, sorry for that, the changelog is:
v2:
[1/5] ACPI: CPPC: Check _OSC for flexible address space
- Renamed OSC_SB_CPC_FLEXIBLE_ADR_SP to OSC_SB_CPC_FLEXIBLE_ADR_SPACE
[3/5] ACPI: CPPC: Assume no transition latency if no PCCT
and
[4/5] cpufreq: CPPC: Enable fast_switch
- Renamed CPC_IN_SIO to CPC_IN_SYSTEM_IO
- Renamed CPC_IN_SM to CPC_IN_SYSTEM_MEMORY

or do you prefer to have the serie re-submitted ?

Regards,
Pierre
