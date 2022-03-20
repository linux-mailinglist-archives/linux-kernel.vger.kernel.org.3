Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51F4E1E52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiCTXve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiCTXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:51:32 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555CF55BD7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:50:07 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id m17-20020a923f11000000b002c10e8f4c44so6614319ila.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=h1o/x3+MyQFBnHjzVRNxeM68GtFaLPJLq6mBX9f5t8Q=;
        b=vzRL0sE/j4LgCuw6CkD3prlDhrGDeVwEonz+eoKD3Re4/u0ZOJTX2m7k+9/nA6QRo+
         /DrbxAc5XpN8V/zFCSyy/Dwb/L+JOzCvwXXf7ApC1o/xJO959W6ZY5FlUkLtNfOPBLNH
         2367sTW23ZYbOz8c2mcaR2tImlwizx7Py/fZX/mfHbHyWebUh6nddjrs4TiQuDk+8qKY
         W+XmoRj9tG0lPKt8AbgyOB/oS9TX7KsnPW9aE1kXAhg7bAs6Gy8Wf3m57oJF10s/Cdsp
         72fKmd8uTK8V6YawMbtn3J8GyxZPTsbLWyZxlAr/hGcpdkMHNn5akxElCHIeSUuBHMO0
         J8Ww==
X-Gm-Message-State: AOAM532kKn95cmsO84bD0FUBQybfJ8kyd7cZUKVw0oiA6VEcL4EIVFtH
        Q5dkrMajLpSZLd9KYakSZmW2ZTKvDlYayxKekddOIWQXWzWk
X-Google-Smtp-Source: ABdhPJz6YKqHJaENcZDfVc5IJyOK8XLS8S/THTZI0qLRGauhXSKNyXPHq08H1USl3LvgiHwusrBOmer6N4VYpDz8YECBesSStiAQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2614:b0:319:e47e:1b87 with SMTP id
 m20-20020a056638261400b00319e47e1b87mr9042466jat.51.1647820206756; Sun, 20
 Mar 2022 16:50:06 -0700 (PDT)
Date:   Sun, 20 Mar 2022 16:50:06 -0700
In-Reply-To: <3165925.aeNJFYEL58@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013d4fe05daaf0a47@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
From:   syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Read in __free_pages

RBP: 00007ffd90d14ab0 R08: 0000000000000001 R09: 00007ffd90d10035
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd90d14b10 R14: 000000000000000d R15: 00007f2697250490
 </TASK>
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: null-ptr-deref in page_ref_count include/linux/page_ref.h:67 [inline]
BUG: KASAN: null-ptr-deref in put_page_testzero include/linux/mm.h:717 [inline]
BUG: KASAN: null-ptr-deref in __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
Read of size 4 at addr 0000000000000034 by task syz-executor333/4057

CPU: 0 PID: 4057 Comm: syz-executor333 Not tainted 5.17.0-syzkaller-00083-gf443e374ae13-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __kasan_report mm/kasan/report.c:446 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 page_ref_count include/linux/page_ref.h:67 [inline]
 put_page_testzero include/linux/mm.h:717 [inline]
 __free_pages+0x1f/0x1b0 mm/page_alloc.c:5473
 watch_queue_set_size+0x4b1/0x640 kernel/watch_queue.c:276
 pipe_ioctl+0xac/0x2b0 fs/pipe.c:632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f26971ddd49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd90d14aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007f26971ddd49
RDX: 0000000000000029 RSI: 0000000000005760 RDI: 0000000000000003
RBP: 00007ffd90d14ab0 R08: 0000000000000001 R09: 00007ffd90d10035
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd90d14b10 R14: 000000000000000d R15: 00007f2697250490
 </TASK>
==================================================================


Tested on:

commit:         f443e374 Linux 5.17
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124166eb700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19ca6f72fd444749
dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109444dd700000

