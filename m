Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB6451E689
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiEGKty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 06:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344713AbiEGKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 06:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3E9F2125C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651920363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6tGT96k7wfHK+Y3z3B3U0HcMpQlkBA9WkQzKqYtG1fc=;
        b=iS+o7XbU+OZiIeIzc6omJeU6QPyAT9b0SnVC7i78kzoemowwqJ25t99TF8OMymp+vNAfNE
        PglNtWclvKnqYi6VVoQ30SaPEImx+G1AdXf/T5OZLn2qN31viuwtYrgi7ds9KxxpGCWvrY
        Wu9tMLTPypLVAvaaqllTkQobp9yb5e0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-sMX8Gq8LPiOMk0YdMirfMw-1; Sat, 07 May 2022 06:45:59 -0400
X-MC-Unique: sMX8Gq8LPiOMk0YdMirfMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A38C91C05ABE;
        Sat,  7 May 2022 10:45:58 +0000 (UTC)
Received: from localhost (ovpn-13-110.pek2.redhat.com [10.72.13.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D1F740D2830;
        Sat,  7 May 2022 10:45:57 +0000 (UTC)
Date:   Sat, 7 May 2022 18:45:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20220507104554.GE122876@MiWiFi-R3L-srv>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
 <YnQC44KVKirH0vyB@arm.com>
 <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
 <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
 <YnVept85UJCaZp6p@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnVept85UJCaZp6p@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/22 at 06:45pm, Catalin Marinas wrote:
> On Fri, May 06, 2022 at 09:16:08PM +0800, Baoquan He wrote:
> > On 05/06/22 at 11:22am, Leizhen (ThunderTown) wrote:
> > ......  
> > > >> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
> > > >>  	if (crash_base)
> > > >>  		crash_max = crash_base + crash_size;
> > > >>  
> > > >> -	/* Current arm64 boot protocol requires 2MB alignment */
> > > >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> > > >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > > >>  					       crash_base, crash_max);
> > > >>  	if (!crash_base) {
> > > >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > > > 
> > > > I personally like this but let's see how the other thread goes. I guess
> > > 
> > > Me too. This fallback complicates code logic more than just a little.
> > > I'm not sure why someone would rather add fallback than change the bootup
> > > options to crashkernel=X,[high|low]. Perhaps fallback to high/low is a better
> > > compatible and extended mode when crashkernel=X fails to reserve memory. And
> > > the code logic will be much clearer.
> > 
> > The fallback does complicates code, while it was not made at the
> > beginning, but added later. The original crahskernel=xM can only reserve
> > low memory under 896M on x86 to be back compatible with the case in which
> > normal kernel is x86_64, while kdump kernel could be i386. Then customer
> > complained why crashkernel=xM can't be put anywhere so that they don't
> > need to know the details of limited low memory and huge high memory fact 
> > in system.
> > 
> > The implementation of fallback is truly complicated, but its use is
> > quite simple. And it makes crashkernel reservation setting simple.
> > Most of users don't need to know crashkernel=,high, ,low things, unless
> > the crashkernel region is too big. Nobody wants to take away 1G or more
> > from low memory for kdump just in case bad thing happens, while normal
> > kernel itself is seriously impacted by limited low memory.
> 
> IIUC, that's exactly what happens even on x86, it may take away a
> significant chunk of the low memory. Let's say we have 1.2GB of 'low'
> memory (below 4GB) on an arm64 platform. A crashkernel=1G would succeed
> in a low allocation, pretty much affecting the whole system. It would
> only fall back to 'high' _if_ you pass something like crashkernel=1.2G
> so that the low allocation fails. So if I got this right, I find the
> fall-back from crashkernel=X pretty useless, we shouldn't even try it.

Most of time, it's not easy to get 1G contiguous low memory. On x86,
firmware is mapped into low 4G virt address, and system initialization
will take some of them too. On arm64, it's hard too, e.g the physical
memory will start at 1G or 2G position, and firmware need be mapped
under 4G too, and kernel initialization costing. And we are eager to see
crashkernel=,high support too because we got a bug that on an arm64
server, its physical memory is scattered under low 4G so that the
biggest contiguous memory is less than 300M. (Not sure if it's a prototype
machine, I would not say its name in public.) In this case, we need
the fallback implementation to make our default crashkernel=xM setting
succeed getting the required memory from above 4G.

So from our experience and feedback given by customer, crashkernel=xM as
a default setting is the first choice and very easy to use and can
satisfy 99% of needs. If big crashkernel reservation is required,
considering low memory is limited and precious, while most of time
high memory is huge, crashkernel=,high is recommended. The price is about
200M or less memory for DMA, however much the required high memory is, 2G
or more. Believe me this kind of big memory requirement happens on very
few machines, because vmcore dumping tool makedumpfile taking the default
cyclic buffer method to dump which require not much memory. Unless user
has their own dumping tool or other dumping method which require much
memory.

crashkernel=xM, whether it is from its name, or the actual need, had
better get the fallback mechanism to allow it being put anywhere.

> 
> It makes more sense if crashkernel=X,high is a hint to attempt a high
> allocation first with a default low (overridden by a ,low option) or
> even fall-back to low if there's no memory above 4GB.

Hmm, maybe not so much. Please also consider the big end servers usually
carry tons of devices, its rebooting will take half an hour or even more
time. Imagine in an lab with hundereds of servers, one time of OS upgrading 
need to attempt high allocation firstly on each machine, then decide
what is set. That will drive operator mad. So we give them the simplest
way, crashkernel=xM to make it work. If you want to optimize the memory
usage and you know each system well, then please use crashkernel=,high
and crashkernel=,low to make it.

In our distros, the policy is if default crashkernel=xM setting with
OS installation doesn't work well, e.g OOM or reserving too much memory
causing wasting, bug can be reported. crashkernel=,high and
crashkernel=,low don't work well, settle by yourself.

> 
> Could you please have a look at Zhen Lei's latest series without any
> fall-backs? I'd like to queue that if you are happy with it. We can then
> look at adding some fall-back options on top.

I am fine with the v24, except of the corner case I pointed out. I
personally suggest merging the v24 series, and fix the corner case
and add fall back on top, with step by step style.

Thanks
Baoquan

> 
> IMO, we should only aim for:
> 
> 	crashkernel=X		ZONE_DMA allocation, no fall-back
> 	crashkernel=X,high	hint for high allocation, small default
> 				low, fall back to low if alloc fails
> 	crashkernel=X,low	control the default low allocation, only
> 				high is passed
> 
> With the above, I'd expect admins to just go for crashkernel=X,high on
> modern hardware with up to date kexec tools and it does the right thing.
> The crashkernel=X can lead to unexpected results if it eats up all the
> low memory. Let's say this option is for backwards compatibility only.
> 
> Thanks.
> 
> -- 
> Catalin
> 

