Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A19530056
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 04:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiEVCt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 22:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiEVCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 22:49:26 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F53D4BF
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 19:49:24 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so14395713fac.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=BGknOB3l5BbFALA+R+pXhsu16wbF7g8dI+0JIcpU1CE=;
        b=YtO/tu1qRumlBtwXgFHCLssAZ1fK4keSiZJmReaVmL3+uvrAzXt3w129Kr5VzUQpe3
         QtyW5+Va6/7YG8fqVDDtydAzU1vUjZh3MAsRf+K0eaZFiAECOu6kNuyv0pXQ3SdpkLsJ
         X1s4DGWNSkpQwtwCK3ASJoTSnicG61J+m3x6q0s92OQlk3H0VKkKFAlFCuBYS3OSxdJ+
         V2xjhO5ugO0UqYZZQwGkfS2h46qdzfk9Q0HYMT+v8ifY8Br4obM2Oomh7bvpfg65hGa6
         aXMbM/Mh01hL/KxpCSEF8aKIKPK2cxIgRn56lTxYKQYNG+2ItNO+cJoAqhLscE2kbwEy
         Omug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=BGknOB3l5BbFALA+R+pXhsu16wbF7g8dI+0JIcpU1CE=;
        b=jJ1OH3FInOINKFZbqtSfqaDQwyVa1IfPimuIdgmmFqhU3BdS8hcpwkk3dxNwQW61pO
         vINB8x2Vn4fjAjT/GHbaD3DjMoWOEVc3hwljluUzZdPEINNf+rLhNN7AOoPcuc5C+ba/
         FeWrOU6QKTljPAeASK0KDLxdYLIYrzBKxQUndFTI7HW1QetKq2Rtf9R24620lBwl7cYv
         VdRlE9qJAU6eE3NySoLXJWrtIcSnShOA2q0SL5SR1oxy5rIdn0gR+m1vx9ndPOGkejG6
         l/wLWAaocHEuClzqJN4f8YdzqLK3AG+E120reN14ebb9SuOlDnpnA59saNmE6LeE4d52
         1mNg==
X-Gm-Message-State: AOAM533tes6UlS8qjpH7J64nutapZ/0Y5pl4I4Jv/kqtvbdKZPt9cXs6
        xhv3N4DrYeg1S7kSJgjONs752Q==
X-Google-Smtp-Source: ABdhPJwjwiWKLKChgkpyXLGuxP2CfTR5WO+2rBQ0jb9INRh7K7s1tmvPnw2HEhA1grPk9hyd0c0FVQ==
X-Received: by 2002:a05:6870:5707:b0:de:2cb8:7759 with SMTP id k7-20020a056870570700b000de2cb87759mr9420909oap.20.1653187763331;
        Sat, 21 May 2022 19:49:23 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e21-20020a056870451500b000e686d1388csm572036oao.38.2022.05.21.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 19:49:22 -0700 (PDT)
Date:   Sat, 21 May 2022 19:49:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
In-Reply-To: <20220509130805.20335-6-mgorman@techsingularity.net>
Message-ID: <554f4cdf-e4d9-f547-d3bb-1bcc1c9eb1@google.com>
References: <20220509130805.20335-1-mgorman@techsingularity.net> <20220509130805.20335-6-mgorman@techsingularity.net>
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

On Mon, 9 May 2022, Mel Gorman wrote:

> Currently the PCP lists are protected by using local_lock_irqsave to
> prevent migration and IRQ reentrancy but this is inconvenient. Remote
> draining of the lists is impossible and a workqueue is required and
> every task allocation/free must disable then enable interrupts which is
> expensive.
> 
> As preparation for dealing with both of those problems, protect the
> lists with a spinlock. The IRQ-unsafe version of the lock is used
> because IRQs are already disabled by local_lock_irqsave. spin_trylock
> is used in preparation for a time when local_lock could be used instead
> of lock_lock_irqsave.

8c580f60a145 ("mm/page_alloc: protect PCP lists with a spinlock")
in next-20220520: I haven't looked up whether that comes from a
stable or unstable suburb of akpm's tree.

