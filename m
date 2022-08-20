Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B159AF7F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiHTSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiHTSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181E30F68
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id io12so2178796ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=88oHSzQ0vTHS0TxhRNvuFrIFb5k3LWgW3oAtlKkp/5g=;
        b=cWvX/3XYWw1VWHai/C2N4aD2DL5E9rQkXXxX7Z/rbs4P8owd0RWXpSDsK9eAdCM4UL
         RzZY4WyrXMYIvqzqYpGSqaCYbloJs9190wWQXGbCp84x25/yiOTKbtipJzemfjkzyWt+
         fsft6WFJvpbySkTgRg1yE+V01xzvoKsSqTkx97e37470UGXPBvQbyp6Xa9dgGcAqvxZ/
         KbJrwZnr4kyHD7La34IPWj0goNyvtxNklwhL36q33JO1JX5q80AilSwgrewv0T8YDlaE
         alMDCWq7dg6xsHpF/Z2BReDF45yN2CzWl55SllyczRRzz0taQFPnUbybKDT0CFhDNnb5
         NgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=88oHSzQ0vTHS0TxhRNvuFrIFb5k3LWgW3oAtlKkp/5g=;
        b=XMSPobggLLi3rWA1raDgnaOoreMzpYfawkplw6zfqZ4//unbITvR1VkKxEoF2b/DHQ
         RLjgl99Y4KL3oGvKtZiGxh83e1hJf6E8uDR8MAUQ3aJ6j+MGTPsAGhS/KpRkvWQ0hl5K
         quhQOkMNctrM1lc4WD+bK8Qnxp/9g9e+uwNUjg8LCrHYe7q7ibqiX+HDx9544vWQ32Q5
         ddx0wRQTtmNP3VF4+tSvabxO9mF2IqS0an6JMyo7kbgS6uEg70jbgv8v7qVVddVnH58+
         6cEoAIBzl7icta9nrkFHxRAqR/BY59gmjiMrBibt3lTTHoS4b8vXOW0nxnAEnXInYmf+
         kgRw==
X-Gm-Message-State: ACgBeo3FKA0nGUf68uhpIVtkQKJp/991uqoOzvpWXocGWNgiU20TQNLd
        g6ROVkVfJSjgrerJe9DPXii3wUuKqho=
X-Google-Smtp-Source: AA6agR5bLCKHk3jgTFpxnCTHYYLw6AWbWkNdbHL8hGi0BltBIa8RQZNCEsEJ7WDueawwZxhZ4szQ/g==
X-Received: by 2002:a17:907:28c8:b0:730:9ccc:331f with SMTP id en8-20020a17090728c800b007309ccc331fmr8060357ejc.608.1661019408684;
        Sat, 20 Aug 2022 11:16:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 18/19] staging: r8188eu: remove os_dep/xmit_linux.c
Date:   Sat, 20 Aug 2022 20:16:22 +0200
Message-Id: <20220820181623.12497-19-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the last remaining function rtw_xmit_entry(), and the static
functions it calls, from os_dep/xmit_linux.c to core/rtw_xmit.c and
remove the now empty file os_dep/xmit_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile             |   1 -
 drivers/staging/r8188eu/core/rtw_xmit.c      | 102 ++++++++++++++++
 drivers/staging/r8188eu/include/rtw_xmit.h   |   1 +
 drivers/staging/r8188eu/include/xmit_osdep.h |   2 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 115 -------------------
 5 files changed, 103 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index b38fb8157d79..afafe6957155 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -27,7 +27,6 @@ r8188eu-y = \
 		os_dep/osdep_service.o \
 		os_dep/usb_intf.o \
 		os_dep/usb_ops_linux.o \
-		os_dep/xmit_linux.o \
 		core/rtw_ap.o \
 		core/rtw_br_ext.o \
 		core/rtw_cmd.o \
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f8d6f458b83e..d41d1d09d8ae 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -2226,3 +2226,105 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
 }
+
+static void rtw_check_xmit_resource(struct adapter *padapter, struct sk_buff *pkt)
+{
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	u16 queue;
+
+	queue = skb_get_queue_mapping(pkt);
+	if (padapter->registrypriv.wifi_spec) {
+		/* No free space for Tx, tx_worker is too slow */
+		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD)
+			netif_stop_subqueue(padapter->pnetdev, queue);
+	} else {
+		if (pxmitpriv->free_xmitframe_cnt <= 4) {
+			if (!netif_tx_queue_stopped(netdev_get_tx_queue(padapter->pnetdev, queue)))
+				netif_stop_subqueue(padapter->pnetdev, queue);
+		}
+	}
+}
+
+static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
+{
+	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct list_head *phead, *plist;
+	struct sk_buff *newskb;
+	struct sta_info *psta = NULL;
+	s32 res;
+
+	spin_lock_bh(&pstapriv->asoc_list_lock);
+	phead = &pstapriv->asoc_list;
+	plist = phead->next;
+
+	/* free sta asoc_queue */
+	while (phead != plist) {
+		psta = container_of(plist, struct sta_info, asoc_list);
+
+		plist = plist->next;
+
+		/* avoid   come from STA1 and send back STA1 */
+		if (!memcmp(psta->hwaddr, &skb->data[6], 6))
+			continue;
+
+		newskb = skb_copy(skb, GFP_ATOMIC);
+
+		if (newskb) {
+			memcpy(newskb->data, psta->hwaddr, 6);
+			res = rtw_xmit(padapter, &newskb);
+			if (res < 0) {
+				pxmitpriv->tx_drop++;
+				dev_kfree_skb_any(newskb);
+			} else {
+				pxmitpriv->tx_pkts++;
+			}
+		} else {
+			pxmitpriv->tx_drop++;
+
+			spin_unlock_bh(&pstapriv->asoc_list_lock);
+			return false;	/*  Caller shall tx this multicast frame via normal way. */
+		}
+	}
+
+	spin_unlock_bh(&pstapriv->asoc_list_lock);
+	dev_kfree_skb_any(skb);
+	return true;
+}
+
+int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
+{
+	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	s32 res = 0;
+
+	if (!rtw_if_up(padapter))
+		goto drop_packet;
+
+	rtw_check_xmit_resource(padapter, pkt);
+
+	if (!rtw_mc2u_disable && check_fwstate(pmlmepriv, WIFI_AP_STATE) &&
+	    (IP_MCAST_MAC(pkt->data) || ICMPV6_MCAST_MAC(pkt->data)) &&
+	    (padapter->registrypriv.wifi_spec == 0)) {
+		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME / 4)) {
+			res = rtw_mlcst2unicst(padapter, pkt);
+			if (res)
+				goto exit;
+		}
+	}
+
+	res = rtw_xmit(padapter, &pkt);
+	if (res < 0)
+		goto drop_packet;
+
+	pxmitpriv->tx_pkts++;
+	goto exit;
+
+drop_packet:
+	pxmitpriv->tx_drop++;
+	dev_kfree_skb_any(pkt);
+
+exit:
+	return 0;
+}
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index be9a7afad8ea..0d05ab9abcfb 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -368,6 +368,7 @@ int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms);
 void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
 
 void rtw_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe);
