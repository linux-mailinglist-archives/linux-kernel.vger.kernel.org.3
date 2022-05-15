Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB31527847
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiEOOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiEOOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:52:35 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09718B0A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:52:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id r2-20020a92cd82000000b002d1011eee16so1958577ilb.23
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CDM6KLJWHiUdyyYgu+q/QybYO2uV3H4N8wCbvfHehAE=;
        b=ojQip7jEy9motLjxM8FLky/3O7dtXebNSo69e1X+UNT0nHsv2nyli7S/zcLrnP3t4v
         /n2/3S4zXY2u8jp0jhrSdw1iLdc9TQkvdLhfg9PtLWUxwJvKAKKdR7yUbGqodwGsA4Ax
         spfyohb3W8iyh37tMMTrVDcQVIemy/2nXLNz0po598ac4S6zdvwJzx/bPAjak37dS8Q+
         iw5iBCC7bgM2dbMkpUxL5T41xerhKv5ehefIeKHiwmXslv0OkXBpz5/rAMjGDWWCOkCV
         YbGZL7OgrlIyZaW0KJuW3/O6f7ljSs31FdSCGf+RlMSDXZCOpWIFZ/u5omaedrPrRSaI
         QIwA==
X-Gm-Message-State: AOAM533zrwIQ/MPFNJvuSlz7bGWOWF0YLDlD/nm0xanaJKjtptnRTedf
        GDdYPFkY+BPLgaclSAkmG0ymhX4mO/DBe6kSS1U92JHBkBl6
X-Google-Smtp-Source: ABdhPJy+c3igZ6REoGHXaRIHK/l8izrNbiLeqCZutXsVaftSfsxCHQYdN0Hli0eV1B2jfCu/Kee8cDqe9vXVpoQcHKHRgcgs4pdF
MIME-Version: 1.0
X-Received: by 2002:a6b:e406:0:b0:657:baed:ec0b with SMTP id
 u6-20020a6be406000000b00657baedec0bmr6242365iog.27.1652626342805; Sun, 15 May
 2022 07:52:22 -0700 (PDT)
Date:   Sun, 15 May 2022 07:52:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c058f05df0e0eea@google.com>
Subject: [syzbot] WARNING: still has locks held in io_ring_submit_lock
From:   syzbot <syzbot+987d7bb19195ae45208c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, f.fainelli@gmail.com,
        io-uring@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        syzkaller-bugs@googlegroups.com, xiam0nd.tong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10872211f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=987d7bb19195ae45208c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1141bd21f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167ebdbef00000

The issue was bisected to:

commit 6da69b1da130e7d96766042750cd9f902e890eba
Author: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Date:   Mon Mar 28 03:24:31 2022 +0000

    net: dsa: bcm_sf2_cfp: fix an incorrect NULL check on list iterator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1652eb11f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1552eb11f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1152eb11f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+987d7bb19195ae45208c@syzkaller.appspotmail.com
Fixes: 6da69b1da130 ("net: dsa: bcm_sf2_cfp: fix an incorrect NULL check on list iterator")

====================================
WARNING: iou-wrk-3613/3623 still has locks held!
5.18.0-rc6-next-20220513-syzkaller #0 Not tainted
------------------------------------
1 lock held by iou-wrk-3613/3623:
 #0: ffff888140bfe0a8 (&ctx->uring_lock){+.+.}-{3:3}, at: io_ring_submit_lock+0x75/0xc0 fs/io_uring.c:1494

stack backtrace:
CPU: 0 PID: 3623 Comm: iou-wrk-3613 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 try_to_freeze include/linux/freezer.h:66 [inline]
 get_signal+0x1424/0x2600 kernel/signal.c:2647
 io_wqe_worker+0x64b/0xdb0 fs/io-wq.c:663
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:297
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
