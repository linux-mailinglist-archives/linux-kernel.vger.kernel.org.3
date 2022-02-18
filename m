Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA14BBA50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiBRNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:51:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiBRNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:51:11 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8982557B6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:50:55 -0800 (PST)
Received: from dslb-178-004-174-047.178.004.pools.vodafone-ip.de ([178.4.174.47] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nL3eu-0007eo-0c; Fri, 18 Feb 2022 14:50:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] staging: r8188eu: use ieee80211 helpers to check the frame type
Date:   Fri, 18 Feb 2022 14:50:36 +0100
Message-Id: <20220218135038.908307-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218135038.908307-1-martin@kaiser.cx>
References: <20220218135038.908307-1-martin@kaiser.cx>
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

Use the ieee80211_is_... helper functions to check the frame type in
the validate_recv_frame function. Add a temporary variable for the
16-bit frame control field.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 955cc0a1638a..bb31423ec26c 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -3,6 +3,7 @@
 
 #define _RTW_RECV_C_
 
+#include <linux/ieee80211.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
@@ -1056,12 +1057,12 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	/* then call check if rx seq/frag. duplicated. */
 
-	u8 type;
 	u8 subtype;
 	int retval = _SUCCESS;
 	u8 bDumpRxPkt;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	u8 *ptr = precv_frame->rx_data;
+	__le16 fc = *(__le16 *)ptr;
 	u8  ver = (unsigned char)(*ptr) & 0x3;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
@@ -1077,7 +1078,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 		goto exit;
 	}
 
-	type =  GetFrameType(ptr);
 	subtype = GetFrameSubType(ptr); /* bit(7)~bit(2) */
 
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
@@ -1093,16 +1093,14 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	/* Dump rx packets */
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
-	switch (type) {
-	case IEEE80211_FTYPE_MGMT:
+
+	if (ieee80211_is_mgmt(fc)) {
 		validate_recv_mgnt_frame(adapter, precv_frame);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
-		break;
-	case WIFI_CTRL_TYPE: /* ctrl */
+	} else if (ieee80211_is_ctl(fc)) {
 		validate_recv_ctrl_frame(adapter, precv_frame);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
-		break;
-	case WIFI_DATA_TYPE: /* data */
+	} else if (ieee80211_is_data(fc)) {
 		rtw_led_control(adapter, LED_CTL_RX);
 		pattrib->qos = (subtype & BIT(7)) ? 1 : 0;
 		retval = validate_recv_data_frame(adapter, precv_frame);
@@ -1110,11 +1108,8 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 			struct recv_priv *precvpriv = &adapter->recvpriv;
 			precvpriv->rx_drop++;
 		}
-		break;
-	default:
+	} else
 		retval = _FAIL;
-		break;
-	}
 
 exit:
 
-- 
2.30.2

