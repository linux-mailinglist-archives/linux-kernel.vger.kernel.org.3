Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30DA4DBD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351511AbiCQCiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCQCiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5541D64D7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647484612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZhwNgQbbAAh7E0gC5xHfd78zBYBbrLsvzLXwX0m2k0o=;
        b=iUIMfZizxmSyM286KM1aHrOkruzmL/YWzTqpUQmTkH8WG/uUjNqsfXvqlcssLzzgvNSwKh
        fkGVhgJG8MI7QU96thypiKENLGZ14qZbdCCzb4Zqxfrhu0PmUVog46Bq/0q6/FaESPIcxs
        Acp8goECf65Qx/wlYqOsNPkFRlJdQa8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-n9NDOC7VOrmT60TGaq6cJg-1; Wed, 16 Mar 2022 22:36:49 -0400
X-MC-Unique: n9NDOC7VOrmT60TGaq6cJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2141B899EC2;
        Thu, 17 Mar 2022 02:36:48 +0000 (UTC)
Received: from localhost (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 379F230BBC;
        Thu, 17 Mar 2022 02:36:43 +0000 (UTC)
Date:   Thu, 17 Mar 2022 10:36:40 +0800
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
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
Message-ID: <YjKeuFGtjI7944uy@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <YjHUAi0xrUy+qk/L@MiWiFi-R3L-srv>
 <7d7a3e70-6a46-b722-ef48-7206a47185dd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7a3e70-6a46-b722-ef48-7206a47185dd@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/22 at 09:11pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/3/16 20:11, Baoquan He wrote:
> > On 02/27/22 at 11:07am, Zhen Lei wrote:
...... 

> > Hi leizhen,
> > 
> > I made change on reserve_crashkenrel(), inline comment may be slow.
> > Please check and consider if they can be taken.
> 
> That's great. Thank you very much.
> 
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 30ae6638ff54..f96351da1e3e 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -109,38 +109,43 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >   * This function reserves memory area given in "crashkernel=" kernel command
> >   * line parameter. The memory reserved is used by dump capture kernel when
> >   * primary kernel is crashing.
> > + *
> > + * NOTE: Reservation of crashkernel,low is special since its existence
> > + * is not independent, need rely on the existence of crashkernel,high.
> > + * Hence there are different cases for crashkernel,low reservation:

Considering to update the 3rd line as below:

 * NOTE: Reservation of crashkernel,low is special since its existence
 * is not independent, need rely on the existence of crashkernel,high.
 * Here, four cases of crashkernel,low reservation are summarized: 

> > + * 1) crashkernel=Y,low is specified explicitly, crashkernel,low takes Y;
> > + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
> > + *    take the default crashkernel,low value;
> > + * 3) crashkernel=X is specified, while fallback to get a memory region
> > + *    in high memory, take the default crashkernel,low value;
> > + * 4) crashkernel='invalid value',low is specified, failed the whole
> > + *    crashkernel reservation and bail out.
> >   */
> >  static void __init reserve_crashkernel(void)
> >  {
> >  	unsigned long long crash_base, crash_size;
> >  	unsigned long long crash_low_size;
> >  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > -	int ret;
> >  	bool fixed_base, high = false;
> >  	char *cmdline = boot_command_line;
> > +	int ret;
> >  
> >  	/* crashkernel=X[@offset] */
> >  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> >  				&crash_size, &crash_base);
> >  	if (ret || !crash_size) {
> > -		/* crashkernel=X,high */
> >  		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> >  		if (ret || !crash_size)
> >  			return;
> >  
> > -		/* crashkernel=Y,low */
> >  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> >  		if (ret == -ENOENT)
> > -			/*
> > -			 * crashkernel=Y,low is not specified explicitly, use
> > -			 * default size automatically.
> > -			 */
> > +			/* case #2 of crashkernel,low reservation */
> >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >  		else if (ret)
> > -			/* crashkernel=Y,low is specified but Y is invalid */
> > +			/* case #4 of crashkernel,low reservation */
> >  			return;
> >  
> > -		/* Mark crashkernel=X,high is specified */
> >  		high = true;
> >  		crash_max = CRASH_ADDR_HIGH_MAX;
> >  	}
> > @@ -148,7 +153,6 @@ static void __init reserve_crashkernel(void)
> >  	fixed_base = !!crash_base;
> >  	crash_size = PAGE_ALIGN(crash_size);
> >  
> > -	/* User specifies base address explicitly. */
> >  	if (fixed_base)
> >  		crash_max = crash_base + crash_size;
> >  
> > @@ -172,11 +176,7 @@ static void __init reserve_crashkernel(void)
> >  	}
> >  
> >  	if (crash_base >= SZ_4G) {
> > -		/*
> > -		 * For case crashkernel=X, low memory is not enough and fall
> > -		 * back to reserve specified size of memory above 4G, try to
> > -		 * allocate minimum required memory below 4G again.
> > -		 */
> > +		/* case #3 of crashkernel,low reservation */
> >  		if (!high)
> >  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >  
> > 
> >>  
> >> -	/* Current arm64 boot protocol requires 2MB alignment */
> >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> >> +retry:
> >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>  					       crash_base, crash_max);
> >>  	if (!crash_base) {
> >> +		/*
> >> +		 * Attempt to fully allocate low memory failed, fall back
> >> +		 * to high memory, the minimum required low memory will be
> >> +		 * reserved later.
> >> +		 */
> >> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> >> +			crash_max = CRASH_ADDR_HIGH_MAX;
> >> +			goto retry;
> >> +		}
> >> +
> >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >>  			crash_size);
> >>  		return;
> >>  	}
> >>  
> >> +	if (crash_base >= SZ_4G) {
> >> +		/*
> >> +		 * For case crashkernel=X, low memory is not enough and fall
> >> +		 * back to reserve specified size of memory above 4G, try to
> >> +		 * allocate minimum required memory below 4G again.
> >> +		 */
> >> +		if (!high)
> >> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> >> +
> >> +		if (reserve_crashkernel_low(crash_low_size)) {
> >> +			memblock_phys_free(crash_base, crash_size);
> >> +			return;
> >> +		}
> >> +	}
> >> +
> >>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> >>  		crash_base, crash_base + crash_size, crash_size >> 20);
> >>  
> >> @@ -107,6 +194,9 @@ static void __init reserve_crashkernel(void)
> >>  	 * map. Inform kmemleak so that it won't try to access it.
> >>  	 */
> >>  	kmemleak_ignore_phys(crash_base);
> >> +	if (crashk_low_res.end)
> >> +		kmemleak_ignore_phys(crashk_low_res.start);
> >> +
> >>  	crashk_res.start = crash_base;
> >>  	crashk_res.end = crash_base + crash_size - 1;
> >>  	insert_resource(&iomem_resource, &crashk_res);
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

