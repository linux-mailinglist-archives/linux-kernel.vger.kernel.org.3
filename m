Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C756C7A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGIHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIHN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:13:26 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105578203
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:13:24 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so537023ile.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 00:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YNjDCWN7v9Gcshr/FrnIxWh4qyNpKpJS7nTPejRH6ns=;
        b=NTrqgH51cK5ld/T0CmCW4K9jzsSGYRLgvCpeyz6Q3wLTog6fcIm7iiJ3qtByWtkpfo
         SLr0g92TQHgyqpULFmdE2jnY7ICVi1U3It3Fyqdb+sp4cuIoyxeQyrVQdmHYPBOuNIVS
         kgrf93cQoFA81o6cuVzU56e5S/noVr4oG2EA/K2Ix0g0kd8AbRB0KMgwdCt6NVODuX31
         hbM5b5g/fekFULf5iTnKMcpqsyBYqCbNMISVWk5ysGh4q+tb61owdCITeBcIlv11nbAf
         1kw5x/ON60wAkku/ywe5o/t1ba7IPB7TfwW8uGrqhrLVwqXFoIAs57O6arB2kD5ZLcLr
         4iNA==
X-Gm-Message-State: AJIora8iLxu3aV8Q2jPJT/CNkp2loXp6WTk3oqbYk/zlSG6fo00fIPFl
        RtV1MZsDXYlamLo9g1GHs1oakOxdOpdsAATuFtdLiuqj5hQo
X-Google-Smtp-Source: AGRyM1smuz787MixueMSePd3errsnBxIJ1iHqS6CFU4MwcPMrANcCEOr4I7OXyQXTI4BMMaDTWZWFwM1DqAFUQu4NOawf7JOmhzp
MIME-Version: 1.0
X-Received: by 2002:a05:6638:154:b0:339:e14c:867e with SMTP id
 y20-20020a056638015400b00339e14c867emr4245883jao.190.1657350803629; Sat, 09
 Jul 2022 00:13:23 -0700 (PDT)
Date:   Sat, 09 Jul 2022 00:13:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb2d6c05e35a0d73@google.com>
Subject: [syzbot] memory leak in xas_create
From:   syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14967ccc080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=916233b7694a38ff
dashboard link: https://syzkaller.appspot.com/bug?extid=a785d07959bc94837d51
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ae834080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com

2022/07/05 05:22:17 executed programs: 828
2022/07/05 05:22:23 executed programs: 846
2022/07/05 05:22:30 executed programs: 866
2022/07/05 05:22:37 executed programs: 875
BUG: memory leak
unreferenced object 0xffff888113662480 (size 576):
  comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
  hex dump (first 32 bytes):
    06 15 08 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    58 08 46 1d 81 88 ff ff 98 24 66 13 81 88 ff ff  X.F......$f.....
  backtrace:
    [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
    [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
    [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
    [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
    [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
    [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
    [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

BUG: memory leak
unreferenced object 0xffff8881136e2900 (size 576):
  comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
  hex dump (first 32 bytes):
    00 07 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
    58 08 46 1d 81 88 ff ff 18 29 6e 13 81 88 ff ff  X.F......)n.....
  backtrace:
    [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
    [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
    [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
    [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
    [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
    [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
    [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

BUG: memory leak
unreferenced object 0xffff8881136e0480 (size 576):
  comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
  hex dump (first 32 bytes):
    00 06 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
    58 08 46 1d 81 88 ff ff 98 04 6e 13 81 88 ff ff  X.F.......n.....
  backtrace:
    [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
    [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
    [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
    [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
    [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
    [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
    [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

BUG: memory leak
unreferenced object 0xffff8881136de900 (size 576):
  comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
  hex dump (first 32 bytes):
    00 05 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
    58 08 46 1d 81 88 ff ff 18 e9 6d 13 81 88 ff ff  X.F.......m.....
  backtrace:
    [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
    [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
    [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
    [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
    [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
    [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
    [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

BUG: memory leak
unreferenced object 0xffff88811371b6c0 (size 576):
  comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
  hex dump (first 32 bytes):
    00 04 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
    58 08 46 1d 81 88 ff ff d8 b6 71 13 81 88 ff ff  X.F.......q.....
  backtrace:
    [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
    [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
    [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
    [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
    [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
    [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
    [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

BUG: memory leak
unreferenced object 0xffff888113666d80 (size 576):
  comm "khugepaged", pid 32, jiffies 4295002751 (age 22.940s)
  hex dump (first 32 bytes):
    00 03 00 00 00 00 00 00 80 24 66 13 81 88 ff ff  .........$f.....
    58 08 46 1d 81 88 ff ff 98 6d 66 13 81 88 ff ff  X.F......mf.....
  backtrace:
    [<ffffffff824aa006>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff824acc55>] xas_create+0x395/0x820 lib/xarray.c:679
    [<ffffffff824ad180>] xas_create_range+0xa0/0x1c0 lib/xarray.c:719
    [<ffffffff815957f3>] collapse_file+0x283/0x2870 mm/khugepaged.c:1670
    [<ffffffff8159b52c>] khugepaged_scan_file mm/khugepaged.c:2072 [inline]
    [<ffffffff8159b52c>] khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
    [<ffffffff8159b52c>] khugepaged_do_scan mm/khugepaged.c:2251 [inline]
    [<ffffffff8159b52c>] khugepaged+0x227c/0x43a0 mm/khugepaged.c:2296
    [<ffffffff8127b8b5>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100222f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
