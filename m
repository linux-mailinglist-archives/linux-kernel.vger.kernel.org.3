Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79250553EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354644AbiFUWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiFUWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:43:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD253192F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:43:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e63so12915098pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z10YjbGtVNtNaiRFQZ9iJnz/D8Swy7zmtw8XgDlVqn0=;
        b=XqlJN32LFfmGk5fiFz1GotTsTWczcw6uQz6E9eZcTdXjSoT17/kWBSMCmXAlXVYnW0
         VUjnl1RgsBXw3HhOYgEfiNTLHPwrKk4y+dbHr01Jk/Ryn0oW5RHSYCyozL3J4jisaITS
         jew4gmOBak1wlNPuOHlrAZLGaDdIj8wFlIpZIl0Ljd55FrB2tJ414koINNctVCIfMrSv
         tGBvJxetTrQ9JHuxHALueumpFhyKR/KPK/Pq4KfsTKegQZQ2i6HDP/UzpB9lOU+lQ2Ya
         FXgnHhsOtf6JTWWqNp3Dhya7yJRJQVnjAwMaz9pFSJ5WUEjPyv0/k9j7crocD53MvWn4
         7CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z10YjbGtVNtNaiRFQZ9iJnz/D8Swy7zmtw8XgDlVqn0=;
        b=P/Fvad9QtQHGKSEWuGq0HykyqAl2Gtss7melUAqbllUcgBYyqiQqUA9s0lKTs7k91O
         lzJznPH1uK4ore6+EOXVAENY4axA2sjSY3FbBg03zE6PF+05fHZO7lgcWjv6Riz4XQp7
         zTHlZCCI2/AZUQxmjhSCOkzuPB8rbC5+KnA4WX5sggya6HImBz5wVWPrYx5LFOSbjq7H
         Bu8zbC4/WMmTdXE5wGpKFN9MPnhybQQ36ZEZ6dPx6HLqP0zhHoVMyCLK1R8z7pM/0i7d
         ESh4nuozNyNYEKMMkPs0btFvHwFCqMVuUJjxtf9vKqIUHxolIX8NJV+nUTN9Bo/cnELE
         TTIQ==
X-Gm-Message-State: AJIora93a+t3CHCU/YmjhYMf92peNMBbTXOi/uhE8CJB4JiqewNPErDo
        Mn+78Rwy7kDrRDuFYZ4AubGBVA==
X-Google-Smtp-Source: AGRyM1sEzXqvV22jXnla/irisYFfL3I8Gp1mmH2mWOJwQT2FjGOK1+rP90XkleDvR0sp3NosXsmIdw==
X-Received: by 2002:a05:6a00:150a:b0:525:3030:fe41 with SMTP id q10-20020a056a00150a00b005253030fe41mr8805854pfu.37.1655851428788;
        Tue, 21 Jun 2022 15:43:48 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id o68-20020a62cd47000000b005251e2b53acsm5771789pfg.116.2022.06.21.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:43:48 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:43:44 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Yang Shi <shy828301@gmail.com>, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
Message-ID: <YrJJoP5vrZflvwd0@google.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
 <YrIzEZxuwQAi7VR1@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrIzEZxuwQAi7VR1@monkey>
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

