Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38380585AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiG3OkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiG3Oj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 10:39:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9141A17AAC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 07:39:58 -0700 (PDT)
Received: from dslb-188-104-059-172.188.104.pools.vodafone-ip.de ([188.104.59.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oHndA-0004pM-LY; Sat, 30 Jul 2022 16:39:52 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: make rtw_handle_dualmac a void function
Date:   Sat, 30 Jul 2022 16:39:38 +0200
Message-Id: <20220730143939.671951-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220730143939.671951-1-martin@kaiser.cx>
References: <20220730143939.671951-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtw_handle_dualmac function always returns _SUCCESS. Remove the return
value and update the one caller that checks it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 5 +----
 drivers/staging/r8188eu/include/drv_types.h  | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c    | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 3a002cb6834f..235dbf353802 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1578,10 +1578,8 @@ void beacon_timing_control(struct adapter *padapter)
 
 static struct adapter *pbuddy_padapter;
 
-int rtw_handle_dualmac(struct adapter *adapter, bool init)
+void rtw_handle_dualmac(struct adapter *adapter, bool init)
 {
-	int status = _SUCCESS;
-
 	if (init) {
 		if (!pbuddy_padapter) {
 			pbuddy_padapter = adapter;
@@ -1594,5 +1592,4 @@ int rtw_handle_dualmac(struct adapter *adapter, bool init)
 	} else {
 		pbuddy_padapter = NULL;
 	}
-	return status;
 }
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index bba88a0ede61..9f8a8d3e8f77 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -222,7 +222,7 @@ struct adapter {
 
 #define adapter_to_dvobj(adapter) (adapter->dvobj)
 
-int rtw_handle_dualmac(struct adapter *adapter, bool init);
+void rtw_handle_dualmac(struct adapter *adapter, bool init);
 
 static inline u8 *myid(struct eeprom_priv *peepriv)
 {
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index e1a0447fd1e7..4dbdffa4e293 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -306,8 +306,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	padapter->hw_init_mutex = &usb_drv->hw_init_mutex;
 
-	if (rtw_handle_dualmac(padapter, 1) != _SUCCESS)
-		goto free_adapter;
+	rtw_handle_dualmac(padapter, 1);
 
 	pnetdev = rtw_init_netdev(padapter);
 	if (!pnetdev)
@@ -370,7 +369,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtw_free_drv_sw(padapter);
 handle_dualmac:
 	rtw_handle_dualmac(padapter, 0);
-free_adapter:
 	if (pnetdev)
 		rtw_free_netdev(pnetdev);
 	else
-- 
2.30.2

