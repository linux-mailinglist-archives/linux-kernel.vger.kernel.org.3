Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79454B8571
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiBPKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:21:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiBPKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA0E240B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645006874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfjiT9hvH+PfPn+X9Vuuf3OiUTodgHii1kaq2hHxdic=;
        b=ElrgBDY0HJcnzn6DCzTTW2AmQY/b2m0wBoQHdYFPMrKLrVp2hAy7W+Vxx5STdZci0QxTEN
        +luQTd/kd2k4OHb2d4vfVVxhrYPKrH3SaPhA85J0LTjD1fyTR0qjFaXhoduLIAiKZzjHPh
        +0/+nXGrpfixz4mb9pnB9flddWxRhjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-j-WaJnkpMUCUO4yvrwpt2A-1; Wed, 16 Feb 2022 05:21:10 -0500
X-MC-Unique: j-WaJnkpMUCUO4yvrwpt2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0974814245;
        Wed, 16 Feb 2022 10:21:06 +0000 (UTC)
Received: from localhost (ovpn-13-16.pek2.redhat.com [10.72.13.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B68655E4B6;
        Wed, 16 Feb 2022 10:21:00 +0000 (UTC)
Date:   Wed, 16 Feb 2022 18:20:58 +0800
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
Message-ID: <YgzQCqwmCOfzwzx/@MiWiFi-R3L-srv>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-4-thunder.leizhen@huawei.com>
 <YgnSCxlr1O2ZZ1sO@MiWiFi-R3L-srv>
 <0e84548b-179a-1bad-8f49-963d66426e43@huawei.com>
 <f1614874-306d-482a-a652-d71a8bcbe3a9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1614874-306d-482a-a652-d71a8bcbe3a9@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/22 at 10:58am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/2/14 15:53, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2022/2/14 11:52, Baoquan He wrote:
> >> On 01/24/22 at 04:47pm, Zhen Lei wrote:
> >> ......
> >>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >>> index 6c653a2c7cff052..a5d43feac0d7d96 100644
> >>> --- a/arch/arm64/mm/init.c
> >>> +++ b/arch/arm64/mm/init.c
> >>> @@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>>  #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> >>>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> >>>  
> >>> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> >>> +{
> >>> +	unsigned long long low_base;
> >>> +
> >>> +	/* passed with crashkernel=0,low ? */
> >>> +	if (!low_size)
> >>> +		return 0;
> >>> +
> >>> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> >>> +	if (!low_base) {
> >>> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> >>> +		return -ENOMEM;
> >>> +	}
> >>> +
> >>> +	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
> >>> +		low_base, low_base + low_size, low_size >> 20);
> >>> +
> >>> +	crashk_low_res.start = low_base;
> >>> +	crashk_low_res.end   = low_base + low_size - 1;
> >>> +	insert_resource(&iomem_resource, &crashk_low_res);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  /*
> >>>   * reserve_crashkernel() - reserves memory for crash kernel
> >>
> >> My another concern is the crashkernel=,low handling. In this patch, the
> >> code related to low memory is obscure. Wondering if we should make them
> >> explicit with a little redundant but very clear code flows. Saying this
> >> because the code must be very clear to you and reviewers, it may be
> >> harder for later code reader or anyone interested to understand.
> >>
> >> 1) crashkernel=X,high
> >> 2) crashkernel=X,high crashkernel=Y,low
> >> 3) crashkernel=X,high crashkernel=0,low
> >> 4) crashkernel=X,high crashkernel='messy code',low
> >> 5) crashkernel=X //fall back to high memory, low memory is required then.
> >>
> >> It could be me thinking about it too much. I made changes to your patch
> >> with a tuning, not sure if it's OK to you. Otherwise, this patchset
> > 
> > I think it's good.
> > 
> >> works very well for all above test cases, it's ripe to be merged for
> >> wider testing.
> > 
> > I will test it tomorrow. I've prepared a little more use cases than yours.
> 
> After the following modifications, I have tested it and it works well. Passed
> all the test cases I prepared.

That's great.

You might need to add 'crashkernel=xM, crashkernel=0,low',
'crashkernel=xM, crashkernel='messy code',low' to your test cases.

> 
> > 
> > 1) crashkernel=4G						//high=4G, low=256M
> > 2) crashkernel=4G crashkernel=512M,high crashkernel=512M,low	//high=4G, low=256M, high and low are ignored
> > 3) crashkernel=4G crashkernel=512M,high				//high=4G, low=256M, high is ignored
> > 4) crashkernel=4G crashkernel=512M,low				//high=4G, low=256M, low is ignored
> > 5) crashkernel=4G@0xe0000000					//high=0G, low=0M, cannot allocate, failed
> > 6) crashkernel=512M						//high=0G, low=512M
> > 7) crashkernel=128M						//high=0G, low=128M
> > 8) crashkernel=512M@0xde000000		//512M@3552M		//high=0G, low=512M
> > 9) crashkernel=4G,high						//high=4G, low=256M
> > a) crashkernel=4G,high crashkernel=512M,low			//high=4G, low=512M
> > b) crashkernel=512M,high crashkernel=128M,low			//high=512M, low=128M
> > c) crashkernel=512M,low						//high=0G, low=0M, invalid
> > 
> > 
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index a5d43feac0d7..671862c56d7d 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -94,7 +94,8 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >>  
> >>  	return 0;
> >>  }
> >> -
> >> +/*Words explaining why it's 256M*/
> >> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE SZ_256M
> 
> It's an empirical value.
> 
> 94fb9334182284e8e7e4bcb9125c25dc33af19d4 x86/crash: Allocate enough low memory when crashkernel=high
> 
>     When the crash kernel is loaded above 4GiB in memory, the
>     first kernel allocates only 72MiB of low-memory for the DMA
>     requirements of the second kernel. On systems with many
>     devices this is not enough and causes device driver
>     initialization errors and failed crash dumps. Testing by
>     SUSE and Redhat has shown that 256MiB is a good default
>     value for now and the discussion has lead to this value as
>     well. So set this default value to 256MiB to make sure there
>     is enough memory available for DMA.

Then, some words like below can be added. I am not confident it's good
enought, hope someone else can help to polish it.

/*
 * This is an empirical value in x86_64 and taken here directly. Please
 * refer to code comment in reserve_crashkernel_low() of x86_64 for more
 * details.
 */
#define DEFAULT_CRASH_KERNEL_LOW_SIZE SZ_256M

> 
> 
> >>  /*
> >>   * reserve_crashkernel() - reserves memory for crash kernel
> >>   *
> >> @@ -105,10 +106,10 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >>  static void __init reserve_crashkernel(void)
> >>  {
> >>  	unsigned long long crash_base, crash_size;
> >> -	unsigned long long crash_low_size = SZ_256M;
> >> +	unsigned long long crash_low_size;
> >>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> >>  	int ret;
> >> -	bool fixed_base;
> >> +	bool fixed_base, high;
> 
> high = false;
> 
> >>  	char *cmdline = boot_command_line;
> >>  
> >>  	/* crashkernel=X[@offset] */
> >> @@ -126,7 +127,10 @@ static void __init reserve_crashkernel(void)
> >>  		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
> >>  		if (!ret)
> >>  			crash_low_size = low_size;
> >> +		else
> >> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >>  
> >> +		high = true;
> >>  		crash_max = CRASH_ADDR_HIGH_MAX;
> >>  	}
> >>  
> >> @@ -134,7 +138,7 @@ static void __init reserve_crashkernel(void)
> >>  	crash_size = PAGE_ALIGN(crash_size);
> >>  
> >>  	/* User specifies base address explicitly. */
> >> -	if (crash_base)
> >> +	if (fixed_base)
> >>  		crash_max = crash_base + crash_size;
> >>  
> >>  retry:
> >> @@ -156,7 +160,10 @@ static void __init reserve_crashkernel(void)
> >>  		return;
> >>  	}
> >>  
> >> -	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> >> +	if (crash_base >= SZ_4G && !high) 
> >> +		crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >> +
> >> +	if (reserve_crashkernel_low(crash_low_size)) {
> >>  		memblock_phys_free(crash_base, crash_size);
> >>  		return;
> >>  	}
> 
> -       if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> -               memblock_phys_free(crash_base, crash_size);
> -               return;
> +       if (crash_base >= SZ_4G) {
> +               if (!high)
> +                       crash_low_size = SZ_256M;
> +
> +               if (reserve_crashkernel_low(crash_low_size)) {
> +                       memblock_phys_free(crash_base, crash_size);
> +                       return;
> +               }
>         }
> 
> Looks like changing 'high' to 'low' would be more accurate. Whether crashkernel=Y,low is specified.

