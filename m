Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C865A454D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiH2Ijl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiH2Ijc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:39:32 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A658DEA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id p16so11118033ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=F7xQEMvWoIJZdLeR96ZnN0p9ITpBz3EsMgm1juYUkNs=;
        b=yHMcl0fhfOHiuKnstggWyMWcmz2zICDZdr6oU3EUuD+i746BIlzDXekaVXo+opR4+7
         g5rtalyBIFReXtvfU6Xg+y/LwueH8a1oDf5/kEn1sNAE9a53SLiWKSBDgvM6mJFkE2nQ
         s1V93criYf4o1aGwd94bVhN2S4h8B+99kgz29W9jlBeTKNtYU1EkYEdFxk92V1N4ZavP
         FcBD3ZRoF2Kcie8laH9Xr9v7yboeALgbMAp7Itm3VcjOlW6vLKEFL5JchsujlDasI52I
         KtdLoJl0T1ulATaW/tjMm1tOmdMQjNeSPbOpMvTaZ8AjE/XW6imtIAScGuhCINPjSp4v
         zQZQ==
X-Gm-Message-State: ACgBeo2+wj/w2CemYHTN0a+l5mU/p5VHWrRljKtgmfqhWBr+0JYXa8RO
        rCxplm614XIu/70XNelpvnQ=
X-Google-Smtp-Source: AA6agR6ZXYigLbvGGKSnfvlYEdAmG4rrNf6Hw94H+9rJeS57PL4aVpYaTb+mcGBRAHbBkwV4RKG6RA==
X-Received: by 2002:a17:907:320a:b0:741:72ee:8f3 with SMTP id xg10-20020a170907320a00b0074172ee08f3mr3904334ejb.168.1661762355713;
        Mon, 29 Aug 2022 01:39:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090634c700b0073dde62713asm4160469ejb.89.2022.08.29.01.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:39:15 -0700 (PDT)
Message-ID: <987ed804-e03b-5bd6-3cd8-cbc494261f3a@kernel.org>
Date:   Mon, 29 Aug 2022 10:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 tiocsti
Content-Language: en-US
To:     syzbot <syzbot+032314e8d7de2bdb97f7@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000e12a9005e6ff4417@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <000000000000e12a9005e6ff4417@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: BUG: unable to handle kernel NULL pointer dereference in 
gsmld_receive_buf

On 24. 08. 22, 18:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1c23f9e627a7 Linux 6.0-rc2
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17eefdcb080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3045c937aad027f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=032314e8d7de2bdb97f7
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1190eb6b080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a1e50d080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+032314e8d7de2bdb97f7@syzkaller.appspotmail.com
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
>    ESR = 0x0000000086000006
>    EC = 0x21: IABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b28b000
> [0000000000000000] pgd=080000010b411003, p4d=080000010b411003, pud=080000010b47b003, pmd=0000000000000000
> Internal error: Oops: 86000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 3028 Comm: syz-executor908 Not tainted 6.0.0-rc2-syzkaller-16440-g1c23f9e627a7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : 0x0
> lr : gsmld_receive_buf+0x140/0x214 drivers/tty/n_gsm.c:2861
> sp : ffff80000ffe3cb0
> x29: ffff80000ffe3cc0 x28: 0000000000000000 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: ffff80000d937000
> x23: ffff80000d681e40 x22: ffff0000cb2dc000 x21: ffff80000ffe3d21
> x20: ffff80000c205988 x19: ffff80000ffe3d24 x18: 00000000000000c0
> x17: ffff80000dd7a698 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000004 x12: ffff80000d681e78
> x11: ff808000098e7e04 x10: 0000000000000000 x9 : ffff8000098e7e04
> x8 : 0000000000000000 x7 : ffff8000098dcea4 x6 : 0000000000000000
> x5 : ffff80000e087890 x4 : 0000000000000002 x3 : 0000000000000001
> x2 : ffff80000ffe3d20 x1 : 0000000000000000 x0 : ffff0000cb2dc000
> Call trace:
>   0x0
>   tiocsti+0x168/0x1c4 drivers/tty/tty_io.c:2293
>   tty_ioctl+0x284/0x9f4 drivers/tty/tty_io.c:2692
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
>   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>   el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>   do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
>   el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>   el0t_64_sync+0x18c/0x190
> Code: bad PC value
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

-- 
js

