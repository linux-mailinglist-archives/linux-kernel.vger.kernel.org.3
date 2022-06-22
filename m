Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2B554093
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355855AbiFVCf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355886AbiFVCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:35:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD952193E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:35:21 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id l130-20020a6b3e88000000b00669dcc36db3so8503617ioa.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qbckaV5ProAZ+VwaqK7h0vS9+jwuzfVt8tKSlPRCpHk=;
        b=aRB0yhUiUMTjPCCi8Tg2mITNBfjQgKmrsIvmc+2dmuV9JVEBbZfudYL2A8fMQJ3LQa
         doSDmbkLsVEhkDta6bHvoLdoUTDx91qtrWZxhtBcTngCi6w5hFYZ0DIWyHU1xW38HUUS
         Ytqui3l7jZwO3ZMRIRmn2b329Uxcb7jZnwm5rqewM1uDcYXWdONA1zwjdn9ESFj1lNHo
         lxfByWH8Bf77NX+BOApTlxAn0uGs02XZuux6OFN+gs1J8vyiePlHWhXiDewNM77mwMI+
         XggbJ5/VAzRuD26tm6kenbJUQiUX4AuwRYgSRdyRx1QV90OkSocJFyQwkVxNkF31oFSR
         Qw3w==
X-Gm-Message-State: AJIora/KiNmUYiy/2NyWYkUvltAs3fEd4osh+T1C0vCHFnRNWDiEg1Me
        WTWjhs7qFli65KH2glEwm4NjzSRkQ/r037gmjHHvLyvx+C/b
X-Google-Smtp-Source: AGRyM1vVeqfFfunQOmNktWQ3BEBvlkqRjKQ95uSrB0UJSIz2/S+eS8X7h2EdSAvqKUiteAzQWHPMvauNK2rwZhZ66jHnYAO5NWwe
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3729:b0:332:1c7e:91f7 with SMTP id
 k41-20020a056638372900b003321c7e91f7mr800775jav.84.1655865321113; Tue, 21 Jun
 2022 19:35:21 -0700 (PDT)
Date:   Tue, 21 Jun 2022 19:35:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042d02d05e2003028@google.com>
Subject: [syzbot] INFO: task hung in kernfs_dop_revalidate
From:   syzbot <syzbot+41424c58d8613bce38c0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

syzbot found the following issue on:

HEAD commit:    f0ec9c65a8d6 Merge tag 'char-misc-5.19-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1012c290080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70e1a4d352a3c6ae
dashboard link: https://syzkaller.appspot.com/bug?extid=41424c58d8613bce38c0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cdda40080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41424c58d8613bce38c0@syzkaller.appspotmail.com

INFO: task udevd:2979 blocked for more than 147 seconds.
      Not tainted 5.19.0-rc2-syzkaller-00147-gf0ec9c65a8d6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26640 pid: 2979 ppid:     1 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
 schedule+0xd2/0x1f0 kernel/sched/core.c:6500
 rwsem_down_read_slowpath+0x5b9/0xb00 kernel/locking/rwsem.c:1077
 __down_read_common kernel/locking/rwsem.c:1242 [inline]
 __down_read kernel/locking/rwsem.c:1251 [inline]
 down_read+0xe2/0x440 kernel/locking/rwsem.c:1491
 kernfs_dop_revalidate+0xec/0x600 fs/kernfs/dir.c:1098
 d_revalidate fs/namei.c:848 [inline]
 d_revalidate fs/namei.c:845 [inline]
 lookup_fast+0x385/0x6d0 fs/namei.c:1662
 walk_component+0xcf/0x6a0 fs/namei.c:2010
 link_path_walk.part.0+0x7ef/0xf70 fs/namei.c:2341
 link_path_walk fs/namei.c:2265 [inline]
 path_lookupat+0xc8/0x860 fs/namei.c:2492
 filename_lookup+0x1c6/0x590 fs/namei.c:2522
 user_path_at_empty+0x42/0x60 fs/namei.c:2895
 do_readlinkat+0xcd/0x2f0 fs/stat.c:456
 __do_sys_readlink fs/stat.c:489 [inline]
 __se_sys_readlink fs/stat.c:486 [inline]
 __x64_sys_readlink+0x74/0xb0 fs/stat.c:486
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fb1d2b27277
RSP: 002b:00007ffda1230de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00007ffda1230df8 RCX: 00007fb1d2b27277
RDX: 0000000000000400 RSI: 00007ffda1230df8 RDI: 00007ffda12312d8
RBP: 0000000000000400 R08: 00000000007fffff R09: 0000563248ae65a0
R10: 00007fb1d2bb4fc0 R11: 0000000000000246 R12: 00007ffda12312d8
R13: 00007ffda1231248 R14: 0000563248ad0910 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.3:3686 blocked for more than 156 seconds.
      Not tainted 5.19.0-rc2-syzkaller-00147-gf0ec9c65a8d6 #0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