On 21 Jun 14:07, Mike Kravetz wrote:
> On 06/16/22 10:48, Yang Shi wrote:
> > This series is the follow-up of the discussion about cleaning up transhuge_xxx
> > helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> > 
> > THP has a bunch of helpers that do VMA sanity check for different paths, they
> > do the similar checks for the most callsites and have a lot duplicate codes.
> > And it is confusing what helpers should be used at what conditions.
> > 
> > This series reorganized and cleaned up the code so that we could consolidate
> > all the checks into hugepage_vma_check().
> > 
> > The transhuge_vma_enabled(), transparent_hugepage_active() and
> > __transparent_hugepage_enabled() are killed by this series.
> 
> Running libhugetlbfs tests on next-20220621 produces the following:
> 
> [   77.436038] BUG: kernel NULL pointer dereference, address: 0000000000000378
> [   77.437278] #PF: supervisor read access in kernel mode
> [   77.438211] #PF: error_code(0x0000) - not-present page
> [   77.439097] PGD 800000017a1a6067 P4D 800000017a1a6067 PUD 17f3b9067 PMD 0 
> [   77.440021] Oops: 0000 [#7] PREEMPT SMP PTI
> [   77.440635] CPU: 1 PID: 2720 Comm: get_huge_pages Tainted: G      D           5.19.0-rc3-next-20220621+ #22
> [   77.441973] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
> [   77.443115] RIP: 0010:hugepage_vma_check+0x15/0x170
> [   77.444021] Code: 01 e9 84 fd ff ff 48 89 d8 e9 14 ff ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 f7 c6 00 00 00 40 0f 85 fe 00 00 00 48 8b 47 10 <48> 8b 80 78 03 00 00 48 c1 e8 18 83 e0 01 0f 85 e6 00 00 00 4c 8b
> [   77.447327] RSP: 0018:ffffc900039dfd20 EFLAGS: 00010246
> [   77.448317] RAX: 0000000000000000 RBX: ffff88817e4b27a0 RCX: 0000000000000000
> [   77.449681] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff823f2000
> [   77.451040] RBP: ffffffff823f2000 R08: 0000000000000008 R09: ffff8881a3c042e6
> [   77.452353] R10: 00007ffe8b341000 R11: ffff8881a3c04526 R12: ffff88817e4b27a0
> [   77.453677] R13: ffffc900039dfd28 R14: ffff88817e4b27c8 R15: ffffffff823f2000
> [   77.455046] FS:  00007f0edc9880c0(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
> [   77.456625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   77.457745] CR2: 0000000000000378 CR3: 0000000179394006 CR4: 0000000000370ee0
> [   77.459936] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   77.461308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   77.462477] Call Trace:
> [   77.462950]  <TASK>
> [   77.463402]  show_smap+0xed/0x1c0
> [   77.464019]  seq_read_iter+0x2af/0x480
> [   77.464674]  seq_read+0xeb/0x120
> [   77.465286]  vfs_read+0x97/0x190
> [   77.465880]  ksys_read+0x5f/0xe0
> [   77.466488]  do_syscall_64+0x3b/0x90
> [   77.467155]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   77.468023] RIP: 0033:0x7f0edca7ade2
> [   77.468609] Code: c0 e9 b2 fe ff ff 50 48 8d 3d b2 3f 0a 00 e8 05 f0 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> [   77.471492] RSP: 002b:00007ffe8b324c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   77.472845] RAX: ffffffffffffffda RBX: 00000000022f82a0 RCX: 00007f0edca7ade2
> [   77.474017] RDX: 0000000000000400 RSI: 00000000022f8480 RDI: 0000000000000003
> [   77.475184] RBP: 00007f0edcb4f320 R08: 0000000000000003 R09: 0000000000000000
> [   77.476379] R10: 00007f0edcaffac0 R11: 0000000000000246 R12: 00000000022f82a0
> [   77.477517] R13: 0000000000000d68 R14: 00007f0edcb4e720 R15: 0000000000000d68
> [   77.478590]  </TASK>
> [   77.479012] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq snd_seq_device snd_pcm joydev snd_timer 9p netfs 9pnet_virtio snd soundcore virtio_balloon 9pnet virtio_console virtio_blk virtio_net net_failover failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_ring virtio_pci_legacy_dev virtio_pci_modern_dev fuse
> [   77.484573] CR2: 0000000000000378
> [   77.485123] ---[ end trace 0000000000000000 ]---
> 
> 
> Looks to be related to this series.  I'll start debugging unless someone
> knows what the issue may be.
> -- 
> Mike Kravetz

Thanks Mike,

I posted the issue in response to '[v5 PATCH 4/7] mm: thp: kill
transparent_hugepage_active()' of this series[1], where the issue was
introduced.

TLDR: we need to check vma->vm_mm because for vDSO vma, this is NULL.


[1] https://lore.kernel.org/linux-mm/YrIU2iP0H5LQbV7R@google.com/
