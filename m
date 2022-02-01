Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B574A58B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiBAInk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiBAInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738EC061401
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:43:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u18so32326160edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDq463DNVx/yVKZ/LadmFf4Y3fkl66W4uW7inBK8Rkc=;
        b=E+2wTffkrVC/iGBhzKfuD7TRLzeyBo7Xdig565Z4e3Zc58OqmVaQN7Z8Nb4re9HpYu
         2hg6kOFds4juLeqHaMO9uxNidkj80QvtgfskqsA8bqEdWO2cWLHViGidVL+VATjEWRr6
         oLr9zPrZ10cz9kPGHKceXqdg/qNSdlKs+XdwBJljPLF3IvsbiAULYCkjDal5iEk7Cbgm
         mqoGSufeZK4MgpN+5OAiUgQ6z5xtIqaidNcpuV9n/+DPUiTUmH2O5wCFkiiZuXgYciJz
         QOnpAMcOLYL9Az2O+Q8qzZlGfoljAwBLbCTwk7Adi2/+xl//GgFD7Udu13+S3T4LdlNQ
         +jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDq463DNVx/yVKZ/LadmFf4Y3fkl66W4uW7inBK8Rkc=;
        b=mIuDG8fZMwI2YovrQobw7Pqnu6QHGju5QjICnLdLC53ZcicwqN3+dxc2UfsOqExPBf
         RGsMF7cTJfZ4bvhAw5eV30FWwpJL+vk1l1P3nhTCR/xk4hVsU3Ci+HLOQNG5oJKXbvVH
         a6is02+lsGa2Wj4KXUQW9/GbhPGd+fciWa8+Fsg45lN3t1YZi/aUF22yywhEESXa5z5p
         n2cInzlvKA1TUgzohAgCD2isdt2SZmQ7TFqz/dQYPECnkmHcpZ5vt2ELi4NRofc14ske
         pYfCzaj2q3rTuJd/Qgxpv8El40Ns6WmpaPCsK1MJ91hz7L6y49is/b3puDNEpIGJ/ul0
         GEXA==
X-Gm-Message-State: AOAM531Fp0MrPUXjczQ/5fRT6+3y8TlVp8IyuNSGTTejJklBZhrr7ha1
        bvEQ2zAFtxBOP7SopbK5Ciw=
X-Google-Smtp-Source: ABdhPJyqQzkb4f6lJvMfhPBHYgRQmt22p5Q8jsB++VkSFjjhRJkQ2YANIp5uaatl/xXwABi0guHb1A==
X-Received: by 2002:a50:9fc6:: with SMTP id c64mr24255079edf.5.1643704997273;
        Tue, 01 Feb 2022 00:43:17 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id c14sm19123431edy.66.2022.02.01.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:43:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 9/9] staging: r8188eu: remove UsbRxAggPage* from struct hal_data_8188e
Date:   Tue,  1 Feb 2022 09:42:59 +0100
Message-Id: <20220201084259.7497-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201084259.7497-1-straube.linux@gmail.com>
References: <20220201084259.7497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UsbRxAggPageCount and UsbRxAggPageTimeout in struct hal_data_8188e
are set and never changed. Define these constants and remove the
variables from the hal_data_8188e structure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 10 +++-------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  6 +++---
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1d0d58204c68..f21b910bd88d 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -53,9 +53,6 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 	else
 		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
 
-	haldata->UsbRxAggPageCount	= 48; /* uint :128 b 0x0A;	10 = MAX_RX_DMA_BUFFER_SIZE/2/haldata->UsbBulkOutSize */
-	haldata->UsbRxAggPageTimeout	= 0x4; /* 6, absolute time = 34ms/(2^6) */
-
 	HalUsbSetQueuePipeMapping8188EUsb(adapt, pdvobjpriv->RtNumOutPipes);
 }
 
@@ -433,7 +430,6 @@ usb_AggSettingRxUpdate(
 		struct adapter *Adapter
 	)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
 	u8 valueDMA;
 	u8 valueUSB;
 
@@ -446,8 +442,8 @@ usb_AggSettingRxUpdate(
 	rtw_write8(Adapter, REG_TRXDMA_CTRL, valueDMA);
 	rtw_write8(Adapter, REG_USB_SPECIAL_OPTION, valueUSB);
 
-	rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-	rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, haldata->UsbRxAggPageTimeout);
+	rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, USB_RXAGG_PAGE_COUNT);
+	rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, USB_RXAGG_PAGE_TIMEOUT);
 }
 
 static void InitUsbAggregationSetting(struct adapter *Adapter)
@@ -1314,7 +1310,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 threshold = *((u8 *)val);
 			if (threshold == 0)
-				threshold = haldata->UsbRxAggPageCount;
+				threshold = USB_RXAGG_PAGE_COUNT;
 			rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, threshold);
 		}
 		break;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 94678dad37ce..e3c028ff20c7 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -141,6 +141,9 @@ struct txpowerinfo24g {
 
 #define EFUSE_PROTECT_BYTES_BANK	16
 
+#define USB_RXAGG_PAGE_COUNT	48
+#define USB_RXAGG_PAGE_TIMEOUT	0x4
+
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
 	/* current WIFI_PHY values */
@@ -205,9 +208,6 @@ struct hal_data_8188e {
 	u8	bMacPwrCtrlOn;
 
 	u32	UsbBulkOutSize;
-
-	u8	UsbRxAggPageCount;	/*  8192C DMA page count */
-	u8	UsbRxAggPageTimeout;
 };
 
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
-- 
2.34.1