What I menat is like below, we even can add code comment to make it more
clearer.

static void __init reserve_crashkernel(void)
{

        /* crashkernel=X[@offset] */
        ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
                                &crash_size, &crash_base);
        if (ret || !crash_size) {
                unsigned long long low_size;

                /* crashkernel=X,high */
                ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
                if (ret || !crash_size)
                        return;

                /* crashkernel=X,low */
                ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
		//case #1, crashkernel=yM,low is specified explicitly in cmdline
                if (!ret)
                        crash_low_size = low_size;
		else //case #2, crashkernel=yM,low is not specified explicitly
                        crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;

		//high means crashkernel,high is specified explicitly
		high = true;
                crash_max = CRASH_ADDR_HIGH_MAX;
        }

        fixed_base = !!crash_base;
        crash_size = PAGE_ALIGN(crash_size);

        /* User specifies base address explicitly. */
        if (crash_base)
                crash_max = crash_base + crash_size;
retry:
        crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
                                               crash_base, crash_max);
        if (!crash_base) {
                /*
                 * Attempt to fully allocate low memory failed, fall back
                 * to high memory, the minimum required low memory will be
                 * reserved later.
                 */
                if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
                        crash_max = CRASH_ADDR_HIGH_MAX;
                        goto retry;
                }

                pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
                        crash_size);
                return;
        }


	//case #3: get crashkernel from high memory through fallback, let's set crashkernel,low too.
        if (crash_base >= SZ_4G && !high)
		crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;	

        if (reserve_crashkernel_low(crash_low_size)) {
                memblock_phys_free(crash_base, crash_size);
                return;
        }

        pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
                crash_base, crash_base + crash_size, crash_size >> 20);

        /*
         * The crashkernel memory will be removed from the kernel linear
         * map. Inform kmemleak so that it won't try to access it.
         */
        kmemleak_ignore_phys(crash_base);
        if (crashk_low_res.end)
                kmemleak_ignore_phys(crashk_low_res.start);

        crashk_res.start = crash_base;
        crashk_res.end = crash_base + crash_size - 1;
        insert_resource(&iomem_resource, &crashk_res);
}


