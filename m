Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0B54BA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiFNTFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiFNTFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:05:37 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7800710EF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:05:36 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id 3-20020a056e0220c300b002d3d7ebdfdeso7086452ilq.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iPvTtH8+uMsbdQrce2mVnt2NttPZ+//+Jm7WS48w6Ak=;
        b=ECD9k438RR++jP7SUuA1t0By/F+s+mztiPNCt+J3U/usj8uPSxnsfDCtrE48w/i7Lp
         GjeQYTw22hvYHPe54xgf5tpcsnJ7X7sm/TOo4/cXHje40Yvub/7Bwx2qCm3S3/eeMdZr
         PY0Ym4+uv9hYkJVNjIH/TcRZi0cZ7APY/IY2zwxNTVgCl1r9V/N4Jd1scfQCn7LMuVaO
         R9Wbrwoqn7JYXw3DalaUoTImq5tkImD5QMu5afe4Xkw+3xVDtNUWot4lk9ajS4FjocVF
         YNjrsZuhdNjn4fXEpimUfJoYMojcUqTGSD5QJ1e+dwUzv2iYtXskDl/T8WA7mQhEPxwQ
         Nh/w==
X-Gm-Message-State: AJIora9lxtcffIvbJMqEHpQ8lis4IMnAfTFJiNJNA29Vsx8xjiUxMIdK
        4ph5gPECZIFd5w1FlQIUjfflJ5OWzYlSrS3tCWKWxleJBusa
X-Google-Smtp-Source: AGRyM1vH3NBceHOP89M5WUfzRy6OKpPuD+kczaCt9QvQEMIz2nE/aioWFNh3a8mgs1QxX8PLvFmaqmb9OWFjF9kfG/g+h1d2yrLa
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:2d3:dc52:35e9 with SMTP id
 j14-20020a92ca0e000000b002d3dc5235e9mr3831025ils.44.1655233535782; Tue, 14
 Jun 2022 12:05:35 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:05:35 -0700
In-Reply-To: <000000000000cb8e3a05c4ed84bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebb59305e16d1627@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in __show_regs
From:   syzbot <syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com>
To:     0x7f454c46@gmail.com, bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, glider@google.com, hpa@zytor.com,
        krisman@collabora.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, masahiroy@kernel.org, mingo@redhat.com,
        rajatasthana4@gmail.com, sashal@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    2f3064574275 README.md: ORC is no more a problem
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=169a2310080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e6293529531e9ca
dashboard link: https://syzkaller.appspot.com/bug?extid=b17d3e853d5dce65f981
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 9ffb5944a699b6a0d69c169ceff97636395ee30f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14917c2ff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1303752ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com

Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:j1939_session_deactivate net/can/j1939/transport.c:1090 [inline]
RIP: 0010:j1939_session_deactivate_activate_next+0x271/0x480 net/can/j1939/transport.c:1100
Code: f4 e9 ed fd ff ff 8b 7d d4 e8 fb 31 13 f4 e9 24 fe ff ff 44 89 ff e8 ee 31 13 f4 41 83 fc 02 0f 83 68 fe ff ff e8 df 70 82 f3 <0f> 0b e9 61 fe ff ff 8b 7d d4 e8 d0 31 13 f4 e9 68 fe ff ff 44 89
RSP: 0018:ffff888102e3f5c8 EFLAGS: 00010246
=====================================================
BUG: KMSAN: uninit-value in __show_regs+0xe6/0x1040 arch/x86/kernel/process_64.c:76
 __show_regs+0xe6/0x1040 arch/x86/kernel/process_64.c:76
 show_regs+0xc0/0x160 arch/x86/kernel/dumpstack.c:463
 __warn+0x3c2/0x730 kernel/panic.c:596
 report_bug+0x8eb/0xae0 lib/bug.c:199
 handle_bug+0x41/0x70 arch/x86/kernel/traps.c:315
 exc_invalid_op+0x1b/0x50 arch/x86/kernel/traps.c:335
 asm_exc_invalid_op+0x12/0x20
 j1939_session_deactivate_activate_next+0x271/0x480 net/can/j1939/transport.c:1100
 j1939_xtp_rx_abort_one+0x861/0x900 net/can/j1939/transport.c:1340
 j1939_xtp_rx_abort net/can/j1939/transport.c:1351 [inline]
 j1939_tp_cmd_recv net/can/j1939/transport.c:2100 [inline]
 j1939_tp_recv+0x1534/0x1cd0 net/can/j1939/transport.c:2133
 j1939_can_recv+0xed0/0x1070 net/can/j1939/main.c:108
 deliver net/can/af_can.c:574 [inline]
 can_rcv_filter+0x74b/0x1110 net/can/af_can.c:608
 can_receive+0x4fb/0x6d0 net/can/af_can.c:665
 can_rcv+0x1f0/0x490 net/can/af_can.c:696
 __netif_receive_skb_one_core net/core/dev.c:5405 [inline]
 __netif_receive_skb+0x1f1/0x640 net/core/dev.c:5519
 process_backlog+0x4e7/0xb50 net/core/dev.c:5847
 __napi_poll+0x14e/0xb80 net/core/dev.c:6413
 napi_poll net/core/dev.c:6480 [inline]
 net_rx_action+0x7e8/0x1830 net/core/dev.c:6567
 __do_softirq+0x206/0x809 kernel/softirq.c:558
 run_ksoftirqd+0x37/0x50 kernel/softirq.c:921
 smpboot_thread_fn+0x626/0xbf0 kernel/smpboot.c:164
 kthread+0x3c7/0x500 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Local variable mic created at:
 ieee80211_rx_h_michael_mic_verify+0x54/0x10f0 net/mac80211/wpa.c:100
 ieee80211_rx_handlers+0x2d31/0xf170 net/mac80211/rx.c:3929

CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.18.0-syzkaller-16253-g2f3064574275 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================

