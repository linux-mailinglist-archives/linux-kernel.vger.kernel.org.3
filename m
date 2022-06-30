Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3A560EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiF3B6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF3B6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:58:12 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [210.0.225.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D80C248;
        Wed, 29 Jun 2022 18:58:06 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 30 Jun
 2022 09:58:03 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 30 Jun
 2022 09:58:01 +0800
Subject: Re: [PATCH V2] cpufreq: Add Zhaoxin/Centaur turbo boost control
 interface support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <c4f669a8-0da6-862a-0450-ddf178272bdd@zhaoxin.com>
 <CAJZ5v0iGQz0GprbHSL6JVmHv8y-kDsyW4TouN6JwJZtp46DokQ@mail.gmail.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <2d961645-75e4-de10-47d5-b3351c54fa0b@zhaoxin.com>
Date:   Thu, 30 Jun 2022 09:58:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iGQz0GprbHSL6JVmHv8y-kDsyW4TouN6JwJZtp46DokQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/6/2022 02:16, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2022 at 3:21 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>>
>> Recent Zhaoxin/Centaur CPUs support X86_FEATURE_IDA and the turbo boost
>> can be dynamically enabled or disabled through MSR 0x1a0[38] in the same
>> way as Intel. So add turbo boost control support for these CPUs too.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>    drivers/cpufreq/acpi-cpufreq.c | 4 ++++
>>    1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 3d514b8..1bb2b90 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -78,6 +78,8 @@ static bool boost_state(unsigned int cpu)
>>
>>          switch (boot_cpu_data.x86_vendor) {
>>          case X86_VENDOR_INTEL:
>> +       case X86_VENDOR_CENTAUR:
>> +       case X86_VENDOR_ZHAOXIN:
>>                  rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
>>                  msr = lo | ((u64)hi << 32);
>>                  return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
>> @@ -97,6 +99,8 @@ static int boost_set_msr(bool enable)
>>
>>          switch (boot_cpu_data.x86_vendor) {
>>          case X86_VENDOR_INTEL:
>> +       case X86_VENDOR_CENTAUR:
>> +       case X86_VENDOR_ZHAOXIN:
>>                  msr_addr = MSR_IA32_MISC_ENABLE;
>>                  msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
>>                  break;
>> --
> 
> Applied as 5.20 material.
> 

Thanks a lot.

> However, I had to manually fix up the formatting of the patch.
> 

Sorry for inconvenient.

> Can you please configure your e-mail client so that this is not
> necessary in the future?
> 

Was using the Thunderbird client to send patch, and will use git 
send-email in the future.

> Thanks!
> .
> 

-- 
Sincerely
TonyWWang-oc
