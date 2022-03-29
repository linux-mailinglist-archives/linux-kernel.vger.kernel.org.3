Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61C24EA666
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiC2E0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiC2E0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:26:00 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86723D478
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:24:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t19so14315507qtc.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=OHsT30LerQF22ZxAY4E0nr/Vxbvqe+9c/4GeB7Fivh8=;
        b=N+EsFZUrQDyjVloHimvvkYMsBgu+pa6DpbKwo+Zcn2AxLUESRVqEjt2to46fJ2NUZg
         AzegJhQvpu/oMaXxe7Ef0ilxAaQCNfXXzN8lxRKApiPg1nEizVbJV3CC2v0R2nyXY2nZ
         Q/ibW8cZ7KpjArRqRtxJT3mSnwHkIyxGiqQzifXo82mD6vG0oTjoBl+WtnIypAUAIyHN
         ve1axsAWd2HS8Gvi62dLmA8M+cVyF9VtBp1hAVd9Ic5RSpnr4uz/b9t+E1eam6CnDDQX
         WpSLm9u+UboXF0Gwu5txXNOsAmealYGJgJyNdxyxu07iy40atTHv2zy3N4qsJ2wyg9Av
         kHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=OHsT30LerQF22ZxAY4E0nr/Vxbvqe+9c/4GeB7Fivh8=;
        b=Z6GahYoiqNOcVkQ12Ex7xSaaL44sEzzcQGXN/adw8OtRC89jXhhdCoi6YxWV4P9rwZ
         ATF7QKCEfY7QYXGB+57dHSy4zgUuYRxKiZX+bVYqYmcNp1K34L8N/MLvAqgbsx0VxsJF
         kG/MJzjAJYkl1e+pjY+p5z13Icr04yHVCJZbSyXBbmhVfu8yx37NrQ9zFhHkdfqymTFf
         18V+G8frBPa1mK7xt6X36WgUUg+LQx3AxBAiJnl2T/cTUMa7Gyquy6vtEwnzernZbofh
         BWVShg9Atnut7/8WAif7XeJv5oMX+hs86XZj7aCyWj6VTRGsdq8W6+C5u/R5Wc5RmCu1
         lS8Q==
X-Gm-Message-State: AOAM533yXAlUO4U7xd1TTkjf0saIcup4DT+6BXONETAVEwezpewhaD/6
        7BFtCK3TDY1OJEX3nmPmlNZmrQ==
X-Google-Smtp-Source: ABdhPJxfTzQF/4ZAeYVD42hLjotpcitS/7MwiAfMdWth5B6XyDL4W++zJKi7NeSloasokbh5SUekxQ==
X-Received: by 2002:ac8:4417:0:b0:2e1:b5bb:3474 with SMTP id j23-20020ac84417000000b002e1b5bb3474mr25252083qtn.18.1648527856325;
        Mon, 28 Mar 2022 21:24:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a12ac00b0067d4bfffc59sm8790217qki.118.2022.03.28.21.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:24:16 -0700 (PDT)
Date:   Mon, 28 Mar 2022 21:24:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: WARNING: mm/workingset.c:567 shadow_lru_isolate
Message-ID: <55db706b-9bce-b820-7d88-6392374cd4fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunday's linux.git, under tmpfs swapping load (including
ext4 file readonly THPs and shmem THPs), gave me the:

	if (WARN_ON_ONCE(!node->nr_values))
		goto out_invalid;
	if (WARN_ON_ONCE(node->count != node->nr_values))
		goto out_invalid;

from mm/workingset.c - log below.  I did see these on mmotm before
the merge window, but only now got around to bisecting them.  And
the bisection, confirmed by revert, arrives surprisingly at:

820c4e2e6f51 ("mm/vmscan: Free non-shmem folios without splitting them")

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1739,8 +1739,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
+		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
+			/* Split shmem THP */
 			if (split_folio_to_list(folio, page_list))
 				goto keep_locked;
 		}

I'm not familiar with workingset.c, I'll make no guesses, over to you!

Hugh

