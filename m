Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6C471C65
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhLLS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhLLS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:58:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F02C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:58:48 -0800 (PST)
Received: from dslb-188-104-058-180.188.104.pools.vodafone-ip.de ([188.104.58.180] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mwU3Y-0001zY-E1; Sun, 12 Dec 2021 19:58:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: move xmit status check from hal to rtw_cmd
Date:   Sun, 12 Dec 2021 19:58:31 +0100
Message-Id: <20211212185833.22000-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211212185833.22000-1-martin@kaiser.cx>
References: <20211212185833.22000-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rtl8188e_sreset_xmit_status_check from the hal layer into
rtw_cmd.c.

As this driver supports only the 8188 chipset, there's no need
to go through the hal layer for simple operations that have only
one caller.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c            | 12 ++++++++++++
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c     | 12 ------------
 drivers/staging/r8188eu/include/rtl8188e_sreset.h |  1 -
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ace3a6342e01..283ae08ae4cb 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -950,6 +950,18 @@ static void traffic_status_watchdog(struct adapter *padapter)
 	pmlmepriv->LinkDetectInfo.bHigherBusyTxTraffic = bHigherBusyTxTraffic;
 }
 
+static void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
+{
+	u32 txdma_status;
+
+	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
+	if (txdma_status != 0x00) {
+		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
+		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
+	}
+	/* total xmit irp = 4 */
+}
+
 static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct mlme_priv *pmlmepriv;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 7b3ac6e306ce..7fec776a8e87 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -6,18 +6,6 @@
 #include "../include/rtl8188e_sreset.h"
 #include "../include/rtl8188e_hal.h"
 
-void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
-{
-	u32 txdma_status;
-
-	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
-	if (txdma_status != 0x00) {
-		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
-		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
-	}
-	/* total xmit irp = 4 */
-}
-
 void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
 	u32 rx_dma_status = 0;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_sreset.h b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
index bb8b0048fbf9..4e96a5a6e075 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_sreset.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
@@ -7,7 +7,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-void rtl8188e_sreset_xmit_status_check(struct adapter *padapter);
 void rtl8188e_sreset_linked_status_check(struct adapter *padapter);
 
 #endif
-- 
2.20.1

