Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69884556FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiFWBKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFWBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:10:44 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [210.0.225.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF230F68;
        Wed, 22 Jun 2022 18:10:41 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 23 Jun
 2022 09:10:38 +0800
Received: from [10.32.64.1] (10.32.64.1) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 23 Jun
 2022 09:10:36 +0800
Subject: Re: [PATCH] x86/cstate: Add Zhaoxin ACPI Cx FFH MWAIT support
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
        <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <bccae278-e735-4681-cb3a-41359e42032b@zhaoxin.com>
 <CAJZ5v0i78UPYpc9epEOndigxAsj3YVXJJTrQDoX0Dw5p-zpgaQ@mail.gmail.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <61d5a117-c0d8-8752-5d70-b383530aef86@zhaoxin.com>
Date:   Thu, 23 Jun 2022 09:10:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i78UPYpc9epEOndigxAsj3YVXJJTrQDoX0Dw5p-zpgaQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/6/2022 21:38, Rafael J. Wysocki wrote:
> Please CC linux-acpi@vger.kernel.org on ACPI-related changes (added now).

Ok.

> 
> On Wed, Jun 22, 2022 at 5:29 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>>
>> Recent Zhaoxin CPUs support X86_FEATURE_MWAIT that implies the
>> MONITOR/MWAIT instructions can be used for ACPI Cx state. The BIOS
>> declares Cx state in _CST object to use FFH on Zhaoxin systems. So
>> let function ffh_cstate_init() support Zhaoxin too.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>    arch/x86/kernel/acpi/cstate.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index 7945eae..d4185e1 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -213,7 +213,9 @@ static int __init ffh_cstate_init(void)
>>
>>          if (c->x86_vendor != X86_VENDOR_INTEL &&
>>              c->x86_vendor != X86_VENDOR_AMD &&
>> -           c->x86_vendor != X86_VENDOR_HYGON)
>> +           c->x86_vendor != X86_VENDOR_HYGON &&
>> +           c->x86_vendor != X86_VENDOR_CENTAUR &&
>> +           c->x86_vendor != X86_VENDOR_ZHAOXIN)
> 
> Centaur is not mentioned in the changelog and it should be.

Will add Centaur in the changelog. Thanks a lot.

> 
>>                  return -1;
>>
>>          cpu_cstate_entry = alloc_percpu(struct cstate_entry);
>> --
> .
> 

-- 
Sincerely
TonyWWang-oc
