Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB13B590D30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiHLIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiHLIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:09:31 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38282A830E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:09:27 -0700 (PDT)
X-QQ-mid: bizesmtp85t1660291475tx9fiduu
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 12 Aug 2022 16:04:33 +0800 (CST)
X-QQ-SSF: 01400000002000D0T000B00A0000000
X-QQ-FEAT: wyHyreHVAxq5Bg6kIXyXqpfoNoa0o3Lc2cVxrPfZ43Q5+5qcR1t2uiwZYeKLI
        jTEkZZI7UTFbl6rhJhMSeI47W6E8qyXLgrYV+HMAuxtO5tcob6GBGrobLugT5MB3HwgDiki
        NTCaUJ5h9YrSsjQt0tCUi1X/h5ohge2ACHUYPCXx7nxk8E2slop+CTpFhlYftfuunVwld4v
        Bw1r4b3p1psJrQVTjDqsK6vhcVzfYOKG2VJKrcDCW6522UvmPnCLQqRYeaBhmldD5zWs6t6
        Nbtly0c2p9PoNmJkjhJJgshM71ivMyUS2SjphOQ40XP/Oo9CS+VVrzBjyL4ubVlpTzzbm+G
        tWxGFvJQ7awkpYSfp+0k8GpBjrG0KTb9h6B9FS6AE9glFheDAjHvAkkccZwaqcj70UZ8fYd
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] afs: convert kmap() to kmap_local_page() in mntpt.c
Date:   Fri, 12 Aug 2022 16:04:32 +0800
Message-Id: <20220812080432.14909-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap's pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled.  Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in mntpt.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in mntpt.c.

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 fs/afs/mntpt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 97f50e9fd9eb..7e3cacb11780 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -132,11 +132,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		buf = kmap(page);
+		buf = kmap_local_page(page);
 		ret = -EINVAL;
 		if (buf[size - 1] == '.')
 			ret = vfs_parse_fs_string(fc, "source", buf, size - 1);
-		kunmap(page);
+		kunmap_local(buf);
 		put_page(page);
 		if (ret < 0)
 			return ret;
-- 
2.20.1

