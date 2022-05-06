Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97A51D633
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391159AbiEFLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEFLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274051E57;
        Fri,  6 May 2022 04:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF96161DEC;
        Fri,  6 May 2022 11:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA7FC385AA;
        Fri,  6 May 2022 11:06:26 +0000 (UTC)
Date:   Fri, 6 May 2022 12:06:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
Subject: Re: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YnUBLgUiZDhRPMzU@arm.com>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
 <YnQC44KVKirH0vyB@arm.com>
 <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:22:51AM +0800, Leizhen (ThunderTown) wrote:
> On 2022/5/6 1:01, Catalin Marinas wrote:
> > On Thu, May 05, 2022 at 05:18:42PM +0800, Zhen Lei wrote:
> >> From: Chen Zhou <chenzhou10@huawei.com>
> >>
> >> There are following issues in arm64 kdump:
> >> 1. We use crashkernel=X to reserve crashkernel in DMA zone, which
> >> will fail when there is not enough low memory.
> >> 2. If reserving crashkernel above DMA zone, in this case, crash dump
> >> kernel will fail to boot because there is no low memory available
> >> for allocation.
> >>
> >> To solve these issues, introduce crashkernel=X,[high,low].
> >> The "crashkernel=X,high" is used to select a region above DMA zone, and
> >> the "crashkernel=Y,low" is used to allocate specified size low memory.
> > 
> > Thanks for posting the simplified version, though the discussion with
> > Baoquan is still ongoing. AFAICT there is no fallback if crashkernel=
> > fails. The advantage with this series is cleaner code, we set the limits
> > during parsing and don't have to adjust them if some of the first
> > allocation failed.
> 
> Yes, I'm currently implementing it in the simplest version, providing only
> the most basic functions. Because the conclusions of this part of the discussion
> are clear. I think I can send the fallback, default low size, and mapping optimization
> patches separately after this basic version is merged. These three functions can
> be discussed separately.

This works for me. If we decide to go for fallbacks, it can be done as a
separate patch.

> >> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> >> +		if (ret || !crash_size)
> >> +			return;
> >> +
> >> +		/*
> >> +		 * crashkernel=Y,low can be specified or not, but invalid value
> >> +		 * is not allowed.
> >> +		 */
> >> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> >> +		if (ret && (ret != -ENOENT))
> >> +			return;
> >> +
> >> +		crash_max = CRASH_ADDR_HIGH_MAX;
> >> +	}
> >>  
> >>  	crash_size = PAGE_ALIGN(crash_size);
> >>  
> >> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
> >>  	if (crash_base)
> >>  		crash_max = crash_base + crash_size;
> >>  
> >> -	/* Current arm64 boot protocol requires 2MB alignment */
> >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>  					       crash_base, crash_max);
> >>  	if (!crash_base) {
> >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > 
> > I personally like this but let's see how the other thread goes. I guess
> 
> Me too. This fallback complicates code logic more than just a little.
> I'm not sure why someone would rather add fallback than change the bootup
> options to crashkernel=X,[high|low]. Perhaps fallback to high/low is a better
> compatible and extended mode when crashkernel=X fails to reserve memory. And
> the code logic will be much clearer.
> 
> //parse crashkernel=X		//To simplify the discussion, Ignore [@offset]
> crash_base = memblock_phys_alloc_range()
> if (!crash_base || /* crashkernel=X is not specified */) {
> 	//parse crashkernel=X,[high,low]
> 	//reserve high/low memory
> }
> 
> So that, the following three modes are supported:
> 1) crashkernel=X[@offset]
> 2) crashkernel=X,high crashkernel=X,low
> 3) crashkernel=X[@offset] crashkernel=X,high [crashkernel=Y,low]

The whole interface isn't great but if we add fall-back options, I'd
rather stick close to what x86 does. IOW, if crashkernel=X is provided,
ignore explicit high/low (so 3 does not exist).

(if I had added it from the beginning, I'd have removed 'high'
completely and allow crashkernel=X to fall-back to 'high' with an
optional explicit 'low' or 'dma' if the default is not sufficient; but I
think there's too much bikeshedding already)

> > if we want a fallback, it would come just before the check the above:
> > 
> > 	if (!crash_base && crash_max != CRASH_ADDR_HIGH_MAX) {
> > 		/* attempt high allocation with default low */
> > 		if (!crash_low_size)
> > 			crash_low_size = some default;
> > 		crash_max = CRASH_ADDR_LOW_MAX;
> 
> crash_max = CRASH_ADDR_HIGH_MAX; We should fallback to high memory now.

Yes, that's the idea.

Anyway, please post the current series with the minor updates I
mentioned and we can add a fallback patch (or two) on top.

Thanks.

-- 
Catalin
