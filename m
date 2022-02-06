Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CCF4AB122
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbiBFR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345435AbiBFR7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:59:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9FC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:59:41 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGlp4-0002n8-1H; Sun, 06 Feb 2022 18:59:38 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: remove ishighspeed from dvobj_priv
Date:   Sun,  6 Feb 2022 18:59:25 +0100
Message-Id: <20220206175925.461426-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206175925.461426-1-martin@kaiser.cx>
References: <20220206175925.461426-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to store the usb device speed in struct dvobj_priv.

We can read the speed from struct usb_device. dvobj_priv has a pointer
to the usb_device.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_iol.c      | 4 +++-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 4 ++--
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/include/usb_ops.h   | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 8 --------
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 923da2a9f6ae..26f2a6fc3f38 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -68,8 +68,10 @@ bool rtw_IOL_applied(struct adapter  *adapter)
 	if (1 == adapter->registrypriv.fw_iol)
 		return true;
 
-	if ((2 == adapter->registrypriv.fw_iol) && (!adapter_to_dvobj(adapter)->ishighspeed))
+	if ((2 == adapter->registrypriv.fw_iol) &&
+	    (!(adapter_to_dvobj(adapter)->pusbdev->speed == USB_SPEED_HIGH)))
 		return true;
+
 	return false;
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 03966a1e247e..e3a28c443f24 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -48,7 +48,7 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct dvobj_priv	*pdvobjpriv = adapter_to_dvobj(adapt);
 
-	if (pdvobjpriv->ishighspeed)
+	if (pdvobjpriv->pusbdev->speed == USB_SPEED_HIGH)
 		haldata->UsbBulkOutSize = USB_HIGH_SPEED_BULK_SIZE;/* 512 bytes */
 	else
 		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
@@ -105,7 +105,7 @@ static void _InitInterrupt(struct adapter *Adapter)
 	/*  1; Use bulk endpoint to upload interrupt pkt, */
 	usb_opt = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
 
-	if (!adapter_to_dvobj(Adapter)->ishighspeed)
+	if (!(adapter_to_dvobj(Adapter)->pusbdev->speed == USB_SPEED_HIGH))
 		usb_opt = usb_opt & (~INT_BULK_SEL);
 	else
 		usb_opt = usb_opt | (INT_BULK_SEL);
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 618a6529192b..894e70a0d506 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -137,7 +137,6 @@ struct dvobj_priv {
 
 /*-------- below is for USB INTERFACE --------*/
 
-	u8	ishighspeed;
 	u8	RtNumOutPipes;
 
 	struct usb_interface *pusbintf;
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 0a1155bbc7b8..62e4706c0497 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -55,7 +55,7 @@ static inline u8 rtw_usb_bulk_size_boundary(struct adapter *padapter,
 	u8 rst = true;
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(padapter);
 
-	if (pdvobjpriv->ishighspeed)
+	if (pdvobjpriv->pusbdev->speed == USB_SPEED_HIGH)
 		rst = (0 == (buf_len) % USB_HIGH_SPEED_BULK_SIZE) ?
 		      true : false;
 	else
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 10c33e2ae3bc..cd7f28d25c47 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -117,14 +117,6 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	if (rt_num_in_pipes != 1)
 		goto err;
 
-	if (pusbd->speed == USB_SPEED_HIGH) {
-		pdvobjpriv->ishighspeed = true;
-		DBG_88E("USB_SPEED_HIGH\n");
-	} else {
-		pdvobjpriv->ishighspeed = false;
-		DBG_88E("NON USB_SPEED_HIGH\n");
-	}
-
 	/* 3 misc */
 	rtw_reset_continual_urb_error(pdvobjpriv);
 
-- 
2.30.2

