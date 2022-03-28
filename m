Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5893F4E8BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiC1Bnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiC1Bnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:43:39 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E284F9E3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:41:58 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 09:41:57 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 09:41:56 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>, <straube.linux@gmail.com>,
        <martin@kaiser.cx>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=E7=99=BD=E6=B5=A9=E6=96=87?= <baihaowen@meizu.com>
Subject: [PATCH] staging: r8188eu: Directly return instead of using local ret variable
Date:   Mon, 28 Mar 2022 09:41:55 +0800
Message-ID: <1648431715-21333-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 白浩文 <baihaowen@meizu.com>

fixes coccinelle warning:
./drivers/staging/r8188eu/core/rtw_mlme_ext.c:1518:14-17: Unneeded variable: "ret".
 Return "_FAIL" on line 1549
./drivers/staging/r8188eu/core/rtw_mlme_ext.c:357:5-8: Unneeded variable: "res".
 Return "_SUCCESS" on line 380

Signed-off-by: 白浩文 <baihaowen@meizu.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 10d5f12..4b7b0ee 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -354,7 +354,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 int	init_mlme_ext_priv(struct adapter *padapter)
 {
-	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -377,7 +376,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 
 	pmlmeext->active_keep_alive_check = true;
 
-	return res;
+	return _SUCCESS;
 }
 
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
@@ -1515,7 +1514,6 @@ unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
 
 unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
@@ -1546,7 +1544,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
 	}
 
 exit:
-	return ret;
+	return _FAIL;
 }
 
 unsigned int OnAction_qos(struct adapter *padapter, struct recv_frame *precv_frame)
-- 
2.7.4

