Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B055D925
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiF0Gk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiF0Gkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:40:49 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0C2BF9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:40:46 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 27 Jun
 2022 14:40:44 +0800
Received: from chenyuwen-VirtualBox.meizu.com (172.16.32.26) by
 IT-EXMB-1-125.meizu.com (172.16.1.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 27 Jun 2022 14:40:43 +0800
From:   Yuwen Chen <chenyuwen1@meizu.com>
To:     <hsiangkao@linux.alibaba.com>
CC:     <chenyuwen1@meizu.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <xiang@kernel.org>,
        <zbestahu@gmail.com>
Subject: [PATCH] erofs: wake up all waiters after z_erofs_lzma_head ready
Date:   Mon, 27 Jun 2022 06:40:41 +0800
Message-ID: <20220626224041.4288-1-chenyuwen1@meizu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YrlLA5kDpprL0klA@B-P7TQMD6M-0146.local>
References: <YrlLA5kDpprL0klA@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.32.26]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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

