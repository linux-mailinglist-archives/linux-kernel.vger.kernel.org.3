Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240ED51E764
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385047AbiEGN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiEGN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D612366A9
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651929770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8e+k/+y9OcE1mgVQl5G3myG0wCTkmuqBJJIz2n+p6KI=;
        b=EvmJFEvN1wDCz6TxbWUk1auHKVqsLVBoZu7qv2g/VCnHuOVR9QfOcHG4u4UVc3P4BHDM1z
        5PhXt5SyD8Ye9O5b/K0B14Us1qltveCLj26x8ZRoC6IPf1l42ZIzIQ+DObY51tNtxKGnn+
        bP7MgY/SmnBpSKWC7f1yOY3StIZIn3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-y-8dsoQnOnWyX_xDm9-YPg-1; Sat, 07 May 2022 09:22:46 -0400
X-MC-Unique: y-8dsoQnOnWyX_xDm9-YPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9705F101AA44;
        Sat,  7 May 2022 13:22:45 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E74840D2830;
        Sat,  7 May 2022 13:22:41 +0000 (UTC)
Date:   Sat, 7 May 2022 21:22:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YnZyjQJ059j8RGIe@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
 <d9b21f31-6fd2-a898-9a70-c63ff4f36212@huawei.com>
 <YnXUSBcFmEpxaqBf@MiWiFi-R3L-srv>
 <9f6fdbb8-b6c5-3ca0-31b6-617175739e81@huawei.com>
 <6e892914-74ae-2b8f-954e-342aaf4be870@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e892914-74ae-2b8f-954e-342aaf4be870@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 at 05:35pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/7 11:37, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2022/5/7 10:07, Baoquan He wrote:
> >> On 05/07/22 at 09:34am, Leizhen (ThunderTown) wrote:
> >>>
> >>>
> >>> On 2022/5/7 7:10, Baoquan He wrote:
> >>>> On 05/06/22 at 07:43pm, Zhen Lei wrote:
> >>>> ......  
> >>>>> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
> >>>>>  	if (crash_base)
> >>>>>  		crash_max = crash_base + crash_size;
> >>>>>  
> >>>>> -	/* Current arm64 boot protocol requires 2MB alignment */
> >>>>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> >>>>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>>>>  					       crash_base, crash_max);
> >>>>>  	if (!crash_base) {
> >>>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >>>>> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
> >>>>>  		return;
> >>>>>  	}
> >>>>>  
> >>>>
> >>>> There's corner case missed, e.g
> >>>> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> >>>> 2) ,high and ,low are specified, the whole system memory is under 4G.
> >>>>
> >>>> Below judgement can filter them away:
> >>>>         
> >>>> 	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
> >>>> 	    reserve_crashkernel_low(crash_low_size)) {
> >>>>
> >>>> What's your opinion? Leave it and add document to notice user, or fix it
> >>>> with code change?
> 
> I decided to modify the code and document. But the code changes aren't what
> you suggested. For the following reasons:

Hi Lei,

I would say let's merge this version firstly, then add the left step
by step. Crashkernel= is not a simple parameter, expecting to make it in
one step is not realistic. Otherwise, we will be in a mess of all
cases of discussion and handling. Let's slow down and get the basic
support added.

> 1. The memory allocated for 'high' may be partially under 4G. So the low
>    memory may not be enough. Of course, it's rare.

No, let's forget under 4G or above 4G thing on arm64, but use
arm64_dma_phys_limit instead. It's basically equivalent to 4G
on x86, while will cause confusion.

And I may not get what you are saying the 'high' partially under 4G
thing, could you be more specific or give an example?

> 2. The second kernel can work properly only when the high and low memory
>    are successfully applied for. For example, high=128M, low=128M, but the
>    second kernel need 256M.

I may not get this either. We usually won't split our memory requirement
into ,high and ,low region. ,high is the main place to accommadate kernel
image, initrd, and user space program's memory allocation. ,low is for
DMA during kernel bootup.

We probably should not encourage or guide user to use like this if I got
you correctly. That will complicate the crashkernel= usage more.

> 
> So for the cases you listed:
> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
>    --> Follow you suggestion, ignore crashkernel=Y,low, don't allocate low memory.
> 
> @@ -100,6 +100,14 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
>         unsigned long long low_base;
> 
> +       /*
> +        * The kernel does not have any DMA zone, so the range of each DMA
> +        * zone is unknown. Please make sure both CONFIG_ZONE_DMA and
> +        * CONFIG_ZONE_DMA32 are also not set in the second kernel.
> +        */
> +       if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> +               return 0;
> +
> 
> 2) ,high and ,low are specified, the whole system memory is under 4G.
>    --> two memory ranges will be allocated, the size is what 'high' and 'low' specified.
>    --> Yes, the memory of 'low' may be above 'high', but the 'high' just hint allocation
>    --> from top, try high memory first. Of course, this may cause kexec to fail to load.
>    --> Because the memory of 'low' with small size will be used to store Image, etc..
>    --> But the memory of 'low' above 'high' is almost impossible, we use memblock API to
>    --> allocate memory from top to bottem, 'low' above 'high' need a sizeable memory block
>    --> (128M, 256M?) to be freed at init phase.

