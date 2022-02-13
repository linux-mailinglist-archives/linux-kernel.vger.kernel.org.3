Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C94B39F7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiBMHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 02:40:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiBMHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 02:40:18 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7AB5E74F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:40:13 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id c1-20020a928e01000000b002bec519e98fso3834267ild.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oRfpPTSGOsdyO99LvTMXgGpDnyRQBC34+PfjrxCsCL8=;
        b=dwis5Cn4OPxPXbqTanW8393cEI9E4kB3uYmrQItpXkG8QsG2iZ4mNajubro6AVJWoV
         7+KeTr7jqPiY6rnvv6gSgeSr7ZHj6mYOseHO65Kd1omU1ehCiNnWTAqfDKgnvmwVn3zR
         GQtxHFJQf7YaZBy3/7ywgSTSyKidPY8akA+4DMJmQPvQbxcXxc2I5TgYh8Rppg8dHAf4
         SAI1bJDtlZd6zT9BaL2Wjf/GjRKmBC8Ay84aR/GepCkxQWPf51G2FbfDVATqazSAj9/8
         9i/p52mV35lJXT6IUofNq/Rl1L/lfmOct4mprNEI/4ds6aXsENxBQwGi+D+b5KY/uu33
         pOlA==
X-Gm-Message-State: AOAM531+NMdqt2GcQMsnSEd6Fm463bXsoTVd1EKPMb09hxJjri2FQu76
        LO+jwZGF+bE9woOcE9hMdvD6il21YrzLUo2Tkty6XE+6rUZH
X-Google-Smtp-Source: ABdhPJz9HAJzXkTEwapHXTCFyMFvf2SBJ2EidvqzyEttUSeWpKTsupkH/5O/ZZSA5uV6DkS2MUYFxGWPI9jL1Wlgb7qhczf2DvEE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:: with SMTP id y11mr5025528ill.185.1644738013286;
 Sat, 12 Feb 2022 23:40:13 -0800 (PST)
Date:   Sat, 12 Feb 2022 23:40:13 -0800
In-Reply-To: <20220213073017.1092-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007d82605d7e16949@google.com>
Subject: Re: [syzbot] INFO: task hung in usb_get_descriptor
From:   syzbot <syzbot+31ae6d17d115e980fd14@syzkaller.appspotmail.com>
To:     brouer@redhat.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        skhan@linuxfoundation.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Write in vhci_shutdown_connection

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
BUG: KASAN: null-ptr-deref in refcount_add include/linux/refcount.h:201 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:104 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x810 kernel/kthread.c:591
Write of size 4 at addr 000000000000001c by task kworker/u4:4/186

CPU: 0 PID: 186 Comm: kworker/u4:4 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x16e lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 refcount_add include/linux/refcount.h:201 [inline]
 refcount_inc include/linux/refcount.h:241 [inline]
 get_task_struct include/linux/sched/task.h:104 [inline]
 kthread_stop+0x90/0x810 kernel/kthread.c:591
 vhci_shutdown_connection+0x17f/0x360 drivers/usb/usbip/vhci_hcd.c:1015
 event_handler+0x1f0/0x4f0 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x86c/0x16a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 186 Comm: kworker/u4:4 Tainted: G    B             5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usbip_event event_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x16e lib/dump_stack.c:118
 panic+0x393/0x7d3 kernel/panic.c:231
 end_report+0x4d/0x53 mm/kasan/report.c:104
 __kasan_report mm/kasan/report.c:520 [inline]
 kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
 refcount_add include/linux/refcount.h:201 [inline]
 refcount_inc include/linux/refcount.h:241 [inline]
 get_task_struct include/linux/sched/task.h:104 [inline]
 kthread_stop+0x90/0x810 kernel/kthread.c:591
 vhci_shutdown_connection+0x17f/0x360 drivers/usb/usbip/vhci_hcd.c:1015
 event_handler+0x1f0/0x4f0 drivers/usb/usbip/usbip_event.c:78
 process_one_work+0x86c/0x16a0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=125b4faa700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4f7c05cb42b5045
dashboard link: https://syzkaller.appspot.com/bug?extid=31ae6d17d115e980fd14
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1359552c700000

