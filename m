Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682AD570C11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiGKUiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5925B7BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A08761661
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5213CC34115;
        Mon, 11 Jul 2022 20:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657571889;
        bh=cnUVDubaNzgk0NffKk3JKU3NhkVJCM3oATbypnRcSEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LuAl+cFs4Fg+MB+xruxD0UC2PnnjqqSu2UYAi7KWvWCW2rGnfoRP2Eb3P/XXi6o/z
         38sJExI+8Ek1aKpm+jY2ND0rquSZgj9UgYGA8TZFc0F2gV/GYqorz78SDvl7Rt5tAg
         TPZLbLaHXo8bkFXo1MpM9/oCUoLfKzV0VN3yXwUg=
Date:   Mon, 11 Jul 2022 13:38:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Zach O'Keefe <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] memory leak in xas_create
Message-Id: <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
In-Reply-To: <000000000000eb2d6c05e35a0d73@google.com>
References: <000000000000eb2d6c05e35a0d73@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022 00:13:23 -0700 syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com
> 
> 2022/07/05 05:22:17 executed programs: 828
> 2022/07/05 05:22:23 executed programs: 846
> 2022/07/05 05:22:30 executed programs: 866
> 2022/07/05 05:22:37 executed programs: 875
> BUG: memory leak

Thanks.  Presumably due to khugepaged changes.

Can we expect a bisection search?

> unreferenced object 0xffff888113662480 (size 576):
>   comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
>   hex dump (first 32 bytes):
>     06 15 08 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     58 08 46 1d 81 88 ff ff 98 24 66 13 81 88 ff ff  X.F......$f.....
>   backtrace:
>     [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
>     [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
>     [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
>     [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
>     [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
>     [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
>     [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>     [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
>     [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> BUG: memory leak
> unreferenced object 0xffff8881136e2900 (size 576):
>   comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
>   hex dump (first 32 bytes):
>     00 07 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
>     58 08 46 1d 81 88 ff ff 18 29 6e 13 81 88 ff ff  X.F......)n.....
>   backtrace:
>     [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
>     [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
>     [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
>     [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
>     [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
>     [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
>     [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>     [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
>     [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> BUG: memory leak
> unreferenced object 0xffff8881136e0480 (size 576):
>   comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
>   hex dump (first 32 bytes):
>     00 06 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
>     58 08 46 1d 81 88 ff ff 98 04 6e 13 81 88 ff ff  X.F.......n.....
>   backtrace:
>     [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
>     [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
>     [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
>     [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
>     [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
>     [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
>     [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>     [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
>     [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> BUG: memory leak
> unreferenced object 0xffff8881136de900 (size 576):
>   comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
>   hex dump (first 32 bytes):
>     00 05 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
>     58 08 46 1d 81 88 ff ff 18 e9 6d 13 81 88 ff ff  X.F.......m.....
>   backtrace:
>     [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
>     [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
>     [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
>     [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
>     [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
>     [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
>     [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>     [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
>     [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> BUG: memory leak
> unreferenced object 0xffff88811371b6c0 (size 576):
>   comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
>   hex dump (first 32 bytes):
>     00 04 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
>     58 08 46 1d 81 88 ff ff d8 b6 71 13 81 88 ff ff  X.F.......q.....
>   backtrace:
>     [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
>     [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
>     [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
>     [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
>     [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
>     [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
>     [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>     [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
>     [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> BUG: memory leak
> unreferenced object 0xffff888113666d80 (size 576):
>   comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
>   hex dump (first 32 bytes):
>     00 03 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
>     58 08 46 1d 81 88 ff ff 98 6d 66 13 81 88 ff ff  X.F......mf.....
>   backtrace:
>     [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
>     [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
>     [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
>     [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
>     [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
>     [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
>     [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>     [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
>     [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
>     [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
