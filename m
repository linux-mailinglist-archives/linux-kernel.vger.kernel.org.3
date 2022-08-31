Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E217D5A76FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiHaHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHaHBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:01:41 -0400
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 00:01:39 PDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06B1767C82
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:01:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACniTqEBQ9jiJkUAg--.45336S2;
        Wed, 31 Aug 2022 14:53:56 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] lkdtm: Add checks after calling kmalloc and vmalloc
Date:   Wed, 31 Aug 2022 14:53:55 +0800
Message-Id: <20220831065355.2125181-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACniTqEBQ9jiJkUAg--.45336S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW3ZrykZryDJFWktFy8uFg_yoWkArb_Gr
        4rAr17XryYya48C347KF1rZr4FkF4kXFsIkasaqwsIqFy7Jr4rJ3409r45AwsxZrWFkFnr
        Ww4DJ3s29r12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU24E_UUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the memory allocation,
it should be better to check the return value after
calling kmalloc and vmalloc and skip the execute_location
if fails.

Fixes: cc33c537c12f ("lkdtm: add "EXEC_*" triggers")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/misc/lkdtm/perms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index b93404d65650..9ba927d74973 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -180,14 +180,16 @@ static void lkdtm_EXEC_STACK(void)
 static void lkdtm_EXEC_KMALLOC(void)
 {
 	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
-	execute_location(kmalloc_area, CODE_WRITE);
+	if (kmalloc_area)
+		execute_location(kmalloc_area, CODE_WRITE);
 	kfree(kmalloc_area);
 }
 
 static void lkdtm_EXEC_VMALLOC(void)
 {
 	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
-	execute_location(vmalloc_area, CODE_WRITE);
+	if (vmalloc_area)
+		execute_location(vmalloc_area, CODE_WRITE);
 	vfree(vmalloc_area);
 }
 
-- 
2.25.1

