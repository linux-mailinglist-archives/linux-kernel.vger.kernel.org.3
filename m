Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57F44C5D86
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiB0Qmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiB0Qmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:42:49 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C11F6D192
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:42:12 -0800 (PST)
Received: from ipservice-092-217-088-081.092.217.pools.vodafone-ip.de ([92.217.88.81] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nOMca-0005Z9-36; Sun, 27 Feb 2022 17:42:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 1/8] staging: r8188eu: use ieee80211 define for management frame type
Date:   Sun, 27 Feb 2022 17:41:40 +0100
Message-Id: <20220227164147.1168847-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220227164147.1168847-1-martin@kaiser.cx>
References: <20220218135038.908307-1-martin@kaiser.cx>
 <20220227164147.1168847-1-martin@kaiser.cx>
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

Replace the driver-internal define for management frame type with
IEEE80211_FTYPE_MGMT.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c |  3 ++-
 drivers/staging/r8188eu/core/rtw_recv.c     |  2 +-
 drivers/staging/r8188eu/include/wifi.h      | 25 ++++++++++-----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 0b77ddde6ce2..f49641abc8b8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3,6 +3,7 @@
 
 #define _RTW_MLME_EXT_C_
 
+#include <linux/ieee80211.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/wifi.h"
@@ -414,7 +415,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	u8 *pframe = precv_frame->rx_data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
 
-	if (GetFrameType(pframe) != WIFI_MGT_TYPE)
+	if (GetFrameType(pframe) != IEEE80211_FTYPE_MGMT)
 		return;
 
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 6dacb2687034..1133239f29bc 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1094,7 +1094,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	/* Dump rx packets */
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
 	switch (type) {
-	case WIFI_MGT_TYPE: /* mgnt */
+	case IEEE80211_FTYPE_MGMT:
 		validate_recv_mgnt_frame(adapter, precv_frame);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index e7083d721dae..5b383c2e9880 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -18,7 +18,6 @@
 #define WLAN_SSID_MAXLEN	32
 
 enum WIFI_FRAME_TYPE {
-	WIFI_MGT_TYPE  =	(0),
 	WIFI_CTRL_TYPE =	(BIT(2)),
 	WIFI_DATA_TYPE =	(BIT(3)),
 	WIFI_QOS_DATA_TYPE	= (BIT(7)|BIT(3)),	/*  QoS Data */
@@ -26,18 +25,18 @@ enum WIFI_FRAME_TYPE {
 
 enum WIFI_FRAME_SUBTYPE {
 	/*  below is for mgt frame */
-	WIFI_ASSOCREQ       = (0 | WIFI_MGT_TYPE),
-	WIFI_ASSOCRSP       = (BIT(4) | WIFI_MGT_TYPE),
-	WIFI_REASSOCREQ     = (BIT(5) | WIFI_MGT_TYPE),
-	WIFI_REASSOCRSP     = (BIT(5) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_PROBEREQ       = (BIT(6) | WIFI_MGT_TYPE),
-	WIFI_PROBERSP       = (BIT(6) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_BEACON         = (BIT(7) | WIFI_MGT_TYPE),
-	WIFI_ATIM           = (BIT(7) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_DISASSOC       = (BIT(7) | BIT(5) | WIFI_MGT_TYPE),
-	WIFI_AUTH           = (BIT(7) | BIT(5) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_DEAUTH         = (BIT(7) | BIT(6) | WIFI_MGT_TYPE),
-	WIFI_ACTION         = (BIT(7) | BIT(6) | BIT(4) | WIFI_MGT_TYPE),
+	WIFI_ASSOCREQ       = (0 | IEEE80211_FTYPE_MGMT),
+	WIFI_ASSOCRSP       = (BIT(4) | IEEE80211_FTYPE_MGMT),
+	WIFI_REASSOCREQ     = (BIT(5) | IEEE80211_FTYPE_MGMT),
+	WIFI_REASSOCRSP     = (BIT(5) | BIT(4) | IEEE80211_FTYPE_MGMT),
+	WIFI_PROBEREQ       = (BIT(6) | IEEE80211_FTYPE_MGMT),
+	WIFI_PROBERSP       = (BIT(6) | BIT(4) | IEEE80211_FTYPE_MGMT),
+	WIFI_BEACON         = (BIT(7) | IEEE80211_FTYPE_MGMT),
+	WIFI_ATIM           = (BIT(7) | BIT(4) | IEEE80211_FTYPE_MGMT),
+	WIFI_DISASSOC       = (BIT(7) | BIT(5) | IEEE80211_FTYPE_MGMT),
+	WIFI_AUTH           = (BIT(7) | BIT(5) | BIT(4) | IEEE80211_FTYPE_MGMT),
+	WIFI_DEAUTH         = (BIT(7) | BIT(6) | IEEE80211_FTYPE_MGMT),
+	WIFI_ACTION         = (BIT(7) | BIT(6) | BIT(4) | IEEE80211_FTYPE_MGMT),
 
 	/*  below is for control frame */
 	WIFI_PSPOLL         = (BIT(7) | BIT(5) | WIFI_CTRL_TYPE),
-- 
2.30.2

