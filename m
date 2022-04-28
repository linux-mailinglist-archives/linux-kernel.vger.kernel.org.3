Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7486513ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbiD1R3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350474AbiD1R3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:29:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C28220C4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:25:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e24so4922451pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCwam7UiUNOXhElbv2jko1D22lHmNSK/U551dYCHJBk=;
        b=kb2gXGO0dOiHelquCwPSsvA81OokVqaYnDdu+PCdW9ZS0DatM5QQUDG0tmfeaQmLzo
         4CJS+I78m6sSb3rqc15C4CJpW2lQp40Cpec+y1RhaGZCBz9izEaUCWIt8S4Lw1ZjOsrD
         46UMZnHk/jDIwkEIWMmBS6cSAo5Vz5iqQ7RyBUr0ZjXjbBmHCERFX0NjjvMvBmcSlihu
         iX+ttzi3Z8eLHazNtGWX7lX1ai7smZXZg9JBSjDzJIUUbJezyAR6Qfi9ZCU+7kVRPzx2
         3HNwguIMh1tbxiEnJAwiuc3M1jnQR566x2JDe8I+hp5rp3OdFSKMTN9lSdEavqnco0i0
         fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCwam7UiUNOXhElbv2jko1D22lHmNSK/U551dYCHJBk=;
        b=d03roFe1c+Bm79nNCzYVxyTtxiEhMOD81JJvP3IitNBsftaHgiEc4zE99hRWxQWpYs
         tCvkVzYKsreWwcI6AIZE0naHp24zpZ6oh7kihSf+swnzMLafkQU2fRYLH3ojFcrv7zWu
         +8XYB7Lu4qASWPfnRkLNf7oRSHgJvaLf5kepyTlGCTSfAfPPOhaWRt8PcBVWjxWpgMGl
         5Q7YcEdQxAkTnBW/bXemRhUQIGsPkm1yRjg2szq1T2IJLfNGgLudfkvJhlxIIw1leCKh
         fUOyk+MWSpx0K1oZTatQTr3Q+ia9GgJyzlohLDBOX9uoqAsp03lgEkz4lPwkD/WLFMXh
         wmsA==
X-Gm-Message-State: AOAM532J0Ww930BlEa9LR2Z3A4k+T/wF0Znz6pDueRVOSK/ZivK2aHgm
        s1fdkoWtDUlQZoKaBDvEFkWTORppC/0LXMvbUNB5CKQw
X-Google-Smtp-Source: ABdhPJx/6Wrux0hAoIpHbzr0izmaFGDh3pXpcrD2VvY0Ekjt5BdumhW+HSUTcUf/+427d9ui4qoZtrF+a9c0tOAKRCg=
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id
 g3-20020a170902d5c300b00154c472de80mr34345864plh.87.1651166745857; Thu, 28
 Apr 2022 10:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Apr 2022 10:25:33 -0700
