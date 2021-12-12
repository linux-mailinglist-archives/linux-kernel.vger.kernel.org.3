Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82EE471C68
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhLLS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhLLS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:58:50 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9FC061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:58:49 -0800 (PST)
Received: from dslb-188-104-058-180.188.104.pools.vodafone-ip.de ([188.104.58.180] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mwU3Z-0001zY-Lq; Sun, 12 Dec 2021 19:58:45 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: move linked status check from hal to rtw_mlme_ext
Date:   Sun, 12 Dec 2021 19:58:32 +0100
Message-Id: <20211212185833.22000-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211212185833.22000-1-martin@kaiser.cx>
References: <20211212185833.22000-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rtl8188e_sreset_linked_status_check from the hal layer into
rtw_mlme_ext.c.

Like the xmit status check, this is a simple function that's only
called from one place.

With this function gone, hal/rtl8188e_sreset.c and
include/rtl8188e_sreset.h are now empty and can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile              |  1 -
 drivers/staging/r8188eu/core/rtw_cmd.c        |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 19 +++++++++++++-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c | 25 -------------------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  1 -
 .../staging/r8188eu/include/rtl8188e_sreset.h | 12 ---------
 6 files changed, 18 insertions(+), 41 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 delete mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 62933b0f29b5..580b9308d566 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -21,7 +21,6 @@ r8188eu-y = \
 		hal/rtl8188e_phycfg.o \
 		hal/rtl8188e_rf6052.o \
 		hal/rtl8188e_rxdesc.o \
-		hal/rtl8188e_sreset.o \
 		hal/rtl8188e_xmit.o \
 		hal/rtl8188eu_led.o \
 		hal/rtl8188eu_recv.o \
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 283ae08ae4cb..6d503eb7ff26 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -10,7 +10,6 @@
 #include "../include/rtw_br_ext.h"
 #include "../include/rtw_mlme_ext.h"
 #include "../include/rtl8188e_dm.h"
-#include "../include/rtl8188e_sreset.h"
 
 /*
 Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 4b6d33249d95..15a443b9bc6d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -10,7 +10,6 @@
 #include "../include/wlan_bssdef.h"
 #include "../include/mlme_osdep.h"
 #include "../include/recv_osdep.h"
-#include "../include/rtl8188e_sreset.h"
 #include "../include/rtl8188e_xmit.h"
 #include "../include/rtl8188e_dm.h"
 
@@ -7160,6 +7159,24 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 	return ret;
 }
 
+static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
+{
+	u32 rx_dma_status = 0;
+	u8 fw_status = 0;
+	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
+	if (rx_dma_status != 0x00) {
+		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
+		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
+	}
+	fw_status = rtw_read8(padapter, REG_FMETHR);
+	if (fw_status != 0x00) {
+		if (fw_status == 1)
+			DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
+		else if (fw_status == 2)
+			DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
+	}
+}
+
 void linked_status_chk(struct adapter *padapter)
 {
 	u32	i;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
deleted file mode 100644
index 7fec776a8e87..000000000000
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#define _RTL8188E_SRESET_C_
-
-#include "../include/rtl8188e_sreset.h"
-#include "../include/rtl8188e_hal.h"
-
-void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
-{
-	u32 rx_dma_status = 0;
-	u8 fw_status = 0;
-	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
-	if (rx_dma_status != 0x00) {
-		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
-		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
-	}
-	fw_status = rtw_read8(padapter, REG_FMETHR);
-	if (fw_status != 0x00) {
-		if (fw_status == 1)
-			DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
-		else if (fw_status == 2)
-			DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
-	}
-}
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index f8ac4920f049..9bfa255f1679 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -13,7 +13,6 @@
 #include "rtl8188e_recv.h"
 #include "rtl8188e_xmit.h"
 #include "rtl8188e_cmd.h"
-#include "rtl8188e_sreset.h"
 #include "rtw_efuse.h"
 #include "odm_precomp.h"
 #include "odm.h"
diff --git a/drivers/staging/r8188eu/include/rtl8188e_sreset.h b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
deleted file mode 100644
index 4e96a5a6e075..000000000000
--- a/drivers/staging/r8188eu/include/rtl8188e_sreset.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef _RTL8188E_SRESET_H_
-#define _RTL8188E_SRESET_H_
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-void rtl8188e_sreset_linked_status_check(struct adapter *padapter);
-
-#endif
-- 
2.20.1

