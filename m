Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2035F55DBED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbiF1DpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbiF1DpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:45:22 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD09324BF7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:45:13 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.190.70.91])
        by mail-app2 (Coremail) with SMTP id by_KCgCnvEA6ebpic5u+Ag--.56483S2;
        Tue, 28 Jun 2022 11:45:07 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v7] devcoredump: change gfp_t parameter of kzalloc to GFP_KERNEL
Date:   Tue, 28 Jun 2022 11:44:58 +0800
Message-Id: <20220628034458.17384-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCnvEA6ebpic5u+Ag--.56483S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWkJr4rXr1DGr1UCr1xZrb_yoW8XrWxpF
        4rGas2yFZ5Gr4S9a4DWF4fW3W5Aw17JFW8Wa4j93yUuws3Ar17CrWDtFW5Aw1DX34rtFW5
        XF15Jw18uFy7taUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAggPAVZdtabqkgAcs4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_coredumpv() and dev_coredumpm() could not be used in atomic
context, because they call kvasprintf_const() and kstrdup() with
GFP_KERNEL parameter. The process is shown below:

dev_coredumpv(.., gfp_t gfp)
  dev_coredumpm(.., gfp_t gfp)
    kzalloc(.., gfp);
    dev_set_name
      kobject_set_name_vargs
        kvasprintf_const(GFP_KERNEL, ...); //may sleep
          kstrdup(s, GFP_KERNEL); //may sleep

This patch changes the gfp_t parameter of kzalloc() in dev_coredumpm() to
GFP_KERNEL in order to show they could not be used in atomic context.

What's more, this patch does not remove the gfp_t parameter in
dev_coredumpv() and dev_coredumpm() in order that it will not influence
other new users that are added in other trees.

Fixes: 833c95456a70 ("device coredump: add new device coredump class")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v7:
  - change gfp_t parameter of kzalloc in dev_coredumpm() to GFP_KERNEL.

 drivers/base/devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d6bb8..cf60aacf8a8 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -268,7 +268,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	if (!try_module_get(owner))
 		goto free;
 
-	devcd = kzalloc(sizeof(*devcd), gfp);
+	devcd = kzalloc(sizeof(*devcd), GFP_KERNEL);
 	if (!devcd)
 		goto put_module;
 
-- 
2.17.1

