Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63839579487
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiGSHtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiGSHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:49:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D329A22BEA;
        Tue, 19 Jul 2022 00:49:00 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ln9t4722qzFqJP;
        Tue, 19 Jul 2022 15:47:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:48:58 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        Jason Yan <yanaijie@huawei.com>,
        <syzbot+d44b35ecfb807e5af0b5@syzkaller.appspotmail.com>
Subject: [PATCH] scsi: fix WARNING in scsi_alloc_sgtables
Date:   Tue, 19 Jul 2022 16:00:26 +0800
Message-ID: <20220719080026.1595874-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in SG_IO howto[1]:

"If iovec_count is non-zero then 'dxfer_len' should be equal to the sum
of iov_len lengths. If not, the minimum of the two is the transfer
length."

When iovec_count is non-zero and dxfer_len is zero, the sg_io() just
genarated a null bio, and finally caused a warning below. To fix it,
skip generating a bio for this request if dxfer_len is zero.

[1] https://tldp.org/HOWTO/SCSI-Generic-HOWTO/x198.html

WARNING: CPU: 2 PID: 3643 at drivers/scsi/scsi_lib.c:1032 scsi_alloc_sgtables+0xc7d/0xf70 drivers/scsi/scsi_lib.c:1032
Modules linked in:

CPU: 2 PID: 3643 Comm: syz-executor397 Not tainted
5.17.0-rc3-syzkaller-00316-gb81b1829e7e3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-204/01/2014
RIP: 0010:scsi_alloc_sgtables+0xc7d/0xf70 drivers/scsi/scsi_lib.c:1032
Code: e7 fc 31 ff 44 89 f6 e8 c1 4e e7 fc 45 85 f6 0f 84 1a f5 ff ff e8
93 4c e7 fc 83 c5 01 0f b7 ed e9 0f f5 ff ff e8 83 4c e7 fc <0f> 0b 41
   bc 0a 00 00 00 e9 2b fb ff ff 41 bc 09 00 00 00 e9 20 fb
RSP: 0018:ffffc90000d07558 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801bfc96a0 RCX: 0000000000000000
RDX: ffff88801c876000 RSI: ffffffff849060bd RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff849055b9 R11: 0000000000000000 R12: ffff888012b8c000
R13: ffff88801bfc9580 R14: 0000000000000000 R15: ffff88801432c000
FS:  00007effdec8e700(0000) GS:ffff88802cc00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007effdec6d718 CR3: 00000000206d6000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scsi_setup_scsi_cmnd drivers/scsi/scsi_lib.c:1219 [inline]
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1614 [inline]
 scsi_queue_rq+0x283e/0x3630 drivers/scsi/scsi_lib.c:1730
 blk_mq_dispatch_rq_list+0x6ea/0x22e0 block/blk-mq.c:1851
 __blk_mq_sched_dispatch_requests+0x20b/0x410 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xfb/0x180 block/blk-mq-sched.c:332
 __blk_mq_run_hw_queue+0xf9/0x350 block/blk-mq.c:1968
 __blk_mq_delay_run_hw_queue+0x5b6/0x6c0 block/blk-mq.c:2045
 blk_mq_run_hw_queue+0x30f/0x480 block/blk-mq.c:2096
 blk_mq_sched_insert_request+0x340/0x440 block/blk-mq-sched.c:451
 blk_execute_rq+0xcc/0x340 block/blk-mq.c:1231
 sg_io+0x67c/0x1210 drivers/scsi/scsi_ioctl.c:485
 scsi_ioctl_sg_io drivers/scsi/scsi_ioctl.c:866 [inline]
 scsi_ioctl+0xa66/0x1560 drivers/scsi/scsi_ioctl.c:921
 sd_ioctl+0x199/0x2a0 drivers/scsi/sd.c:1576
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7effdecdc5d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007effdec8e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007effded664c0 RCX: 00007effdecdc5d9
RDX: 0000000020002300 RSI: 0000000000002285 RDI: 0000000000000004
RBP: 00007effded34034 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007effded34054 R14: 2f30656c69662f2e R15: 00007effded664c8

Reported-by: syzbot+d44b35ecfb807e5af0b5@syzkaller.appspotmail.com
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/scsi_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index a480c4d589f5..729e309e6034 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -450,7 +450,7 @@ static int sg_io(struct scsi_device *sdev, struct sg_io_hdr *hdr, fmode_t mode)
 		goto out_put_request;
 
 	ret = 0;
-	if (hdr->iovec_count) {
+	if (hdr->iovec_count && hdr->dxfer_len) {
 		struct iov_iter i;
 		struct iovec *iov = NULL;
 
-- 
2.31.1

