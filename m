Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF105A0AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiHYHsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiHYHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182FA3D63
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C58E61A24
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB93C433D7;
        Thu, 25 Aug 2022 07:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661413719;
        bh=dQKKQ6rhEloN80vnbe6U+fegbAvUdopbeJMAvtIxeJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfTOxogQpjcTXyROKDnxZKor+jiOMfeJ+0KNfJwxtE3mgA0Xmwl+LnH+mBtCHpG69
         aHlFw5k+hSqJ7HSRxVX8hY3Uas7I4miAePUMWXRUHRhycnej5Zlr5iytNWZIKmbZJq
         OtrJhVALfvEfkefQwiUP8TGEKUWJ2tZlQthU0dsxmnxjyi7q/uFF1P1rT0jYZ6AAsx
         pcDJFM3Y5G9vyU4YChRDMBGPZOk1c42KFzw8XFec3PY0XiETXK078KXrWcV21LOrbh
         MoEXRYIQOsKJUeEcqFPacnMQo+L94HDVrm3L9ecAH/6HT3N0zEyJGojIqlCE8bf0Ca
         e/6RTdOYHV/0A==
Date:   Thu, 25 Aug 2022 10:48:21 +0300
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
Message-ID: <YwcpRQvNErbTq1XB@kernel.org>
References: <20220819041156.873873-1-rppt@kernel.org>
 <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Thu, Aug 25, 2022 at 03:35:04PM +0800, Baoquan He wrote:
> Add kexec list in CC
> 
> On 08/19/22 at 07:11am, Mike Rapoport wrote:
> > From: Mike Rapoport <mike.rapoport@gmail.com>
> > 
> > Hi,
> > 
> > There were several rounds of discussion how to remap with base pages only
> > the crash kernel area, the latest one here:
> > 
> > https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com
> > 
> > and this is my attempt to allow having both large pages in the linear map
> > and protection for the crash kernel memory.
> > 
> > For server systems it is important to protect crash kernel memory for
> > post-mortem analysis, and for that protection to work the crash kernel
> > memory should be mapped with base pages in the linear map. 
> > 
> > On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
> > happens after the linear map is created and the current code forces using
> > base pages for the entire linear map, which results in performance
> > degradation.
> > 
> > These patches enable remapping of the crash kernel area with base pages
> > while keeping large pages in the rest of the linear map.
> > 
> > The idea is to align crash kernel reservation to PUD boundaries, remap that
> > PUD and then free the extra memory.
> 
> Hi Mike,
> 
> Thanks for the effort to work on this issue. While I have to say this
> isnt's good because it can only be made relying on a prerequisite that
> there's big enough memory. If on a system, say 2G memory, it's not easy
> to succeed on getting one 1G memory. While we only require far smaller
> region than 1G, e.g about 200M which should be easy to get. So the way
> taken in this patchset is too quirky and will cause regression on
> systemswith small memory. This kind of sytems with small memory exists
> widely on virt guest instance.

I don't agree there is a regression. If the PUD-aligned allocation fails,
there is a fallback to the allocation of the exact size requested for crash
kernel. This allocation just won't get protected.

Also please note, that the changes are only for the case when user didn't
force base-size pages in the linear map, so anything that works now will
work the same way with this set applied.
 
> The crashkernel reservation happens after linear map because the
> reservation needs to know the dma zone boundary, arm64_dma_phys_limit.
> If we can deduce that before bootmem_init(), the reservation can be
> done before linear map. I will make an attempt on that. If still can't
> be accepted, we would like to take off the crashkernel region protection
> on arm64 for now.

I doubt it would be easy because arm64_dma_phys_limit is determined after
parsing of the device tree and there might be memory allocations of
possibly unmapped memory during the parsing.
 
> Thanks
> Baoquan
> 

-- 
Sincerely yours,
Mike.
