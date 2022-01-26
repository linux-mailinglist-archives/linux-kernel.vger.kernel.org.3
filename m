Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1449C7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiAZKvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:51:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233374AbiAZKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643194301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWkCCr+cZIABMShRzGE5w0r+QFexn0uI0rJOE+FJ8zg=;
        b=gtEi+nDp+I3UnZSz1T9Kbs24ucjXZupl3i88ArwNpYK8o5fiTpgh0pLbMEMFZZ5mXTbLgB
        divgxE7YFOxZJ3OxoU/cDhbx+8/DKBqQ2d8ryYvuAXi3VToOd7rr5aXpkakpS3PO60hth0
        Hj8tjEtv1WzaxQfcfSJ1wlGl3cJPny4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-sX_dFgHJPjW64qApibGAcA-1; Wed, 26 Jan 2022 05:51:39 -0500
X-MC-Unique: sX_dFgHJPjW64qApibGAcA-1
Received: by mail-wr1-f69.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so1699529wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tWkCCr+cZIABMShRzGE5w0r+QFexn0uI0rJOE+FJ8zg=;
        b=EN/NhZeYZDKuEYLkZ/G2XpMl3ccGhOTUEaQqo+dT5AyD/1tuhHJF7dkvA2xiIrni4e
         CWUl9ta04emVfzWx9yyuq2q6ggaF+9ArQT8yERmBgXhZpDaHHLQ64aWjynJfPNM2+/3+
         i7Kq0ObtXdeqZXzx2RHPZYgbrDhjpefkfWPQDIWS+fzOMpEgR9OWF6/CO3c6iyuRs8xh
         0/oVO3dasCB9USX2pwOxx+3M1xEwMftFhyMix406dXt2P2bSPVcI5xELGar7G4Iddlhx
         vVreMZA4M9Nh2jZvnj7ewnA2wTHiyVzy2yD38rKdn1hGCbcN/7CNm5SeAbWIW11hCjA5
         oV+g==
X-Gm-Message-State: AOAM533AIsRSj3elrE8VmUcz3DcQq32Tjsu8lZmekQeTIKNnYKfHpEkl
        BCFNz11igVSwdASKxbzWbQOSxEs41DWKig81b4zTxODvxnWB7FsQzQbYH13JG33M4QPkZXBFtjq
        41KdnsFn4PXtx5oPOgSakHZeS
X-Received: by 2002:a05:6000:1086:: with SMTP id y6mr20807676wrw.475.1643194298261;
        Wed, 26 Jan 2022 02:51:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrqLoh1AwKwFrW5ZSirecma/GBUkLzjCw7SNYQaqACsp2WLkoOCWPIELDdY0sP1cEXxcIuPA==
X-Received: by 2002:a05:6000:1086:: with SMTP id y6mr20807654wrw.475.1643194297988;
        Wed, 26 Jan 2022 02:51:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id p8sm3463293wrr.16.2022.01.26.02.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:51:37 -0800 (PST)
Message-ID: <af603cbe-4a38-9947-5e6d-9a9328b473fb@redhat.com>
Date:   Wed, 26 Jan 2022 11:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [v2 PATCH] fs/proc: task_mmu.c: don't read mapcount for migration
 entry
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        jannh@google.com, willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20220120202805.3369-1-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220120202805.3369-1-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 21:28, Yang Shi wrote:
> The syzbot reported the below BUG:
> 
> kernel BUG at include/linux/page-flags.h:785!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 4392 Comm: syz-executor560 Not tainted 5.16.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
> RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744
> Code: e8 d3 16 d1 ff 48 c7 c6 c0 00 b6 89 48 89 ef e8 94 4e 04 00 0f 0b e8 bd 16 d1 ff 48 c7 c6 60 01 b6 89 48 89 ef e8 7e 4e 04 00 <0f> 0b e8 a7 16 d1 ff 48 c7 c6 a0 01 b6 89 4c 89 f7 e8 68 4e 04 00
> RSP: 0018:ffffc90002b6f7b8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888019619d00 RSI: ffffffff81a68c12 RDI: 0000000000000003
> RBP: ffffea0001bdc2c0 R08: 0000000000000029 R09: 00000000ffffffff
> R10: ffffffff8903e29f R11: 00000000ffffffff R12: 00000000ffffffff
> R13: 00000000ffffea00 R14: ffffc90002b6fb30 R15: ffffea0001bd8001
> FS:  00007faa2aefd700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff7e663318 CR3: 0000000018c6e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  page_mapcount include/linux/mm.h:837 [inline]
>  smaps_account+0x470/0xb10 fs/proc/task_mmu.c:466
>  smaps_pte_entry fs/proc/task_mmu.c:538 [inline]
>  smaps_pte_range+0x611/0x1250 fs/proc/task_mmu.c:601
>  walk_pmd_range mm/pagewalk.c:128 [inline]
>  walk_pud_range mm/pagewalk.c:205 [inline]
>  walk_p4d_range mm/pagewalk.c:240 [inline]
>  walk_pgd_range mm/pagewalk.c:277 [inline]
>  __walk_page_range+0xe23/0x1ea0 mm/pagewalk.c:379
>  walk_page_vma+0x277/0x350 mm/pagewalk.c:530
>  smap_gather_stats.part.0+0x148/0x260 fs/proc/task_mmu.c:768
>  smap_gather_stats fs/proc/task_mmu.c:741 [inline]
>  show_smap+0xc6/0x440 fs/proc/task_mmu.c:822
>  seq_read_iter+0xbb0/0x1240 fs/seq_file.c:272
>  seq_read+0x3e0/0x5b0 fs/seq_file.c:162
>  vfs_read+0x1b5/0x600 fs/read_write.c:479
>  ksys_read+0x12d/0x250 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7faa2af6c969
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007faa2aefd288 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007faa2aff4418 RCX: 00007faa2af6c969
> RDX: 0000000000002025 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007faa2aff4410 R08: 00007faa2aefd700 R09: 0000000000000000
> R10: 00007faa2aefd700 R11: 0000000000000246 R12: 00007faa2afc20ac
> R13: 00007fff7e6632bf R14: 00007faa2aefd400 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 24ec93ff95e4ac3d ]---
> RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
> RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744
> Code: e8 d3 16 d1 ff 48 c7 c6 c0 00 b6 89 48 89 ef e8 94 4e 04 00 0f 0b e8 bd 16 d1 ff 48 c7 c6 60 01 b6 89 48 89 ef e8 7e 4e 04 00 <0f> 0b e8 a7 16 d1 ff 48 c7 c6 a0 01 b6 89 4c 89 f7 e8 68 4e 04 00
> RSP: 0018:ffffc90002b6f7b8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888019619d00 RSI: ffffffff81a68c12 RDI: 0000000000000003
> RBP: ffffea0001bdc2c0 R08: 0000000000000029 R09: 00000000ffffffff
> R10: ffffffff8903e29f R11: 00000000ffffffff R12: 00000000ffffffff
> R13: 00000000ffffea00 R14: ffffc90002b6fb30 R15: ffffea0001bd8001
> FS:  00007faa2aefd700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff7e663318 CR3: 0000000018c6e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 

Does this point at the bigger issue that reading the mapcount without
having the page locked is completely unstable?


-- 
Thanks,

David / dhildenb

