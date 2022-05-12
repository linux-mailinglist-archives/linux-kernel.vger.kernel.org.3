Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F9524C90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353616AbiELMUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353606AbiELMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:20:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788A2469F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:20:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so3087471ilc.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ECsNBH3R+758KxYtoRcfDChqnInBt6dPUMitEt/42zs=;
        b=5+u64sk6zb11Gez+p5yfUvBJVMUYu15PsQ35elmWuC0JKEutMppQDNxErHUOOGWrWF
         O4NWHXeWh8QZtok4ykfDP6cLqFCW8VchZG9z9EPOII313pKWuhXwDd7n9K+y5IaAlmuh
         YcvTDVA3Z5V/C+NY86D8zO1yXm0iT6Vpptssp2ndLFaCsrtEviooAkGwmszpaGvbTp7d
         j9luRWYRkgGGYcRkUItW9squLcepPMJ9dehvRk2M6Vj7tBUF175d7Rknk39BK9b5DHsQ
         vxWR5h0wLpmEFH6+VNgUKzl34xsk8xpPOsQ2ozvKPWzIpn8bcfzsbPeEW9g08+vv1hhj
         dshw==
X-Gm-Message-State: AOAM530xPg/8x9HYeEK3/hT1GdqdLsb5bIpCmFHa20wUG+R319AqTTTx
        V23h/vhL8hSiqLC5vEfG5TSd7aBWJYH9dOkqX0HIM+s0pAjm
X-Google-Smtp-Source: ABdhPJyRFrAKLktRcsRS/D1IXedH0tWevtoDU+ZVekRKWKSPlU1cH3jSpbBtwBAEGWDrs+v3InPMwTcG2Y3hXlKCrkDgizB6fov2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26cb:b0:648:f391:c37d with SMTP id
 g11-20020a05660226cb00b00648f391c37dmr13222406ioo.198.1652358008274; Thu, 12
 May 2022 05:20:08 -0700 (PDT)
Date:   Thu, 12 May 2022 05:20:08 -0700
In-Reply-To: <20220512120234.6088-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020077105decf94ea@google.com>
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
WARNING: CPU: 1 PID: 4071 at fs/namespace.c:1236 mntput_no_expire+0xada/0xcd0 fs/namespace.c:1236
Modules linked in:
CPU: 1 PID: 4071 Comm: syz-executor.4 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0xada/0xcd0 fs/namespace.c:1236
Code: 30 84 c0 0f 84 b9 fe ff ff 3c 03 0f 8f b1 fe ff ff 4c 89 44 24 10 e8 45 50 e9 ff 4c 8b 44 24 10 e9 9d fe ff ff e8 46 bf 9d ff <0f> 0b e9 19 fd ff ff e8 3a bf 9d ff e8 75 cf 91 07 31 ff 89 c5 89
RSP: 0018:ffffc9000324fcf0 EFLAGS: 00010293

RAX: 0000000000000000 RBX: 1ffff92000649fa4 RCX: 0000000000000000
RDX: ffff88807ccd0000 RSI: ffffffff81db819a RDI: 0000000000000003
RBP: ffff888022660c00 R08: 0000000000000000 R09: ffffffff9006d94f
R10: ffffffff81db7eb1 R11: 0000000000000001 R12: 0000000000000008
R13: ffffc9000324fd40 R14: 00000000ffffffff R15: 0000000000000002
FS:  0000555556484400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005567c4d8d680 CR3: 0000000022908000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 path_umount+0x925/0x10d0 fs/namespace.c:1809
 ksys_umount fs/namespace.c:1828 [inline]
 __do_sys_umount fs/namespace.c:1833 [inline]
 __se_sys_umount fs/namespace.c:1831 [inline]
 __x64_sys_umount+0x159/0x180 fs/namespace.c:1831
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0dfe48a557
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef4140618 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0dfe48a557
RDX: 00007ffef41406ea RSI: 000000000000000a RDI: 00007ffef41406e0
RBP: 00007ffef41406e0 R08: 00000000ffffffff R09: 00007ffef41404b0
R10: 00005555564858b3 R11: 0000000000000246 R12: 00007f0dfe4e21f8
R13: 00007ffef41417a0 R14: 0000555556485810 R15: 00007ffef41417e0
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=159cbc4ef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1449df71f00000

