Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65C4CCA9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiCDAMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiCDAMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:12:31 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6058A3EABB;
        Thu,  3 Mar 2022 16:11:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V69QsyJ_1646352701;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V69QsyJ_1646352701)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Mar 2022 08:11:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mani@kernel.org
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] bus: mhi: ep: Fix an ignored error return from ida_alloc()
Date:   Fri,  4 Mar 2022 08:11:39 +0800
Message-Id: <20220304001139.95082-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to ida_alloc() is int, it can be a negative
error code, however this is being assigned to an unsigned int variable
'mhi_cntrl->index', so assign the value to 'ret' concurrently to solve
this problem without affecting other functions.

Eliminate the following coccicheck warning:
./drivers/bus/mhi/ep/main.c:1422:5-21: WARNING: Unsigned expression
compared with zero: mhi_cntrl -> index < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/bus/mhi/ep/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 3e98107f08c4..b27e90d97029 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1418,11 +1418,9 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_ep_mmio_set_env(mhi_cntrl, MHI_EE_AMSS);
 
 	/* Set controller index */
-	mhi_cntrl->index = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
-	if (mhi_cntrl->index < 0) {
-		ret = mhi_cntrl->index;
+	mhi_cntrl->index = ret = ida_alloc(&mhi_ep_cntrl_ida, GFP_KERNEL);
+	if (ret < 0)
 		goto err_destroy_wq;
-	}
 
 	irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
 	ret = request_irq(mhi_cntrl->irq, mhi_ep_irq, IRQF_TRIGGER_HIGH,
-- 
2.20.1.7.g153144c