Not really. Please think about the case that crashkernel=1G,hign
crashkernel=128M,low. memblock top down allocation find a lower position
for 1G, but a higher position for 128M because of meomry fragmentation.
It's easy but reasonable thing.

>    -->  Maybe I should add: crash_max = min(crash_base, CRASH_ADDR_LOW_MAX);
>    --> to make sure the memory of 'low' is always under 'high'

I would say let's not scatter these details into different places.
Like what I changed, it's much easier and code is more understandable.
Let's discuss this after this series accepted. A new series can be
posted to handle these. 

> 
> >>>
> >>> I think maybe we can leave it unchanged. If the user configures two memory ranges,
> >>> we'd better apply for two. Otherwise, he'll be confused when he inquires. Currently,
> >>> crash_low_size is non-zero only when 'crashkernel=Y,low' is explicitly configured.
> >>
> >> Then user need know the system information, e.g how much is the high
> >> memory, low memory, if CONFIG_ZONE_DMA|DMA32 is enabled. And we need
> >> describe these cases in document. Any corner case or exception need
> >> be noted if we don't handle it in code.
> >>
> >> Caring about this very much because we have CI with existed test cases
> >> to run on the system, and QA will check these manually too. Support
> >> engineer need detailed document if anything special but happened.
> >> Anything unclear or uncovered will be reported as bug to our kernel dev.
> >> Guess your company do the similar thing like this.
> >>
> >> This crashkerne,high and crashkernel,low reservation is special if we
> >> allow ,high, ,low existing in the same zone. Imagine on system with
> >> CONFIG_ZONE_DMA|DMA32 disabled, people copy the crashkernel=512M,high
> >> and crashkernel=128M,low from other system, and he could get
> >> crash_res at [5G, 5G+512M], while crash_low_res at [6G, 6G+128M]. Guess
> >> how they will judge us.
> > 
> > OK, I got it.
> > 
> >>
> >>>
> >>>>
> >>>> I would suggest merging this series, Lei can add this corner case
> >>>> handling on top. Since this is a newly added support, we don't have
> >>>> to make it one step. Doing step by step can make reviewing easier.
> >>>>
> >>>>> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> >>>>> +		memblock_phys_free(crash_base, crash_size);
> >>>>> +		return;
> >>>>> +	}
> >>>>> +
> >>>>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> >>>>>  		crash_base, crash_base + crash_size, crash_size >> 20);
> >>>>>  
> >>>>> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
> >>>>>  	 * map. Inform kmemleak so that it won't try to access it.
> >>>>>  	 */
> >>>>>  	kmemleak_ignore_phys(crash_base);
> >>>>> +	if (crashk_low_res.end)
> >>>>> +		kmemleak_ignore_phys(crashk_low_res.start);
> >>>>> +
> >>>>>  	crashk_res.start = crash_base;
> >>>>>  	crashk_res.end = crash_base + crash_size - 1;
> >>>>>  	insert_resource(&iomem_resource, &crashk_res);
> >>>>> -- 
> >>>>> 2.25.1
> >>>>>
> >>>>
> >>>> .
> >>>>
> >>>
> >>> -- 
> >>> Regards,
> >>>   Zhen Lei
> >>>
> >>
> >> .
> >>
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