Mel, the VM_BUG_ON(in_hardirq()) which this adds to free_unref_page_list() 
is not valid.  I have no appreciation of how important it is to the whole
scheme, but as it stands, it crashes; and when I change it to a warning

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3475,7 +3475,7 @@ void free_unref_page_list(struct list_he
 	if (list_empty(list))
 		return;
 
-	VM_BUG_ON(in_hardirq());
+	WARN_ON_ONCE(in_hardirq());
 
 	local_lock_irqsave(&pagesets.lock, flags);
 
then everything *appears* to go on working correctly after the splat
below (from which you will infer that I'm swapping to nvme):

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
[  256.200065]  folio_rotate_reclaimable+0xa0/0xd1
[  256.201545]  folio_end_writeback+0x1c/0x78
[  256.203064]  end_page_writeback+0x11/0x13
[  256.204495]  end_swap_bio_write+0x87/0x95
[  256.205967]  bio_endio+0x15e/0x162
[  256.207393]  blk_mq_end_request_batch+0xd2/0x18d
[  256.208932]  ? __this_cpu_preempt_check+0x13/0x15
[  256.210378]  ? lock_is_held_type+0xcf/0x10f
[  256.211714]  ? lock_is_held+0xc/0xe
[  256.213065]  ? rcu_read_lock_sched_held+0x24/0x4f
[  256.214450]  nvme_pci_complete_batch+0x4c/0x51
[  256.215811]  nvme_irq+0x43/0x4e
[  256.217173]  ? nvme_unmap_data+0xb5/0xb5
[  256.218633]  __handle_irq_event_percpu+0xff/0x235
[  256.220062]  handle_irq_event_percpu+0x10/0x39
[  256.221584]  handle_irq_event+0x34/0x53
[  256.223061]  handle_edge_irq+0xb1/0xd5
[  256.224486]  __common_interrupt+0x7a/0xe6
[  256.225918]  common_interrupt+0x9c/0xca
[  256.227330]  </IRQ>
[  256.228763]  <TASK>
[  256.230226]  asm_common_interrupt+0x2c/0x40
[  256.231724] RIP: 0010:lock_acquire.part.0+0x1a9/0x1b4
[  256.233190] Code: df ec 7e ff c8 74 19 0f 0b 48 c7 c7 77 2c 4e 82 e8 d7 e7 88 00 65 c7 05 01 df ec 7e 00 00 00 00 48 85 db 74 01 fb 48 8d 65 d8 <5b> 41 5c 41 5d 41 5e 41 5f 5d c3 55 48 89 e5 41 57 4d 89 cf 41 56
[  256.234804] RSP: 0018:ffff888010e939f0 EFLAGS: 00000206
[  256.236339] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 3e4406066e4f4abc
[  256.237889] RDX: 0000000000000000 RSI: ffffffff824021e7 RDI: ffffffff8244b3d1
[  256.239401] RBP: ffff888010e93a18 R08: 0000000000000028 R09: 000000000002001d
[  256.240994] R10: 0000000000000000 R11: ffff8880101891b8 R12: 0000000000000002
[  256.242545] R13: ffffffff82757a80 R14: ffffffff81253954 R15: 0000000000000000
[  256.244085]  ? __folio_memcg_unlock+0x48/0x48
[  256.245597]  lock_acquire+0xfa/0x10a
[  256.247179]  ? __folio_memcg_unlock+0x48/0x48
[  256.248727]  rcu_lock_acquire.constprop.0+0x24/0x27
[  256.250293]  ? __folio_memcg_unlock+0x48/0x48
[  256.251736]  mem_cgroup_iter+0x3d/0x178
[  256.253245]  shrink_node_memcgs+0x169/0x182
[  256.254822]  shrink_node+0x220/0x3d9
[  256.256372]  shrink_zones+0x10f/0x1ca
[  256.257923]  ? __this_cpu_preempt_check+0x13/0x15
[  256.259437]  do_try_to_free_pages+0x7a/0x192
[  256.260947]  try_to_free_mem_cgroup_pages+0x14b/0x213
[  256.262405]  try_charge_memcg+0x230/0x433
[  256.263865]  try_charge+0x12/0x17
[  256.265236]  charge_memcg+0x25/0x7c
[  256.266615]  __mem_cgroup_charge+0x28/0x3d
[  256.267962]  mem_cgroup_charge.constprop.0+0x1d/0x1f
[  256.269290]  do_anonymous_page+0x118/0x20c
[  256.270712]  handle_pte_fault+0x151/0x15f
[  256.272015]  __handle_mm_fault+0x39d/0x3ac
[  256.273198]  handle_mm_fault+0xc2/0x188
[  256.274371]  do_user_addr_fault+0x240/0x39d
[  256.275595]  exc_page_fault+0x1e1/0x204
[  256.276787]  asm_exc_page_fault+0x2c/0x40
[  256.277906] RIP: 0033:0xd67250
[  256.279017] Code: 02 f6 ff 49 89 c0 48 83 fb 08 73 1e f6 c3 04 75 39 48 85 db 74 2d c6 00 00 f6 c3 02 74 25 31 c0 66 41 89 44 18 fe eb 1b 66 90 <48> c7 44 18 f8 00 00 00 00 48 8d 4b ff 31 c0 4c 89 c7 48 c1 e9 03
[  256.280355] RSP: 002b:00007fffffffc360 EFLAGS: 00010206
[  256.281678] RAX: 00007ffff5972000 RBX: 00000000000000a8 RCX: 000000000000000c
[  256.282955] RDX: 0000000000000006 RSI: 0000000000000017 RDI: 0000000000000986
[  256.284264] RBP: 0000000000000002 R08: 00007ffff5972000 R09: 0000000000000987
[  256.285554] R10: 0000000000000001 R11: 0000000001000001 R12: 00007ffff5969c80
[  256.286930] R13: 0000000000000015 R14: 0000000000000000 R15: 0000000001eb4760
[  256.288300]  </TASK>
[  256.289533] irq event stamp: 95044
[  256.290776] hardirqs last  enabled at (95043): [<ffffffff819ddf43>] irqentry_exit+0x67/0x75
[  256.292147] hardirqs last disabled at (95044): [<ffffffff819db09c>] common_interrupt+0x1a/0xca
[  256.293479] softirqs last  enabled at (94982): [<ffffffff81c0036f>] __do_softirq+0x36f/0x3aa
[  256.294754] softirqs last disabled at (94977): [<ffffffff81105c01>] __irq_exit_rcu+0x85/0xc1
