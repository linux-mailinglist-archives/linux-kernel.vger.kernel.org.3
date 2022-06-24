Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8496559BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiFXOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiFXOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:34:44 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EFA614EDE3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:34:41 -0700 (PDT)
Received: (qmail 34279 invoked by uid 1000); 24 Jun 2022 10:34:40 -0400
Date:   Fri, 24 Jun 2022 10:34:40 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+aa620fb1ece874a3f34c@syzkaller.appspotmail.com>
Cc:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, hdanton@sina.com, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, schspa@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in ida_free (2)
Message-ID: <YrXLgOCf4e4kmIzH@rowland.harvard.edu>
References: <000000000000fd80ab05e2314a27@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fd80ab05e2314a27@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:10:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    08897940f458 Add linux-next specific files for 20220623
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fc8c60080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fb185a52c6ad0a8e
> dashboard link: https://syzkaller.appspot.com/bug?extid=aa620fb1ece874a3f34c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116b4140080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab12e4080000
> 
> The issue was bisected to:
> 
> commit f2d8c2606825317b77db1f9ba0fc26ef26160b30
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Mon Jun 13 14:17:03 2022 +0000
> 
>     usb: gadget: Fix non-unique driver names in raw-gadget driver
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b40318080000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17b40318080000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b40318080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+aa620fb1ece874a3f34c@syzkaller.appspotmail.com
> Fixes: f2d8c2606825 ("usb: gadget: Fix non-unique driver names in raw-gadget driver")
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> BUG: KASAN: null-ptr-deref in ida_free+0x1b6/0x2e0 lib/idr.c:510
> Read of size 8 at addr 0000000000000000 by task syz-executor185/3627
> 
> CPU: 1 PID: 3627 Comm: syz-executor185 Not tainted 5.19.0-rc3-next-20220623-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
>  ida_free+0x1b6/0x2e0 lib/idr.c:510
>  dev_free+0xec/0x700 drivers/usb/gadget/legacy/raw_gadget.c:212
>  kref_put include/linux/kref.h:65 [inline]
>  raw_release+0x219/0x290 drivers/usb/gadget/legacy/raw_gadget.c:424
>  __fput+0x277/0x9d0 fs/file_table.c:317
>  task_work_run+0xdd/0x1a0 kernel/task_work.c:177
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xb05/0x2a00 kernel/exit.c:795
>  do_group_exit+0xd2/0x2f0 kernel/exit.c:925
>  __do_sys_exit_group kernel/exit.c:936 [inline]
>  __se_sys_exit_group kernel/exit.c:934 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f12d28b6bd9
> Code: Unable to access opcode bytes at RIP 0x7f12d28b6baf.
> RSP: 002b:00007ffea2859da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f12d292b3f0 RCX: 00007f12d28b6bd9
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 000000000000000b
> R10: 00007ffea2857e00 R11: 0000000000000246 R12: 00007f12d292b3f0
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
>  </TASK>
> ==================================================================

This should be fixed by the patch that was just merged.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 90bc2af24638
