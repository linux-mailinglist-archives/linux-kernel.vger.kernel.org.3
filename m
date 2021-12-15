Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3381F475C99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbhLOQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:03:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34874 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhLOQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:03:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38D3761995
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CABDC36AE1;
        Wed, 15 Dec 2021 16:02:58 +0000 (UTC)
Date:   Wed, 15 Dec 2021 16:02:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, will@kernel.org,
        anshuman.khandual@arm.com, akpm@linux-foundation.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@redhat.com,
        gshan@redhat.com, justin.he@arm.com, nd@arm.com
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YboRr0BCgjAbYdHe@arm.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
 <Ybn4EfweLqKtyW0+@fixkernel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybn4EfweLqKtyW0+@fixkernel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:13:37AM -0500, Qian Cai wrote:
> On Fri, Dec 10, 2021 at 05:54:32PM +0800, Jianyong Wu wrote:
> > fixmap is a global resource and is used recursively in create pud mapping.
> > It may lead to race condition when alloc_init_pud is called concurrently.
> > 
> > Fox example:
> > alloc_init_pud is called when kernel_init. If memory hotplug
> > thread, which will also call alloc_init_pud, happens during
> > kernel_init, the race for fixmap occurs.
> > 
> > The race condition flow can be:
> > 
> > *************** begin **************
> > 
> > kerenl_init thread                          virtio-mem workqueue thread
> > ==================                          ======== ==================
> > alloc_init_pud(...)
> >   pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
> > ...                                         ...
> >     READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
> > ...                                         ...
> >   pud_clear_fixmap() //fixmap break
> >                                               READ_ONCE(*pudp) //CRASH!
> > 
> > **************** end ***************
> > 
> > Hence, a spin lock is introduced to protect the fixmap during create pdg
> > mapping.
> > 
> > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> 
> I am afraid there is a problem to take a spinlock there.
> 
> node 0 deferred pages initialised in 2740ms
>  pgdatinit0 (176) used greatest stack depth: 59184 bytes left
>  devtmpfs: initialized
>  KASLR disabled due to lack of seed
>  BUG: sleeping function called from invalid context at mm/page_alloc.c:5151

Thanks for the report. Definitely a bug, GFP_KERNEL_ACCOUNT allows for
the page allocator to sleep. I'll drop the patch from the arm64
for-next/fixes branch for now and sort it out later.

-- 
Catalin
