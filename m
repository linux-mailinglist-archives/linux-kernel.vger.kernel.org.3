Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE94772F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhLPNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:15:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28324 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhLPNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:15:33 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JFCJw19VTzbjMD;
        Thu, 16 Dec 2021 21:15:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 21:15:31 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 21:15:30 +0800
Subject: Re: [PATCH v17 05/10] x86: kdump: move reserve_crashkernel[_low]()
 into crash_core.c
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
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
 <20211210065533.2023-6-thunder.leizhen@huawei.com> <YbsgNpPMmp38X+it@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <217fb106-980c-0bd9-8398-d52ef255d51f@huawei.com>
Date:   Thu, 16 Dec 2021 21:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YbsgNpPMmp38X+it@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/16 19:17, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 02:55:28PM +0800, Zhen Lei wrote:
>> + * reserve_crashkernel() - reserves memory for crash kernel
>> + *
>> + * This function reserves memory area given in "crashkernel=" kernel command
>> + * line parameter. The memory reserved is used by dump capture kernel when
>> + * primary kernel is crashing.
>> + */
>> +void __init reserve_crashkernel(void)
> 
> As I've already alluded to in another mail, ontop of this there should
> be a patch or multiple patches which clean this up more and perhaps even
> split it into separate functions doing stuff in this order:
> 
> 1. Parse all crashkernel= cmdline options
> 
> 2. Do all crash_base, crash_size etc checks
> 
> 3. Do the memory reservations
> 
> And all that supplied with comments explaining why stuff is being done.

I agree with you. This makes the code look clear. I will do it, try to
post v18 next Monday.

> 
> This set of functions is a mess and there's no better time for cleaning
> it up and documenting it properly than when you move it to generic code.
> 
> Thx.
> 
