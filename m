Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDD5111C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358468AbiD0G6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356571AbiD0G6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:58:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E746E15B440;
        Tue, 26 Apr 2022 23:54:55 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kp8Z91bRFzGpVQ;
        Wed, 27 Apr 2022 14:52:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 14:54:53 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 14:54:52 +0800
Subject: Re: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com> <YmgzxsrrMlCDYsWp@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
Date:   Wed, 27 Apr 2022 14:54:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YmgzxsrrMlCDYsWp@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/27 2:02, Catalin Marinas wrote:
> On Thu, Apr 14, 2022 at 07:57:16PM +0800, Zhen Lei wrote:
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>>   *
>>   * This function reserves memory area given in "crashkernel=" kernel command
>>   * line parameter. The memory reserved is used by dump capture kernel when
>>   * primary kernel is crashing.
>> + *
>> + * NOTE: Reservation of crashkernel,low is special since its existence
>> + * is not independent, need rely on the existence of crashkernel,high.
>> + * Here, four cases of crashkernel low memory reservation are summarized:
>> + * 1) crashkernel=Y,low is specified explicitly, the size of crashkernel low
>> + *    memory takes Y;
>> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
>> + *    take the default crashkernel low memory size;
>> + * 3) crashkernel=X is specified, while fallback to get a memory region
>> + *    in high memory, take the default crashkernel low memory size;
>> + * 4) crashkernel='invalid value',low is specified, failed the whole
>> + *    crashkernel reservation and bail out.
> 
> Following the x86 behaviour made sense when we were tried to get that
> code generic. Now that we moved the logic under arch/arm64, we can
> diverge a bit. I lost track of the original (v1/v2) proposal but I
> wonder whether we still need the fallback to high for crashkernel=Y.

I don't think anyone has raised this demand yet! If it weren't for the
fact that crashkernel=X appeared earlier, it would probably have been
enough for a combination of crashkernel=X,high and crashkernel=Y,low.

In fact, I also tend not to support "fallback to high for crashkernel=Y".
I took over this from Chen Zhou. In the absence of any objection, I had
to inherit. Now that you've brought it up, I'm happy to delete it.
Supporting this feature complicates the code logic a lot. The point is,
it's not fully backwards compatible yet. For example, someone may want
crashkernel=3G to report failure, but the the new support make it work.

> Maybe simpler, no fallbacks:
> 
> 	crashkernel=Y - keep the current behaviour, ignore high,low
> 	crashkernel=Y,high - allocate above ZONE_DMA
> 	crashkernel=Y,low - allocate within ZONE_DMA
> 
>>From your proposal, the difference is that the Y,high option won't
> have any default ZONE_DMA fallback, one would have to explicitly pass
> the Y,low option if needed.

I agree with you. Now we don't need code generic, so there is no need to
carry the historical burden of other ARCHs. arm64 does not need to delve
into that empirical value(the default size of crash low memory).

> 
> Just a thought, maybe it makes the code simpler. But I'm open to
> discussion if there are good arguments for the proposed (x86-like)
> behaviour. One argument could be for crashkernel=Y to fall back to high
> if distros don't want to bother with high/low settings.

I think distros should take precedence over "crashkernel=Y,high". After all,
ZONE_DMA memory is more valuable than high memory.


> 
> Another thing I may have asked in the past, what happens if we run a new
> kernel with these patches with old kexec user tools. I suspect the
> crashkernel=Y with the fallback to high will confuse the tools.

If crashkernel=Y can reserve the memory in Zone_DMA successfully, the old
kexec works well. But if crashkernel=Y fallback to high memory, the second
kernel will boot failed, because the old kexec can only use dtb to pass the
high memory range to the second kernel. In comparison, if no fallback, we can
see crash memory reservation failure in the first kernel, so we have a chance
to adjust Y.

Currently, the new kexec tool will pick the last memory range(sorted by address
in ascending order) to store Image,dtb,initrd.


> 
> BTW, please separate the NO_BLOCK_MAPPINGS optimisations from the
> crashkernel above 4G. Let's get the crashkernel reservations sorted
> first, it's been around for too long.

OK, thank you. That's a good suggestion.

> 
> Thanks.
> 

-- 
Regards,
  Zhen Lei
