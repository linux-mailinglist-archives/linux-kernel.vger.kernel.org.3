Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E25A4F49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiH2OcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Ob7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:31:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E68F964
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C70CB810A1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B28C433C1;
        Mon, 29 Aug 2022 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661783515;
        bh=KXyavkK9jmchKS7BM+QIziwxtNYM2+lbxNBUUd3PHyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pA/7OOQUY7XbeE1en6O+TKcX7NVXmCgSUo0LFicvnYUdsGNwOxmQyJYCf3dPiZGPq
         x4Scu4HcCVz/Gsqim3s73gcMswgBBN+ZePPcmKiUd/rjj8Zlz36TpZOjeLNO+yhcVa
         z5VNUAVpZw6cQkITOzrXbR6az7CHVc1x/IGCgl63fLTbUJ0R9Q1KXjjMoOM9QvesJg
         43Tewm0guxDD6hw4uI+87G4+Y/MoaIgKizEfB7U2xx952E6nntJyEC6UArWKCTyk/e
         0RnVCmmOg+D1u0LzKx8dh5pnr4FHFtqLsX3pT0U8Qm9Q5FnMuSRxQjmcN9fDMo7yv7
         vM9/oezVpYc3Q==
Date:   Mon, 29 Aug 2022 17:31:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <YwzNyVH8FB374In5@kernel.org>
References: <20220819041156.873873-1-rppt@kernel.org>
 <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
 <YwcpRQvNErbTq1XB@kernel.org>
 <YwspSc83XveXSFnW@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwspSc83XveXSFnW@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 04:37:29PM +0800, Baoquan He wrote:
> On 08/25/22 at 10:48am, Mike Rapoport wrote:
> ...... 
> > > > There were several rounds of discussion how to remap with base pages only
> > > > the crash kernel area, the latest one here:
> > > > 
> > > > https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com
> > > > 
> > > > and this is my attempt to allow having both large pages in the linear map
> > > > and protection for the crash kernel memory.
> > > > 
> > > > For server systems it is important to protect crash kernel memory for
> > > > post-mortem analysis, and for that protection to work the crash kernel
> > > > memory should be mapped with base pages in the linear map. 
> > > > 
> > > > On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
> > > > happens after the linear map is created and the current code forces using
> > > > base pages for the entire linear map, which results in performance
> > > > degradation.
> > > > 
> > > > These patches enable remapping of the crash kernel area with base pages
> > > > while keeping large pages in the rest of the linear map.
> > > > 
> > > > The idea is to align crash kernel reservation to PUD boundaries, remap that
> > > > PUD and then free the extra memory.
> > > 
> > > Hi Mike,
> > > 
> > > Thanks for the effort to work on this issue. While I have to say this
> > > isnt's good because it can only be made relying on a prerequisite that
> > > there's big enough memory. If on a system, say 2G memory, it's not easy
> > > to succeed on getting one 1G memory. While we only require far smaller
> > > region than 1G, e.g about 200M which should be easy to get. So the way
> > > taken in this patchset is too quirky and will cause regression on
> > > systemswith small memory. This kind of sytems with small memory exists
> > > widely on virt guest instance.
> > 
> > I don't agree there is a regression. If the PUD-aligned allocation fails,
> > there is a fallback to the allocation of the exact size requested for crash
> > kernel. This allocation just won't get protected.
> 
> Sorry, I misunderstood it. I just went through the log and didn't
> look into codes.
> 
> But honestly, if we accept the fallback which doesn't do the protection,
> we should be able to take off the protection completely, right?
> Otherwise, the reservation code is a little complicated.

We don't do protection of the crash kernel for most architectures
supporting kexec ;-)

My goal was to allow large systems with ZONE_DMA/DMA32 have block mappings
in the linear map and crash kernel protection without breaking backward
compatibility for the existing systems.

> > Also please note, that the changes are only for the case when user didn't
> > force base-size pages in the linear map, so anything that works now will
> > work the same way with this set applied.
> >  
> > > The crashkernel reservation happens after linear map because the
> > > reservation needs to know the dma zone boundary, arm64_dma_phys_limit.
> > > If we can deduce that before bootmem_init(), the reservation can be
> > > done before linear map. I will make an attempt on that. If still can't
> > > be accepted, we would like to take off the crashkernel region protection
> > > on arm64 for now.
> > 
> > I doubt it would be easy because arm64_dma_phys_limit is determined after
> > parsing of the device tree and there might be memory allocations of
> > possibly unmapped memory during the parsing.
> 
> I have sent out the patches with an attempt, it's pretty straightforward
> and simple. Because arm64 only has one exception, namely Raspberry Pi 4,
> on which some peripherals can only address 30bit range. That is a corner
> case, to be honest. And kdump is a necessary feature on server, but may
> not be so expected on Raspberry Pi 4, a system for computer education
> and hobbyists. And kdump only cares whether the dump target devices can
> address 32bit range, namely storage device or network card on server.
> If finally confirmed that storage devices can only address 30bit range
> on Raspberry Pi 4, people still can have crashkernel=xM@yM method to
> reserve crashkernel regions.

I hope you are right and Raspberry Pi 4 is the only system that limits
DMA'able range to 30 bits. But with diversity of arm64 chips and boards I
won't be surprised that there are other variants with a similar problem.
 
> Thanks
> Baoquan
> 

-- 
Sincerely yours,
Mike.
