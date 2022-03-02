Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E34C9A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiCBBjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCBBjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:39:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3D6F54F88
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:38:34 -0800 (PST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWs2Tyh5iZ_UAAA--.3742S2;
        Wed, 02 Mar 2022 09:38:32 +0800 (CST)
From:   wangjianxing <wangjianxing@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangjianxing <wangjianxing@loongson.cn>
Subject: [PATCH 1/1] mm/page_alloc: add scheduling point to free_unref_page_list
Date:   Tue,  1 Mar 2022 20:38:25 -0500
Message-Id: <20220302013825.2290315-1-wangjianxing@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxWs2Tyh5iZ_UAAA--.3742S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4UXrWfGFWUKF4UJr43Jrb_yoWDtFX_Z3
        47uw1xCr15KrW3CF1qyan3Ww4S934rCw4UWwsruFy5Ja4UtF1vvayIy3Z3WF18WrWxWay3
        G34kAFZxCw17JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free a large list of pages maybe cause rcu_sched starved on
non-preemptible kernels

rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
[...]
Call Trace:
  free_unref_page_list+0x19c/0x270
  release_pages+0x3cc/0x498
  tlb_flush_mmu_free+0x44/0x70
  zap_pte_range+0x450/0x738
  unmap_page_range+0x108/0x240
  unmap_vmas+0x74/0xf0
  unmap_region+0xb0/0x120
  do_munmap+0x264/0x438
  vm_munmap+0x58/0xa0
  sys_munmap+0x10/0x20
  syscall_common+0x24/0x38

Signed-off-by: wangjianxing <wangjianxing@loongson.cn>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6..1b96421c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3479,6 +3479,9 @@ void free_unref_page_list(struct list_head *list)
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
 			local_unlock_irqrestore(&pagesets.lock, flags);
+
+			cond_resched();
+
 			batch_count = 0;
 			local_lock_irqsave(&pagesets.lock, flags);
 		}
-- 
2.27.0

