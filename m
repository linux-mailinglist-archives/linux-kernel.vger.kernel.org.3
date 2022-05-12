Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1789524F65
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354995AbiELOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350311AbiELOFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:05:10 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607B5D5DF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:05:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id t1-20020a056602140100b0065393cc1dc3so3088387iov.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Mf+SGmOPJ8hxFoqVz1yrqkfaKgwcbpjRG6BPa4pWlFc=;
        b=BUKyb/XrTplc8y+xLSNHhwabHi8N3FQ/xCrJU+IKIU1Ce6Nj3hcYyf8sIs5jgwQD+Z
         DnW11MtpbtYpTV5DWx2PK23ZCriBtf4spm1im3LaTwSF/yaHxo46H3el+L+MsGgIKD07
         X86FeHFfo254dGdCYss9G9bm1FmrkjTGrPAh9t0e1axZk+zfavfEXvBOU63GIGg1Tb3E
         f5TNB7G3OIzBmzaFTfS/X4LFN9Co/47/mIokDNaYxhG0izj/e6XzsncYCw63/iekn4iO
         R1/TR5V887X4Yz2NnzGibygn/EDxEs1DFyCUrv7f/PztUUihbwoMr22q0KX3U99vIZqf
         QaPA==
X-Gm-Message-State: AOAM530fE3xF9UpYmWyPoPpgYK1aNKshQT3zfxWlPlKDL88zEYCsK49k
        W6o2qOrzEvTcty6NHTwnrfN+Sxjwe3CXcKOUXjbq1Bg/5DYS
X-Google-Smtp-Source: ABdhPJzTUtokRcXE9eT4uPY5zHhPJf32Dv6MYzpQ2lsTmIb5KHpdvLNYHwnldCI0qYYCbFxguwbqM0jVkKmOz5U8KO8jNlqlMywp
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4189:b0:32b:a06a:b007 with SMTP id
 az9-20020a056638418900b0032ba06ab007mr41435jab.101.1652364308550; Thu, 12 May
 2022 07:05:08 -0700 (PDT)
Date:   Thu, 12 May 2022 07:05:08 -0700
In-Reply-To: <20220512133426.6300-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a69d4305ded10b86@google.com>
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
WARNING: CPU: 1 PID: 4303 at fs/namespace.c:1225 mntput_no_expire+0x965/0xfc0 fs/namespace.c:1225
Modules linked in:
CPU: 1 PID: 4303 Comm: syz-executor.2 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x965/0xfc0 fs/namespace.c:1225
Code: 05 00 00 48 8b 35 93 a4 dd 0b b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 e0 fd f0 8b e8 c5 0e 72 ff e9 15 f9 ff ff e8 bb c0 9d ff <0f> 0b e9 ca f8 ff ff e8 af c0 9d ff 0f 0b e9 be f8 ff ff e8 a3 c0
RSP: 0018:ffffc900039dfd78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888018771d80 RSI: ffffffff81db8025 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db78d8 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88807d666600 R14: dffffc0000000000 R15: ffffed100facccca
FS:  00005555560e5400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556a84848 CR3: 000000001a7cd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1287
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f215003bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffc71fd75e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f215003bd2b
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f215019d960 R08: 0000000000000000 R09: 00007ffc71fe1080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000016e46
R13: 00007ffc71fd76e0 R14: 00007ffc71fd7700 R15: 0000000000000032
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=10502459f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1786c8c6f00000