[ 1470.572186] ------------[ cut here ]------------
[ 1470.574478] WARNING: CPU: 1 PID: 47 at mm/workingset.c:567 shadow_lru_isolate+0x84/0x128
[ 1470.575570] CPU: 1 PID: 47 Comm: kswapd0 Not tainted 5.18.0-rc0 #2
[ 1470.576592] Hardware name: LENOVO 20HQS0EG02/20HQS0EG02, BIOS N1MET54W (1.39 ) 04/16/2019
[ 1470.577836] RIP: 0010:shadow_lru_isolate+0x84/0x128
[ 1470.579170] Code: 89 ff 4c 8d 73 e8 e8 16 f4 ff ff 83 ca ff be 09 00 00 00 4c 89 f7 e8 91 3c 05 00 4c 89 ef e8 e9 25 7d 00 8a 43 eb 84 c0 75 04 <0f> 0b eb 2a 3a 43 ea 74 04 0f 0b eb 21 48 c7 c6 6a f7 1f 81 4c 89
[ 1470.580669] RSP: 0018:ffff888000e0bba0 EFLAGS: 00010046
[ 1470.582173] RAX: 0000000080000000 RBX: ffff888016c21510 RCX: 8bc9d3bc33ed677c
[ 1470.583755] RDX: 0000000000000003 RSI: ffffffff823f436f RDI: 00000000ffffffff
[ 1470.585303] RBP: ffff888000e0bbc8 R08: 0000000000000078 R09: 00000000000c8386
[ 1470.586860] R10: 0000000000000001 R11: ffff888000e055b8 R12: ffff8880166c99d0
[ 1470.588518] R13: ffff8880010dd180 R14: ffff888016c214f8 R15: ffff8880010dd1c0
[ 1470.590154] FS:  0000000000000000(0000) GS:ffff88803ec80000(0000) knlGS:0000000000000000
[ 1470.591743] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1470.593296] CR2: 0000555555694f50 CR3: 000000000f940005 CR4: 00000000003706e0
[ 1470.594824] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1470.596198] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1470.597581] Call Trace:
[ 1470.598907]  <TASK>
[ 1470.600267]  __list_lru_walk_one+0x84/0xf2
[ 1470.601629]  ? workingset_update_node+0x84/0x84
[ 1470.602977]  list_lru_walk_one_irq+0x59/0x74
[ 1470.604324]  ? workingset_update_node+0x84/0x84
[ 1470.605657]  scan_shadow_nodes+0x29/0x2b
[ 1470.607073]  do_shrink_slab+0x1d0/0x33d
[ 1470.608477]  shrink_slab+0x98/0x100
[ 1470.609880]  shrink_node_memcgs+0x136/0x182
[ 1470.611164]  shrink_node+0x220/0x3d9
[ 1470.612446]  balance_pgdat+0x216/0x3cb
[ 1470.613715]  ? lock_is_held_type+0xcf/0x10f
[ 1470.615010]  kswapd+0x189/0x1ae
[ 1470.616285]  ? balance_pgdat+0x3cb/0x3cb
[ 1470.617481]  kthread+0xee/0xf6
[ 1470.618690]  ? kthread_exit+0x1f/0x1f
[ 1470.619932]  ret_from_fork+0x1f/0x30
[ 1470.621110]  </TASK>
[ 1470.622237] irq event stamp: 76862920
[ 1470.623284] hardirqs last  enabled at (76862919): [<ffffffff819d1ee3>] _raw_spin_unlock_irq+0x23/0x42
[ 1470.624373] hardirqs last disabled at (76862920): [<ffffffff819d1c96>] _raw_spin_lock_irq+0x17/0x4c
[ 1470.625540] softirqs last  enabled at (76861226): [<ffffffff81c0036f>] __do_softirq+0x36f/0x3aa
[ 1470.626752] softirqs last disabled at (76861195): [<ffffffff811049cd>] __irq_exit_rcu+0x85/0xc1
[ 1470.627957] ---[ end trace 0000000000000000 ]---
[ 1470.629407] ------------[ cut here ]------------
[ 1470.630849] WARNING: CPU: 1 PID: 47 at mm/workingset.c:569 shadow_lru_isolate+0x8d/0x128
[ 1470.632264] CPU: 1 PID: 47 Comm: kswapd0 Tainted: G        W         5.18.0-rc0 #2
[ 1470.633729] Hardware name: LENOVO 20HQS0EG02/20HQS0EG02, BIOS N1MET54W (1.39 ) 04/16/2019
[ 1470.635202] RIP: 0010:shadow_lru_isolate+0x8d/0x128
[ 1470.636601] Code: ff ff 83 ca ff be 09 00 00 00 4c 89 f7 e8 91 3c 05 00 4c 89 ef e8 e9 25 7d 00 8a 43 eb 84 c0 75 04 0f 0b eb 2a 3a 43 ea 74 04 <0f> 0b eb 21 48 c7 c6 6a f7 1f 81 4c 89 f7 e8 71 ca 7a 00 ba 01 00
[ 1470.638206] RSP: 0018:ffff888000e0bba0 EFLAGS: 00010087
[ 1470.639811] RAX: 0000000080000020 RBX: ffff888016c4d020 RCX: 8bc9d3bc33ed677c
[ 1470.641470] RDX: 0000000000000003 RSI: ffffffff823f436f RDI: 00000000ffffffff
[ 1470.643072] RBP: ffff888000e0bbc8 R08: 0000000000000078 R09: 00000000000c8386
[ 1470.644688] R10: 0000000000000001 R11: ffff888000e055b8 R12: ffff888016c54910
[ 1470.646312] R13: ffff8880010dd180 R14: ffff888016c4d008 R15: ffff8880010dd1c0
[ 1470.648341] FS:  0000000000000000(0000) GS:ffff88803ec80000(0000) knlGS:0000000000000000
[ 1470.649820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1470.651404] CR2: 0000555555694f50 CR3: 000000000f940005 CR4: 00000000003706e0
[ 1470.651408] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1470.651411] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1470.655817] Call Trace:
[ 1470.655821]  <TASK>
[ 1470.655824]  __list_lru_walk_one+0x84/0xf2
[ 1470.660171]  ? workingset_update_node+0x84/0x84
[ 1470.660178]  list_lru_walk_one_irq+0x59/0x74
[ 1470.662784]  ? workingset_update_node+0x84/0x84
[ 1470.662791]  scan_shadow_nodes+0x29/0x2b
[ 1470.662795]  do_shrink_slab+0x1d0/0x33d
[ 1470.662800]  shrink_slab+0x98/0x100
[ 1470.662805]  shrink_node_memcgs+0x136/0x182
[ 1470.662810]  shrink_node+0x220/0x3d9
[ 1470.662814]  balance_pgdat+0x216/0x3cb
[ 1470.662818]  ? lock_is_held_type+0xcf/0x10f
[ 1470.662824]  kswapd+0x189/0x1ae
[ 1470.662828]  ? balance_pgdat+0x3cb/0x3cb
[ 1470.662833]  kthread+0xee/0xf6
[ 1470.662838]  ? kthread_exit+0x1f/0x1f
[ 1470.662843]  ret_from_fork+0x1f/0x30
[ 1470.662849]  </TASK>
[ 1470.662851] irq event stamp: 76862966
[ 1470.662854] hardirqs last  enabled at (76862965): [<ffffffff819d1ee3>] _raw_spin_unlock_irq+0x23/0x42
[ 1470.662860] hardirqs last disabled at (76862966): [<ffffffff819d1c96>] _raw_spin_lock_irq+0x17/0x4c
[ 1470.662866] softirqs last  enabled at (76862958): [<ffffffff81c0036f>] __do_softirq+0x36f/0x3aa
[ 1470.662871] softirqs last disabled at (76862925): [<ffffffff811049cd>] __irq_exit_rcu+0x85/0xc1
[ 1470.662877] ---[ end trace 0000000000000000 ]---
