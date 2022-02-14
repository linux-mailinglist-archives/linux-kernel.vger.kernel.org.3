Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757364B4299
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiBNHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:10:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbiBNHKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 883A858E6C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644822613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5iYrmeqFTWTMK2U/eGmx/ua6zxpJzL0laPaQH0XD4c=;
        b=fYWJCicLOliVZOPOe7VPnmp1B7Ydl7Ra8Ar9CF3Qw7s0HvjWWbihswAZblH+qlhTbooZdb
        WeEZ5Xdul9JYJlgn02LdEnmEiPpzzKnZhOd9glibC5VwphaK8x4JXmBhzMY/LBH4cDosA9
        HXYDxmcPY2Oe+PNkgRf7ha7Aox6ittA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-U84TX2mcNDagSzVBXsNdkg-1; Mon, 14 Feb 2022 02:10:08 -0500
X-MC-Unique: U84TX2mcNDagSzVBXsNdkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A253180833A;
        Mon, 14 Feb 2022 07:10:05 +0000 (UTC)
Received: from localhost (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC4A2105C751;
        Mon, 14 Feb 2022 07:10:01 +0000 (UTC)
Date:   Mon, 14 Feb 2022 15:09:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v20 3/5] arm64: kdump: reimplement crashkernel=X
Message-ID: <YgoARncp0jCMTDEX@MiWiFi-R3L-srv>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-4-thunder.leizhen@huawei.com>
 <YgY6yvX7PEeZpdTr@MiWiFi-R3L-srv>
 <6ac0c60c-78bc-9789-9f5c-659fb5fa3e9a@huawei.com>
 <YgY/qQUkBF0eZ9zc@MiWiFi-R3L-srv>
 <441c2917-bd86-da71-22d2-f526baf1457f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441c2917-bd86-da71-22d2-f526baf1457f@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/22 at 02:44pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/2/11 18:51, Baoquan He wrote:
