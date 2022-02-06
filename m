Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503CB4AB00A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiBFOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbiBFOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:44:20 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F00C043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:44:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so34911052ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AK0LMG8NGazeN34p/4cbhYhjkwamksVdCLRSj/Z+FGc=;
        b=PreNiXFFHB/jRM4lxBxs2d24p6HH2q7a8FvDvK5JPlq8d1MMkNhzKVzq68ycjrO1Ag
         1SyVaY7WdUJWPH7XvDlYuMLKWXd9pgBfOXop9xy/NMdLqIp+G7GBlOzzPROwX0RxArwW
         Q3RZP+kWYkEzSD5zMaMHjX5aohtjWivjFeGws/igN6Bp1aJ5I5eLJBJIQsd3OPZm4NTb
         HxN0u+7NLvKKETJVxIKnXy4dK0xeEWapfzXf70CRVXlky70EfjOf629scOjr7NoMF+xr
         n4uxhGcRp3LqVgqysq2v2eMndWwgsdVz3KuAip1aA7Pdo4lzdoPbWlgiDR5DKJOTdLx0
         GA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AK0LMG8NGazeN34p/4cbhYhjkwamksVdCLRSj/Z+FGc=;
        b=pkvQVYI9IciUYWMChHKtokKz1k8Dge6gpdk/mI9P1HQqF+CB3ezJs6eGd9txPFdxWl
         7FSLx7q4za44G4agKkLsNvwXttz4neWjCgxw20zgHH8QlB0xT08ZkxqcFBWGZqFZtook
         5QnK4am5zqoilXwjyt3f0mhdyN4WjgppZIaL/ABcws88ZICgqNJzDl2eYCSnWNTf5K0+
         g0OIT47OIHFrb3CkIuZCIZEaGqoC8qzSsmEiRSFHR25hijdvzPUCcHAACfoKSJPwvanA
         UvkcixQyfSrn3c40CqiG6cVCQyEC5orXiHweZbehBdWtDSUpzAwNQIJ7T8DAKuY3nGXw
         1MhA==
X-Gm-Message-State: AOAM531qm2NWRjUfURtQKrrqLOHWHKAJZVQH3s2iGL7Pu3i7r5/ipmXl
        mRPBJ8+KYxSruMbu7AC3PZw=
X-Google-Smtp-Source: ABdhPJxtKt9R9YoNCxwfwJ9R7MWdaqi4SEZ92bue8+F5vtmHupCeKuI/jTG9YapZjZvowkBoEpQGCg==
X-Received: by 2002:a17:907:8a26:: with SMTP id sc38mr6587125ejc.338.1644158657157;
        Sun, 06 Feb 2022 06:44:17 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id fi3sm458388ejc.168.2022.02.06.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:44:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove UsbBulkOutSize from struct hal_data_8188e
Date:   Sun,  6 Feb 2022 15:44:07 +0100
Message-Id: <20220206144407.8397-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UsbBulkOutSize in struct hal_data_8188e is only used to set a local
variable in rtl8188eu_xmitframe_complete(). Set the local variable
directly and remove UsbBulkOutSize from the hal_data_8188e structure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c   | 9 +++++++--
 drivers/staging/r8188eu/hal/usb_halinit.c      | 8 +-------
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 2 --
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 94dafc7c1ad0..205a392a0ad3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -382,7 +382,7 @@ static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
 
 s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 {
-	struct hal_data_8188e *haldata = &adapt->haldata;
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
 	struct xmit_frame *pxmitframe = NULL;
 	struct xmit_frame *pfirstframe = NULL;
 
@@ -396,13 +396,18 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 	u32 pbuf_tail;	/*  last pkt tail */
 	u32 len;	/*  packet length, except TXDESC_SIZE and PKT_OFFSET */
 
-	u32 bulksize = haldata->UsbBulkOutSize;
+	u32 bulksize;
 	u8 desc_cnt;
 	u32 bulkptr;
 
 	/*  dump frame variable */
 	u32 ff_hwaddr;
 
+	if (pdvobjpriv->ishighspeed)
+		bulksize = USB_HIGH_SPEED_BULK_SIZE;
+	else
+		bulksize = USB_FULL_SPEED_BULK_SIZE;
+
 	/*  check xmitbuffer is ok */
 	if (!pxmitbuf) {
 		pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index f21b910bd88d..1a8e085ca5da 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -45,13 +45,7 @@ static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPi
 
 void rtl8188eu_interface_configure(struct adapter *adapt)
 {
-	struct hal_data_8188e *haldata = &adapt->haldata;
-	struct dvobj_priv	*pdvobjpriv = adapter_to_dvobj(adapt);
-
-	if (pdvobjpriv->ishighspeed)
-		haldata->UsbBulkOutSize = USB_HIGH_SPEED_BULK_SIZE;/* 512 bytes */
-	else
-		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
 
 	HalUsbSetQueuePipeMapping8188EUsb(adapt, pdvobjpriv->RtNumOutPipes);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index c323476f5936..e97575dd1edc 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -171,8 +171,6 @@ struct hal_data_8188e {
 	/*  Auto FSM to Turn On, include clock, isolation, power control
 	 *  for MAC only */
 	u8	bMacPwrCtrlOn;
-
-	u32	UsbBulkOutSize;
 };
 
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
-- 
2.34.1

