Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3571F58F9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiHKJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHKJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:03:26 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8FE167E1;
        Thu, 11 Aug 2022 02:03:23 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 27B934X8019956-27B934XC019956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2022 17:03:16 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] USB: trancevibrator: simplify tv_probe
Date:   Thu, 11 Aug 2022 17:02:09 +0800
Message-Id: <20220811090213.35899-2-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811090213.35899-1-dzm91@hust.edu.cn>
References: <20220811090213.35899-1-dzm91@hust.edu.cn>
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

The function tv_probe does not need to invoke kfree when the
allocation fails. So let's simplify the code of tv_probe.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/usb/misc/trancevibrator.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
index 55cb63652eda..30d4d774d448 100644
--- a/drivers/usb/misc/trancevibrator.c
+++ b/drivers/usb/misc/trancevibrator.c
@@ -84,22 +84,15 @@ static int tv_probe(struct usb_interface *interface,
 {
 	struct usb_device *udev = interface_to_usbdev(interface);
 	struct trancevibrator *dev;
-	int retval;
 
 	dev = kzalloc(sizeof(struct trancevibrator), GFP_KERNEL);
-	if (!dev) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	dev->udev = usb_get_dev(udev);
 	usb_set_intfdata(interface, dev);
 
 	return 0;
-
-error:
-	kfree(dev);
-	return retval;
 }
 
 static void tv_disconnect(struct usb_interface *interface)
-- 
2.35.1