+int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev);
 
 /* include after declaring struct xmit_buf, in order to avoid warning */
 #include "xmit_osdep.h"
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index ae738d215e99..0a68b2dd8d5e 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -17,6 +17,4 @@ struct sta_xmit_priv;
 struct xmit_frame;
 struct xmit_buf;
 
-int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
-
 #endif /* __XMIT_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
deleted file mode 100644
index 4721447a02e8..000000000000
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2012 Realtek Corporation. */
-
-#define _XMIT_OSDEP_C_
-
-#include "../include/osdep_service.h"
-#include "../include/drv_types.h"
-#include "../include/wifi.h"
-#include "../include/mlme_osdep.h"
-#include "../include/xmit_osdep.h"
-#include "../include/osdep_intf.h"
-#include "../include/usb_osintf.h"
-
-static void rtw_check_xmit_resource(struct adapter *padapter, struct sk_buff *pkt)
-{
-	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	u16	queue;
-
-	queue = skb_get_queue_mapping(pkt);
-	if (padapter->registrypriv.wifi_spec) {
-		/* No free space for Tx, tx_worker is too slow */
-		if (pxmitpriv->hwxmits[queue].accnt > WMM_XMIT_THRESHOLD)
-			netif_stop_subqueue(padapter->pnetdev, queue);
-	} else {
-		if (pxmitpriv->free_xmitframe_cnt <= 4) {
-			if (!netif_tx_queue_stopped(netdev_get_tx_queue(padapter->pnetdev, queue)))
-				netif_stop_subqueue(padapter->pnetdev, queue);
-		}
-	}
-}
-
-static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
-{
-	struct	sta_priv *pstapriv = &padapter->stapriv;
-	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	struct list_head *phead, *plist;
-	struct sk_buff *newskb;
-	struct sta_info *psta = NULL;
-	s32	res;
-
-	spin_lock_bh(&pstapriv->asoc_list_lock);
-	phead = &pstapriv->asoc_list;
-	plist = phead->next;
-
-	/* free sta asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-
-		plist = plist->next;
-
-		/* avoid   come from STA1 and send back STA1 */
-		if (!memcmp(psta->hwaddr, &skb->data[6], 6))
-			continue;
-
-		newskb = skb_copy(skb, GFP_ATOMIC);
-
-		if (newskb) {
-			memcpy(newskb->data, psta->hwaddr, 6);
-			res = rtw_xmit(padapter, &newskb);
-			if (res < 0) {
-				pxmitpriv->tx_drop++;
-				dev_kfree_skb_any(newskb);
-			} else {
-				pxmitpriv->tx_pkts++;
-			}
-		} else {
-			pxmitpriv->tx_drop++;
-
-			spin_unlock_bh(&pstapriv->asoc_list_lock);
-			return false;	/*  Caller shall tx this multicast frame via normal way. */
-		}
-	}
-
-	spin_unlock_bh(&pstapriv->asoc_list_lock);
-	dev_kfree_skb_any(skb);
-	return true;
-}
-
-int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
-{
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
-	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	s32 res = 0;
-
-	if (!rtw_if_up(padapter))
-		goto drop_packet;
-
-	rtw_check_xmit_resource(padapter, pkt);
-
-	if (!rtw_mc2u_disable && check_fwstate(pmlmepriv, WIFI_AP_STATE) &&
-	    (IP_MCAST_MAC(pkt->data) || ICMPV6_MCAST_MAC(pkt->data)) &&
-	    (padapter->registrypriv.wifi_spec == 0)) {
-		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME / 4)) {
-			res = rtw_mlcst2unicst(padapter, pkt);
-			if (res)
-				goto exit;
-		}
-	}
-
-	res = rtw_xmit(padapter, &pkt);
-	if (res < 0)
-		goto drop_packet;
-
-	pxmitpriv->tx_pkts++;
-	goto exit;
-
-drop_packet:
-	pxmitpriv->tx_drop++;
-	dev_kfree_skb_any(pkt);
-
-exit:
-
-	return 0;
-}
-- 
2.37.2

