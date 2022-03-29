Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840934EAF83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiC2Opt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiC2Opn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:45:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708F366A7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t7Q+jhI9UZJhIWE2/oqDfYhFA25P+HJW56muMmn3X9U=; b=S56/59mjT/XoUOayZae2jx8dZD
        WdZ98U/Zj60LEJcCEdPp8ehpChTRTa6y+NAMe1wWQCp4DQfmUjDJNwxh4tdTkp5qc5uQfkWom9vam
        NUasl9Gk/Unj1vdPVYN3yvwgZvFvWCmkS0wWUsTHlMqpMqRiPAbCs9eO8bTOn6xmjVKXs1b9Wsnw5
        8eYW4ELbrhnuC4ZF6KHa/IE+IyVvSI2RIVMifsf9lfKSOWblxNDgtNbyX12FEkHSSTzJIt+V8x6UF
        t3S83extJu7IyBuRtYMWGo62SyhKC7ziFiJSj7CLvwF2lPxGiKYaA1GVvkNvBLAu8nHq/F4+bjq3P
        zeQjqlJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZD4Y-000Mmz-7c; Tue, 29 Mar 2022 14:43:50 +0000
Date:   Tue, 29 Mar 2022 15:43:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: WARNING: mm/workingset.c:567 shadow_lru_isolate
Message-ID: <YkMbJoBIriAHG0cc@casper.infradead.org>
References: <55db706b-9bce-b820-7d88-6392374cd4fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55db706b-9bce-b820-7d88-6392374cd4fc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:24:00PM -0700, Hugh Dickins wrote:
> Sunday's linux.git, under tmpfs swapping load (including
> ext4 file readonly THPs and shmem THPs), gave me the:
> 
> 	if (WARN_ON_ONCE(!node->nr_values))
> 		goto out_invalid;

Fun.  I'm assuming it's actually the ext4 file ROTHP that causes the
issue ... but really, I don't think it matters to fixing the bug.

> 	if (WARN_ON_ONCE(node->count != node->nr_values))
> 		goto out_invalid;
> 
> from mm/workingset.c - log below.  I did see these on mmotm before
> the merge window, but only now got around to bisecting them.  And
> the bisection, confirmed by revert, arrives surprisingly at:
> 
> 820c4e2e6f51 ("mm/vmscan: Free non-shmem folios without splitting them")
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1739,8 +1739,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  				/* Adding to swap updated mapping */
>  				mapping = page_mapping(page);
>  			}
> -		} else if (unlikely(PageTransHuge(page))) {
> -			/* Split file THP */
> +		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
> +			/* Split shmem THP */
>  			if (split_folio_to_list(folio, page_list))
>  				goto keep_locked;
>  		}
> 
> I'm not familiar with workingset.c, I'll make no guesses, over to you!

