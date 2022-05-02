Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6A5177BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387200AbiEBULA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387178AbiEBUKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:10:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEECBCA7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:07:17 -0700 (PDT)
Received: from ipservice-092-217-077-109.092.217.pools.vodafone-ip.de ([92.217.77.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nlcKB-0007ch-92; Mon, 02 May 2022 22:07:15 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/9] staging: r8188eu: replace OnAction_tbl with switch-case
Date:   Mon,  2 May 2022 22:06:49 +0200
Message-Id: <20220502200652.143665-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502200652.143665-1-martin@kaiser.cx>
References: <20220502200652.143665-1-martin@kaiser.cx>
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

OnAction_tbl has only three entries. It's simpler to use a switch
statement instead of iterating over the table.

We can then remove the table itself and struct action_handler, which was
used only for the table entries.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 22 +++++++++----------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  5 -----
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 9c83a74f0795..0df89bbdb63a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -32,12 +32,6 @@ static mlme_handler mlme_sta_tbl[] = {
 	OnAction,
 };
 
-static struct action_handler OnAction_tbl[] = {
-	{RTW_WLAN_CATEGORY_BACK, &OnAction_back},
-	{RTW_WLAN_CATEGORY_PUBLIC, on_action_public},
-	{RTW_WLAN_CATEGORY_P2P, &OnAction_p2p},
-};
-
 static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
 /**************************************************
@@ -3877,9 +3871,7 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 
 unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-	int i;
 	unsigned char	category;
-	struct action_handler *ptable;
 	unsigned char	*frame_body;
 	u8 *pframe = precv_frame->rx_data;
 
@@ -3887,10 +3879,16 @@ unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	category = frame_body[0];
 
-	for (i = 0; i < ARRAY_SIZE(OnAction_tbl); i++) {
-		ptable = &OnAction_tbl[i];
-		if (category == ptable->num)
-			ptable->func(padapter, precv_frame);
+	switch (category) {
+	case RTW_WLAN_CATEGORY_BACK:
+		OnAction_back(padapter, precv_frame);
+		break;
+	case RTW_WLAN_CATEGORY_PUBLIC:
+		on_action_public(padapter, precv_frame);
+		break;
+	case RTW_WLAN_CATEGORY_P2P:
+		OnAction_p2p(padapter, precv_frame);
+		break;
 	}
 	return _SUCCESS;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 63e4ee8e3dfb..888b12a9f755 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -186,11 +186,6 @@ enum SCAN_STATE {
 
 typedef unsigned int (*mlme_handler)(struct adapter *adapt, struct recv_frame *frame);
 
-struct action_handler {
-	unsigned int   num;
-	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
-};
-
 struct	ss_res {
 	int	state;
 	int	bss_cnt;
-- 
2.30.2

