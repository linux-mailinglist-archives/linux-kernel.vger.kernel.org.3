Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3B58F6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiHKEVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiHKEVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:21:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2752262E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:20:59 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M3D5v1WVjzXdRJ;
        Thu, 11 Aug 2022 12:16:51 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 12:20:57 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 11 Aug
 2022 12:20:57 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <chenxiaosong2@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] tty: n_gsm: fix NULL pointer dereference in gsmld_receive_buf()
Date:   Thu, 11 Aug 2022 12:28:48 +0800
Message-ID: <20220811042848.3017861-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported NULL pointer dereference bug as follows:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 3 PID: 1360 Comm: a.out Not tainted 5.19.0-next-20220810 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
 BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000570fcf8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff8880189c2000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880189c2000
RBP: ffffc9000570fda1 R08: 0000000000000000 R09: ffffffff8f59ab27
R10: ffffc9000570fd58 R11: ffff8880196f8000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffc9000570fd90 R15: dffffc0000000000
FS:  00007f382232c540(0000) GS:ffff888107d80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000101452005 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 gsmld_receive_buf+0x1c7/0x320
 tty_ioctl+0x50e/0x1520
 __x64_sys_ioctl+0x19c/0x210
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f382225e9b9
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7
 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
 ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd1c0fdd98 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f382225e9b9
RDX: 00007ffd1c0fdda4 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007ffd1c0fddb0 R08: 000000000000000e R09: 000000001c0fdea0
R10: 0000000000000000 R11: 0000000000000217 R12: 0000560d89007070
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---

Reproducer(c program):
1. int fd = open("/dev/char/4:20", O_RDWR, 0);
2. int arg = 0x15; ioctl(fd, 0x5423, &arg);
3. int arg2 = 0; ioctl(fd, 0x5412, &arg2);

gsm->receive is NULL when gsm_mux is not activated by gsm_activate_mux():

  ioctl(fd, 0x5423, &arg)
    vfs_ioctl
      tty_ioctl
        tiocsetd
          tty_set_ldisc
            tty_ldisc_open
              gsmld_open
                gsm_alloc_mux
                  gsm = kzalloc(sizeof(struct gsm_mux), GFP_KERNEL)
                  gsm->receive == NULL
  ioctl(fd, 0x5412, &arg2)
    vfs_ioctl
      tty_ioctl
        tiocsti // fake input character
          gsmld_receive_buf
            gsm->receive == NULL

Fix this by adding sanity check on struct gsm_mux->receive.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..f1621667b69f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2850,6 +2850,9 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
 
+	if (!gsm->receive)
+		return;
+
 	if (debug & 4)
 		gsm_hex_dump_bytes(__func__, cp, count);
 
-- 
2.31.1

