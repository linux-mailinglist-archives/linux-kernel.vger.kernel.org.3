Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CD250334C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiDPE2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiDPE2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:17 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F213CD4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:25:44 -0700 (PDT)
Date:   Sat, 16 Apr 2022 13:25:36 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650083143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sCmTR67ANX5zgjllBNBvU/F0lbCm+PnkqjbDF5PCS4=;
        b=LU2o/zcZCHXeg7zlG8pVv+KuxnVqISCCdciw3nRoBfbRL8iYDGX7CTlWMoEKa9bbMceYOg
        GK7EnbEOKWpEcvlDBAaKxA7jYeTwh5E5iqxwKNrPZostoUOVLyTTfYOFKjBXP13W5Jtxrp
        C65UyNi1pJizuHmVzeIbiBg5fk9w4Ss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     John Hubbard <jhubbard@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1] mm: recheck PageCompound() before printing out info
 of head page
Message-ID: <20220416042536.GA1058054@u2004>
References: <20220414235950.840409-1-naoya.horiguchi@linux.dev>
 <a07a8bab-9962-d7f4-a49a-e44ece203032@nvidia.com>
 <21807e0d-8bd1-7b1a-dd76-85a02267b424@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21807e0d-8bd1-7b1a-dd76-85a02267b424@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 09:56:41AM +0800, Miaohe Lin wrote:
