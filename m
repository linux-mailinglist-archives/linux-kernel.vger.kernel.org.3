Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9D532A44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiEXMTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiEXMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:19:30 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288F9346A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:19:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 9EE3EFB80F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:19:26 +0100 (IST)
Received: (qmail 8447 invoked from network); 24 May 2022 12:19:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2022 12:19:26 -0000
Date:   Tue, 24 May 2022 13:19:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
Message-ID: <20220524121924.GZ3441@techsingularity.net>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
 <20220509130805.20335-6-mgorman@techsingularity.net>
 <554f4cdf-e4d9-f547-d3bb-1bcc1c9eb1@google.com>
 <20220524121224.GY3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220524121224.GY3441@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 01:12:24PM +0100, Mel Gorman wrote:
> On Sat, May 21, 2022 at 07:49:10PM -0700, Hugh Dickins wrote:
> > On Mon, 9 May 2022, Mel Gorman wrote:
> > 
> > > Currently the PCP lists are protected by using local_lock_irqsave to
> > > prevent migration and IRQ reentrancy but this is inconvenient. Remote
> > > draining of the lists is impossible and a workqueue is required and
> > > every task allocation/free must disable then enable interrupts which is
> > > expensive.
> > > 
> > > As preparation for dealing with both of those problems, protect the
> > > lists with a spinlock. The IRQ-unsafe version of the lock is used
> > > because IRQs are already disabled by local_lock_irqsave. spin_trylock
> > > is used in preparation for a time when local_lock could be used instead
> > > of lock_lock_irqsave.
> > 
> > 8c580f60a145 ("mm/page_alloc: protect PCP lists with a spinlock")
> > in next-20220520: I haven't looked up whether that comes from a
> > stable or unstable suburb of akpm's tree.
> > 
> > Mel, the VM_BUG_ON(in_hardirq()) which this adds to free_unref_page_list() 
> > is not valid.  I have no appreciation of how important it is to the whole
> > scheme, but as it stands, it crashes; and when I change it to a warning
> > 
> 
> Thanks Hugh. Sorry for the delay in responding, I was offline for a few
> days. The context where free_unref_page_list is called from IRQ context
> is safe and the VM_BUG_ON can be removed.
> 

Version that has a more appropriate baseline, it'll cause a collision
later in the series but it's trivially resolved.

--8<--
mm/page_alloc: Protect PCP lists with a spinlock -fix

Hugh Dickins reported the following problem;

[  256.167040] WARNING: CPU: 0 PID: 9842 at mm/page_alloc.c:3478 free_unref_page_list+0x92/0x343
[  256.170031] CPU: 0 PID: 9842 Comm: cc1 Not tainted 5.18.0-rc7-n20 #3
[  256.171285] Hardware name: LENOVO 20HQS0EG02/20HQS0EG02, BIOS N1MET54W (1.39 ) 04/16/2019
[  256.172555] RIP: 0010:free_unref_page_list+0x92/0x343
[  256.173820] Code: ff ff 49 8b 44 24 08 4d 89 e0 4c 8d 60 f8 eb b6 48 8b 03 48 39 c3 0f 84 af 02 00 00 65 8b 05 72 7f df 7e a9 00 00 0f 00 74 02 <0f> 0b 9c 41 5d fa 41 0f ba e5 09 73 05 e8 1f 0a f9 ff e8 46 90 7b
[  256.175289] RSP: 0018:ffff88803ec07c80 EFLAGS: 00010006
[  256.176683] RAX: 0000000080010000 RBX: ffff88803ec07cf8 RCX: 000000000000002c
[  256.178122] RDX: 0000000000000000 RSI: ffff88803ec29d28 RDI: 0000000000000040
[  256.179580] RBP: ffff88803ec07cc0 R08: ffff88803ec07cf0 R09: 00000000000a401d
[  256.181031] R10: 0000000000000000 R11: ffff8880101891b8 R12: ffff88803f6dd600
[  256.182501] R13: ffff88803ec07cf8 R14: 000000000000000f R15: 0000000000000000
[  256.183957] FS:  00007ffff7fcfac0(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
[  256.185419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  256.186911] CR2: 0000555555710cdc CR3: 00000000240b4004 CR4: 00000000003706f0
[  256.188395] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  256.189888] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  256.191390] Call Trace:
[  256.192844]  <IRQ>
[  256.194253]  ? __mem_cgroup_uncharge_list+0x4e/0x57
[  256.195715]  release_pages+0x26f/0x27e
[  256.197150]  ? list_add_tail+0x39/0x39
[  256.198603]  pagevec_lru_move_fn+0x95/0xa4

The VM_BUG_ON was added as preparing for a time when the PCP was an IRQ-unsafe
lock. The fundamental limitation is that free_unref_page_list() cannot be called
with the PCP lock held when an IRQ is delivered. At the moment, this is impossible
and even if PCP was an IRQ-unsafe lock, free_unref_page_list is not called from
page allocator context in an unsafe manner. Remove the VM_BUG_ON.

This is a fix to the mmotm patch
mm-page_alloc-protect-pcp-lists-with-a-spinlock.patch

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3a6aa97ad7a..52e7fe681483 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3535,8 +3535,6 @@ void free_unref_page_list(struct list_head *list)
 	if (list_empty(list))
 		return;
 
-	VM_BUG_ON(in_hardirq());
-
 	local_lock_irqsave(&pagesets.lock, flags);
 
 	page = lru_to_page(list);
