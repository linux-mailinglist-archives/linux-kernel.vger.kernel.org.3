Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3251DE73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444258AbiEFRtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378615AbiEFRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:49:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE148B57;
        Fri,  6 May 2022 10:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CE44B83736;
        Fri,  6 May 2022 17:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E16C385A8;
        Fri,  6 May 2022 17:45:13 +0000 (UTC)
Date:   Fri, 6 May 2022 18:45:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
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
Subject: Re: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YnVept85UJCaZp6p@arm.com>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
 <YnQC44KVKirH0vyB@arm.com>
 <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
 <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 09:16:08PM +0800, Baoquan He wrote:
> On 05/06/22 at 11:22am, Leizhen (ThunderTown) wrote:
> ......  
> > >> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
> > >>  	if (crash_base)
> > >>  		crash_max = crash_base + crash_size;
> > >>  
> > >> -	/* Current arm64 boot protocol requires 2MB alignment */
> > >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> > >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > >>  					       crash_base, crash_max);
> > >>  	if (!crash_base) {
> > >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > > 
> > > I personally like this but let's see how the other thread goes. I guess
> > 
> > Me too. This fallback complicates code logic more than just a little.
> > I'm not sure why someone would rather add fallback than change the bootup
> > options to crashkernel=X,[high|low]. Perhaps fallback to high/low is a better
> > compatible and extended mode when crashkernel=X fails to reserve memory. And
> > the code logic will be much clearer.
> 
> The fallback does complicates code, while it was not made at the
> beginning, but added later. The original crahskernel=xM can only reserve
> low memory under 896M on x86 to be back compatible with the case in which
> normal kernel is x86_64, while kdump kernel could be i386. Then customer
> complained why crashkernel=xM can't be put anywhere so that they don't
> need to know the details of limited low memory and huge high memory fact 
> in system.
> 
> The implementation of fallback is truly complicated, but its use is
> quite simple. And it makes crashkernel reservation setting simple.
> Most of users don't need to know crashkernel=,high, ,low things, unless
> the crashkernel region is too big. Nobody wants to take away 1G or more
> from low memory for kdump just in case bad thing happens, while normal
> kernel itself is seriously impacted by limited low memory.

IIUC, that's exactly what happens even on x86, it may take away a
significant chunk of the low memory. Let's say we have 1.2GB of 'low'
memory (below 4GB) on an arm64 platform. A crashkernel=1G would succeed
in a low allocation, pretty much affecting the whole system. It would
only fall back to 'high' _if_ you pass something like crashkernel=1.2G
so that the low allocation fails. So if I got this right, I find the
fall-back from crashkernel=X pretty useless, we shouldn't even try it.

It makes more sense if crashkernel=X,high is a hint to attempt a high
allocation first with a default low (overridden by a ,low option) or
even fall-back to low if there's no memory above 4GB.

Could you please have a look at Zhen Lei's latest series without any
fall-backs? I'd like to queue that if you are happy with it. We can then
look at adding some fall-back options on top.

IMO, we should only aim for:

	crashkernel=X		ZONE_DMA allocation, no fall-back
	crashkernel=X,high	hint for high allocation, small default
				low, fall back to low if alloc fails
	crashkernel=X,low	control the default low allocation, only
				high is passed

With the above, I'd expect admins to just go for crashkernel=X,high on
modern hardware with up to date kexec tools and it does the right thing.
The crashkernel=X can lead to unexpected results if it eats up all the
low memory. Let's say this option is for backwards compatibility only.

Thanks.

-- 
Catalin
