Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F46955AA6B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiFYNSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiFYNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:18:38 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5881EAD8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:18:34 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 25 Jun
 2022 21:18:34 +0800
Received: from localhost.localdomain (172.16.255.36) by
 IT-EXMB-1-125.meizu.com (172.16.1.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 25 Jun 2022 21:18:31 +0800
From:   Even <chenyuwen1@meizu.com>
To:     <xiang@kernel.org>
CC:     <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, Even <chenyuwen1@meizu.com>
Subject: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Date:   Sat, 25 Jun 2022 21:18:09 +0800
Message-ID: <20220625131809.6081-1-chenyuwen1@meizu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.255.36]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user mounts the erofs second times, the decompression thread
may hung. The problem happens due to a sequence of steps like the
following:

1) Task A called z_erofs_load_lzma_config which obtain all of the node
   from the z_erofs_lzma_head.

2) At this time, task B called the z_erofs_lzma_decompress and wanted to
   get a node. But the z_erofs_lzma_head was empty, the Task B had to
   sleep.

3) Task A release nodes and push nodes into the z_erofs_lzma_head. But
   task B was still sleeping.

One example report when the hung happens:
task:kworker/u3:1 state:D stack:14384 pid: 86 ppid: 2 flags:0x00004000
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 __schedule+0x281/0x760
 schedule+0x49/0xb0
 z_erofs_lzma_decompress+0x4bc/0x580
 ? cpu_core_flags+0x10/0x10
 z_erofs_decompress_pcluster+0x49b/0xba0
 ? __update_load_avg_se+0x2b0/0x330
 ? __update_load_avg_se+0x2b0/0x330
 ? update_load_avg+0x5f/0x690
 ? update_load_avg+0x5f/0x690
 ? set_next_entity+0xbd/0x110
 ? _raw_spin_unlock+0xd/0x20
 z_erofs_decompress_queue.isra.0+0x2e/0x50
 z_erofs_decompressqueue_work+0x30/0x60
 process_one_work+0x1d3/0x3a0
 worker_thread+0x45/0x3a0
 ? process_one_work+0x3a0/0x3a0
 kthread+0xe2/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>

Signed-off-by: Even <chenyuwen1@meizu.com>
---
 fs/erofs/decompressor_lzma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 05a3063cf2bc..5e59b3f523eb 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 	DBG_BUGON(z_erofs_lzma_head);
 	z_erofs_lzma_head = head;
 	spin_unlock(&z_erofs_lzma_lock);
+	wake_up_all(&z_erofs_lzma_wq);
 
 	z_erofs_lzma_max_dictsize = dict_size;
 	mutex_unlock(&lzma_resize_mutex);
-- 
2.25.1