> 
> 
> > 
> > It feels like {} may need to be added here so that it is in branch "if (crash_base >= SZ_4G)".
> > The case of "crashkernel=128M" will not fall back to high memory and does not need to reserve
> > low memory again.
> > 
> >>
> >>>   *
> >>> @@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>>  static void __init reserve_crashkernel(void)
> >>>  {
> >>>  	unsigned long long crash_base, crash_size;
> >>> +	unsigned long long crash_low_size = SZ_256M;
> >>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> >>>  	int ret;
> >>> +	bool fixed_base;
> >>> +	char *cmdline = boot_command_line;
> >>>  
> >>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >>> +	/* crashkernel=X[@offset] */
> >>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> >>>  				&crash_size, &crash_base);
> >>> -	/* no crashkernel= or invalid value specified */
> >>> -	if (ret || !crash_size)
> >>> -		return;
> >>> +	if (ret || !crash_size) {
> >>> +		unsigned long long low_size;
> >>>  
> >>> +		/* crashkernel=X,high */
> >>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> >>> +		if (ret || !crash_size)
> >>> +			return;
> >>> +
> >>> +		/* crashkernel=X,low */
> >>> +		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
> >>> +		if (!ret)
> >>> +			crash_low_size = low_size;
> >>> +
> >>> +		crash_max = CRASH_ADDR_HIGH_MAX;
> >>> +	}
> >>> +
> >>> +	fixed_base = !!crash_base;
> >>>  	crash_size = PAGE_ALIGN(crash_size);
> >>>  
> >>>  	/* User specifies base address explicitly. */
> >>>  	if (crash_base)
> >>>  		crash_max = crash_base + crash_size;
> >>>  
> >>> +retry:
> >>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>>  					       crash_base, crash_max);
> >>>  	if (!crash_base) {
> >>> +		/*
> >>> +		 * Attempt to fully allocate low memory failed, fall back
> >>> +		 * to high memory, the minimum required low memory will be
> >>> +		 * reserved later.
> >>> +		 */
> >>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> >>> +			crash_max = CRASH_ADDR_HIGH_MAX;
> >>> +			goto retry;
> >>> +		}
> >>> +
> >>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >>>  			crash_size);
> >>>  		return;
> >>>  	}
> >>>  
> >>> +	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
> >>> +		memblock_phys_free(crash_base, crash_size);
> >>> +		return;
> >>> +	}
> >>> +
> >>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> >>>  		crash_base, crash_base + crash_size, crash_size >> 20);
> >>>  
> >>> @@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
> >>>  	 * map. Inform kmemleak so that it won't try to access it.
> >>>  	 */
> >>>  	kmemleak_ignore_phys(crash_base);
> >>> +	if (crashk_low_res.end)
> >>> +		kmemleak_ignore_phys(crashk_low_res.start);
> >>> +
> >>>  	crashk_res.start = crash_base;
> >>>  	crashk_res.end = crash_base + crash_size - 1;
> >>>  	insert_resource(&iomem_resource, &crashk_res);
> >>> -- 
> >>> 2.25.1
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

