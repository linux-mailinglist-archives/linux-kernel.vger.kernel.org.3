Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF25A96B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiIAM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiIAM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D735C363
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662035165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrt1ZYitPBlV+DXuxO50MrOwRbd2uvYAZJ1ekTubqT8=;
        b=Mwe945GLgcO6Qub9KRAFaZkNuxIcapnTlVgd49/oPd1hZ7xP6xVV7a0GLf4W4NItOVdM1P
        ZuwwIRxbH1u2Tfy8aEUN7trFijsxzT9a15wT77ikLJmn2BZSYgtduI4UT+Krx/7aBzCObZ
        GO2UDz9zX3cvBoItwzV3TS1tYzYiYAc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-2bpZLYifNdGtOQSeAJA5DA-1; Thu, 01 Sep 2022 08:26:02 -0400
X-MC-Unique: 2bpZLYifNdGtOQSeAJA5DA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 721F13C0D1A4;
        Thu,  1 Sep 2022 12:26:01 +0000 (UTC)
Received: from localhost (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0781415125;
        Thu,  1 Sep 2022 12:26:00 +0000 (UTC)
Date:   Thu, 1 Sep 2022 20:25:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ardb@kernel.org,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBeS0G+F+fsBgod@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/22 at 10:24am, Mike Rapoport wrote:
> On Wed, Aug 31, 2022 at 10:29:39PM +0800, Baoquan He wrote:
> > On 08/31/22 at 10:37am, Mike Rapoport wrote:
> > > On Sun, Aug 28, 2022 at 08:55:44AM +0800, Baoquan He wrote:
> > > > 
> > > > Solution:
> > > > =========
> > > > To fix the problem, we should always take 4G as the crashkernel low
> > > > memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
> > > > With this, we don't need to defer the crashkernel reservation till
> > > > bootmem_init() is called to set the arm64_dma_phys_limit. As long as
> > > > memblock init is done, we can conclude what is the upper limit of low
> > > > memory zone.
> > > > 
> > > > 1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
> > > >   limit = PHYS_ADDR_MAX+1  (Corner cases)
> > > 
> > > Why these are corner cases? 
> > > The case when CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled is the
> > > simplest one because it does not require the whole dancing around
> > > arm64_dma_phys_limit initialization.
> > > 
> > > And AFAIK, memblock_start_of_DRAM() > 4G is not uncommon on arm64, but it
> > > does not matter for device DMA addressing.
> > 
> > Thanks for reviewing.
> > 
> > I could be wrong and have misunderstanding about corner case.
> > 
> > With my understanding, both ZONE_DMA and ZONE_DMA32 are enabled by
> > default in kernel. And on distros, I believe they are on too. The both
> > ZONE_DMA and ZONE_DMA32 disabled case should only exist on one specific
> > product, and the memblock_start_of_DRAM() > 4G case too. At least, I
> > haven't seen one in our LAB. What I thought the non generic as corner
> > case could be wrong. I will change that phrasing.
> > 
> > mm/Kconfig:
> > config ZONE_DMA
> >         bool "Support DMA zone" if ARCH_HAS_ZONE_DMA_SET
> >         default y if ARM64 || X86
> > 
> > config ZONE_DMA32
> >         bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
> >         depends on !X86_32
> >         default y if ARM64
> 
> My point was that the cases with ZONE_DMA/DMA32 disabled or with RAM above
> 4G do not require detection of arm64_dma_phys_limit before reserving the
> crash kernel, can use predefined constants and are simple to handle.

I see.

>  
> > > The actual corner cases are systems with ZONE_DMA/DMA32 and with <32 bits
> > > limit for device DMA addressing (e.g RPi 4). I think the changelog should
> > 
> > Right, RPi4's 30bit DMA addressing device is corner case.
> > 
> > > mention that to use kdump on these devices user must specify
> > > crashkernel=X@Y 
> > 
> > Makes sense. I will add words in log, and add sentences to
> > mention that in code comment or some place of document.
> > Thanks for advice.
> > 
> > > 
> > > > 2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
> > > >    limit = 4G  (generic case)
> > > > 
> 
> ...
> 
> > > > +static phys_addr_t __init crash_addr_low_max(void)
> > > > +{
> > > > +	phys_addr_t low_mem_mask = U32_MAX;
> > > > +	phys_addr_t phys_start = memblock_start_of_DRAM();
> > > > +
> > > > +	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> > > > +	     (phys_start > U32_MAX))
> > > > +		low_mem_mask = PHYS_ADDR_MAX;
> > > > +
> > > > +	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;
> > > 
> > > Since RAM frequently starts on non-zero address the limit for systems with
> > > ZONE_DMA/DMA32 should be memblock_start_of_DRAM() + 4G. There is no need to
> > 
> > It may not be right for memblock_start_of_DRAM(). On most of arm64
> > servers I ever tested, their memblock usually starts from a higher
> > address, but not zero which is like x86. E.g below memory ranges printed
> > on an ampere-mtsnow-altra system, the starting addr is 0x83000000. With
> > my understanding, DMA addressing bits correspond to the cpu logical
> > address range devices can address. So memblock_start_of_DRAM() + 4G
> > seems not right for normal system, and not right for system which
> > starting physical address is above 4G. I refer to max_zone_phys() of
> > arch/arm64/mm/init.c when implementing crash_addr_low_max(). Please
> > correct me if I am wrong.
> 
> My understanding was that no matter where DRAM starts, the first 4G would
> be accessible by 32-bit devices, but I maybe wrong as well :)
> 
> I haven't notice you used max_zone_phys() as a reference. Wouldn't it be
> simpler to just call it from crash_addr_low_max():
> 
> static phys_addr_t __init crash_addr_low_max(void)
> {
> 	return max_zone_phys(32);
> }

max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
it like:

static phys_addr_t __init crash_addr_low_max(void)
{
        phys_addr_t low_mem_mask = U32_MAX;
        phys_addr_t phys_start = memblock_start_of_DRAM();

        if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
             (phys_start > U32_MAX))
                low_mem_mask = PHYS_ADDR_MAX;

        return low_mem_mast + 1;
}

or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
as you suggested. Which one do you like better?

static phys_addr_t __init crash_addr_low_max(void)
{
        if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
		return PHYS_ADDR_MAX + 1;

        return max_zone_phys(32);
}

