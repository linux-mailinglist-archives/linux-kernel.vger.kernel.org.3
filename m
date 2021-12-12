Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46F0471B00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhLLOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:53:56 -0500
Received: from out203-205-221-236.mail.qq.com ([203.205.221.236]:60293 "EHLO
        out203-205-221-236.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhLLOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:53:54 -0500
X-Greylist: delayed 74092 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 09:53:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639320832;
        bh=iYZdxcxe9VY+yNUM+YHAJte4KYDTh4ZgWycVEiQ2c6Y=;
        h=From:To:Cc:Subject:Date;
        b=vhx1GsisJSjQN72RtyleiCLrVi63xIy/KCtse3lkQDGR1Fo6xWXQqNM0A54fcCJFV
         Wow19SxSeYDmnD0V4WspyChZFpEH2RCV2eMoubaS0JIo1cj3OQxGoZTdHOBMAFQwii
         bJANmM1B+DfOwbbRHlRHznMzpCi3NJ9zTdTiPkKA=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id D719A2F8; Sun, 12 Dec 2021 22:53:49 +0800
X-QQ-mid: xmsmtpt1639320829tbpueg3ia
Message-ID: <tencent_CE9983800222FC46C9E9BF12C492592F9705@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkED+5UYiYGfEf03/afmb+7dfQ6nVybJfhhfOJI6vJB51p0g80gJZp
         D1b/+V6Id3tZ18RQUY1B8LEMoB2NOsZeuIHD5v7eiwALzLngSRzE080SJX+LO6SWyJNoeba0goTh
         3xCaItZdN1ejAvOxYScD3XOF3XyRw8rhRnVoYpUr3HMj/9tdAZcGwuPU76QP+eP60kkIFh87+c+a
         9ghfIqhNZ1v3Y2+fx9rAklTFK3W8gSkS6Z1XhsX0Gi6MWdbiSavixEVDe6LqEf44lJJQdXzujyBH
         ZEj4meQ8aYuUzSssMvYqdcXLrEiZPnMRlamYwmFKqt6ggoZIgOUVa6pF5sWtj/jjQQK2NobfxLPd
         PG6Lb45WvP1I39UaZe8iJu9RB2R3ZJGtuGg/rGS8MlLQfS87OOGIs/71yB6wsclk5OuK4BNkugrH
         bl3XGbDGZPxoNyvOe5vGeRi9yvZQ7G3xf0Gval97ePDHoGPvA+EcWr0NxKtHLRlwDufFCH7SzzAZ
         TfqqaF8g3IRS8wZ+M8aoNEIUDOwPwjpq/NvckttHpamXNvMGkHcNQBQewKKWiQguV1OvPvGa8yPU
         LSt9XYHBfvkG1Z1dJb93RT0tcD+hX32xGsmmqg1ygCsPfUtmo/63+yXPcZ/lR0b9LzFS3wDUwA/d
         kqo5gqN1KQK9cfjVIGWpIUnvUd/1mIro/13rA4jDabVEtfoYVkEUAe8Kqo8ZrZ3x9Qy0nYYP/Bwm
         9S2c0m67vxHE2XlaWwJyUn0BVuqA45z/JKNzh8AX3IGi4n5v3miQ/pIvJLuvQzHc2KF6kEX65u2L
         jixKDonjmzxPZfPf0tDEWo8e8fqrdnmFPP//zBxRh2hJegOWcWYatz0VbENFiguyfl57w2ixdQ7k
         7AS38UpDNboNQg2tUEJr8=
From:   xkernel <xkernel.wang@foxmail.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] media: usb: dvb-usb-v2: check the return value of kstrdup()
Date:   Sun, 12 Dec 2021 22:52:24 +0800
X-OQ-MSGID: <20211212145224.2056-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL if some internal memory errors happen, it is
better to check the return value of it. Since the return type of
dvb_usbv2_disconnect() is void, so only raise the error info.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index f1c79f3..a43a310 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -1009,6 +1009,9 @@ void dvb_usbv2_disconnect(struct usb_interface *intf)
 	const char *devname = kstrdup(dev_name(&d->udev->dev), GFP_KERNEL);
 	const char *drvname = d->name;
 
+	if (!devname)
+		dev_err(&d->udev->dev, "%s: kstrdup() failed\n", KBUILD_MODNAME);
+
 	dev_dbg(&d->udev->dev, "%s: bInterfaceNumber=%d\n", __func__,
 			intf->cur_altsetting->desc.bInterfaceNumber);
 
@@ -1023,9 +1026,14 @@ void dvb_usbv2_disconnect(struct usb_interface *intf)
 	kfree(d->priv);
 	kfree(d);
 
-	pr_info("%s: '%s:%s' successfully deinitialized and disconnected\n",
-		KBUILD_MODNAME, drvname, devname);
-	kfree(devname);
+	if (devname) {
+		pr_info("%s: '%s:%s' successfully deinitialized and disconnected\n",
+			KBUILD_MODNAME, drvname, devname);
+		kfree(devname);
+	} else {
+		pr_info("%s: '%s:UNKNOWN' successfully deinitialized and disconnected\n",
+			KBUILD_MODNAME, drvname);
+	}
 }
 EXPORT_SYMBOL(dvb_usbv2_disconnect);
 
-- 
