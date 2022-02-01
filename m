Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEA4A58B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiBAInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiBAInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03CCC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:43:17 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jx6so52176838ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8zl36G7JlUGXj8aWslwhr97KzVAYYmIGHBWCkBFK+8=;
        b=E941/X84IaEHoXKvH/LHgPKecFrjJ7ESo8JUDdvrWGzaWn6oAu+3K/5p0GvE0gGiaA
         3Me4GAYQPEaGpeBxgxsZg9IM7+bwIpoE5Gb/kKAQaaUhdCaKiE78DnsMUStMhJtdBJdW
         UGCyxg0shKxnAGVdViJmIRBcoW5GbD5adLOfMKiIar81a5CMLLD03BxH+rdynJOCZK55
         fXaM804mHAaKj9/MG6I9zcEkk4cO8Oh4B2CjVRrjLA3wPt4In9qkMP0PbME8KJlgsHCr
         4FBPaK06owjaNmPLE78Jk4URskCBMTW3gprCvIOupwuTCVgHURXLM7KYL1Qw2JJDmozX
         2Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8zl36G7JlUGXj8aWslwhr97KzVAYYmIGHBWCkBFK+8=;
        b=xjrBe3NTpfw729Q91mc18dUvkuBFKTEe38mouXcj9nkBalhtGEmNDL/UhPyjxcuEsE
         G0fx4Vawnd1t/4Fdk9v9/vIAQ4KeomkDvoidBT1WPZwGSDnDkHsZhZsk9eWf5VwRMI5J
         mHrF/flWudaZetQ7ZOQoh4lwrLQEMyLeAKIcCvrwauqB0EenU8OpQiXzB3DuuqobCp4f
         IdwI8hbMmWf4nlCKIqdgVN0blAHvTVIjkE+DhjWertPs+7jf0S8xD72m2wu4sdO0pPaa
         /xpAVQmaOCEKBWHijvg6YKDLKTvXOblie2TqKX4BdgF2V+KCzYb7LiyiUNY2GsQ9zZQf
         /Ktg==
X-Gm-Message-State: AOAM533q9zUuMMD6x9FqrKZltQydpTIeX334997+GUjMOXswKpy4lIct
        oeo/P42CYJHwdrzilBBVT+c=
X-Google-Smtp-Source: ABdhPJyhx1/GltpDK0pKlqouPy8wnEFLIJbK8JjoRBLmvQrIZKqPEfGQAM/d4LzsOKRg7mwJff4xfg==
X-Received: by 2002:a17:907:3f0d:: with SMTP id hq13mr20219436ejc.358.1643704996548;
        Tue, 01 Feb 2022 00:43:16 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id c14sm19123431edy.66.2022.02.01.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:43:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/9] staging: r8188eu: remove UsbRxAggBlock* from struct hal_data_8188e
Date:   Tue,  1 Feb 2022 09:42:58 +0100
Message-Id: <20220201084259.7497-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201084259.7497-1-straube.linux@gmail.com>
References: <20220201084259.7497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UsbRxAggBlockCount and UsbRxAggBlockTimeout in struct hal_data_8188e
are set but not used. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 24c11c666534..1d0d58204c68 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -53,8 +53,6 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 	else
 		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
 
-	haldata->UsbRxAggBlockCount	= 8; /* unit : 512b */
-	haldata->UsbRxAggBlockTimeout	= 0x6;
 	haldata->UsbRxAggPageCount	= 48; /* uint :128 b 0x0A;	10 = MAX_RX_DMA_BUFFER_SIZE/2/haldata->UsbBulkOutSize */
 	haldata->UsbRxAggPageTimeout	= 0x4; /* 6, absolute time = 34ms/(2^6) */
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 98d909b6d217..94678dad37ce 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -206,10 +206,6 @@ struct hal_data_8188e {
 
 	u32	UsbBulkOutSize;
 
-	u8	UsbRxAggBlockCount;	/*  USB Block count. Block size is
-					 * 512-byte in high speed and 64-byte
-					 * in full speed */
-	u8	UsbRxAggBlockTimeout;
 	u8	UsbRxAggPageCount;	/*  8192C DMA page count */
 	u8	UsbRxAggPageTimeout;
 };
-- 
2.34.1

