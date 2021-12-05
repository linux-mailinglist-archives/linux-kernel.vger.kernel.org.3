Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B44468BA0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhLEPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhLEPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:40 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFFC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:13 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCO-0007gF-UU; Sun, 05 Dec 2021 16:13:09 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/10] staging: r8188eu: remove two unused macros
Date:   Sun,  5 Dec 2021 16:12:44 +0100
Message-Id: <20211205151251.6861-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
References: <20211205151251.6861-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two unused macros that increment and decrement a "mutex counter".

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/osdep_service.h    | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 5d8b567a3165..6c8241372a06 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -74,24 +74,6 @@ static inline void _cancel_timer(struct timer_list *ptimer,u8 *bcancelled)
 #define RTW_TIMER_HDL_NAME(name) rtw_##name##_timer_hdl
 #define RTW_DECLARE_TIMER_HDL(name) void RTW_TIMER_HDL_NAME(name)(RTW_TIMER_HDL_ARGS)
 
-/*  */
-/*  Global Mutex: can only be used at PASSIVE level. */
-/*  */
-
-#define ACQUIRE_GLOBAL_MUTEX(_MutexCounter)                              \
-{                                                               \
-	while (atomic_inc_return((atomic_t *)&(_MutexCounter)) != 1)\
-	{                                                           \
-		atomic_dec((atomic_t *)&(_MutexCounter));        \
-		msleep(10);                          \
-	}                                                           \
-}
-
-#define RELEASE_GLOBAL_MUTEX(_MutexCounter)                              \
-{                                                               \
-	atomic_dec((atomic_t *)&(_MutexCounter));        \
-}
-
 static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
 {
 	return  netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 0)) &&
-- 
2.20.1

