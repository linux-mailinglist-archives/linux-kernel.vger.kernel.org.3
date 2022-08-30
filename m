Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B537F5A59DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH3DZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3DY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CFB1E8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661829888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9eHM5bdDrU457dsjk7yJ0LqGH38gn04owAekbromuM=;
        b=W9N4HEggAi69QSa3goJz4uRrJ20ZSvRbJz6RFSkDxMD95zfZwZ51cLVkg/ukmv2sgn+p2l
        WjDcthFd3Tnq+p89lPXHU4Nolqs6UXd+24as2xoPDwD+RDZqWb/uaeKw4hNXS7SRPSZwI4
        GXnpukzV03Ii+mTIKhWTk9e8zPDoqaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-H6hKGCrnPduvbUXehoYbfA-1; Mon, 29 Aug 2022 23:24:44 -0400
X-MC-Unique: H6hKGCrnPduvbUXehoYbfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6815857FE7;
        Tue, 30 Aug 2022 03:24:42 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A06A951CE;
        Tue, 30 Aug 2022 03:24:41 +0000 (UTC)
Date:   Tue, 30 Aug 2022 11:24:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/5] arm64/mm: remap crash kernel with base pages even if
 rodata_full disabled
Message-ID: <Yw2C9ahluhX4Mg3G@MiWiFi-R3L-srv>
References: <20220819041156.873873-1-rppt@kernel.org>
 <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
 <YwcpRQvNErbTq1XB@kernel.org>
 <YwspSc83XveXSFnW@MiWiFi-R3L-srv>
 <YwzNyVH8FB374In5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwzNyVH8FB374In5@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/22 at 05:31pm, Mike Rapoport wrote:
> On Sun, Aug 28, 2022 at 04:37:29PM +0800, Baoquan He wrote:
> > On 08/25/22 at 10:48am, Mike Rapoport wrote:
> > ...... 
> > > > > There were several rounds of discussion how to remap with base pages only
> > > > > the crash kernel area, the latest one here:
> > > > > 
> > > > > https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com
> > > > > 
> > > > > and this is my attempt to allow having both large pages in the linear map
> > > > > and protection for the crash kernel memory.
> > > > > 
> > > > > For server systems it is important to protect crash kernel memory for
> > > > > post-mortem analysis, and for that protection to work the crash kernel
> > > > > memory should be mapped with base pages in the linear map. 
> > > > > 
> > > > > On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
> > > > > happens after the linear map is created and the current code forces using
> > > > > base pages for the entire linear map, which results in performance
> > > > > degradation.
> > > > > 
> > > > > These patches enable remapping of the crash kernel area with base pages
> > > > > while keeping large pages in the rest of the linear map.
> > > > > 
> > > > > The idea is to align crash kernel reservation to PUD boundaries, remap that
> > > > > PUD and then free the extra memory.
> > > > 
> > > > Hi Mike,
> > > > 
> > > > Thanks for the effort to work on this issue. While I have to say this
> > > > isnt's good because it can only be made relying on a prerequisite that
> > > > there's big enough memory. If on a system, say 2G memory, it's not easy
> > > > to succeed on getting one 1G memory. While we only require far smaller
> > > > region than 1G, e.g about 200M which should be easy to get. So the way
> > > > taken in this patchset is too quirky and will cause regression on
> > > > systemswith small memory. This kind of sytems with small memory exists
> > > > widely on virt guest instance.
> > > 
> > > I don't agree there is a regression. If the PUD-aligned allocation fails,
> > > there is a fallback to the allocation of the exact size requested for crash
> > > kernel. This allocation just won't get protected.
> > 
> > Sorry, I misunderstood it. I just went through the log and didn't
> > look into codes.
> > 
> > But honestly, if we accept the fallback which doesn't do the protection,
> > we should be able to take off the protection completely, right?
> > Otherwise, the reservation code is a little complicated.
> 
> We don't do protection of the crash kernel for most architectures
> supporting kexec ;-)

Yeah. The protection was introduced into x86 firstly by my former
colleague of Redhat as an enhancement. Later people ported it to arm64.
We have signature verification mechanism to check if corruption on
loaded kdump kernel happened. In fact, panic is a small probability
event, and accidental corruption on kdump kernel data is a much smaller
probability event. The protection is an icing on the cake. But if it
brings mess, better take it away if no way to clean up the mess.

> 
> My goal was to allow large systems with ZONE_DMA/DMA32 have block mappings
> in the linear map and crash kernel protection without breaking backward
> compatibility for the existing systems.
> 
> > > Also please note, that the changes are only for the case when user didn't
> > > force base-size pages in the linear map, so anything that works now will
> > > work the same way with this set applied.
> > >  
> > > > The crashkernel reservation happens after linear map because the
> > > > reservation needs to know the dma zone boundary, arm64_dma_phys_limit.
> > > > If we can deduce that before bootmem_init(), the reservation can be
> > > > done before linear map. I will make an attempt on that. If still can't
> > > > be accepted, we would like to take off the crashkernel region protection
> > > > on arm64 for now.
> > > 
> > > I doubt it would be easy because arm64_dma_phys_limit is determined after
> > > parsing of the device tree and there might be memory allocations of
> > > possibly unmapped memory during the parsing.
> > 
> > I have sent out the patches with an attempt, it's pretty straightforward
> > and simple. Because arm64 only has one exception, namely Raspberry Pi 4,
> > on which some peripherals can only address 30bit range. That is a corner
> > case, to be honest. And kdump is a necessary feature on server, but may
> > not be so expected on Raspberry Pi 4, a system for computer education
> > and hobbyists. And kdump only cares whether the dump target devices can
> > address 32bit range, namely storage device or network card on server.
> > If finally confirmed that storage devices can only address 30bit range
> > on Raspberry Pi 4, people still can have crashkernel=xM@yM method to
> > reserve crashkernel regions.
> 
> I hope you are right and Raspberry Pi 4 is the only system that limits
> DMA'able range to 30 bits. But with diversity of arm64 chips and boards I
> won't be surprised that there are other variants with a similar problem.

We still need people to confirm if the storage disk or NIC on RPi4 is
able to address 32 bit range. From Nicalas's patch log and cover-letter,
he said not all devices on RPi4 are 30bit addressable.

That's possible a new arm64 chip comes out with devices of 30bit addresing,
even though those arm64 servers usually deployed with devices of wider than
32bit DMA addressing ability. And I don't think users of the chip will care
about kdump. Kdump is relied more on enterprise level system.

On x86, we ignore those ISA devices in kdump kernel at the beginning.
As you can see, the current kdump kernel has no available physical pages
in DMA zone on x86. If people have a ISA device in x86_64 system, and
want to set it as dump target, it doesn't work at all. We don't support
the corner case. If we want to cover everything, we can only limp with
patches all over us.

