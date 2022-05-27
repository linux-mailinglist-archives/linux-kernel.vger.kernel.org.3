Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD8535E03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiE0KQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350881AbiE0KQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:16:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7FDE80;
        Fri, 27 May 2022 03:16:12 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L8gfN17CNzgYpP;
        Fri, 27 May 2022 18:15:08 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:16:10 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:16:10 +0800
From:   keliu <liuke94@huawei.com>
To:     <dmitry.torokhov@gmail.com>, <marcoshalano@gmail.com>,
        <michael@michaelcullen.name>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: input:  Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 10:37:40 +0000
Message-ID: <20220527103740.3442548-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/input/input.c         | 8 ++++----
 drivers/input/joystick/xpad.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 1365c9dfb5f2..1e4a275795f9 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2618,15 +2618,15 @@ int input_get_new_minor(int legacy_base, unsigned int legacy_num,
 	 * locking is needed here.
 	 */
 	if (legacy_base >= 0) {
-		int minor = ida_simple_get(&input_ida,
+		int minor = ida_alloc_range(&input_ida,
 					   legacy_base,
-					   legacy_base + legacy_num,
+					   legacy_base + legacy_num - 1,
 					   GFP_KERNEL);
 		if (minor >= 0 || !allow_dynamic)
 			return minor;
 	}
 
-	return ida_simple_get(&input_ida,
+	return ida_alloc_range(&input_ida,
 			      INPUT_FIRST_DYNAMIC_DEV, INPUT_MAX_CHAR_DEVICES,
 			      GFP_KERNEL);
 }
@@ -2641,7 +2641,7 @@ EXPORT_SYMBOL(input_get_new_minor);
  */
 void input_free_minor(unsigned int minor)
 {
-	ida_simple_remove(&input_ida, minor);
+	ida_free(&input_ida, minor);
 }
 EXPORT_SYMBOL(input_free_minor);
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..fafc0d5703dc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1456,7 +1456,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->pad_nr = ida_simple_get(&xpad_pad_seq, 0, 0, GFP_KERNEL);
+	xpad->pad_nr = ida_alloc(&xpad_pad_seq, GFP_KERNEL);
 	if (xpad->pad_nr < 0) {
 		error = xpad->pad_nr;
 		goto err_free_mem;
@@ -1479,7 +1479,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	return 0;
 
 err_free_id:
-	ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
+	ida_free(&xpad_pad_seq, xpad->pad_nr);
 err_free_mem:
 	kfree(led);
 	xpad->led = NULL;
@@ -1492,7 +1492,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 
 	if (xpad_led) {
 		led_classdev_unregister(&xpad_led->led_cdev);
-		ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
+		ida_free(&xpad_pad_seq, xpad->pad_nr);
 		kfree(xpad_led);
 	}
 }
-- 
2.25.1

