Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE84DABF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354276AbiCPHoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354269AbiCPHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:44:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DE329AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:43:38 -0700 (PDT)
X-UUID: b8b9268005924c798f11d488ea397757-20220316
X-UUID: b8b9268005924c798f11d488ea397757-20220316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1666183484; Wed, 16 Mar 2022 15:43:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Mar 2022 15:43:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 15:43:29 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] driver core: Prevent overriding async driver of a device before it probe
Date:   Wed, 16 Mar 2022 15:43:28 +0800
Message-ID: <20220316074328.1801-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are 2 matched drivers for a device using
async probe mechanism, the dev->p->async_driver might
be overridden by the last attached driver.
So just skip the later one if the previous matched driver
was not handled by async thread yet.

Below is my use case which having this problem.

Make both driver mmcblk and mmc_test allow async probe,
the dev->p->async_driver will be overridden by the later driver
mmc_test and bind to the device then claim it for testing.
When it happen, mmcblk will never do probe again.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/base/dd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f47cab21430f..f0bd779a4696 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1085,6 +1085,7 @@ static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	__device_driver_lock(dev, dev->parent);
 	drv = dev->p->async_driver;
+	dev->p->async_driver = NULL;
 	ret = driver_probe_device(drv, dev);
 	__device_driver_unlock(dev, dev->parent);
 
@@ -1131,7 +1132,7 @@ static int __driver_attach(struct device *dev, void *data)
 		 */
 		dev_dbg(dev, "probing driver %s asynchronously\n", drv->name);
 		device_lock(dev);
-		if (!dev->driver) {
+		if (!dev->driver && !dev->p->async_driver) {
 			get_device(dev);
 			dev->p->async_driver = drv;
 			async_schedule_dev(__driver_attach_async_helper, dev);
-- 
2.18.0

