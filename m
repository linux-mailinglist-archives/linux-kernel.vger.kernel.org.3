Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB84A467CC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353051AbhLCRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:47:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhLCRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:47:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ABB1B828E3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 17:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110E3C53FCD;
        Fri,  3 Dec 2021 17:44:14 +0000 (UTC)
Date:   Fri, 3 Dec 2021 17:44:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v1] arm64/mm: avoid race condition of update page table
 when kernel init
Message-ID: <YapXa8JWPNhkePwO@arm.com>
References: <20211027094828.7629-1-jianyong.wu@arm.com>
 <1cd8e875-24b1-2904-4e9f-2a4eb13674dc@arm.com>
 <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR08MB72767A6DFA5A7ED8117E7C44F4869@AM9PR08MB7276.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 08:36:07AM +0100, Jianyong Wu wrote:
> From Anshuman Khandual <anshuman.khandual@arm.com>:
> > On 10/27/21 3:18 PM, Jianyong Wu wrote:
> > > Race condition of page table update can happen in kernel boot period
> > > as both of memory hotplug action when kernel init and the
> > > mark_rodata_ro can update page table. For virtio-mem, the function excute flow chart is:
> > >
> > > -------------------------
> > > kernel_init
> > >   kernel_init_freeable
> > >     ...
> > >       do_initcall
> > >         ...
> > >           module_init [A]
> > >
> > >   ...
> > >   mark_readonly
> > >     mark_rodata_ro [B]
> > > -------------------------
[...]
> > > We can see that the error derived from the l3 translation as the pte
> > > value is *0*. That is because the fixmap has been clear when access.
> > >
> > > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> > > ---
> > >  arch/arm64/mm/mmu.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
> > > cfd9deb347c3..567dfba8f08a 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -564,8 +564,10 @@ void mark_rodata_ro(void)
> > >      * to cover NOTES and EXCEPTION_TABLE.
> > >      */
> > >     section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
> > > +   get_online_mems();
> > >     update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
> > >                         section_size, PAGE_KERNEL_RO);
> > > +   put_online_mems();
> > >
> > >     debug_checkwx();
> > >  }
> >
> > While this should solve the current problem i.e race between concurrent
> > memory hotplug operation and mark_rodata_ro(), but I am still wondering
> > whether this is the fix at the right place and granularity. Basically a hotplug
> > operation queued in an work queue at [A] can execute during [B] is the root
> > cause of this problem.
> 
> Not exactly, this issue doesn't only happen at the the *pure* kernel
> boot. For example, hotplug memory through VM monitor when VM boot. We
> can't foresee when that happen. Thus, this issue can affect all kinds
> of memory hotplug mechanism, including ACPI based memory hotplug and
> virtio-mem. I'm not sure that fix it here is the best way. If the race
> only happens between kernel init and memory hotplug, I think it's fine
> to fix it here. IMO, this issue results from the race for "fixmap"
> resource. I wonder why this global resource is not protected by a
> lock. Maybe we can add one and fix it there.

IIUC the race is caused by multiple attempts to use the fixmap at the
same time. We can add a fixmap_lock and hold it during
__create_pgd_mapping().

-- 
Catalin
