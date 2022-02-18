Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDD4BBA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiBRNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:51:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiBRNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:51:15 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0529720B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:50:58 -0800 (PST)
Received: from dslb-178-004-174-047.178.004.pools.vodafone-ip.de ([178.4.174.47] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nL3ev-0007eo-9y; Fri, 18 Feb 2022 14:50:53 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: refactor validate_recv_frame's error handling
Date:   Fri, 18 Feb 2022 14:50:37 +0100
Message-Id: <20220218135038.908307-4-martin@kaiser.cx>
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

Refactor the error handling of validate_recv_frame. It's simpler to
default to _FAIL.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index bb31423ec26c..52a3ad297099 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1058,7 +1058,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	/* then call check if rx seq/frag. duplicated. */
 
 	u8 subtype;
-	int retval = _SUCCESS;
+	int retval = _FAIL;
 	u8 bDumpRxPkt;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	u8 *ptr = precv_frame->rx_data;
@@ -1073,10 +1073,8 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	}
 
 	/* add version chk */
-	if (ver != 0) {
-		retval = _FAIL;
-		goto exit;
-	}
+	if (ver != 0)
+		return _FAIL;
 
 	subtype = GetFrameSubType(ptr); /* bit(7)~bit(2) */
 
@@ -1094,13 +1092,12 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	/* Dump rx packets */
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
 
-	if (ieee80211_is_mgmt(fc)) {
+	/* We return _SUCCESS only for data frames. */
+	if (ieee80211_is_mgmt(fc))
 		validate_recv_mgnt_frame(adapter, precv_frame);
-		retval = _FAIL; /*  only data frame return _SUCCESS */
-	} else if (ieee80211_is_ctl(fc)) {
+	else if (ieee80211_is_ctl(fc))
 		validate_recv_ctrl_frame(adapter, precv_frame);
-		retval = _FAIL; /*  only data frame return _SUCCESS */
-	} else if (ieee80211_is_data(fc)) {
+	else if (ieee80211_is_data(fc)) {
 		rtw_led_control(adapter, LED_CTL_RX);
 		pattrib->qos = (subtype & BIT(7)) ? 1 : 0;
 		retval = validate_recv_data_frame(adapter, precv_frame);
@@ -1108,10 +1105,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 			struct recv_priv *precvpriv = &adapter->recvpriv;
 			precvpriv->rx_drop++;
 		}
-	} else
-		retval = _FAIL;
-
-exit:
+	}
 
 	return retval;
 }
-- 
2.30.2