Message-ID: <CAHbLzko3=bHrsWNGdb0QZijN9oPg3pchbC2F9=_6Td+2xDczhA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in get_any_page()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:32 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> The following VM_BUG_ON_FOLIO() is triggered when memory error event
> happens on the (thp/folio) pages which are about to be freed:
>
>   [ 1160.232771] page:00000000b36a8a0f refcount:1 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x16a000
>   [ 1160.236916] page:00000000b36a8a0f refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x16a000
>   [ 1160.240684] flags: 0x57ffffc0800000(hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
>   [ 1160.243458] raw: 0057ffffc0800000 dead000000000100 dead000000000122 0000000000000000
>   [ 1160.246268] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>   [ 1160.249197] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
>   [ 1160.251815] ------------[ cut here ]------------
>   [ 1160.253438] kernel BUG at include/linux/mm.h:788!
>   [ 1160.256162] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   [ 1160.258172] CPU: 2 PID: 115368 Comm: mceinj.sh Tainted: G            E     5.18.0-rc1-v5.18-rc1-220404-2353-005-g83111+ #3
>   [ 1160.262049] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
>   [ 1160.265103] RIP: 0010:dump_page.cold+0x27e/0x2bd
>   [ 1160.266757] Code: fe ff ff 48 c7 c6 81 f1 5a 98 e9 4c fe ff ff 48 c7 c6 a1 95 59 98 e9 40 fe ff ff 48 c7 c6 50 bf 5a 98 48 89 ef e8 9d 04 6d ff <0f> 0b 41 f7 c4 ff 0f 00 00 0f 85 9f fd ff ff 49 8b 04 24 a9 00 00
>   [ 1160.273180] RSP: 0018:ffffaa2c4d59fd18 EFLAGS: 00010292
>   [ 1160.274969] RAX: 000000000000003e RBX: 0000000000000001 RCX: 0000000000000000
>   [ 1160.277263] RDX: 0000000000000001 RSI: ffffffff985995a1 RDI: 00000000ffffffff
>   [ 1160.279571] RBP: ffffdc9c45a80000 R08: 0000000000000000 R09: 00000000ffffdfff
>   [ 1160.281794] R10: ffffaa2c4d59fb08 R11: ffffffff98940d08 R12: ffffdc9c45a80000
>   [ 1160.283920] R13: ffffffff985b6f94 R14: 0000000000000000 R15: ffffdc9c45a80000
>   [ 1160.286641] FS:  00007eff54ce1740(0000) GS:ffff99c67bd00000(0000) knlGS:0000000000000000
>   [ 1160.289498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1160.291106] CR2: 00005628381a5f68 CR3: 0000000104712003 CR4: 0000000000170ee0
>   [ 1160.293031] Call Trace:
>   [ 1160.293724]  <TASK>
>   [ 1160.294334]  get_hwpoison_page+0x47d/0x570
>   [ 1160.295474]  memory_failure+0x106/0xaa0
>   [ 1160.296474]  ? security_capable+0x36/0x50
>   [ 1160.297524]  hard_offline_page_store+0x43/0x80
>   [ 1160.298684]  kernfs_fop_write_iter+0x11c/0x1b0
>   [ 1160.299829]  new_sync_write+0xf9/0x160
>   [ 1160.300810]  vfs_write+0x209/0x290
>   [ 1160.301835]  ksys_write+0x4f/0xc0
>   [ 1160.302718]  do_syscall_64+0x3b/0x90
>   [ 1160.303664]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [ 1160.304981] RIP: 0033:0x7eff54b018b7
>
> As shown in the RIP address, this VM_BUG_ON in folio_entire_mapcount() is
> called from dump_page("hwpoison: unhandlable page") in get_any_page().
> The below explains the mechanism of the race:
>
>   CPU 0                                       CPU 1
>
>     memory_failure
>       get_hwpoison_page
>         get_any_page
>           dump_page
>             compound = PageCompound
>                                                 free_pages_prepare
>                                                   page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP
>             folio_entire_mapcount
>               VM_BUG_ON_FOLIO(!folio_test_large(folio))
>
> So replace dump_page() with safer one, pr_err().
>
> Fixes: 74e8ee4708a8 ("mm: Turn head_compound_mapcount() into folio_entire_mapcount()")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v1 -> v2:
> - v1: https://lore.kernel.org/linux-mm/20220414235950.840409-1-naoya.horiguchi@linux.dev/T/#u
> - update caller side instead of changing dump_page().
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 35e11d6bea4a..0e1453514a2b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1270,7 +1270,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>         }
>  out:
>         if (ret == -EIO)
> -               dump_page(p, "hwpoison: unhandlable page");
> +               pr_err("Memory failure: %#lx: unhandlable page.\n", page_to_pfn(p));

I think dump_page() is helpful to tell the users more information
about the unhandlable page, I'm ok with this fix for now, but should
we consider having a memory failure safe dump_page() in the future?

>
>         return ret;
>  }
> --
> 2.25.1
>
>
