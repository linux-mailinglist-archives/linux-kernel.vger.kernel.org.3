Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412054C95E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbiFONC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFONCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:02:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328043EE6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:02:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k5-20020a6bba05000000b00668eb755190so6021428iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=mtUhdNRZNmg9G4GeeY0ggufur11Mdyz98aTGenLg6Ww=;
        b=znewZPG+ttrferpJUxDK0wie/aNBeUMI/3lKIbt5HCK0SxlxnVoO6YekQcgRJixxw9
         VfxoFjvpGcm2WVj/9tI643A7vdlSJJlYZw/Ol1I1trbZp0RTqccPPAU3cA9Q3EBkWWw8
         JflpQhoDIzPe0vHF05j03m6oYnYBpWUwENPvBGyFlZws3foH0Lg3PhZvNKBCIs37Mmx1
         9q1trByAARDzcBWctnrYa1Co7ZKhqyjTkmcRCzD/pMas20o2jpSmbUCjQioJeoT9arWN
         H24LrlMI/t2OUgooY3m1b8ibE2p7R0WBIJrxeLz7pKSwP32vdzbsg9KZzK1RTJIAFpEJ
         9cCA==
X-Gm-Message-State: AOAM531mlA3Iq8YQPgJbtsEjI8j/JamYjSMUZ2h/oyeeF0l1yLs9y9Xb
        huhZM6T4Aya2wKOLR/K/ngwo/Ky97StA5CQFNIAbjWtcRQ7k
X-Google-Smtp-Source: ABdhPJx+Pt6/CCEG6wAmXaNjd2zsLFgLAy1xkBTnjtyfoFqdNXm1dKSzGwvBhCDBh3qn79x4Af05bv4F8uspxf1Z7LkiIhKWJyiL
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8e:b0:5e9:74e7:6b01 with SMTP id
 r14-20020a0566022b8e00b005e974e76b01mr5225239iov.127.1655298141564; Wed, 15
 Jun 2022 06:02:21 -0700 (PDT)
Date:   Wed, 15 Jun 2022 06:02:21 -0700
In-Reply-To: <20220615130208.2209-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9bb9b05e17c21a8@google.com>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in __show_regs
From:   syzbot <syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

> On Tue, 14 Jun 2022 12:05:35 -0700
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    2f3064574275 README.md: ORC is no more a problem
>> git tree:       https://github.com/google/kmsan.git master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=169a2310080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e6293529531e9ca
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b17d3e853d5dce65f981
>> compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 9ffb5944a699b6a0d69c169ceff97636395ee30f), GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14917c2ff00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1303752ff00000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com
>> 
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:j1939_session_deactivate net/can/j1939/transport.c:1090 [inline]
>> RIP: 0010:j1939_session_deactivate_activate_next+0x271/0x480 net/can/j1939/transport.c:1100
>> Code: f4 e9 ed fd ff ff 8b 7d d4 e8 fb 31 13 f4 e9 24 fe ff ff 44 89 ff e8 ee 31 13 f4 41 83 fc 02 0f 83 68 fe ff ff e8 df 70 82 f3 <0f> 0b e9 61 fe ff ff 8b 7d d4 e8 d0 31 13 f4 e9 68 fe ff ff 44 89
>> RSP: 0018:ffff888102e3f5c8 EFLAGS: 00010246
>> =====================================================
>> BUG: KMSAN: uninit-value in __show_regs+0xe6/0x1040 arch/x86/kernel/process_64.c:76
>>  __show_regs+0xe6/0x1040 arch/x86/kernel/process_64.c:76
>>  show_regs+0xc0/0x160 arch/x86/kernel/dumpstack.c:463
>>  __warn+0x3c2/0x730 kernel/panic.c:596
>>  report_bug+0x8eb/0xae0 lib/bug.c:199
>>  handle_bug+0x41/0x70 arch/x86/kernel/traps.c:315
>>  exc_invalid_op+0x1b/0x50 arch/x86/kernel/traps.c:335
>>  asm_exc_invalid_op+0x12/0x20
>>  j1939_session_deactivate_activate_next+0x271/0x480 net/can/j1939/transport.c:1100
>>  j1939_xtp_rx_abort_one+0x861/0x900 net/can/j1939/transport.c:1340
>>  j1939_xtp_rx_abort net/can/j1939/transport.c:1351 [inline]
>>  j1939_tp_cmd_recv net/can/j1939/transport.c:2100 [inline]
>>  j1939_tp_recv+0x1534/0x1cd0 net/can/j1939/transport.c:2133
>>  j1939_can_recv+0xed0/0x1070 net/can/j1939/main.c:108
>>  deliver net/can/af_can.c:574 [inline]
>>  can_rcv_filter+0x74b/0x1110 net/can/af_can.c:608
>>  can_receive+0x4fb/0x6d0 net/can/af_can.c:665
>>  can_rcv+0x1f0/0x490 net/can/af_can.c:696
>>  __netif_receive_skb_one_core net/core/dev.c:5405 [inline]
>>  __netif_receive_skb+0x1f1/0x640 net/core/dev.c:5519
>>  process_backlog+0x4e7/0xb50 net/core/dev.c:5847
>>  __napi_poll+0x14e/0xb80 net/core/dev.c:6413
>>  napi_poll net/core/dev.c:6480 [inline]
>>  net_rx_action+0x7e8/0x1830 net/core/dev.c:6567
>>  __do_softirq+0x206/0x809 kernel/softirq.c:558
>>  run_ksoftirqd+0x37/0x50 kernel/softirq.c:921
>>  smpboot_thread_fn+0x626/0xbf0 kernel/smpboot.c:164
>>  kthread+0x3c7/0x500 kernel/kthread.c:376
>>  ret_from_fork+0x1f/0x30
>> 
>> Local variable mic created at:
>>  ieee80211_rx_h_michael_mic_verify+0x54/0x10f0 net/mac80211/wpa.c:100
>>  ieee80211_rx_handlers+0x2d31/0xf170 net/mac80211/rx.c:3929
>> 
>> CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.18.0-syzkaller-16253-g2f3064574275 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> =====================================================
>
> See if session is already deactivated.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  24625f7d

KMSAN bugs can only be tested on https://github.com/google/kmsan.git tree
because KMSAN tool is not upstreamed yet.
See https://goo.gl/tpsmEJ#kmsan-bugs for details.

>
> diff -pur a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> --- a/net/can/j1939/transport.c	2022-06-15 18:48:27.235848700 +0800
> +++ b/net/can/j1939/transport.c	2022-06-15 20:51:11.711001100 +0800
> @@ -1085,9 +1085,9 @@ static bool j1939_session_deactivate(str
>  
>  	j1939_session_list_lock(priv);
>  	/* This function should be called with a session ref-count of at
> -	 * least 2.
> +	 * least 2 if the session is not deactivated yet.
>  	 */
> -	WARN_ON_ONCE(kref_read(&session->kref) < 2);
> +	WARN_ON_ONCE(session->err != ESHUTDOWN && kref_read(&session->kref) < 2);
>  	active = j1939_session_deactivate_locked(session);
>  	j1939_session_list_unlock(priv);
>  
> --
