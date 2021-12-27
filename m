Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1747F9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 02:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhL0Bqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 20:46:36 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30175 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhL0Boq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 20:44:46 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JMgQM26Kvz8w5B;
        Mon, 27 Dec 2021 09:42:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 09:44:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 09:44:24 +0800
Message-ID: <c7037a3a-d0b1-6351-5e31-22be0d8e0e01@huawei.com>
Date:   Mon, 27 Dec 2021 09:44:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] mm: vmalloc: Let user to control huge vmalloc default
 behavior
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
 <20211226083912.166512-2-wangkefeng.wang@huawei.com>
 <6c4bd989-268e-5899-09a7-ac573bd8b4d9@csgroup.eu>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <6c4bd989-268e-5899-09a7-ac573bd8b4d9@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/27 1:36, Christophe Leroy wrote:
>
> Le 26/12/2021 à 09:39, Kefeng Wang a écrit :
>> Add HUGE_VMALLOC_DEFAULT_ENABLED to let user to choose whether or
>> not enable huge vmalloc mappings by default, and this could make
>> more architectures to enable huge vmalloc mappings feature but
>> don't want to enable it by default.
>>
>> Add hugevmalloc=on/off parameter to enable or disable this feature
>> at boot time, nohugevmalloc is still supported and equivalent to
>> hugevmalloc=off.
>
> Is there a real added value to have the user be able to select that ?
>
> If the architecture supports it, is there any good reason to not use it ?

There are some disadvantages[1],  one of the main concerns is the possible

memory waste, we have backported this feature to our kernel 5.10, but our

downstream in our some scenario(especially in embedded), they don't want

it enabled by default, and others want it, this is why patch1 comes.

>
> Why not just do like PPC and enable it by default ? Why should it be
> enabled by default on PPC but disabled by default on ARM64 and X86 ?

The PPC is default enabled, we don't changes this behavior.

Maybe upstream is not care about this, as I said in cover-letter, if 
arm64/x86

don't want patch1, we could only just select config to enable it.

Let's wait for more feedback.

Thanks.

[1] 
https://lore.kernel.org/linux-mm/1616036421.amjz2efujj.astroid@bobo.none/

