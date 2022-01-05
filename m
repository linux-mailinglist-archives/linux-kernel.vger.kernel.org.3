Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B4484F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiAEI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:27:08 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:54822 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238495AbiAEI06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:26:58 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAC3TaY7VtVhlVTRBQ--.47155S2;
        Wed, 05 Jan 2022 16:26:35 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     mika.westerberg@linux.intel.com
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] thunderbolt: Check for null pointer after calling kmemdup in icm_handle_event
Date:   Wed,  5 Jan 2022 16:26:34 +0800
Message-Id: <20220105082634.2410596-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3TaY7VtVhlVTRBQ--.47155S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWxGrWktFyxAFyxCrWDCFg_yoWDCFc_C3
        s5urnFqw1FkFnakwnrJr15ZayftFWkZr1S9FnY93s3Jr9xAFyru34jvrn8Gr4fJFZ8XF9r
        CrZFvFWfZrnrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbqQ6JUUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the allocation, kmemdup() may return NULL
pointer.
Like alloc_switch(), it might be better to check it.
Therefore, icm_handle_event() should also check the return value of
kmemdup().
If fails, just free 'n' and directly return is enough, same as the way
to handle the failure of kmalloc().

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/thunderbolt/icm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 2f30b816705a..514a77a02985 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1739,6 +1739,11 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 
 	INIT_WORK(&n->work, icm_handle_notification);
 	n->pkg = kmemdup(buf, size, GFP_KERNEL);
+	if (!n->pkg) {
+		kfree(n);
+		return;
+	}
+
 	n->tb = tb;
 
 	queue_work(tb->wq, &n->work);
-- 
2.25.1

