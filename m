Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9A4A58B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiBAInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiBAInR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF03C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:43:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n10so32532311edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+khK+X1Tp7N7uLEEkyh1T4TAhKh+Nifr7JoDeeEAPdc=;
        b=jBtKgJ3XTY5GVjqULjidEebnr4VyPiFDrmgXJ0pQtyd/6nQrBXgIVs9lYl0Y0HkHHA
         OckP0DnMaoZKU/lyAam2Bd7LDNdmWnddkpYV0FazV6mGNZp6l4yYLGLgWnk+Lpj188lc
         SjGjZOHb+QHGYsI07RuGSpgR1ShZJxIRmgx5+nre/tvbeoYfkKNZAaa511ihTp9ZkNV+
         C1wuUSNAM+FxB7/GoQWZ0S9MIsK334LrnFGEhb+aQ78MX9sVlLa4E/AdupPDelV557wc
         Zl7RKmQUAz1TTSLOWpHVsPdzbZQixb1dc3qxgdQGHKuKTM25qecLClkYI6TJ1LBrxwpf
         UUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+khK+X1Tp7N7uLEEkyh1T4TAhKh+Nifr7JoDeeEAPdc=;
        b=PlVb2acPm262/31iKViPrdhYbX3BUb6ocpXH9FYInOSYZWZNTNcgQtyKX2rDo6Psz/
         u/NTUrLs1SZl24msos+JIHAkPAH464UmuZzFZcYtHf0Fku9W/PARSxlfgZq2FJ20yDWM
         2/IXdRe4slRz3dFdAJ3csKWy1y6Mdmog3fDWgqGhkv8cZWJ2dErZOOrulue8YRUX667K
         aGopxgkvQoje3GUpvsGy4o8hTNiIAKbKeaf9x/S6i98iRqWuny6U4r5hA8kkmKutHxxe
         1isbJp3q3JMU+HF5OIFbKLGXCSPDVm2ANg1bEbH3sFbUCltXTIPK2wddR2R7jsmdvRyQ
         yumA==
X-Gm-Message-State: AOAM530Ls9GHyNBVUZb7QWOUcMK3h98MaRI6STtGO3dMw0Ofs2sHijCO
        XBU34A6xVixPaNE9ZvpvboI=
X-Google-Smtp-Source: ABdhPJwROa4jmK1HSSwcC5LuSdZCeZnn57xUSJwfO/ZUIrHB2hCGkPCKpNnxWZdLl/OSyGXyvr1Q8w==
X-Received: by 2002:aa7:c4cd:: with SMTP id p13mr2738450edr.428.1643704995838;
        Tue, 01 Feb 2022 00:43:15 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id c14sm19123431edy.66.2022.02.01.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:43:15 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/9] staging: r8188eu: remove UsbRxAggMode from struct hal_data_8188e
Date:   Tue,  1 Feb 2022 09:42:57 +0100
Message-Id: <20220201084259.7497-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201084259.7497-1-straube.linux@gmail.com>
References: <20220201084259.7497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UsbRxAggMode in struct hal_data_8188e is set to USB_RX_AGG_DMA and
never changed. Remove UsbRxAggMode from the hal_data_8188e structure
and remove related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c     | 46 ++-----------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 14 +-----
 .../staging/r8188eu/include/rtl8188e_hal.h    |  8 ----
 3 files changed, 7 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1c40d5065f51..24c11c666534 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -53,7 +53,6 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 	else
 		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
 
-	haldata->UsbRxAggMode		= USB_RX_AGG_DMA;/*  USB_RX_AGG_DMA; */
 	haldata->UsbRxAggBlockCount	= 8; /* unit : 512b */
 	haldata->UsbRxAggBlockTimeout	= 0x6;
 	haldata->UsbRxAggPageCount	= 48; /* uint :128 b 0x0A;	10 = MAX_RX_DMA_BUFFER_SIZE/2/haldata->UsbBulkOutSize */
