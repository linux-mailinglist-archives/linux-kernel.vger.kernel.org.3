Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010553070E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiEWBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiEWBSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:18:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E491B63;
        Sun, 22 May 2022 18:18:41 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L5zvX1KQDz1JC5q;
        Mon, 23 May 2022 09:17:12 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 09:18:39 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 09:18:37 +0800
Message-ID: <7a1ce182-343a-75f9-5447-f7ca12cb0c36@huawei.com>
Date:   Mon, 23 May 2022 09:18:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] Add support to relocate kernel image to mirrored
 region
To:     <ardb@kernel.org>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <dvhart@infradead.org>, <andy@infradead.org>,
        <rppt@kernel.org>, <paulmck@kernel.org>, <peterz@infradead.org>,
        <jroedel@suse.de>, <songmuchun@bytedance.com>, <macro@orcam.me.uk>,
        <frederic@kernel.org>, <W_Armin@gmx.de>, <john.garry@huawei.com>,
        <seanjc@google.com>, <tsbogend@alpha.franken.de>,
        <anshuman.khandual@arm.com>, <chenhuacai@kernel.org>,
        <david@redhat.com>, <gpiccoli@igalia.com>, <mark.rutland@arm.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-mm@kvack.org>,
        <mawupeng1@huawei.com>
References: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
 <20220419070150.254377-1-mawupeng1@huawei.com>
 <CAMj1kXHr2RdYSPor1st1ZnL=O42c8N6e=bNG+eFhatfefWLUrw@mail.gmail.com>
 <c65d22b4-f654-21aa-bd5f-d4f8b0939a25@huawei.com>
 <7058b8d8-c0cb-108e-0db9-2fdf5fb154cf@huawei.com>
 <CAMj1kXHnL12j6FPGtEeSQB2-kHzoVF+LJMUF9YBq43Yi1UntDg@mail.gmail.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAMj1kXHnL12j6FPGtEeSQB2-kHzoVF+LJMUF9YBq43Yi1UntDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/20 14:52, Ard Biesheuvel 写道:
> On Thu, 19 May 2022 at 13:09, mawupeng <mawupeng1@huawei.com> wrote:
>>
>>
>>
>> 在 2022/5/7 17:28, mawupeng 写道:
>>>
>>>
>>> 在 2022/5/3 17:58, Ard Biesheuvel 写道:
>>>> On Tue, 19 Apr 2022 at 08:43, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>>>>
>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>
>>>>> Now system image will perfer to be located to mirrored regions both KASLR
>>>>> on and off.
>>>>>
>>>>
>>>> Hello Ma Wupeng,
>>>>
>>>> I wonder if we could simplify this as follows:
>>>> - ignore the non-KASLR case for now, and rely on the bootloader  > load the image into mirrored memory if it exists;
>>>
>>> In grub, memory for static image is allocated via the following path:
>>>
>>> grub_cmd_linux
>>>     kernel = grub_malloc(filelen)
>>>     kernel_alloc_addr = grub_efi_allocate_any_pages (kernel_alloc_pages)
>>>     grub_memcpy (kernel_addr, kernel, grub_min(filelen, kernel_size))
>>>      grub_loader_set (grub_linux_boot, grub_linux_unload, 0)
>>>
>>> Can we get memory from mirrored region by the following steps:
>>> 1. get memory map by calling grub_efi_get_memory_map()
>>> 2. iter all memory map to find a suitable mirrored memory area
>>> 3. locate kernel image to this area
>>>
>>> So, if kaslr is not enabled
>>>    - grub will load kernel into mirrored region
>>> else
>>>    - arm64-stub.c will relocate kernel image to mirrored region
>>>
>>> Is this feasible?
>>
>> Is this a feasible proposal to relocate the static kernel image itself
>> into more reliable memory?
>>
> 
> I'm not sure, it all depends on the firmware.
> 
> When GRUB calls LoadImage(), the firmware will reallocate the image
> and unpack it there. So it is really the firmware's job to ensure that
> the image is loaded into a suitable location.
> 
> I have some code here that implements a EFI based decompressor, and
> which loads the kernel image into mirrored memory if it exists,
> without the need to move it again. It could trivially be modified to
> deal with non-randomized loads as well.
> 
> But the bottom line is that UEFI should expose the ability to target
> mirrored memory, hacking around it like this is not a sustainable
> approach.

Since firmware is responsible for put kernel static image into mirrored
region and kernel is responsible for relocate this image into mirrored
region if kaslr is enabled. There is no conflict between these two.

Can we integrate the kernel part(introduce mirrored support to arm64) first?

> .
