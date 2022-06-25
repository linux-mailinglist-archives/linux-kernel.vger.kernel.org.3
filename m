Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45D855A83A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiFYI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiFYI6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:58:14 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF35FC13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=X6rIM
        tLO3uci6xsCn9+sGkQf0y5oJPBg8DN1+ZQ9zq8=; b=W8ozts2K5V858tq/jX0Gk
        enaspmJgs5Ds/nFZxCarhItJEkaD5+CItXNoXzR6GaGLcdpr09DaZnUH+Ei5vUsT
        558WKr5ma8owv1+Yw4QY4sZb5QZ3UfbIS/3Dca2EPoPrGCJx3sJfQs3R50xiaRbB
        WRHaQDFUHgaOe1bR0pJeuk=
Received: from localhost.localdomain (unknown [120.231.117.174])
        by smtp7 (Coremail) with SMTP id DsmowACHx_8EzrZiFAfLDw--.2621S2;
        Sat, 25 Jun 2022 16:57:40 +0800 (CST)
From:   Even <cheny_wen@126.com>
To:     xiang@kernel.org
Cc:     chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Even <chenyuwen1@meizu.com>
Subject: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Date:   Sat, 25 Jun 2022 16:57:38 +0800
Message-Id: <20220625085738.12834-1-cheny_wen@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowACHx_8EzrZiFAfLDw--.2621S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArW3uF18Ww1fKw1UZFW7CFg_yoW8Zw1kpr
        nIkFyxKrWxWrn8u3yfJr13Gry7CrWSgr48G3s7tF93Xay5JF4xXw18tFnFgF4UWr90v39Y
        ya1j9w17J34F9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bj_-PUUUUU=
X-Originating-IP: [120.231.117.174]
X-CM-SenderInfo: xfkh05hbzh0qqrswhudrp/1tbiFAUrhl86VkqFxAAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even <chenyuwen1@meizu.com>

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

