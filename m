Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E01574D22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiGNMKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiGNMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:09:52 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B33F333
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:08:48 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j17-20020a056e02219100b002dc4e721203so987996ila.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xFnPnpP/G7u2XnAw40xBSXDR4IKqMm4aVVQnDeJHz1g=;
        b=tNsi389gkA4JbOhGxOQ9t9Z/aX0813VSVunqYAJKsmJFS075G/9PgLeZLI3UyCCX6R
         yEXJSDKl5mif3gd215MulrvMopAPVUs848AdRjW/2a43/DyXChdsp0F5nXFve2pvpcKg
         3EJymNReWJz8iQgFYIF0S/ya1ZPc02/51cUSlTES3dhmGudFz8xDcB5OaTsj9mEXtsaP
         sV6FQPh5lhDHj+oiGyoptN9/ajBp+6bHEF7Hx1mqnFcKW0nRrzJda1dtFx2ISzdiqSjZ
         Q9VEKELQE6cWLeHpNAzONqzj9i0rKZE5CgyRsi9ajlz3F1N61zYQs1uWI3Ks9QJy0mpZ
         4WEw==
X-Gm-Message-State: AJIora9XhYQoKqf4/nVKyAYKfWOkb1jt+0dMxLgksTMjsRG3Ww/4vtzx
        R/lFh/UYJW+mCUst7tn5iTcuqDyw7VsHNSro4ISWPdCPJZN9
X-Google-Smtp-Source: AGRyM1uHruF+JtwFguHVwlc4HWMQAzNuNdkMKcgYVJZ8aL9xJ0irTHvP+9dNr1/xZ7pAJFVuv5qMVFYjMIkQdt+beiCDmmI/JfFW
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c4e:b0:657:4115:d9e4 with SMTP id
 x14-20020a0566022c4e00b006574115d9e4mr4164255iov.91.1657800505735; Thu, 14
 Jul 2022 05:08:25 -0700 (PDT)
Date:   Thu, 14 Jul 2022 05:08:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040bd4905e3c2c237@google.com>
Subject: [syzbot] INFO: trying to register non-static key in ieee80211_do_stop
From:   syzbot <syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
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

HEAD commit:    b11e5f6a3a5c net: sunhme: output link status with a single..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=108ed862080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa95f12403a2e0d2
dashboard link: https://syzkaller.appspot.com/bug?extid=eceab52db7c4b961e9d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173a7c78080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1102749a080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 3615 Comm: syz-executor630 Not tainted 5.19.0-rc5-syzkaller-00263-gb11e5f6a3a5c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf30/0x1130 kernel/locking/lockdep.c:1292
 __lock_acquire+0x10a/0x5660 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:354 [inline]
 ieee80211_do_stop+0xc3/0x1ff0 net/mac80211/iface.c:380
 ieee80211_runtime_change_iftype net/mac80211/iface.c:1789 [inline]
 ieee80211_if_change_type+0x383/0x840 net/mac80211/iface.c:1827
 ieee80211_change_iface+0x57/0x3f0 net/mac80211/cfg.c:190
 rdev_change_virtual_intf net/wireless/rdev-ops.h:69 [inline]
 cfg80211_change_iface+0x5e1/0xf10 net/wireless/util.c:1078
 nl80211_set_interface+0x64f/0x8c0 net/wireless/nl80211.c:4041
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2488
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2542
 __sys_sendmsg net/socket.c:2571 [inline]
 __do_sys_sendmsg net/socket.c:2580 [inline]
 __se_sys_sendmsg net/socket.c:2578 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2578
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5bf1b37b89
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd682b8a38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
