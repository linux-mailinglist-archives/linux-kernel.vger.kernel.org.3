Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C92558EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFXDF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiFXDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:05:23 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [210.0.225.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBE33F;
        Thu, 23 Jun 2022 20:05:17 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 24 Jun
 2022 11:05:15 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 24 Jun
 2022 11:05:13 +0800
Subject: Re: [PATCH V1] x86/cstate: Add Zhaoxin/Centaur ACPI Cx FFH MWAIT
 support
To:     Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <0b583b7e-dcd3-be51-f367-1c12ac841d3f@zhaoxin.com>
 <ec121630-1ee5-1336-1ed4-04506f0c4129@intel.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <e4fd583f-dafd-e2b5-7880-f12684f3e252@zhaoxin.com>
Date:   Fri, 24 Jun 2022 11:05:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ec121630-1ee5-1336-1ed4-04506f0c4129@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 23/6/2022 23:55, Dave Hansen wrote:
> On 6/22/22 18:26, Tony W Wang-oc wrote:
>> Recent Zhaoxin/Centaur CPUs support X86_FEATURE_MWAIT that implies
>> the MONITOR/MWAIT instructions can be used for ACPI Cx state.
>> The BIOS declares Cx state in _CST object to use FFH on Zhaoxin/Centaur
>> systems. So let function ffh_cstate_init() support These CPUs too.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>   arch/x86/kernel/acpi/cstate.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index 7945eae..d4185e1 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -213,7 +213,9 @@ static int __init ffh_cstate_init(void)
>>
>>       if (c->x86_vendor != X86_VENDOR_INTEL &&
>>           c->x86_vendor != X86_VENDOR_AMD &&
>> -        c->x86_vendor != X86_VENDOR_HYGON)
>> +        c->x86_vendor != X86_VENDOR_HYGON &&
>> +        c->x86_vendor != X86_VENDOR_CENTAUR &&
>> +        c->x86_vendor != X86_VENDOR_ZHAOXIN)
>>           return -1;
> 
> Many of the changelogs that add new vendors here go on about particular
> C states declared in the _CST object and contents of CPUID leaf 5.
> 
> Why do we even _have_ a vendor check here?  Shouldn't the code just be
> going and doing the validation of the _CST object and CPUID that the
> changelogs blather on about?
> 

Yes, agree!

Will change as below. Please help to check if it is OK. Thanks a lot.
  static int __init ffh_cstate_init(void)
  {
-       struct cpuinfo_x86 *c = &boot_cpu_data;
-
-       if (c->x86_vendor != X86_VENDOR_INTEL &&
-           c->x86_vendor != X86_VENDOR_AMD &&
-           c->x86_vendor != X86_VENDOR_HYGON)
+       if (!boot_cpu_has(X86_FEATURE_MWAIT))
                 return -1;

> Intel certainly made the original sin on this one (see 991528d7348), but
> I hope _something_ changed in the 16 years since that patch went in.
> .
> 

-- 
Sincerely
TonyWWang-oc
