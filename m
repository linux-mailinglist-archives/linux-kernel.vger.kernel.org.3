Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81A8565E51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiGDURZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiGDURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:17:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52311A12
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:17:13 -0700 (PDT)
Received: from dslb-178-004-207-027.178.004.pools.vodafone-ip.de ([178.4.207.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o8SVJ-00007Y-W7; Mon, 04 Jul 2022 22:17:10 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: r8188eu: use ieee80211 helper to check for nullfunc frame
Date:   Mon,  4 Jul 2022 22:16:54 +0200
Message-Id: <20220704201654.195574-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704201654.195574-1-martin@kaiser.cx>
References: <20220704201654.195574-1-martin@kaiser.cx>
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

Use the ieee80211_is_nullfunc function from ieee80211.h to check for a
nullfunc frame. This is a data frame whose subtype has bit6 set.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 8b21ec8f111f..32cd452d1f3d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -649,6 +649,7 @@ static int ap2sta_data_frame(
 	struct sta_info **psta)
 {
 	u8 *ptr = precv_frame->rx_data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	int ret = _SUCCESS;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
@@ -693,8 +694,8 @@ static int ap2sta_data_frame(
 			goto exit;
 		}
 
-		if (GetFrameSubType(ptr) & BIT(6)) {
-			/* No data, will not indicate to upper layer, temporily count it here */
+		if (ieee80211_is_nullfunc(hdr->frame_control)) {
+			/* We count the nullfunc frame, but we'll not pass it on to higher layers. */
 			count_rx_stats(adapter, precv_frame, *psta);
 			ret = RTW_RX_HANDLED;
 			goto exit;
-- 
2.30.2

