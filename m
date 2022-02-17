Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5712A4B97DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiBQEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:50:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiBQEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:50:53 -0500
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 20:50:39 PST
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F1929ADED;
        Wed, 16 Feb 2022 20:50:38 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 21H4dsXQ007777-21H4dsXT007777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 17 Feb 2022 12:40:01 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: hdpvr: call flush_work only if initialized
Date:   Thu, 17 Feb 2022 12:39:40 +0800
Message-Id: <20220217043950.749343-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

flush_work will throw one WARN if worker->func is NULL. So we should always
initialize one worker before calling flush_work. When hdpvr_probe does not
initialize its worker, the hdpvr_disconnect will encounter one WARN. The
stack trace is in the following:

 hdpvr_disconnect+0xb8/0xf2 drivers/media/usb/hdpvr/hdpvr-core.c:425
 usb_unbind_interface+0xbf/0x3a0 drivers/usb/core/driver.c:458
 __device_release_driver drivers/base/dd.c:1206 [inline]
 device_release_driver_internal+0x22a/0x230 drivers/base/dd.c:1237
 bus_remove_device+0x108/0x160 drivers/base/bus.c:529
 device_del+0x1fe/0x510 drivers/base/core.c:3592
 usb_disable_device+0xd1/0x1d0 drivers/usb/core/message.c:1419
 usb_disconnect+0x109/0x330 drivers/usb/core/hub.c:2228

Fix this by adding a sanity check of the worker before flush_work.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/media/usb/hdpvr/hdpvr-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index 52e05a69c46e..d102b459d45d 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -422,7 +422,8 @@ static void hdpvr_disconnect(struct usb_interface *interface)
 	mutex_unlock(&dev->io_mutex);
 	v4l2_device_disconnect(&dev->v4l2_dev);
 	msleep(100);
-	flush_work(&dev->worker);
+	if (dev->worker.func)
+		flush_work(&dev->worker);
 	mutex_lock(&dev->io_mutex);
 	hdpvr_cancel_queue(dev);
 	mutex_unlock(&dev->io_mutex);
-- 
2.25.1

