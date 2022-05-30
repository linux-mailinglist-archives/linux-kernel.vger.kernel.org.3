Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAE537AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiE3MsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiE3MsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:48:21 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD561623
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:48:20 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id k184-20020a6bbac1000000b0065aeedd4ba8so5443583iof.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fviMwFuCOHUegEvnIFsjn2njt9ZqkztQPMv6YKuPdAA=;
        b=OaGeDhGlOn75Y02o4svMgDqO9yIBg2b34d7E+zcHx7ieJ1No/QIWTM15TT0tOxu0+T
         XRtzz2axEK00QS3iW0idoXHpwa7/7ce9Im9XarAJVmwNxpTiO6GHbu8zE73K+g368TW/
         NGCrmE2ssFOJs3qAV+OF37H+0h4v+Vqw0d03BRnu8JHQqSBqCIXNCznY1V+zA1ieMGJD
         z4SFkGpCdvY3NrUfX/gf5BHf+OGmF2hUWe1KkOPjpTc5gfqyC5LJdBwCBO1dbcWfT3kc
         9Qbf8adK1pQ2vqEfTwGVekOV5PnoVzumjkklLcYAxCgbIOkzxB03Qx8dUhI/aTXHZoiC
         XGgQ==
X-Gm-Message-State: AOAM533k+4HzobXTRhVFOc+UWMVBceqvmdydM2lyYjQ2JjkCeRFEHvPp
        Y6DFcxhDPHoUUCwAps0dv4rW9ulnZGcpIaSvHROOi/S63xMP
X-Google-Smtp-Source: ABdhPJycnqRf6X1SBHFUkROsgHjQtpBF8Dm7PO+qwNPyD6tzwCY/b/l83ev4fZbc8+AUU6TRX9qmxx5ZaxRAKtUZFRfbJ4Z8oofl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:2d1:1d0c:2e28 with SMTP id
 j11-20020a056e02218b00b002d11d0c2e28mr28257557ila.216.1653914899437; Mon, 30
 May 2022 05:48:19 -0700 (PDT)
Date:   Mon, 30 May 2022 05:48:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011e14605e03a125d@google.com>
Subject: [syzbot] WARNING in dma_map_sgtable (2)
From:   syzbot <syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, sumit.semwal@linaro.org,
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

syzbot found the following issue on:

HEAD commit:    7e062cda7d90 Merge tag 'net-next-5.19' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=172151d3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d71d3c07c36588
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba551855046ba3b3806
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12918503f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1386fa39f00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14107ee5f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16107ee5f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12107ee5f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3610 at kernel/dma/mapping.c:188 dma_map_sgtable+0x203/0x260 kernel/dma/mapping.c:264
Modules linked in:
CPU: 0 PID: 3610 Comm: syz-executor162 Not tainted 5.18.0-syzkaller-04943-g7e062cda7d90 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__dma_map_sg_attrs kernel/dma/mapping.c:188 [inline]
RIP: 0010:dma_map_sgtable+0x203/0x260 kernel/dma/mapping.c:264
Code: 75 15 e8 50 5f 14 00 eb cb e8 49 5f 14 00 eb c4 e8 42 5f 14 00 eb bd e8 3b 5f 14 00 0f 0b bd fb ff ff ff eb af e8 2d 5f 14 00 <0f> 0b 31 ed 48 bb 00 00 00 00 00 fc ff df e9 7b ff ff ff 89 e9 80
RSP: 0018:ffffc9000305fd40 EFLAGS: 00010293
RAX: ffffffff81723873 RBX: dffffc0000000000 RCX: ffff88801fbb8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff8881487e5408 R08: ffffffff81723743 R09: ffffed1003592c9e
R10: ffffed1003592c9e R11: 1ffff11003592c9c R12: ffff8881487e5000
R13: ffff88801ac964e0 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555556c2a300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000001f1ef000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_sg_table+0xf9/0x150 drivers/dma-buf/udmabuf.c:72
 begin_cpu_udmabuf+0xf5/0x160 drivers/dma-buf/udmabuf.c:126
 dma_buf_begin_cpu_access+0xd8/0x170 drivers/dma-buf/dma-buf.c:1172
 dma_buf_ioctl+0x2a0/0x2f0 drivers/dma-buf/dma-buf.c:363
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f8bf9c6dc19
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7cfae1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8bf9c6dc19
RDX: 0000000020000100 RSI: 0000000040086200 RDI: 0000000000000006
RBP: 00007f8bf9c31dc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8bf9c31e50
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
