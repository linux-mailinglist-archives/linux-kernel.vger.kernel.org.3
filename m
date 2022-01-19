Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1666B493AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbiASM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:58:02 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17354 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiASM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:58:02 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jf5Hx5S6gz9s5T;
        Wed, 19 Jan 2022 20:56:45 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 20:57:59 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 20:57:58 +0800
Message-ID: <f0dd59eb-6eb8-5b60-508d-7f4022f655ec@huawei.com>
Date:   Wed, 19 Jan 2022 20:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Let user to control huge vmalloc
 default behavior
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
        <x86@kernel.org>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
 <20211227145903.187152-2-wangkefeng.wang@huawei.com>
 <1642473992.qrnqczjfna.astroid@bobo.none>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1642473992.qrnqczjfna.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/1/18 10:52, Nicholas Piggin wrote:
> Excerpts from Kefeng Wang's message of December 28, 2021 12:59 am:
>> Introduce HUGE_VMALLOC_DEFAULT_ENABLED and make it default y, this
>> let user to choose whether or not enable huge vmalloc mappings by
>> default.
>>
>> Meanwhile, add new hugevmalloc=on/off parameter to enable or disable
>> this feature at boot time, nohugevmalloc is still supported and
>> equivalent to hugevmalloc=off.
> Runtime options are bad enough, Kconfig and boot options are even worse.

nohugevmalloc is like blacklists, on the other hand, Add a 
HUGE_VMALLOC_DEFAULT_ENABLED

to close hugevmalloc default and enable it only via hugevmalloc=on is 
whiteList.


Only parts of our products wants this feature,  we add some interfaces 
which only

alloc hugevmalloc for them, eg, 
vmap_hugepage/vmalloc_hugepage/remap_vmalloc_hugepage_range..

for our products, but it's not the choice of most products, also add 
nohugevmalloc

for most products is expensive, so this is the reason for adding the patch.

more config/cmdline are more flexible for test/products，

>
> The 'nohugevmalloc' option mirrors 'nohugeiomap' and is not expected to
> ever be understood by an administrator unless a kernel developer is
> working with them to hunt down a regression.
>
> IMO there should be no new options. You could switch it off for
> CONFIG_BASE_SMALL perhaps, and otherwise just try to work on heuristics
> first. Bring in new options once it's proven they're needed.

but yes, this patch is optional， could others give some more comments 
about this way？

Thanks.

> Aside from that, thanks for working on these ports, great work.
>
> Thanks,
> Nick
> .
