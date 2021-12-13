Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1B4721F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhLMHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:50:14 -0500
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252]:58891 "EHLO
        out162-62-57-252.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231407AbhLMHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639381808;
        bh=+9zpwVH7/8zpy6rB3XifZdvk+wYtdwLHCiHdBMgpeBk=;
        h=From:To:Cc:Subject:Date;
        b=GPSvgffKi+y6N4UbbQOSYSO7pQ+sPLa5+c+EMxjeWEObXPNl2ck+ZHjB+MHBG2GEX
         gQwYt3GbwzDDYxJpGrWnSsrMfKzzK+E55FpyH/2yfGO9zC6/rHBrKEeFHoQx3fymZ9
         96H7LealnwJXj27PY80Q+e3v0qAiiRXc++C6kcHw=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id C382A62D; Mon, 13 Dec 2021 15:48:56 +0800
X-QQ-mid: xmsmtpt1639381736tg4k1nbca
Message-ID: <tencent_07FF16C8253370EE140700057438B052FD06@qq.com>
X-QQ-XMAILINFO: M3vv73qU6a4um1Sg2+RZMQQDAHB9eIxlliAtOeUzIymUvINy+AUk7+XKJ9qT/G
         xxdwtlWgjQva0FOABEi4WzwmXq+1ig+cXlc2EwSKwcd7x0dNocuk8ouiBIsj7sJ3bHG8bgFQMfhf
         C1Wz9yN0n1ky2dDMXVBsD/TgKNoCd89T5L9QqawknU41PJIMFEm8CkHHlIR2J6b1c/5BkHqE/8VH
         bGtvuq12CGF97sHkxY16jAs1WO9f3FJ054b2HPCH2VEqJe4xAM9KMMQ09oxyXj2NRQnOZMSK+38Q
         lyBhdSa+dIAKRx3hRQE4Fg7jC1g8c9KyG+4lhsabjRsXuAgmBsb0cbomxSICMEV5BaWSUY3eMraT
         mVs1D7cuFvwQcfCkRW4vFSk9Tm4SF4CMkH8AvR3DEWw3PVwfJ3pNeY+W4Q73s4D8VfLDBwbdGrkx
         sv/648Ps2CQfp0NCy+RJMY8rqu+hc0yCBAmriihX8k9edW0tkjplphxZtjQLsvJvRG2qZ/LR54RQ
         ZQzQ7lkpVUCxkQeTlkvKL4P9PTjJ4/4fy+fxT7xPCktSiPsPZCI/m4ol/FiuOU1El8Q/LQaee0z5
         qtwf6jmOoCasb9ZoU0NvtC39NPxJ89r1d4lYbhRRwPQOdHw6UdEVRsbn4csmEA5SqSnkBKX5xp8H
         sQakiWCDQgM9xPS+lpZ4JTqBGlJUoTzJMR8QkUSxrndWUccAyHv9iUSGBydkcbDfY/kKajm1/o/k
         OnPh+pNPHrSuKgjQjSzHjmFHdrR1u8G5o9acvyykxe7tnEZeq0phAc9c0kWjk6eOxBI8wMtT73Tr
         nYAi9Y2IXxPant+saD28CnvbAAakOR8nDdi+H1tmRXYMwtf2Xs/HTFszqGc45tR+eVq4QzpTHH0s
         oVhQrOjKZ2vjs1zhFlVwg=
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] media: usb: dvb-usb-v2: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 15:48:33 +0800
X-OQ-MSGID: <20211213074833.4286-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: Compare with the last email, this one is using my full name.
kstrdup() returns NULL if some internal memory errors happen, it is
better to check the return value of it. Since the return type of
dvb_usbv2_disconnect() is void, so only raise the error info.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
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
