Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D853A099
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351243AbiFAJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351181AbiFAJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:35:14 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595688FD6B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:35:11 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jun 2022
 17:35:13 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 1 Jun
 2022 17:35:09 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: r8188eu: Drop redundant memset
Date:   Wed, 1 Jun 2022 17:35:07 +0800
Message-ID: <1654076108-9326-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The region set by the call to memset is immediately overwritten by the
subsequent call to memcpy. So we drop redundant memset.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 5a815642c3f6..56c8bd5f4c60 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -676,7 +676,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-					memset(&pdev_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
 					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
@@ -1253,7 +1252,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
 
-			memset(&pdev_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
 			memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 			rtw_update_registrypriv_dev_network(adapter);
-- 
2.7.4

