Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2B5A0E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiHYKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiHYKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:53:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 158C4AD9A2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:53:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C340D1E80C99;
        Thu, 25 Aug 2022 18:49:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uCOw5JfbVP25; Thu, 25 Aug 2022 18:49:45 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0FE9E1E80C8D;
        Thu, 25 Aug 2022 18:49:45 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] drivers/firmware: kthread_run_on_cpu function using compound effect
Date:   Thu, 25 Aug 2022 18:51:11 +0800
Message-Id: <20220825105111.263808-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kthread_create_on_node()/kthread_bind()/wake_up_process() with
kthread_run_on_cpu() function.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 drivers/firmware/stratix10-svc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index b4081f4d88a3..6931256683bd 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -949,18 +949,16 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	/* first client will create kernel thread */
 	if (!chan->ctrl->task) {
 		chan->ctrl->task =
-			kthread_create_on_node(svc_normal_to_secure_thread,
+			kthread_run_on_cpu(svc_normal_to_secure_thread,
 					      (void *)chan->ctrl,
-					      cpu_to_node(cpu),
-					      "svc_smc_hvc_thread");
+					      cpu,
+					      "svc_smc_hvc_thread_%u");
 			if (IS_ERR(chan->ctrl->task)) {
 				dev_err(chan->ctrl->dev,
 					"failed to create svc_smc_hvc_thread\n");
 				kfree(p_data);
 				return -EINVAL;
 			}
-		kthread_bind(chan->ctrl->task, cpu);
-		wake_up_process(chan->ctrl->task);
 	}
 
 	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
-- 
2.18.2