OK, so the overall point of this part of workingset.c is that we used
to simply remove pages from the page cache when they fell off the end
of the LRU.  Now we replace them with a shadow entry (obviously shmem is
different here which is why you're so unfamiliar with it).  The problem
with this is that we still tie up radix tree nodes tracking how old the
pages would have been.  So workingset puts nodes which only have shadow
entries on an LRU and will remove old radix tree nodes when there's
enough memory pressure.

These WARN_ON messages are supposed to be checking the invariant that
the nodes we're deleting only contain shadow entries; no real pages.
When the first one fires, it says there are _no_ shadow entries in this
node, and if we get to the second one, we're seeing a node with N entries,
but M of them are shadow entries and M != N.  That shouldn't be
possible; we should only put nodes on the list when nr_values is
positive and equal to count (see workingset_update_node()).

OK, so why are we hitting this now?  Before, we'd split the THP,
creating 8 new radix tree nodes, all of which would contain 64 shadow
entries and get put on the LRU.  What _should_ be happening after the
commit that we bisect to is that the node->count is unaffected, but
node->nr_values increases by 8.  I'll investigate a little bit, but
may ask you to add some debug if I'm having trouble reproducing it.

> Hugh
> 
> [ 1470.572186] ------------[ cut here ]------------
> [ 1470.574478] WARNING: CPU: 1 PID: 47 at mm/workingset.c:567 shadow_lru_isolate+0x84/0x128
> [ 1470.575570] CPU: 1 PID: 47 Comm: kswapd0 Not tainted 5.18.0-rc0 #2
> [ 1470.576592] Hardware name: LENOVO 20HQS0EG02/20HQS0EG02, BIOS N1MET54W (1.39 ) 04/16/2019
> [ 1470.577836] RIP: 0010:shadow_lru_isolate+0x84/0x128
> [ 1470.579170] Code: 89 ff 4c 8d 73 e8 e8 16 f4 ff ff 83 ca ff be 09 00 00 00 4c 89 f7 e8 91 3c 05 00 4c 89 ef e8 e9 25 7d 00 8a 43 eb 84 c0 75 04 <0f> 0b eb 2a 3a 43 ea 74 04 0f 0b eb 21 48 c7 c6 6a f7 1f 81 4c 89
> [ 1470.580669] RSP: 0018:ffff888000e0bba0 EFLAGS: 00010046
> [ 1470.582173] RAX: 0000000080000000 RBX: ffff888016c21510 RCX: 8bc9d3bc33ed677c
> [ 1470.583755] RDX: 0000000000000003 RSI: ffffffff823f436f RDI: 00000000ffffffff
> [ 1470.585303] RBP: ffff888000e0bbc8 R08: 0000000000000078 R09: 00000000000c8386
> [ 1470.586860] R10: 0000000000000001 R11: ffff888000e055b8 R12: ffff8880166c99d0
> [ 1470.588518] R13: ffff8880010dd180 R14: ffff888016c214f8 R15: ffff8880010dd1c0
> [ 1470.590154] FS:  0000000000000000(0000) GS:ffff88803ec80000(0000) knlGS:0000000000000000
> [ 1470.591743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1470.593296] CR2: 0000555555694f50 CR3: 000000000f940005 CR4: 00000000003706e0
> [ 1470.594824] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1470.596198] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1470.597581] Call Trace:
> [ 1470.598907]  <TASK>
> [ 1470.600267]  __list_lru_walk_one+0x84/0xf2
> [ 1470.601629]  ? workingset_update_node+0x84/0x84
> [ 1470.602977]  list_lru_walk_one_irq+0x59/0x74
> [ 1470.604324]  ? workingset_update_node+0x84/0x84
> [ 1470.605657]  scan_shadow_nodes+0x29/0x2b
> [ 1470.607073]  do_shrink_slab+0x1d0/0x33d
> [ 1470.608477]  shrink_slab+0x98/0x100
> [ 1470.609880]  shrink_node_memcgs+0x136/0x182
> [ 1470.611164]  shrink_node+0x220/0x3d9
> [ 1470.612446]  balance_pgdat+0x216/0x3cb
> [ 1470.613715]  ? lock_is_held_type+0xcf/0x10f
> [ 1470.615010]  kswapd+0x189/0x1ae
> [ 1470.616285]  ? balance_pgdat+0x3cb/0x3cb
> [ 1470.617481]  kthread+0xee/0xf6
> [ 1470.618690]  ? kthread_exit+0x1f/0x1f
> [ 1470.619932]  ret_from_fork+0x1f/0x30
> [ 1470.621110]  </TASK>
> [ 1470.622237] irq event stamp: 76862920
> [ 1470.623284] hardirqs last  enabled at (76862919): [<ffffffff819d1ee3>] _raw_spin_unlock_irq+0x23/0x42
> [ 1470.624373] hardirqs last disabled at (76862920): [<ffffffff819d1c96>] _raw_spin_lock_irq+0x17/0x4c
> [ 1470.625540] softirqs last  enabled at (76861226): [<ffffffff81c0036f>] __do_softirq+0x36f/0x3aa
> [ 1470.626752] softirqs last disabled at (76861195): [<ffffffff811049cd>] __irq_exit_rcu+0x85/0xc1
> [ 1470.627957] ---[ end trace 0000000000000000 ]---
> [ 1470.629407] ------------[ cut here ]------------
> [ 1470.630849] WARNING: CPU: 1 PID: 47 at mm/workingset.c:569 shadow_lru_isolate+0x8d/0x128
> [ 1470.632264] CPU: 1 PID: 47 Comm: kswapd0 Tainted: G        W         5.18.0-rc0 #2
> [ 1470.633729] Hardware name: LENOVO 20HQS0EG02/20HQS0EG02, BIOS N1MET54W (1.39 ) 04/16/2019
> [ 1470.635202] RIP: 0010:shadow_lru_isolate+0x8d/0x128
> [ 1470.636601] Code: ff ff 83 ca ff be 09 00 00 00 4c 89 f7 e8 91 3c 05 00 4c 89 ef e8 e9 25 7d 00 8a 43 eb 84 c0 75 04 0f 0b eb 2a 3a 43 ea 74 04 <0f> 0b eb 21 48 c7 c6 6a f7 1f 81 4c 89 f7 e8 71 ca 7a 00 ba 01 00
> [ 1470.638206] RSP: 0018:ffff888000e0bba0 EFLAGS: 00010087
> [ 1470.639811] RAX: 0000000080000020 RBX: ffff888016c4d020 RCX: 8bc9d3bc33ed677c
> [ 1470.641470] RDX: 0000000000000003 RSI: ffffffff823f436f RDI: 00000000ffffffff
> [ 1470.643072] RBP: ffff888000e0bbc8 R08: 0000000000000078 R09: 00000000000c8386
> [ 1470.644688] R10: 0000000000000001 R11: ffff888000e055b8 R12: ffff888016c54910
> [ 1470.646312] R13: ffff8880010dd180 R14: ffff888016c4d008 R15: ffff8880010dd1c0
> [ 1470.648341] FS:  0000000000000000(0000) GS:ffff88803ec80000(0000) knlGS:0000000000000000
> [ 1470.649820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1470.651404] CR2: 0000555555694f50 CR3: 000000000f940005 CR4: 00000000003706e0
> [ 1470.651408] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1470.651411] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1470.655817] Call Trace:
> [ 1470.655821]  <TASK>
> [ 1470.655824]  __list_lru_walk_one+0x84/0xf2
> [ 1470.660171]  ? workingset_update_node+0x84/0x84
> [ 1470.660178]  list_lru_walk_one_irq+0x59/0x74
> [ 1470.662784]  ? workingset_update_node+0x84/0x84
> [ 1470.662791]  scan_shadow_nodes+0x29/0x2b
> [ 1470.662795]  do_shrink_slab+0x1d0/0x33d
> [ 1470.662800]  shrink_slab+0x98/0x100
> [ 1470.662805]  shrink_node_memcgs+0x136/0x182
> [ 1470.662810]  shrink_node+0x220/0x3d9
> [ 1470.662814]  balance_pgdat+0x216/0x3cb
> [ 1470.662818]  ? lock_is_held_type+0xcf/0x10f
> [ 1470.662824]  kswapd+0x189/0x1ae
> [ 1470.662828]  ? balance_pgdat+0x3cb/0x3cb
> [ 1470.662833]  kthread+0xee/0xf6
> [ 1470.662838]  ? kthread_exit+0x1f/0x1f
> [ 1470.662843]  ret_from_fork+0x1f/0x30
> [ 1470.662849]  </TASK>
> [ 1470.662851] irq event stamp: 76862966
> [ 1470.662854] hardirqs last  enabled at (76862965): [<ffffffff819d1ee3>] _raw_spin_unlock_irq+0x23/0x42
> [ 1470.662860] hardirqs last disabled at (76862966): [<ffffffff819d1c96>] _raw_spin_lock_irq+0x17/0x4c
> [ 1470.662866] softirqs last  enabled at (76862958): [<ffffffff81c0036f>] __do_softirq+0x36f/0x3aa
> [ 1470.662871] softirqs last disabled at (76862925): [<ffffffff811049cd>] __irq_exit_rcu+0x85/0xc1
> [ 1470.662877] ---[ end trace 0000000000000000 ]---
> 
