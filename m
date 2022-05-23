Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4E531030
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiEWL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiEWL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:27:14 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3CDE48
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:27:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l3-20020a05660227c300b0065a8c141580so7959891ios.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QCQ9Rx5sOF+d7lMeZPRORn2gtYhkl1yNXHf4o1NXpaI=;
        b=hijwc1ftQuL7IKRWHd92ifzo0ts+0TRmgbZWjuGG2b+sWuszSxjlwPhqU1fIzoGSxh
         S3lROqawq7gbDOcaXkVRW255Jx8MO78zxPU+NRhojmx8/inmirmK9/ipLlaC3XQ8COno
         bKGUlJqIQzUTpr4ysUyXwLsmmuBNSFn8VDiu/hzCg/tOyB+y+lat8gbTTJ218ppk6WUl
         cq1n22EPk39WZ4wlO0uIVDoC1dK0jftmValMHKvzo2B3oMj4lnmk5256RFiSuxeIUwa8
         eUpcR4qPNkrWMbo+1pGmWo7WdAP6BJZtid2TYAyoONV7k9h/x3cMZODxtsKlwWVP9kjF
         Cbyw==
X-Gm-Message-State: AOAM5329Z/VB7rsP63LiFzy47I/Bwf56RVbn6JIT/mvu7FaVVrRcWCUC
        2rF5zVVKM6i4dl2F2FhgoGIwx39YAY/kr/N95s6o6oAo6e+v
X-Google-Smtp-Source: ABdhPJwRxk1Tzo+/dKxoCvKqxpreusTr+39AyxXTczOmfbO+jVHhyPNVPaqfGzwYu4BE6Em2vcbjUX3PNZMWCHt5jb2Y510FfFnt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dcc:b0:32e:bfe7:95c6 with SMTP id
 m12-20020a0566380dcc00b0032ebfe795c6mr3003419jaj.245.1653305233439; Mon, 23
 May 2022 04:27:13 -0700 (PDT)
Date:   Mon, 23 May 2022 04:27:13 -0700
In-Reply-To: <20220523110657.3142-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025031405dfac1fa0@google.com>
Subject: Re: [syzbot] general protection fault in ath9k_hif_usb_rx_cb (2)
From:   syzbot <syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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
general protection fault in ath9k_hif_usb_rx_cb

general protection fault, probably for non-canonical address 0xdffffc00000001f6: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000fb0-0x0000000000000fb7]
CPU: 3 PID: 33 Comm: ksoftirqd/3 Not tainted 5.18.0-syzkaller-00380-g4b0986a3613c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:589 [inline]
RIP: 0010:ath9k_hif_usb_rx_cb+0xcfd/0x10d0 drivers/net/wireless/ath/ath9k/hif_usb.c:687
Code: 48 c1 ea 03 80 3c 02 00 0f 85 cc 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 08 48 8d bb b4 0f 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8
RSP: 0018:ffffc900007cf808 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: 00000000000001f6 RSI: ffffffff8526ff89 RDI: 0000000000000fb4
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8526fcef R11: 0000000000004e00 R12: 0000000000000000
R13: ffff88804dc60000 R14: ffff88802c54f000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d696b46600 CR3: 00000000247b2000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1670
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1747
 dummy_timer+0x11f9/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x679/0xa80 kernel/time/timer.c:1737
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1750
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:589 [inline]
RIP: 0010:ath9k_hif_usb_rx_cb+0xcfd/0x10d0 drivers/net/wireless/ath/ath9k/hif_usb.c:687
Code: 48 c1 ea 03 80 3c 02 00 0f 85 cc 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 08 48 8d bb b4 0f 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8
RSP: 0018:ffffc900007cf808 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: 00000000000001f6 RSI: ffffffff8526ff89 RDI: 0000000000000fb4
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8526fcef R11: 0000000000004e00 R12: 0000000000000000
R13: ffff88804dc60000 R14: ffff88802c54f000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d696b46600 CR3: 00000000247b2000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 cc 03 00 00    	jne    0x3da
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 5b 08          	mov    0x8(%rbx),%rbx
  1c:	48 8d bb b4 0f 00 00 	lea    0xfb4(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 09                	jl     0x44
  3b:	84 d2                	test   %dl,%dl
  3d:	74 05                	je     0x44
  3f:	e8                   	.byte 0xe8


Tested on:

commit:         4b0986a3 Linux 5.18
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a7f4e5f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55eba09345624206
dashboard link: https://syzkaller.appspot.com/bug?extid=c6dde1f690b60e0b9fbe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177a69c3f00000

