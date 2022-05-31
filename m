Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736225394B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbiEaQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiEaQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:05:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D1813D5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37015CE16FD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F72C385A9;
        Tue, 31 May 2022 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654013132;
        bh=b9RnbKQcXJrnB1KXhWSO/DdOr7SD54f5RYTo/RuTyvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cvz/dwv0V3OHEJhBZprOfvrwyj/3KtDnbbJKdW+0IZW/rpaLqv9e91ijC878ztnPK
         OEPc1YFzeDiQGH1T4N42tvQQ6cMlvncWnOHbQtW3SXhpF+j5GKJvGAeMQ1iXOLZ67w
         eNYdfDt1yeyMIQ//4ORm3bR2TMVvglqCv6predvJZOSfe42VOhSI85RAFetSKd8a6r
         /KMEFNG4PWT2k25Npqwaw7EtHmOMMc+N+09xZKugDbkA9NiRSUESO/6g36xYRiv8DD
         +Al7EMq3zw1dv0h9WVShe/xwJuLbg6Sa483lwPJ7MjanmNnj2BNjzHR82RW6Lh+E8B
         8MMx0MKg9roUw==
Date:   Tue, 31 May 2022 17:05:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next v7 5/6] arm64/mm: Enable
 ARCH_SUPPORTS_PAGE_TABLE_CHECK
Message-ID: <20220531160524.GC25502@willie-the-truck>
References: <20220507110114.4128854-1-tongtiangen@huawei.com>
 <20220507110114.4128854-6-tongtiangen@huawei.com>
 <20220517135435.GA553@mutt>
 <CA+CK2bAnfxTo-Osvo9=0t=RkC4rTR+mgg2JSypsu3wm6BZFT=A@mail.gmail.com>
 <CADYN=9JtrZSAmN8J8KbG_PRVGKPhJ3JkP+nq2bqrpFqEa=Avjg@mail.gmail.com>
 <CADYN=9JZ_b2OfM8o7Uwf7Oxb_SjgX_dpaqb_=doy1wJ3bM+mvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9JZ_b2OfM8o7Uwf7Oxb_SjgX_dpaqb_=doy1wJ3bM+mvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:41:55PM +0200, Anders Roxell wrote:
> On Tue, 17 May 2022 at 16:33, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > On Tue, 17 May 2022 at 16:02, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Tue, May 17, 2022 at 9:54 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > > >
> > > > On 2022-05-07 11:01, Tong Tiangen wrote:
> > > > > From: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > >
> > > > > As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table check")
> > > > > , enable ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64.
> > > > >
> > > > > Add additional page table check stubs for page table helpers, these stubs
> > > > > can be used to check the existing page table entries.
> > > > >
> > > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> > > > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > >
> > > > When building and booting an arm64 allmodconfig kernel on the next tree, branch next-20220516,
> > > > see the following kernel oops when booting in QEMU [1]:
> > > >
> > > > T35] ------------[ cut here ]------------
> > > > [  578.695796][   T35] kernel BUG at mm/page_table_check.c:82!

That seems to be:

	BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);

> > > > [  578.697292][   T35] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > > > [  578.704318][   T35] Modules linked in:
> > > > [  578.705907][   T35] CPU: 0 PID: 35 Comm: khugepaged Tainted: G                T 5.18.0-rc6-next-20220513 #1 893498a5d8159d9fb26e12492a93c07e83dd4b7f
> > > > [  578.711170][   T35] Hardware name: linux,dummy-virt (DT)
> > > > [  578.713315][   T35] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > [  578.716398][   T35] pc : page_table_check_clear.constprop.0+0x1f4/0x280
> > > > [  578.719107][   T35] lr : page_table_check_clear.constprop.0+0x1cc/0x280
> > > > [  578.721781][   T35] sp : ffff80000f3778b0
> > > > [  578.723446][   T35] x29: ffff80000f3778b0 x28: ffff80000b891218 x27: ffff000012dd55f0
> > > > [  578.726667][   T35] x26: 0000000000000008 x25: ffff80000c38cd80 x24: 0000000000000000
> > > > [  578.729870][   T35] x23: ffff80000c38c9c0 x22: 0000000000000000 x21: 0000000000000200
> > > > [  578.733079][   T35] x20: ffff000007bae000 x19: ffff000007bae008 x18: 0000000000000000
> > > > [  578.736299][   T35] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > > [  578.739505][   T35] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > > > [  578.742735][   T35] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > > > [  578.745925][   T35] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > > [  578.749145][   T35] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff000007bae00c
> > > > [  578.752348][   T35] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 00000000ffffffff
> > > > [  578.755556][   T35] Call trace:
> > > > [  578.756877][   T35]  page_table_check_clear.constprop.0+0x1f4/0x280
> > > > [  578.759446][   T35]  __page_table_check_pmd_clear+0xc4/0x140
> > > > [  578.761757][   T35]  pmdp_collapse_flush+0xa4/0x1c0
> > > > [  578.763771][   T35]  collapse_huge_page+0x4e4/0xb00
> > > > [  578.765778][   T35]  khugepaged_scan_pmd+0xc18/0xd00
> > > > [  578.767840][   T35]  khugepaged_scan_mm_slot+0x580/0x780
> > > > [  578.770018][   T35]  khugepaged+0x2dc/0x400
> > > > [  578.771786][   T35]  kthread+0x164/0x180
> > > > [  578.773430][   T35]  ret_from_fork+0x10/0x20
> > > > [  578.775253][   T35] Code: 52800021 91001263 14000388 36f80040 (d4210000)
> > > > [  578.777990][   T35] ---[ end trace 0000000000000000 ]---
> > > > [  578.778021][   T35] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > > > [  578.782934][   T35] Kernel Offset: disabled
> > > > [  578.784642][   T35] CPU features: 0x000,00100010,00001086
> > > > [  578.786848][   T35] Memory Limit: none
> > > > [  578.788433][   T35] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> 
> Now I see this oops on the mainline kernel too when I'm building and booting an
> arm64 allmodconfig kernel, sha
> 9d004b2f4fea ("Merge tag 'cxl-for-5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl").
> 
> building and booting an arm64 allmodconfig kernel.
> 
> When I revert 42b2547137f5 ("arm64/mm: enable
> ARCH_SUPPORTS_PAGE_TABLE_CHECK") I'm able to boot.
> The kernel boots fine.

I don't think disabling the check is the right thing to do, and I'm not
really seeing anything arm64-specific from the information here either. It's
more likely that one of the many other options (or combination of options)
enabled in allmodconfig is causing the problem. Are you able to reproduce on
x86?

Anshuman -- any ideas?

Will
