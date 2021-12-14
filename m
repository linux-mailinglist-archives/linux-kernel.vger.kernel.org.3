Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAD473E80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhLNImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:42:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29190 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhLNImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:42:01 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JCsJ33QHqz8vr0;
        Tue, 14 Dec 2021 16:39:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 16:41:59 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 16:41:58 +0800
Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
To:     Baoquan He <bhe@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-2-thunder.leizhen@huawei.com>
 <20211213131713.GA23510@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6ad868b9-6c00-f515-074d-e6f980fea7fa@huawei.com>
Date:   Tue, 14 Dec 2021 16:41:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211213131713.GA23510@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/13 21:17, Baoquan He wrote:
> On 12/10/21 at 02:55pm, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> Move CRASH_ALIGN to header asm/kexec.h for later use.
>>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Suggested-by: Baoquan He <bhe@redhat.com>
> 
> I remember Dave and I discussed and suggested this when reviewing.
> You can remove my Suggested-by.

OK, I will do it.

> 
> For this one, I would like to add ack:
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>> ---
>>  arch/x86/include/asm/kexec.h | 3 +++
>>  arch/x86/kernel/setup.c      | 3 ---
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 11b7c06e2828c30..3a22e65262aa70b 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -18,6 +18,9 @@
>>  
>>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>>  
>> +/* 16M alignment for crash kernel regions */
>> +#define CRASH_ALIGN		SZ_16M
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/string.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 6a190c7f4d71b05..5cc60996eac56d6 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -392,9 +392,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>>  
>> -/* 16M alignment for crash kernel regions */
>> -#define CRASH_ALIGN		SZ_16M
>> -
>>  /*
>>   * Keep the crash kernel below this limit.
>>   *
>> -- 
>> 2.25.1
>>
> 
> .
> 
