Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837E4DA441
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351850AbiCOUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351813AbiCOUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:52:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E154F9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:51:05 -0700 (PDT)
Received: from ipservice-092-217-079-029.092.217.pools.vodafone-ip.de ([92.217.79.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nUE8D-00084h-Lf; Tue, 15 Mar 2022 21:51:01 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 6/6] staging: r8188eu: remove local BIT macro
Date:   Tue, 15 Mar 2022 21:50:41 +0100
Message-Id: <20220315205041.2714168-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220315205041.2714168-1-martin@kaiser.cx>
References: <20220315205041.2714168-1-martin@kaiser.cx>
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

The r8188eu driver defines a local BIT(x) macro. Remove this local macro
and use the one from include/linux/bits.h.

The global BIT macro returns an unsigned long value. Therefore, we have to
cast DYNAMIC_BB_DYNAMIC_TXPWR to u32 explicitly. This define is used with
the bitwise not operator.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - cast DYNAMIC_BB_DYNAMIC_TXPWR to u32, fix build error on 64-bit systems

 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/r8188eu/include/wifi.h         | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 0c555ea6719b..2b5089be5156 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -34,7 +34,7 @@
 /*  BB ODM section BIT 0-15 */
 #define	DYNAMIC_BB_DIG				BIT(0)
 #define	DYNAMIC_BB_RA_MASK			BIT(1)
-#define	DYNAMIC_BB_DYNAMIC_TXPWR	BIT(2)
+#define	DYNAMIC_BB_DYNAMIC_TXPWR	((u32)BIT(2))
 #define	DYNAMIC_BB_BB_FA_CNT			BIT(3)
 
 #define		DYNAMIC_BB_RSSI_MONITOR		BIT(4)
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index c331be19ff83..299553351246 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -4,14 +4,9 @@
 #ifndef _WIFI_H_
 #define _WIFI_H_
 
+#include <linux/bits.h>
 #include <linux/ieee80211.h>
 
-#ifdef BIT
-/* error	"BIT define occurred earlier elsewhere!\n" */
-#undef BIT
-#endif
-#define BIT(x)	(1 << (x))
-
 #define WLAN_ETHHDR_LEN		14
 #define WLAN_HDR_A3_LEN		24
 #define WLAN_HDR_A3_QOS_LEN	26
-- 
2.30.2