> On 2022/4/15 9:08, John Hubbard wrote:
> > On 4/14/22 16:59, Naoya Horiguchi wrote:
> >> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >>
> >> The following VM_BUG_ON_FOLIO() is triggered when memory error event
> >> happens on the (thp/folio) pages which are about to be freed:
> >>
> >>    [ 1160.232771] page:00000000b36a8a0f refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x16a000
> >>    [ 1160.236916] page:00000000b36a8a0f refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x16a000
> >>    [ 1160.240684] flags: 0x57ffffc0800000(hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
> >>    [ 1160.243458] raw: 0057ffffc0800000 dead000000000100 dead000000000122 0000000000000000
> >>    [ 1160.246268] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> >>    [ 1160.249197] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
> >>    [ 1160.251815] ------------[ cut here ]------------
> >>    [ 1160.253438] kernel BUG at include/linux/mm.h:788!
> >>    [ 1160.256162] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >>    [ 1160.258172] CPU: 2 PID: 115368 Comm: mceinj.sh Tainted: G            E     5.18.0-rc1-v5.18-rc1-220404-2353-005-g83111+ #3
> >>    [ 1160.262049] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
> >>    [ 1160.265103] RIP: 0010:dump_page.cold+0x27e/0x2bd
> >>    [ 1160.266757] Code: fe ff ff 48 c7 c6 81 f1 5a 98 e9 4c fe ff ff 48 c7 c6 a1 95 59 98 e9 40 fe ff ff 48 c7 c6 50 bf 5a 98 48 89 ef e8 9d 04 6d ff <0f> 0b 41 f7 c4 ff 0f 00 00 0f 85 9f fd ff ff 49 8b 04 24 a9 00 00
> >>    [ 1160.273180] RSP: 0018:ffffaa2c4d59fd18 EFLAGS: 00010292
> >>    [ 1160.274969] RAX: 000000000000003e RBX: 0000000000000001 RCX: 0000000000000000
> >>    [ 1160.277263] RDX: 0000000000000001 RSI: ffffffff985995a1 RDI: 00000000ffffffff
> >>    [ 1160.279571] RBP: ffffdc9c45a80000 R08: 0000000000000000 R09: 00000000ffffdfff
> >>    [ 1160.281794] R10: ffffaa2c4d59fb08 R11: ffffffff98940d08 R12: ffffdc9c45a80000
> >>    [ 1160.283920] R13: ffffffff985b6f94 R14: 0000000000000000 R15: ffffdc9c45a80000
> >>    [ 1160.286641] FS:  00007eff54ce1740(0000) GS:ffff99c67bd00000(0000) knlGS:0000000000000000
> >>    [ 1160.289498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>    [ 1160.291106] CR2: 00005628381a5f68 CR3: 0000000104712003 CR4: 0000000000170ee0
> >>    [ 1160.293031] Call Trace:
> >>    [ 1160.293724]  <TASK>
> >>    [ 1160.294334]  get_hwpoison_page+0x47d/0x570
> >>    [ 1160.295474]  memory_failure+0x106/0xaa0
> >>    [ 1160.296474]  ? security_capable+0x36/0x50
> >>    [ 1160.297524]  hard_offline_page_store+0x43/0x80
> >>    [ 1160.298684]  kernfs_fop_write_iter+0x11c/0x1b0
> >>    [ 1160.299829]  new_sync_write+0xf9/0x160
> >>    [ 1160.300810]  vfs_write+0x209/0x290
> >>    [ 1160.301835]  ksys_write+0x4f/0xc0
> >>    [ 1160.302718]  do_syscall_64+0x3b/0x90
> >>    [ 1160.303664]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>    [ 1160.304981] RIP: 0033:0x7eff54b018b7
> >>
> >> As shown in the RIP address, this VM_BUG_ON in folio_entire_mapcount() is
> >> called from dump_page("hwpoison: unhandlable page") in get_any_page().
> >> The below explains the mechanism of the race:
> >>
> >>    CPU 0                                       CPU 1
> >>
> >>      memory_failure
> >>        get_hwpoison_page
> >>          get_any_page
> >>            dump_page
> >>              compound = PageCompound
> >>                                                  free_pages_prepare
> >>                                                    page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP
> >>              folio_entire_mapcount
> >>                VM_BUG_ON_FOLIO(!folio_test_large(folio))
> >>
> >> So in order to avoid the BUG_ON, recheck PageCompound() before __dump_page()
> >> prints out information about the head page.  Precisely saying, this does
> >> not close up the race, but mitigates the impact to just inaccurate info,
> >> which should be acceptable.
> > 
> > Actually, I don't think it really closes the race even to that extent,
> > because a machine check (MCE, on x86) could come in at any point, so
> > rechecking (without locks) won't really completely fix such a bug, right?
> 
> It might also be unsafe to do dump_mapping or dump_page_owner when page could
> be freed at any time or we might come across some use-after-free issues?

OK, so memory_failure() simply shouldn't call dump_page() before taking page refcnt.

> 
> > 
> >>
> >> Fixes: 74e8ee4708a8 ("mm: Turn head_compound_mapcount() into folio_entire_mapcount()")
> >> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >> ---
> >> I'm actually not sure how widely the race condition could affect.
> >> If we can consider this as a bug specific to memory_failure(), simply
> >> replacing the dump_page() with simple printk() might be a proper fix
> > 
> > I think we should have separate, limited, special case functions that
> > are safe for use by exotic things like the MCE handler. And so just
> > doing a printk there seems better to me.

Thanks, so now I lean to the printk-approach.

> > 
> >> (I confirmed that that fix also works).  But if any other dump_page()'s
> >> caller could race with freeing thp/folio, the more generic fix
> >> (I'm suggesting in this patch) would be desirable.
> > 
> > *If* there are other races, they should be addressed separately, IMHO.
> > Because MCE should be a special case.

I agree.

Thanks,
Naoya Horiguchi

> > 
> >> ---
> >>   mm/debug.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/debug.c b/mm/debug.c
> >> index bef329bf28f0..fce63b200bea 100644
> >> --- a/mm/debug.c
> >> +++ b/mm/debug.c
> >> @@ -93,7 +93,7 @@ static void __dump_page(struct page *page)
> >>       pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
> >>               page, page_ref_count(head), mapcount, mapping,
> >>               page_to_pgoff(page), page_to_pfn(page));
> >> -    if (compound) {
> >> +    if (compound && PageCompound(page)) {
> > 
> > If people decide to keep this approach, then I'd go with something
> > that makes it clear, like:
> > 
> >     /* Re-check, in a semi-doomed attempt to avoid racing with MCE: */
> >     compound = PageCompound(page);
> 
> Agree. A comment will be needed or the code might look obscure.
> 
> Thanks!
> 
> > 
> > :)
> > 
> > thanks,
> 
