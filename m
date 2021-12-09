Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8D46E09F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhLICCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:02:48 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29107 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhLICCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:02:48 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J8cZt1sw4z1DK2C;
        Thu,  9 Dec 2021 09:56:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:59:13 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:59:12 +0800
Subject: Re: [PATCH v16 10/11] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-11-thunder.leizhen@huawei.com>
 <YaaitPTArUZEriob@robh.at.kernel.org>
 <0dc664f7-65ae-767c-3fe6-d1bcf50d41e1@huawei.com>
Message-ID: <281c8196-2a5c-28cf-346a-0ae2f7182f1b@huawei.com>
Date:   Thu, 9 Dec 2021 09:59:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0dc664f7-65ae-767c-3fe6-d1bcf50d41e1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/1 10:55, Leizhen (ThunderTown) wrote:
>>> +	}
>>>  
>>> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>>> +	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
>>> +	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
>> s/ &&/,/

Hi Rob:
  I want to keep "&&" unchanged, do you mind? I'm going to post an
updated version tomorrow, hopefully the last.

> Hi Rob:
> 
> The comma operator may not be suitable for logical judgment. The logical judgment
> before commas (,) is ignored.
> 
> Here's my test：
> 
> C code：
> int main()
> {
>         int i, j;
> 
>         printf("&&:\n");
>         for (i = 0, j = 0; i < 2 && j < 3; i++, j++)
>                 printf("i=%d, j=%d\n", i, j);
> 
>         printf("\ncomma:\n");
>         for (i = 0, j = 0; i < 2, j < 3; i++, j++)	//(i < 2） before comma is ignored
>                 printf("i=%d, j=%d\n", i, j);
> 
>         return 0;
> }
> 
> Output：
> &&:
> i=0, j=0
> i=1, j=1
> 
> comma:
> i=0, j=0
> i=1, j=1
> i=2, j=2
> 
> 
