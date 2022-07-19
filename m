Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF5579180
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiGSDvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiGSDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:51:32 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 20:51:30 PDT
Received: from ZXBJCAS.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51A28E1F;
        Mon, 18 Jul 2022 20:51:29 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXBJCAS.zhaoxin.com
 (10.29.252.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 19 Jul
 2022 11:36:11 +0800
Received: from [10.32.64.15] (10.32.64.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 19 Jul
 2022 11:36:09 +0800
Subject: Re: [PATCH] x86/cstate: Replace vendor check with X86_FEATURE_MWAIT
 in ffh_cstate_init
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        <venkatesh.pallipadi@intel.com>, <yazen.ghannam@amd.com>,
        <puwen@hygon.cn>
References: <1656659147-20396-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <CAJZ5v0jXZKECfaJ0fqx+Hb5vhaw6uFgOaJD1BxwRUjOfMXMJJQ@mail.gmail.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <993cf518-0ec6-639d-039a-6a2a1b1b5793@zhaoxin.com>
Date:   Tue, 19 Jul 2022 11:36:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jXZKECfaJ0fqx+Hb5vhaw6uFgOaJD1BxwRUjOfMXMJJQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.64.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/6 上午2:45, Rafael J. Wysocki wrote:
> On Fri, Jul 1, 2022 at 9:05 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>>
>> The original commit 991528d73486 ("ACPI: Processor native C-states using
>> MWAIT") has a vendor check for Intel in the function of ffh_cstate_init().
>>
>> Commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
>> systems") and commit 280b68a3b3b9 ("x86/cstate: Allow ACPI C1 FFH MWAIT
>> use on Hygon systems") add vendor check for AMD and HYGON in the function
>> of ffh_cstate_init().
>>
>> Recent Zhaoxin and Centaur CPUs support MONITOR/MWAIT instructions that
>> can be used for ACPI Cx state in the same way as Intel. So expected to
>> add the support of these CPUs in the function of ffh_cstate_init() too.
>>
>> The CPU feature X86_FEATURE_MWAIT indicates processor supports MONITOR/
>> MWAIT instructions. So the check for many CPU vendors in ffh_cstate_init()
>> is unnecessary, use X86_FEATURE_MWAIT to replace the CPU vendor check.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

Thanks a lot.
Add some original commit authors this patch related to.

> or please let me know if I'm expected to pick up this one.  Thanks!
> 

Yes for me. Thanks a lot.

> 
>> ---
>>   arch/x86/kernel/acpi/cstate.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index 7945eae..a64c38f 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -209,11 +209,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
>>
>>   static int __init ffh_cstate_init(void)
>>   {
>> -       struct cpuinfo_x86 *c = &boot_cpu_data;
>> -
>> -       if (c->x86_vendor != X86_VENDOR_INTEL &&
>> -           c->x86_vendor != X86_VENDOR_AMD &&
>> -           c->x86_vendor != X86_VENDOR_HYGON)
>> +       if (!boot_cpu_has(X86_FEATURE_MWAIT))
>>                  return -1;
>>
>>          cpu_cstate_entry = alloc_percpu(struct cstate_entry);
>> --
>> 2.7.4
>>
> .
> 
