Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3916526379
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiEMOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiEMOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:12:14 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313221116C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:12:13 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso4827083iom.18
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fCzxRYRPf/Ri+Vt5cERuJd1IcLNFN38IjoPDg1Jl8Sk=;
        b=lRIwVWklsItUOtNDvP6FCCojiVyQsEgqnLzyh3ael8UVqM4Sim3Kq0b3IhkCKnAGy6
         ZmljrbbMsLT5tgrLuGghxysgCvIyt5NqR5wGy5TI6gx5rNuYWwXG54ErCF65hnqlUPPV
         At0SWkxBp3nCoxYfDCxWwsz4iEkbp6R6r5gJkeN8RSkLDsqkiHkJwfghLlWx2yLTrXAr
         zjzdEfDJEDLD73PWIhE7KJIO07wAzsxfVp1negvWDfS+yh4MIigQQCepxDbcmbdMSR9Q
         6omMmkDU14pwI8fzsxmPnQC7DURSbNADymiuvssFCKB3vXf04rPBns3FYa1fGcrQVMSc
         GcSw==
X-Gm-Message-State: AOAM530c6ma+wC8+k2zIk8saAS2n13aeGS0jyoRwd2G+zjJm9Z61/Q8p
        ylQqc3A9Z0q0YMHEVxn6EAyqZItht6zGVUOegqiHxzmaSF+E
X-Google-Smtp-Source: ABdhPJz1EsGxF27pxk4TYEADGgdBCoy1rh68Qx4f0NzGa3tOUZqptqsoI5eTFbmeN/RhR9GufLNgV2R90iZcfQKe0iNBOSPZgel1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170d:b0:2cf:b51b:c934 with SMTP id
 u13-20020a056e02170d00b002cfb51bc934mr2509774ill.285.1652451132588; Fri, 13
 May 2022 07:12:12 -0700 (PDT)
Date:   Fri, 13 May 2022 07:12:12 -0700
In-Reply-To: <20220513134852.6446-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c44a0a05dee54278@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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
WARNING in mntput_no_expire

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4363 at fs/namespace.c:1229 mntput_no_expire+0x979/0xfe0 fs/namespace.c:1229
Modules linked in:
CPU: 0 PID: 4363 Comm: syz-executor.3 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x979/0xfe0 fs/namespace.c:1229
Code: 04 00 00 48 8b 35 ff a4 dd 0b b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 20 fe f0 8b e8 b1 0e 72 ff e9 01 f9 ff ff e8 a7 c0 9d ff <0f> 0b e9 b6 f8 ff ff e8 9b c0 9d ff 0f 0b e9 aa f8 ff ff e8 8f c0
RSP: 0018:ffffc90003c2fd78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880243f9d80 RSI: ffffffff81db8039 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db78d8 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888022f03800 R14: dffffc0000000000 R15: ffffed10045e070a
FS:  0000555556ec8400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555662a848 CR3: 000000006e4e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1292
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5ac9e3bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd32b26f80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f5ac9e3bd2b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f5ac9f9d960 R08: 0000000000000000 R09: 00007ffd32bcf080
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000001705f
R13: 00007ffd32b27080 R14: 00007ffd32b270a0 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=126c6aa5f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10935b21f00000

