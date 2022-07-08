Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84256B054
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiGHCAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:59:59 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB073905;
        Thu,  7 Jul 2022 18:59:56 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id CYP00149;
        Fri, 08 Jul 2022 09:59:49 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 8 Jul 2022 09:59:50 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] bus: mhi: ep: Check dev_set_name() return value
Date:   Thu, 7 Jul 2022 21:59:48 -0400
Message-ID: <20220708015948.4091-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022708095950ed6942c3ae8fce442d2f8adff4aa7a25
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/bus/mhi/ep/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 40109a79017a..1dc8a3557a46 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1242,9 +1242,13 @@ static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id)
 
 	/* Channel name is same for both UL and DL */
 	mhi_dev->name = mhi_chan->name;
-	dev_set_name(&mhi_dev->dev, "%s_%s",
+	ret = dev_set_name(&mhi_dev->dev, "%s_%s",
 		     dev_name(&mhi_cntrl->mhi_dev->dev),
 		     mhi_dev->name);
+	if (ret) {
+		put_device(&mhi_dev->dev);
+		return ret;
+	}
 
 	ret = device_add(&mhi_dev->dev);
 	if (ret)
@@ -1408,7 +1412,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_irq;
 	}
 
-	dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
+	ret = dev_set_name(&mhi_dev->dev, "mhi_ep%u", mhi_cntrl->index);
+	if (ret)
+		goto err_put_dev;
+
 	mhi_dev->name = dev_name(&mhi_dev->dev);
 	mhi_cntrl->mhi_dev = mhi_dev;
 
-- 
2.27.0