> > On 02/11/22 at 06:41pm, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2022/2/11 18:30, Baoquan He wrote:
> >>> On 01/24/22 at 04:47pm, Zhen Lei wrote:
> >>>> From: Chen Zhou <chenzhou10@huawei.com>
> >>> ......
> >>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >>>> index 6c653a2c7cff052..a5d43feac0d7d96 100644
> >>>> --- a/arch/arm64/mm/init.c
> >>>> +++ b/arch/arm64/mm/init.c
> >>>> @@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>>>  #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> >>>>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> >>>>  
> >>>> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> >>>> +{
> >>>> +	unsigned long long low_base;
> >>>> +
> >>>> +	/* passed with crashkernel=0,low ? */
> >>>> +	if (!low_size)
> >>>> +		return 0;
> >>>> +
> >>>> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> >>>> +	if (!low_base) {
> >>>> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> >>>> +		return -ENOMEM;
> >>>> +	}
> >>>> +
> >>>> +	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
> >>>> +		low_base, low_base + low_size, low_size >> 20);
> >>>> +
> >>>> +	crashk_low_res.start = low_base;
> >>>> +	crashk_low_res.end   = low_base + low_size - 1;
> >>>> +	insert_resource(&iomem_resource, &crashk_low_res);
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>>  /*
> >>>>   * reserve_crashkernel() - reserves memory for crash kernel
> >>>>   *
> >>>> @@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>>>  static void __init reserve_crashkernel(void)
> >>>>  {
> >>>>  	unsigned long long crash_base, crash_size;
> >>>> +	unsigned long long crash_low_size = SZ_256M;
> >>>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> >>>>  	int ret;
> >>>> +	bool fixed_base;
> >>>> +	char *cmdline = boot_command_line;
> >>>>  
> >>>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >>>> +	/* crashkernel=X[@offset] */
> >>>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> >>>>  				&crash_size, &crash_base);
> >>>> -	/* no crashkernel= or invalid value specified */
> >>>> -	if (ret || !crash_size)
> >>>> -		return;
> >>>> +	if (ret || !crash_size) {
> >>>> +		unsigned long long low_size;
> >>>>  
> >>>> +		/* crashkernel=X,high */
> >>>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> >>>> +		if (ret || !crash_size)
> >>>> +			return;
> >>>> +
> >>>> +		/* crashkernel=X,low */
> >>>> +		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
> >>>> +		if (!ret)
> >>>> +			crash_low_size = low_size;
> >>>
> >>> Here, the error case is not checked and handled. But it still gets
> >>> expeced result which is the default SZ_256M. Is this designed on
> >>> purpose?
> >>
> >> Yes, we can specify only "crashkernel=X,high".
> >>
> >> This is mentioned in Documentation/admin-guide/kernel-parameters.txt
> >>
> >>         crashkernel=size[KMG],low
> >>                         [KNL, X86-64] range under 4G. When crashkernel=X,high
> >>                         is passed, kernel could allocate physical memory region
> >>                         above 4G, that cause second kernel crash on system
> >>                         that require some amount of low memory, e.g. swiotlb
> >>                         requires at least 64M+32K low memory, also enough extra
> >>                         low memory is needed to make sure DMA buffers for 32-bit
> >>                         devices won't run out. Kernel would try to allocate at     <---------
> >>                         least 256M below 4G automatically.                         <---------
> > 
> > Yeah, that is expected becasue no crahskernel=,low is a right usage. The
> > 'ret' is 0 in the case. If I gave below string, it works too.
> > "crashkernel=256M,high crashkernel=aaabbadfadfd,low"
> 
> Yes, so maybe we should change the error code in __parse_crashkernel()
> from "-EINVAL" to "-ENOENT" when the specified option does not exist.

Good point. I also thought of this, it could be next step clean up. X86
code need this too. In crashkernel='messy code',high, it will fail to
reserve. For consistency, we should fail crashkrenel='messy code',low
too.

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573cd09..395f4fac1773f28 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -243,9 +243,8 @@ static int __init __parse_crashkernel(char *cmdline,
>         *crash_base = 0;
> 
>         ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
> -
>         if (!ck_cmdline)
> -               return -EINVAL;
> +               return -ENOENT;
> 
>         ck_cmdline += strlen(name);
> 
> 
> > 
> >>
> >>>
> >>>> +
> >>>> +		crash_max = CRASH_ADDR_HIGH_MAX;
> >>>> +	}
> >>>> +
> >>>> +	fixed_base = !!crash_base;
> >>>>  	crash_size = PAGE_ALIGN(crash_size);
> >>>>  
> >>>>  	/* User specifies base address explicitly. */
> >>>>  	if (crash_base)
> >>>>  		crash_max = crash_base + crash_size;
> >>>>  
> >>>> +retry:
> >>>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>>>  					       crash_base, crash_max);
> >>>>  	if (!crash_base) {
> >>>> +		/*
> >>>> +		 * Attempt to fully allocate low memory failed, fall back
> >>>> +		 * to high memory, the minimum required low memory will be
> >>>> +		 * reserved later.
> >>>> +		 */
> >>>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> >>>> +			crash_max = CRASH_ADDR_HIGH_MAX;
> >>>> +			goto retry;
> >>>> +		}
> >>>> +
> >>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >>>>  			crash_size);
> >>>>  		return;
> >>>>  	}
> >>>>  
> >>>> +	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> >>>> +		memblock_phys_free(crash_base, crash_size);
> >>>> +		return;
> >>>> +	}
> >>>> +
> >>>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> >>>>  		crash_base, crash_base + crash_size, crash_size >> 20);
> >>>>  
> >>>> @@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
> >>>>  	 * map. Inform kmemleak so that it won't try to access it.
> >>>>  	 */
> >>>>  	kmemleak_ignore_phys(crash_base);
> >>>> +	if (crashk_low_res.end)
> >>>> +		kmemleak_ignore_phys(crashk_low_res.start);
> >>>> +
> >>>>  	crashk_res.start = crash_base;
> >>>>  	crashk_res.end = crash_base + crash_size - 1;
> >>>>  	insert_resource(&iomem_resource, &crashk_res);
> >>>> -- 
> >>>> 2.25.1
> >>>>
> >>>
> >>> .
> >>>
> >>
> >> -- 
> >> Regards,
> >>   Zhen Lei
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

