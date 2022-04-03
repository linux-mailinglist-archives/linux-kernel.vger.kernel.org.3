Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD54F0B64
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiDCQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359592AbiDCQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:57:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F9393E4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:55:06 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3V6-0008D7-Na; Sun, 03 Apr 2022 18:54:52 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/11] staging: r8188eu: ra and ta do not depend on to_ds, from_ds
Date:   Sun,  3 Apr 2022 18:54:35 +0200
Message-Id: <20220403165438.357728-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403165438.357728-1-martin@kaiser.cx>
References: <20220403165438.357728-1-martin@kaiser.cx>
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

The "DS bit usage" table in include/linux/ieee80211.h shows that
ra is always addr1 and ta is always addr2.

We can set pattrib->ra and pattrib->ta regardless of the to_ds and
from_ds bits.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 0098f3de31d7..75c0e0b17185 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -962,19 +962,15 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	if (ieee80211_has_a4(hdr->frame_control))
 		return _FAIL;
 
-	if (ieee80211_has_fromds(hdr->frame_control)) {
-		memcpy(pattrib->ra, pda, ETH_ALEN);
-		memcpy(pattrib->ta, pbssid, ETH_ALEN);
+	memcpy(pattrib->ra, hdr->addr1, ETH_ALEN);
+	memcpy(pattrib->ta, hdr->addr2, ETH_ALEN);
+
+	if (ieee80211_has_fromds(hdr->frame_control))
 		ret = ap2sta_data_frame(adapter, precv_frame, &psta);
-	} else if (ieee80211_has_tods(hdr->frame_control)) {
-		memcpy(pattrib->ra, pbssid, ETH_ALEN);
-		memcpy(pattrib->ta, psa, ETH_ALEN);
+	else if (ieee80211_has_tods(hdr->frame_control))
 		ret = sta2ap_data_frame(adapter, precv_frame, &psta);
-	} else {
-		memcpy(pattrib->ra, pda, ETH_ALEN);
-		memcpy(pattrib->ta, psa, ETH_ALEN);
+	else
 		ret = sta2sta_data_frame(adapter, precv_frame, &psta);
-	}
 
 	if (ret == _FAIL || ret == RTW_RX_HANDLED)
 		return ret;
-- 
2.30.2

