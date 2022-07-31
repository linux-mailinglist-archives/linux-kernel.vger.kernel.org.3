Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AAF585E15
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiGaITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:19:14 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEB11828
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:19:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso4883185ilk.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=AVAa3qG0QNLSYeQAf5B1+PepPqDRQ1sEutCYCo5v6rY=;
        b=Ap1OJbEXWSDLvQBX7pMCzvcQovjIC+t1UJVp5vEQ5UZz6hUyddaB3VFfoH7MSjP5Od
         m4zVXXIjLD2f+hd4tGwJGwJmP5NunF502qbnw7uLkXSaw6BzPob0CgLWyKXxvObx9N16
         9f+nmqCQu5w8CXTfBCnYK69SIKBOQmb3yDx4y+mwY5aHNLv5bGfy10v+JHFP5jhFTBmv
         ptkrbtJSYOKyVeP8mIb/9QgmFFPFkTP7VbDPUDouqBOvWNDhck1CqgEqKIjo7nx0xwtr
         iY4jZek6WZFUPShT4JyVnDhZR5pFq9S1cTEtf+MHgyJGRjkFrgADcPdHMH9mEaLCBgDG
         wNhw==
X-Gm-Message-State: AJIora/7OnFiw0aaaFtFZiY6NFnYN6ieqzWaN2zxZaRWaGSsBelDGxh2
        uN2ZBBkyb02jGGp8eWwpVgvV0vM/v0d8cOpiVs6W97dimR8O
X-Google-Smtp-Source: AGRyM1sUXx4q8OI6MYA+WGMvVd9o8E7yk19qMJPY0LVA306gmVdRSn2xg0SPiDp7Ojjo157GXe1EPapIvilBWRe1kkvUO3LanSkW
MIME-Version: 1.0
X-Received: by 2002:a92:d606:0:b0:2dc:e2d1:b75b with SMTP id
 w6-20020a92d606000000b002dce2d1b75bmr4194585ilm.91.1659255553420; Sun, 31 Jul
 2022 01:19:13 -0700 (PDT)
Date:   Sun, 31 Jul 2022 01:19:13 -0700
In-Reply-To: <20220731080330.602-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da754205e51589e3@google.com>
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
WARNING: CPU: 1 PID: 6061 at net/wireless/ibss.c:36 __cfg80211_ibss_joined+0x487/0x520 net/wireless/ibss.c:36
Modules linked in:
CPU: 1 PID: 6061 Comm: kworker/u4:6 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: cfg80211 cfg80211_event_work
RIP: 0010:__cfg80211_ibss_joined+0x487/0x520 net/wireless/ibss.c:36
Code: 0f 0b e9 0c fe ff ff e8 a7 19 75 f9 e9 41 fc ff ff e8 7d 19 75 f9 e9 7d fc ff ff e8 93 19 75 f9 e9 0d ff ff ff e8 99 51 32 f9 <0f> 0b e9 7e fc ff ff e8 8d 51 32 f9 0f 0b e8 86 19 75 f9 e9 e4 fb
RSP: 0018:ffffc90001d5fbd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888027c24bd0 RCX: 0000000000000000
RDX: ffff8880285e5340 RSI: ffffffff88408237 RDI: 0000000000000000
RBP: ffff888027c24000 R08: 0000000000000001 R09: ffffffff8ee66807
R10: fffffbfff1dccd00 R11: 0000000000000000 R12: 1ffff920003abf7d
R13: ffff88801486a718 R14: 0000000000000000 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000053edb8 CR3: 0000000025e9f000 CR4: 0000000000350ee0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12ecc26a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3565439810a4d2e5
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171e281e080000

