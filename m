Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5F48F817
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiAOQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiAOQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:56:01 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB5C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:56:01 -0800 (PST)
Received: from dslb-178-004-201-171.178.004.pools.vodafone-ip.de ([178.4.201.171] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n8mLM-0005N8-NC; Sat, 15 Jan 2022 17:55:56 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/11] staging: r8188eu: remove rtw_netif_wake_queue wrapper
Date:   Sat, 15 Jan 2022 17:55:33 +0100
Message-Id: <20220115165536.231210-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115165536.231210-1-martin@kaiser.cx>
References: <20220115165536.231210-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rtw_netif_wake_queue wrapper function. Call
netif_tx_wake_all_queues directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/osdep_service.h | 5 -----
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index e52e78b2c6b0..b8f983a1254e 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -67,11 +67,6 @@ static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
 		netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 3));
 }
 
-static inline void rtw_netif_wake_queue(struct net_device *pnetdev)
-{
-	netif_tx_wake_all_queues(pnetdev);
-}
-
 static inline void rtw_netif_start_queue(struct net_device *pnetdev)
 {
 	netif_tx_start_all_queues(pnetdev);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 08d719822062..2e4ad090c77c 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -656,7 +656,7 @@ int _netdev_open(struct net_device *pnetdev)
 	if (!rtw_netif_queue_stopped(pnetdev))
 		rtw_netif_start_queue(pnetdev);
 	else
-		rtw_netif_wake_queue(pnetdev);
+		netif_tx_wake_all_queues(pnetdev);
 
 	netdev_br_init(pnetdev);
 
-- 
2.30.2

