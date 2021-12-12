Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5166F471C67
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhLLS6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhLLS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:58:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF695C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:58:50 -0800 (PST)
Received: from dslb-188-104-058-180.188.104.pools.vodafone-ip.de ([188.104.58.180] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mwU3a-0001zY-T0; Sun, 12 Dec 2021 19:58:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: r8188eu: clean up rtl8188e_sreset_linked_status_check
Date:   Sun, 12 Dec 2021 19:58:33 +0100
Message-Id: <20211212185833.22000-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211212185833.22000-1-martin@kaiser.cx>
References: <20211212185833.22000-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the rtl8188e_sreset_linked_status_check, which has just
been moved to rtw_mlme_ext.

Don't initialise variables to 0 if the first access sets a new value.

Check the value of fw_status only once.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 15a443b9bc6d..8e04238fb5fc 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7161,20 +7161,19 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 
 static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
-	u32 rx_dma_status = 0;
-	u8 fw_status = 0;
-	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
+	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
+	u8 fw_status;
+
 	if (rx_dma_status != 0x00) {
 		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 	}
+
 	fw_status = rtw_read8(padapter, REG_FMETHR);
-	if (fw_status != 0x00) {
-		if (fw_status == 1)
-			DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
-		else if (fw_status == 2)
-			DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
-	}
+	if (fw_status == 1)
+		DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
+	else if (fw_status == 2)
+		DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
 }
 
 void linked_status_chk(struct adapter *padapter)
-- 
2.20.1

