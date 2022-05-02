Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1B5177B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387182AbiEBUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiEBUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:10:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7DDF32
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:07:15 -0700 (PDT)
Received: from ipservice-092-217-077-109.092.217.pools.vodafone-ip.de ([92.217.77.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nlcK8-0007ch-1f; Mon, 02 May 2022 22:07:12 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/9] staging: r8188eu: action category wmm is not used
Date:   Mon,  2 May 2022 22:06:45 +0200
Message-Id: <20220502200652.143665-3-martin@kaiser.cx>
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

The r8188eu driver does not handle the wmm action category. Remove the
empty handler function, the entry in OnAction_tbl and the define for the
category.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 6 ------
 drivers/staging/r8188eu/include/ieee80211.h    | 1 -
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 01fcd996e192..a581930b05df 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -35,7 +35,6 @@ static mlme_handler mlme_sta_tbl[] = {
 static struct action_handler OnAction_tbl[] = {
 	{RTW_WLAN_CATEGORY_BACK, "ACTION_BACK", &OnAction_back},
 	{RTW_WLAN_CATEGORY_PUBLIC, "ACTION_PUBLIC", on_action_public},
-	{RTW_WLAN_CATEGORY_WMM, "ACTION_WMM", &OnAction_wmm},
 	{RTW_WLAN_CATEGORY_P2P, "ACTION_P2P", &OnAction_p2p},
 };
 
@@ -3836,11 +3835,6 @@ unsigned int on_action_public(struct adapter *padapter, struct recv_frame *precv
 	return ret;
 }
 
-unsigned int OnAction_wmm(struct adapter *padapter, struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
 unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	u8 *frame_body;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 0dd7da912891..f9a8aa243877 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -599,7 +599,6 @@ enum rtw_ieee80211_category {
 	RTW_WLAN_CATEGORY_BACK = 3,
 	RTW_WLAN_CATEGORY_PUBLIC = 4, /* IEEE 802.11 public action frames */
 	RTW_WLAN_CATEGORY_TDLS = 12,
-	RTW_WLAN_CATEGORY_WMM = 17,
 	RTW_WLAN_CATEGORY_P2P = 0x7f,/* P2P action frames */
 };
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 0deb6c963d0c..c68b3c77c378 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -577,8 +577,6 @@ unsigned int OnAction_back(struct adapter *padapter,
 			   struct recv_frame *precv_frame);
 unsigned int on_action_public(struct adapter *padapter,
 			      struct recv_frame *precv_frame);
-unsigned int OnAction_wmm(struct adapter *padapter,
-			  struct recv_frame *precv_frame);
 unsigned int OnAction_p2p(struct adapter *padapter,
 			  struct recv_frame *precv_frame);
 
-- 
2.30.2

