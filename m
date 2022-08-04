Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57DE589A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiHDKz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiHDKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:55:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C321116D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:55:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so18322279ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ce2wN3up1tX8smnqeRp0FZBQrQKCapvS40FaCXtgzDI=;
        b=RUTIhajFko4zqfu2qCvTEfrs6BI2DFEpl7C5KaqhptXfDG7NoefWq9aBp7AqoRVHow
         eGxe2BcOLBlJm6InK4R3GY1zzpHGuMw1G+iWniMNITj0c5pX4eFfkMR8xOUheG+KA/k2
         fvWWyXpJxhyuhj6sNfDWi7g6SjYW6r0V0L4ag/uB6s9OnF+VXsUc37B2hicgu9fZ9Fmi
         h6etxWwedKazizncHl8/Z+mB7HFnIermHRfHLqSnFUuzSm86URvHF9ThbdttT5d1hpHi
         DZg/8LRhxeNgs/qhkHGoTBikX7vP3lK00Xa4ZupQptwC6HJePRTxrpZuu8EtarFk28dT
         0ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ce2wN3up1tX8smnqeRp0FZBQrQKCapvS40FaCXtgzDI=;
        b=6GB1eXp1EylTGttSj9JPr0Gw/r5bceROtKDmzmu99leW8+voM10DarcLKeMAzoA7aT
         Wgix4u//KERqUD5nD0Uc5GMfQ3Ds8eFpEtgZyun6cakx+1p9DK/GEEUae0Lwsw97SUzu
         szOxj7sB6OsIZ9lxIS06SyLVmZpvE4V53Wex95Acd50UCmWP+k7NEHMaxA5h8yD2Cpm7
         tZYQmcdle1eOQwb/akPSeR3UQpnZ97Ul4CLRz6gdDJsVnnvPLCvOIIzTmzZt9tbLoq11
         9XCuqRT2Y5GqL0xDDFFS9nR7GC2T591gW3YowbTieD2cN09/1XvwjUwgcfZz/1KPLcWp
         eLcw==
X-Gm-Message-State: ACgBeo0EEldxf8HMTx8ERj3IhvNQ1qb6MIjd0sOVkJop91rVfftFOuQV
        xKHFWVj0nWol9l9kYZa+VhY=
X-Google-Smtp-Source: AA6agR5RECceYtuALfh0gjI+JiMeqEY/3WAH4FahaWMKzXmO6/eBdFz+LEBUVCde/n2r9FIQ1pNQSg==
X-Received: by 2002:a17:907:1c24:b0:72b:838f:cada with SMTP id nc36-20020a1709071c2400b0072b838fcadamr992852ejc.125.1659610548401;
        Thu, 04 Aug 2022 03:55:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id y89-20020a50bb62000000b0043ba0cf5dbasm510013ede.2.2022.08.04.03.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 03:55:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: make handle_txrpt_ccx_88e() static
Date:   Thu,  4 Aug 2022 12:55:31 +0200
Message-Id: <20220804105532.7532-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804105532.7532-1-straube.linux@gmail.com>
References: <20220804105532.7532-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function handle_txrpt_ccx_88e() is only used in usb_ops_linux.c.
Make it static and remove the now empty file rtl8188e_xmit.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile              |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 22 -------------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 14 ++++++++++++
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  2 --
 4 files changed, 14 insertions(+), 25 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index eea16eb7caa0..cddfee3efd36 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -18,7 +18,6 @@ r8188eu-y = \
 		hal/rtl8188e_phycfg.o \
 		hal/rtl8188e_rf6052.o \
 		hal/rtl8188e_rxdesc.o \
-		hal/rtl8188e_xmit.o \
 		hal/rtl8188eu_recv.o \
 		hal/rtl8188eu_xmit.o \
 		hal/usb_halinit.o \
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
deleted file mode 100644
index 46b871f3f631..000000000000
--- a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#define _RTL8188E_XMIT_C_
-
-#include "../include/osdep_service.h"
-#include "../include/drv_types.h"
-#include "../include/rtl8188e_hal.h"
-
-void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
-{
-	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
-
-	if (txrpt_ccx->int_ccx) {
-		if (txrpt_ccx->pkt_ok)
-			rtw_ack_tx_done(&adapter->xmitpriv,
-					RTW_SCTX_DONE_SUCCESS);
-		else
-			rtw_ack_tx_done(&adapter->xmitpriv,
-					RTW_SCTX_DONE_CCX_PKT_FAIL);
-	}
-}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index c1a4d023f627..f29bfa948ce7 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -190,6 +190,20 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	return RTW_STATUS_CODE(ret);
 }
 
+static void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
+{
+	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
+
+	if (txrpt_ccx->int_ccx) {
+		if (txrpt_ccx->pkt_ok)
+			rtw_ack_tx_done(&adapter->xmitpriv,
+					RTW_SCTX_DONE_SUCCESS);
+		else
+			rtw_ack_tx_done(&adapter->xmitpriv,
+					RTW_SCTX_DONE_CCX_PKT_FAIL);
+	}
+}
+
 static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 {
 	u8	*pbuf;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index 8adb672f7a07..c69fed23ded9 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -147,6 +147,4 @@ bool rtl8188eu_xmitframe_complete(struct adapter *padapter,
 				 struct xmit_priv *pxmitpriv,
 				 struct xmit_buf *pxmitbuf);
 
-void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
-
 #endif /* __RTL8188E_XMIT_H__ */
-- 
2.37.1

