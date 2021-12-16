Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA24767A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhLPB77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:59:59 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:57862 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229652AbhLPB77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:59:59 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowACngUCFnbphzRJgAw--.31286S2;
        Thu, 16 Dec 2021 09:59:33 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] lkdtm: potential dereference of null pointer
Date:   Thu, 16 Dec 2021 09:59:32 +0800
Message-Id: <20211216015932.258088-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACngUCFnbphzRJgAw--.31286S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xtrWUArW7ur47AFWxCrg_yoWDArb_Cr
        45Jr12qry7Ga4kCr47tryrXry0kF4qqFsayasaqr1aqF9rGryfJ34jvr15A39xAryrCFnr
        G3yDJas7XF12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_KwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5kucDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of kmalloc() needs to be checked.
To avoid use in execute_location() in case of the failure of alloc.

Fixes: 039a1c42058d ("lkdtm: Relocate code to subdirectory")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/misc/lkdtm/perms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..ef87d9cc2e96 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -138,6 +138,8 @@ void lkdtm_EXEC_STACK(void)
 void lkdtm_EXEC_KMALLOC(void)
 {
 	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
+	if (!kmalloc_area)
+		return;
 	execute_location(kmalloc_area, CODE_WRITE);
 	kfree(kmalloc_area);
 }
@@ -145,6 +147,8 @@ void lkdtm_EXEC_KMALLOC(void)
 void lkdtm_EXEC_VMALLOC(void)
 {
 	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
+	if (!vmalloc_area)
+		return;
 	execute_location(vmalloc_area, CODE_WRITE);
 	vfree(vmalloc_area);
 }
-- 
2.25.1

