Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F228149E26C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbiA0Meg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiA0Meg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:34:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E3C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:34:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC5261A70
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB75C340E4;
        Thu, 27 Jan 2022 12:34:32 +0000 (UTC)
Date:   Thu, 27 Jan 2022 12:34:28 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jianyong Wu <Jianyong.Wu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Justin He <Justin.He@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YfKRVJlWrgluqD9e@arm.com>
References: <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
 <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
 <3e6513f9-77ca-79e5-d185-7e9a11ec7689@redhat.com>
 <AM9PR08MB72764111B775352448D75CD9F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <65fdd873-1f93-56e3-c7a5-98d621c5dbd8@redhat.com>
 <7eb4bc77-c1db-99c4-4c77-ae9ddd159abb@redhat.com>
 <AM9PR08MB7276062BC7B474174FFFA11BF4219@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <ca62449b-7ab0-0e18-ee5a-b46b3f527385@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca62449b-7ab0-0e18-ee5a-b46b3f527385@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:22:47PM +0100, David Hildenbrand wrote:
> > Yes, system_state can roughly separate these callers of __create_pgd_mapping. When system_state > SYSTEM_BOOTING we can add the lock.
> > Thus, I have the following change:
> > 
> > static DEFINE_SPINLOCK(swapper_pgdir_lock);
> > +static DEFINE_MUTEX(fixmap_lock);
> > 
> >  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> >  {
> > @@ -329,6 +330,8 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
> >         }
> >         BUG_ON(p4d_bad(p4d));
> > 
> > +       if (system_state > SYSTEM_BOOTING)
> 
> As there is nothing smaller than SYSTEM_BOOTING, you can use
> 	if (system_state != SYSTEM_BOOTING)
> 
> ...
> 
> > 
> > It seems work and somehow simper. But I don't know if it is reasonable to do this. So, any idea? @Ard Biesheuvel  @Catalin Marinas 
> 
> It's worth looking at kernel/notifier.c, e.g.,
> blocking_notifier_chain_register()
> 
> if (unlikely(system_state == SYSTEM_BOOTING))
> 	return notifier_chain_register(&nh->head, n);
> 
> down_write(&nh->rwsem);
> ret = notifier_chain_register(&nh->head, n);
> up_write(&nh->rwsem);
> 
> If we decide to go down that path, we should make sure to add a comment like
> 
> /*
>  * No need for locking during early boot. And it doesn't work as
>  * expected with KASLR enabled where we might clear BSS twice.
>  */

A similar approach sounds fine to me.

-- 
Catalin
