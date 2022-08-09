Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1050958D8E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiHIMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243189AbiHIMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:47:46 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156161CFC8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:47:38 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id z2so14997487edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vpE19lK+5esF4BbuLLwRiUcX8adde4W0yremjiqZC2k=;
        b=f9OknvtunCyHbVjti8CxtwVbie9Fphf0pHgUyvivr1fNC3iYy0OQWCd55MmkvyUzEe
         qIU7Ba01fKp2wGlnq9mank0yjWamq8hNHgkOjNKANxBOsf2aqx0HKznMplqKu3NQhHon
         DqUKqeuZznq94jft6loH0/apS3bKenWA/bsx3EC3JuvtBgyWRpDQ7RNYVMMLloyWtXUB
         r5/vVsDrQnEmx3jMsgXQx9yCLumrHcTSBA/YuHnoLqzyRypcqjxZJdIZWWS8xbg0bfwZ
         pCPWdEaoSvdgCgjkzAALSWATUytnr1mJ9R/szpS4gph5hOX6PLvrzHtCOZJedHdkcrbh
         0Suw==
X-Gm-Message-State: ACgBeo2M4HtCLCS788k1xqesuwsZ4ipd8EvZqU2duQu3ZPy3/rzZdyya
        O9RazqXz8Vjc8LAowUmOT1Y=
X-Google-Smtp-Source: AA6agR7VRz9bT/OD1M7vAGSpwqFt45s46P9OvDNqDs0ms0SiGwG6aJ7mBchjK/HsFwXsjOiaE4KMkA==
X-Received: by 2002:a05:6402:2755:b0:43d:7568:c78e with SMTP id z21-20020a056402275500b0043d7568c78emr22183805edd.104.1660049256408;
        Tue, 09 Aug 2022 05:47:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e12-20020a50fb8c000000b0043a78236cd2sm5951061edq.89.2022.08.09.05.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:47:36 -0700 (PDT)
Message-ID: <b838966f-47f9-9a58-ca81-02571f270a22@kernel.org>
Date:   Tue, 9 Aug 2022 14:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 gsmld_receive_buf
Content-Language: en-US
To:     syzbot <syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000ade42905e5ba78e0@google.com>
Cc:     "D. Starke" <daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <000000000000ade42905e5ba78e0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Daniel again.

On 08. 08. 22, 15:05, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14a27066080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=e3563f0c94e188366dbb
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164eb3ca080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17327ce1080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 74c90067 P4D 74c90067 PUD 74c53067 PMD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 3606 Comm: syz-executor237 Not tainted 5.19.0-next-20220808-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffc9000387fcf0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff88801bbdf000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801bbdf000
> RBP: ffffc9000387fda1 R08: 0000000000000001 R09: 0000000000000004
> R10: 0000000000000000 R11: 1ffffffff1ffa9ce R12: 0000000000000001
> R13: 0000000000000000 R14: ffffc9000387fd90 R15: dffffc0000000000
> FS:  0000555556e8d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 000000001c7e0000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   gsmld_receive_buf+0x1c2/0x2f0 drivers/tty/n_gsm.c:2861
>   tiocsti drivers/tty/tty_io.c:2293 [inline]
>   tty_ioctl+0xa75/0x15d0 drivers/tty/tty_io.c:2692
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f76c0e5eb59
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe9a4f7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f76c0e5eb59
> RDX: 0000000020000040 RSI: 0000000000005412 RDI: 0000000000000004
> RBP: 00007f76c0e22d00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f76c0e22d90
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffc9000387fcf0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff88801bbdf000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801bbdf000
> RBP: ffffc9000387fda1 R08: 0000000000000001 R09: 0000000000000004
> R10: 0000000000000000 R11: 1ffffffff1ffa9ce R12: 0000000000000001
> R13: 0000000000000000 R14: ffffc9000387fd90 R15: dffffc0000000000
> FS:  0000555556e8d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 000000001c7e0000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 

-- 
js
suse labs

