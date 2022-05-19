Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551552CBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiESGdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiESGcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:32:46 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77C2714D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:32:44 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id r17-20020a0566022b9100b00654b99e71dbso1701459iov.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=84hMBONQvNCs29JQT+olmLldYTybgZAUu2mmj759ANc=;
        b=LNHMMEpCYWilQ10X7O3fPucTPL8h1blylQBbEiQtac/JR6L677ntl9E3KgleYfyQXt
         QFU4p08aGklMQOCXfsNDpdDSOdDZ1APzePiyHETaj9BK8Q4vdOq31HZxFPiLuwipqNSB
         8sIZJNwO+06f2VFLqvMxOsm0vwZXWxxCUV9a/NM7bepfJJt3nTylHNTaEZ9lYsRsrW/s
         Z6U0vTObQ/BPfnC6QZNQMvTF5YmxpcYDOkjE8LjI9UxkBbqs9q9dIOIMJhQHQrhkGMn8
         3ud2v8vBObOp+E4VPBxgXHR+uDHLVnEz1vJ11rPFIAEB+NCmLnF6qDKxoQW/4KyRHh6C
         GwAw==
X-Gm-Message-State: AOAM532mW2t2yuuU3z8ejEckDhzatpBK9zClmHuW69EeyIMQnEOP1/9L
        P2zAVSq+ccoDHbFCPw4fpc2nZVB3f92Tx9tXQIvD/cobddOi
X-Google-Smtp-Source: ABdhPJyeX2hE1ezJYHrqY2wib9FX7CGulEJxcqbDLdDpeqDbPYmPpV8xiVY1YMh+3oivhyZZGFRtot3OO1STMz0xM+oVUo/tit0H
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:2cf:8ecb:c8d4 with SMTP id
 15-20020a056e0216cf00b002cf8ecbc8d4mr1879907ilx.174.1652941963534; Wed, 18
 May 2022 23:32:43 -0700 (PDT)
Date:   Wed, 18 May 2022 23:32:43 -0700
In-Reply-To: <CACT4Y+bRrWXYGgKdbK3AFQLNUumJbSzujEJ=+37dcDBjzJg72A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009228fe05df578ac1@google.com>
Subject: Re: [syzbot] general protection fault in hci_inquiry_result_with_rssi_evt
From:   syzbot <syzbot+e3cad3a4e3f03bc00562@syzkaller.appspotmail.com>
To:     "'Dmitry Vyukov' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
Cc:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, poprdi@google.com,
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

> On Mon, 13 Dec 2021 at 08:17, syzbot
> <syzbot+e3cad3a4e3f03bc00562@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    4eee8d0b64ec Add linux-next specific files for 20211208
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=130203e5b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=20b74d9da4ce1ef1
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e3cad3a4e3f03bc00562
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101eb355b00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b8f805b00000
>>
>> The issue was bisected to:
>>
>> commit 3e54c5890c87a30b1019a3de9dab968ff2b21e06
>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Date:   Wed Dec 1 18:55:03 2021 +0000
>>
>>     Bluetooth: hci_event: Use of a function table to handle HCI events
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150100bab00000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=170100bab00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=130100bab00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+e3cad3a4e3f03bc00562@syzkaller.appspotmail.com
>> Fixes: 3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI events")
>
> Presumably this was fixed by Luiz's patch:
> https://github.com/torvalds/linux/commit/72279d17df54d5e4e7910b39c61a3f3464e36633
>
> Let's close on syzbot to get new reports in future:
>
> #syz fix: Bluetooth: hci_event: Rework hci_inquiry_result_with_rssi_evt

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

>
>
>> Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
>> Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
>> Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
>> Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> CPU: 0 PID: 6545 Comm: kworker/u5:1 Not tainted 5.16.0-rc4-next-20211208-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: hci0 hci_rx_work
>> RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x970 net/bluetooth/hci_event.c:4520
>> Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 88 07 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 4c 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 1b 07 00 00
>> RSP: 0018:ffffc90001aafad0 EFLAGS: 00010246
>> RAX: dffffc0000000000 RBX: ffff88807e754000 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff883588a8 RDI: ffff88807e754000
>> RBP: ffff88807e754000 R08: 0000000000000000 R09: 0000000000000000
>> R10: ffffffff88376f27 R11: 0000000000000000 R12: ffff88807015eb40
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ffd653f7000 CR3: 0000000071f88000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  hci_event_func net/bluetooth/hci_event.c:6812 [inline]
>>  hci_event_packet+0x817/0xe90 net/bluetooth/hci_event.c:6860
>>  hci_rx_work+0x4fa/0xd30 net/bluetooth/hci_core.c:3817
>>  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2318
>>  worker_thread+0x658/0x11f0 kernel/workqueue.c:2465
>>  kthread+0x405/0x4f0 kernel/kthread.c:345
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>>  </TASK>
>> Modules linked in:
>> ---[ end trace 403a15c54e29c5c4 ]---
>> RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x970 net/bluetooth/hci_event.c:4520
>> Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 88 07 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <0f> b6 04 02 4c 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 1b 07 00 00
>> RSP: 0018:ffffc90001aafad0 EFLAGS: 00010246
>> RAX: dffffc0000000000 RBX: ffff88807e754000 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff883588a8 RDI: ffff88807e754000
>> RBP: ffff88807e754000 R08: 0000000000000000 R09: 0000000000000000
>> R10: ffffffff88376f27 R11: 0000000000000000 R12: ffff88807015eb40
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f2bb803f018 CR3: 000000001d893000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess), 4 bytes skipped:
>>    0:   48 c1 ea 03             shr    $0x3,%rdx
>>    4:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>>    8:   0f 85 88 07 00 00       jne    0x796
>>    e:   48 8b 04 24             mov    (%rsp),%rax
>>   12:   4c 8b 28                mov    (%rax),%r13
>>   15:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>>   1c:   fc ff df
>>   1f:   4c 89 ea                mov    %r13,%rdx
>>   22:   48 c1 ea 03             shr    $0x3,%rdx
>> * 26:   0f b6 04 02             movzbl (%rdx,%rax,1),%eax <-- trapping instruction
>>   2a:   4c 89 ea                mov    %r13,%rdx
>>   2d:   83 e2 07                and    $0x7,%edx
>>   30:   38 d0                   cmp    %dl,%al
>>   32:   7f 08                   jg     0x3c
>>   34:   84 c0                   test   %al,%al
>>   36:   0f 85 1b 07 00 00       jne    0x757
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CACT4Y%2BbRrWXYGgKdbK3AFQLNUumJbSzujEJ%3D%2B37dcDBjzJg72A%40mail.gmail.com.
