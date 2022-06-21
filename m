Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF02552F33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiFUJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiFUJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:54:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295A27CDC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:54:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m1so10370369wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NBlYaiNrA6z6JVZCEelSnaUiEnhYlq2qqcRYlS5hxPg=;
        b=f08gh4TqKnX6ne/avz1Mi1V1EByysQED9a5YG7nU1WhL5WB1HigA31Pzn9nBBdSfYt
         KWPxMJRrHxWooN9iKl8TLe5gZcm4GLz7IBSLeAF+Z249VldaLF8rvk3lADFfLAx4Ngs2
         MHlGCaTDDMFXD10lyVVMjNPwPTUA4pbsIKsQqx18MR8xZz6uukefx5fTR4pJZ7E7qsf3
         jdCEgrNyAc2m1IfxLhMNV8BhlOAXptvUa7UpUf7j70A7w/dq11uzvnaQq1aMmKCL6sBN
         4TFZZ4p78xJZ2iIrB0c7/sRNTyKFQtbjRL294bo6yXTx7i+XpDVkY+4h0ZIG++qOngwA
         rIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBlYaiNrA6z6JVZCEelSnaUiEnhYlq2qqcRYlS5hxPg=;
        b=Ou0YZYmrtvFuwhaKIzgfGj089zd4gsZLQE58qVQWAcV3BKxQgJhyoP7pSnHpsFF/Hu
         U8at2E4vpVDcHWJT27CI5xlFaytUGhyI4KJlFwmE1Pw0cUmRQjKNhf7jYUNWfBzVWn9S
         9+Mn/BOXeMYoUvrip1SYZkv7RCb1q8L0BFj+IE12FRAoCn96ZMcJNV0WyAGuYUSXie4n
         YGqZMo0wUwryUmvKhQBKxVKJtP5/HdoTtp46lhJNV8VUpja0z+tymh2AHDR5cBzd5/FF
         ZRg51dpN+w5LGzgcBlNOQV5QICxVXQlLFhooCl33rLPiJL1eVmiENNOnFoN8bgv0IliA
         R20g==
X-Gm-Message-State: AJIora9qTubjWdFvSlcz3n76sYg6F6rYKpfEo8JN4GShirnodm9Co5hg
        ONfteiFwSDoWvJJKPJZDrWZHMSfJHEw=
X-Google-Smtp-Source: AGRyM1uypqmRykDz6KMZ04Qp8joGJ4h0YdpltuVHbtSG/y3f9cvwRIp3D/mlSRyuf9LJK4UcC8kSNg==
X-Received: by 2002:a5d:5c03:0:b0:21b:90e6:42bc with SMTP id cc3-20020a5d5c03000000b0021b90e642bcmr8381867wrb.36.1655805287429;
        Tue, 21 Jun 2022 02:54:47 -0700 (PDT)
Received: from example.org (ip-94-112-203-185.net.upcbroadband.cz. [94.112.203.185])
        by smtp.gmail.com with ESMTPSA id x24-20020a7bc218000000b003942a244ee7sm17448685wmi.44.2022.06.21.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:54:46 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:54:41 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     syzbot <syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in setup_mq_sysctls
Message-ID: <YrGVYfPINRobj+cF@example.org>
References: <000000000000f5004705e1db8bad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f5004705e1db8bad@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 11:52:25PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    979086f5e006 Merge tag 'fs.fixes.v5.19-rc3' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1284331bf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c696a83383a77f81
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4b0d1b35442afbf6fd2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e740ff00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b758bf00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com

I'm working on a fix that will remove this memory allocation entirely.

> executing program
> BUG: memory leak
> unreferenced object 0xffff888112fc9200 (size 512):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     ef d3 60 85 ff ff ff ff 0c 9b d2 12 81 88 ff ff  ..`.............
>     04 00 00 00 a4 01 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
>     [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
>     [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> BUG: memory leak
> unreferenced object 0xffff888112fd5f00 (size 256):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     00 92 fc 12 81 88 ff ff 00 00 00 00 01 00 00 00  ................
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
>     [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> BUG: memory leak
> unreferenced object 0xffff888112fbba00 (size 256):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     78 ba fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> BUG: memory leak
> unreferenced object 0xffff888112fbb900 (size 256):
>   comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
>   hex dump (first 32 bytes):
>     78 b9 fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
>     [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
>     [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
>     [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
>     [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
>     [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
>     [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
>     [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
>     [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
>     [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
>     [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
>     [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
>     [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
>     [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
>     [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
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
> 

-- 
Rgrds, legion

