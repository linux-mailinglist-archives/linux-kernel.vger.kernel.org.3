Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7B537393
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiE3CeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiE3CeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:34:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621072E17;
        Sun, 29 May 2022 19:34:05 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBKG31WX9zjX24;
        Mon, 30 May 2022 10:33:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 10:34:02 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ming.lei@redhat.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] block: fix use-after-free in __cpuhp_state_remove_instance
Date:   Mon, 30 May 2022 10:47:29 +0800
Message-ID: <20220530024729.2621465-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We got issue when remove device mapper as follows:
dmsetup create test --table "0 1048576 linear /dev/sda 0"
dmsetup suspend --nolockfs test
dmsetup load test --table "0 1048576 error /dev/sda 0"
dmsetup resume test
dmsetup suspend --nolockfs test
dmsetup load test --table "0 1048576 linear /dev/sda 0"
dmsetup resume test
dmsetup remove test
==================================================================
BUG: KASAN: wild-memory-access in __cpuhp_state_remove_instance+0x1ea/0x310
Write of size 8 at addr dead000000000122 by task dmsetup/1969

CPU: 1 PID: 1969 Comm: dmsetup Not tainted 5.18.0-next-20220524 #225
Call Trace:
 <TASK>
 dump_stack_lvl+0x6e/0x91
 print_report.cold+0x494/0x6b7
 kasan_report+0xa9/0x120
 __cpuhp_state_remove_instance+0x1ea/0x310
 bioset_exit+0x45/0x2e0
 cleanup_mapped_device+0x4f/0x190
 __dm_destroy+0x230/0x3c0
 dev_remove+0x18b/0x1d0
 ctl_ioctl+0x3d8/0x7c0
 dm_ctl_ioctl+0x21/0x30
 __x64_sys_ioctl+0x12c/0x170
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f0d9aa7a8d7
RSP: 002b:00007fff1ecedce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0d9ad5ff50 RCX: 00007f0d9aa7a8d7
RDX: 000055c98c17d130 RSI: 00000000c138fd04 RDI: 0000000000000003
RBP: 00007f0d9ad9a503 R08: 00007f0d9ad9b040 R09: 00007fff1ecedc10
R10: 0000000000000006 R11: 0000000000000246 R12: 000055c98c17d130
R13: 00007f0d9ad9a503 R14: 000055c98c17d050 R15: 00007f0d9ad9a503
==================================================================

As load different table may lead to bioset flag changes. But bio_alloc_cache_destroy
to free cache depends on if cache is NULL, and also this after free cache didn't
set 'bs->cache' NULL. So this will lead to UAF.
To solve above issue just set ''bs->cache' NULL after free cache.

Fixes: be4d234d7aeb("bio: add allocation cache abstraction")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index a3893d80dccc..be3937b84e68 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -722,6 +722,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
 		bio_alloc_cache_prune(cache, -1U);
 	}
 	free_percpu(bs->cache);
+	bs->cache = NULL;
 }
 
 /**
-- 
2.31.1

