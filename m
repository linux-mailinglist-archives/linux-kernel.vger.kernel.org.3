Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352CE585E37
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiGaIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:47:21 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FEC1274A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:47:20 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d12-20020a056e02214c00b002dd143bee38so4852199ilv.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=9ZWT2dG7kvlI+OPdAV7Z0A6SxXL1xkRWwFlgF6QVYQA=;
        b=GQlbI4Ya4aL+Vqtx+ClH7T3gRmlptaU+jpYAvlhHZmb6+ezxdrq6FX+2Mh2WUvyHPA
         wqTGB/soZjbe2M/j99eiHACw/yW+2EJ1ts68ompoMiW2Tj/PpJ7XjICnB+DovaO6zcqw
         NDm4XKRLW/V+zX5gP9e9pnO36S9XptHXF6P26hyYX+GjSUZu9oorzc3n0TGdke0LajSv
         WLiuYQpj5yj4xuwp6LVyU5hGaSrcADz3OJgy7dbbFZnPolrz1E6XNk0vDR79RLu9xrp7
         BgKHf5Nvh81HhQJpy8GCPS8/32w4CcMH7wzr6D1KwlACINRvWwhj7R775IBCvdGn2Ox7
         Qnbw==
X-Gm-Message-State: AJIora8cxMl/BlsLy2xeQukHFfF9WFluhAAxRg/Am0Or4GreAGV//J5H
        GchjvmKmK31x8mLxFzAAXWcOkFmFuBvRUyRWD7DFxnSAd4Of
X-Google-Smtp-Source: AGRyM1uPo5QRcVHQHZHJ7aXnmx8jTKizYEPWYRJidTXk2aiv4M8TzKT4NNxDkEfomwYcf+6S1cOvw2nIEGlwSaduPdj0yfFgR8mr
MIME-Version: 1.0
X-Received: by 2002:a02:a890:0:b0:33f:22b8:cb0b with SMTP id
 l16-20020a02a890000000b0033f22b8cb0bmr4414472jam.136.1659257240140; Sun, 31
 Jul 2022 01:47:20 -0700 (PDT)
Date:   Sun, 31 Jul 2022 01:47:20 -0700
In-Reply-To: <20220731082711.724-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063c6a105e515ee67@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __cfg80211_ibss_joined

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8 at net/wireless/ibss.c:36 __cfg80211_ibss_joined+0x487/0x520 net/wireless/ibss.c:36
Modules linked in:
CPU: 1 PID: 8 Comm: kworker/u4:0 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: cfg80211 cfg80211_event_work
RIP: 0010:__cfg80211_ibss_joined+0x487/0x520 net/wireless/ibss.c:36
Code: 0f 0b e9 0c fe ff ff e8 87 19 75 f9 e9 41 fc ff ff e8 5d 19 75 f9 e9 7d fc ff ff e8 73 19 75 f9 e9 0d ff ff ff e8 79 51 32 f9 <0f> 0b e9 7e fc ff ff e8 6d 51 32 f9 0f 0b e8 66 19 75 f9 e9 e4 fb
RSP: 0018:ffffc90000cd7bd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888028288bd0 RCX: 0000000000000000
RDX: ffff888010d25340 RSI: ffffffff88408257 RDI: 0000000000000000
RBP: ffff888028288000 R08: 0000000000000001 R09: ffffffff8ee66807
R10: fffffbfff1dccd00 R11: 0000000000000000 R12: 1ffff9200019af7d
R13: ffff888011916918 R14: 0000000000000000 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005680c0 CR3: 000000001aeb4000 CR4: 0000000000350ee0
Call Trace:
 cfg80211_process_wdev_events+0x3de/0x5b0 net/wireless/util.c:977
 cfg80211_process_rdev_events+0x6e/0x100 net/wireless/util.c:1003
 cfg80211_event_work+0x1a/0x20 net/wireless/core.c:322
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


Tested on:

commit:         f40ddce8 Linux 5.11
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff72fe080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3565439810a4d2e5
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16978a82080000

