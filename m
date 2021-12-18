Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6119479AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhLRMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhLRMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:04:41 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 04:04:40 -0800 (PST)
Received: from dslb-178-004-169-039.178.004.pools.vodafone-ip.de ([178.4.169.39] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1myYS4-0008I6-SR; Sat, 18 Dec 2021 13:04:36 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/9] staging: r8188: make rx signal strength function static
Date:   Sat, 18 Dec 2021 13:04:15 +0100
Message-Id: <20211218120423.29906-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211218120423.29906-1-martin@kaiser.cx>
References: <20211218120423.29906-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _linked_rx_signal_strength_display function is used only in
rtw_mlme_ext.c. Make the function static and remove the prototype.

While at it, fix a typo in the function name.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 8e04238fb5fc..0aa958f20cd6 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7124,8 +7124,7 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 Following are the functions for the timer handlers
 
 *****************************************************************************/
-void _linked_rx_signal_strehgth_display(struct adapter *padapter);
-void _linked_rx_signal_strehgth_display(struct adapter *padapter)
+static void _linked_rx_signal_strength_display(struct adapter *padapter)
 {
 	struct mlme_ext_priv    *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info    *pmlmeinfo = &pmlmeext->mlmext_info;
@@ -7186,7 +7185,7 @@ void linked_status_chk(struct adapter *padapter)
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 
 	if (padapter->bRxRSSIDisplay)
-		_linked_rx_signal_strehgth_display(padapter);
+		_linked_rx_signal_strength_display(padapter);
 
 	rtl8188e_sreset_linked_status_check(padapter);
 
-- 
2.20.1