@@ -443,50 +442,15 @@ usb_AggSettingRxUpdate(
 	valueDMA = rtw_read8(Adapter, REG_TRXDMA_CTRL);
 	valueUSB = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
 
-	switch (haldata->UsbRxAggMode) {
-	case USB_RX_AGG_DMA:
-		valueDMA |= RXDMA_AGG_EN;
-		valueUSB &= ~USB_AGG_EN;
-		break;
-	case USB_RX_AGG_USB:
-		valueDMA &= ~RXDMA_AGG_EN;
-		valueUSB |= USB_AGG_EN;
-		break;
-	case USB_RX_AGG_MIX:
-		valueDMA |= RXDMA_AGG_EN;
-		valueUSB |= USB_AGG_EN;
-		break;
-	case USB_RX_AGG_DISABLE:
-	default:
-		valueDMA &= ~RXDMA_AGG_EN;
-		valueUSB &= ~USB_AGG_EN;
-		break;
-	}
+	valueDMA |= RXDMA_AGG_EN;
+	valueUSB &= ~USB_AGG_EN;
 
 	rtw_write8(Adapter, REG_TRXDMA_CTRL, valueDMA);
 	rtw_write8(Adapter, REG_USB_SPECIAL_OPTION, valueUSB);
 
-	switch (haldata->UsbRxAggMode) {
-	case USB_RX_AGG_DMA:
-		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, haldata->UsbRxAggPageTimeout);
-		break;
-	case USB_RX_AGG_USB:
-		rtw_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
-		rtw_write8(Adapter, REG_USB_AGG_TO, haldata->UsbRxAggBlockTimeout);
-		break;
-	case USB_RX_AGG_MIX:
-		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
-		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, (haldata->UsbRxAggPageTimeout & 0x1F));/* 0x280[12:8] */
-		rtw_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
-		rtw_write8(Adapter, REG_USB_AGG_TO, haldata->UsbRxAggBlockTimeout);
-		break;
-	case USB_RX_AGG_DISABLE:
-	default:
-		/*  TODO: */
-		break;
-	}
-}	/*  usb_AggSettingRxUpdate */
+	rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
+	rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH + 1, haldata->UsbRxAggPageTimeout);
+}
 
 static void InitUsbAggregationSetting(struct adapter *Adapter)
 {
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 4a0ab4053e90..b7b51af7f2c3 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -295,18 +295,8 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 		recvframe_put(precvframe, skb_len);
 
-		switch (haldata->UsbRxAggMode) {
-		case USB_RX_AGG_DMA:
-		case USB_RX_AGG_MIX:
-			pkt_offset = (u16)_RND128(pkt_offset);
-			break;
-		case USB_RX_AGG_USB:
-			pkt_offset = (u16)_RND4(pkt_offset);
-			break;
-		case USB_RX_AGG_DISABLE:
-		default:
-			break;
-		}
+		pkt_offset = (u16)_RND128(pkt_offset);
+
 		if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
 			if (pattrib->physt)
 				update_recvframe_phyinfo_88e(precvframe, (struct phy_stat *)pphy_status);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5dce718c0865..98d909b6d217 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -72,13 +72,6 @@ struct rt_firmware_hdr {
 #define DRIVER_EARLY_INT_TIME		0x05
 #define BCN_DMA_ATIME_INT_TIME		0x02
 
-enum usb_rx_agg_mode {
-	USB_RX_AGG_DISABLE,
-	USB_RX_AGG_DMA,
-	USB_RX_AGG_USB,
-	USB_RX_AGG_MIX
-};
-
 #define MAX_RX_DMA_BUFFER_SIZE_88E				\
       0x2400 /* 9k for 88E nornal chip , MaxRxBuff=10k-max(TxReportSize(64*8),
 	      * WOLPattern(16*24)) */
@@ -213,7 +206,6 @@ struct hal_data_8188e {
 
 	u32	UsbBulkOutSize;
 
-	enum usb_rx_agg_mode UsbRxAggMode;
 	u8	UsbRxAggBlockCount;	/*  USB Block count. Block size is
 					 * 512-byte in high speed and 64-byte
 					 * in full speed */
-- 
2.34.1

