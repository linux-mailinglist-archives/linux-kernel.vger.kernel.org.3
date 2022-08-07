Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32158BC50
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiHGSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiHGSPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FAC6544
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j8so12844993ejx.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVLvkERwu7NE7/vOFxkPdswTEThZ3FDfNhElponhDZA=;
        b=TvLuaoGXQuyXyXbs3bOgtscD7X36Y91pWCdezxKHi8NHJY22bcgohfFJvLJTW591Zo
         yuhJUCiVINg/yPPnwQPsUuGt0yWia4tk6MWfo+9Cg8VCIq+LkTCXZdQLg1VxCHf2fVxx
         vPc4YKv6EVUGlaJAjmlLuOXffIX9IqDQbJqhzxfEynOvGH1xdf8zS+Mn69XI1igjb6eZ
         aHyaFdFwpqOXYkrlylB0MmGopPBCjsKH01zhEWr07kLxYZn+y+/uYO2zfpC14sGvqsXH
         2UcMx5ATose+CNgqDcWojmpb3uXiBjF4RhVk2aozDCgLmdUN2poDrYDZbt2wkhXSlr+k
         Ta7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVLvkERwu7NE7/vOFxkPdswTEThZ3FDfNhElponhDZA=;
        b=A61N01I+hmLUw1XF/Uqqya89eWd+Fea8GwCIBmvjUQ1jKMAssdk7AyOmCpmRu+2NRk
         Grrbh1PXD/xyeNq5b6n1DQji4T3If9+SHL3uqO0yCtTYxO9qndLzj7V7DYVB9HCG87jH
         R54ODBEhvsy5pL+j37Y+l7ElhiYI9i8U3soP1Deyt4Pbl20Qx2LU4W1poKAkKM7GsC/+
         Y891m43ngaGmUvhd7FQWuistciYIj6yc/ZFkk2gbpItZTgwCV/uVJUz/kzBuMHKRwnSr
         yQeajUOXq43f5Zk5OTb/KEHAxc1lgpr0O5iUhI4swK50CfKs2ylXnciWdFpBTJ9xq3dL
         wUqg==
X-Gm-Message-State: ACgBeo0vpC9nwkAwiLoq/6p+0rYTvMKoo15fFYp3iPw5WQlD4R3zLHIg
        33SwF7pN5qnxTxk8PD2osRg=
X-Google-Smtp-Source: AA6agR44R3Z8fQXwRs1p2O4uI8VRWxLh1iUyUr39Gg9EWl3gNUmzQYmdWD6ZGqKbvsI4j6oH/nhWaQ==
X-Received: by 2002:a17:906:c781:b0:726:c967:8d1b with SMTP id cw1-20020a170906c78100b00726c9678d1bmr11526693ejb.54.1659896151815;
        Sun, 07 Aug 2022 11:15:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb84.dynamic.kabel-deutschland.de. [95.90.187.132])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0072b92daef1csm4157441ejb.146.2022.08.07.11.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:15:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: make rtw_recv_indicatepkt() static
Date:   Sun,  7 Aug 2022 20:15:37 +0200
Message-Id: <20220807181538.8499-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807181538.8499-1-straube.linux@gmail.com>
References: <20220807181538.8499-1-straube.linux@gmail.com>
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

The function rtw_recv_indicatepkt() is only used in rtw_recv.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 79 +++++++++++++++++++
 drivers/staging/r8188eu/include/recv_osdep.h |  1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 81 --------------------
 3 files changed, 79 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 8f2b131eb767..ee3817c3e1fd 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1579,6 +1579,85 @@ static bool enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, s
 	return true;
 }
 
+static int rtw_recv_indicatepkt(struct adapter *padapter, struct recv_frame *precv_frame)
+{
+	struct recv_priv *precvpriv;
+	struct __queue *pfree_recv_queue;
+	struct sk_buff *skb;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+
+	precvpriv = &padapter->recvpriv;
+	pfree_recv_queue = &precvpriv->free_recv_queue;
+
+	skb = precv_frame->pkt;
+	if (!skb)
+		goto _recv_indicatepkt_drop;
+
+	skb->data = precv_frame->rx_data;
+
+	skb_set_tail_pointer(skb, precv_frame->len);
+
+	skb->len = precv_frame->len;
+
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+		struct sk_buff *pskb2 = NULL;
+		struct sta_info *psta = NULL;
+		struct sta_priv *pstapriv = &padapter->stapriv;
+		struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
+		bool bmcast = is_multicast_ether_addr(pattrib->dst);
+
+		if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
+			if (bmcast) {
+				psta = rtw_get_bcmc_stainfo(padapter);
+				pskb2 = skb_clone(skb, GFP_ATOMIC);
+			} else {
+				psta = rtw_get_stainfo(pstapriv, pattrib->dst);
+			}
+
+			if (psta) {
+				struct net_device *pnetdev;
+
+				pnetdev = (struct net_device *)padapter->pnetdev;
+				skb->dev = pnetdev;
+				skb_set_queue_mapping(skb, rtw_recv_select_queue(skb));
+
+				rtw_xmit_entry(skb, pnetdev);
+
+				if (bmcast)
+					skb = pskb2;
+				else
+					goto _recv_indicatepkt_end;
+			}
+		}
+	}
+
+	rcu_read_lock();
+	rcu_dereference(padapter->pnetdev->rx_handler_data);
+	rcu_read_unlock();
+
+	skb->ip_summed = CHECKSUM_NONE;
+	skb->dev = padapter->pnetdev;
+	skb->protocol = eth_type_trans(skb, padapter->pnetdev);
+
+	netif_rx(skb);
+
+_recv_indicatepkt_end:
+
+	/*  pointers to NULL before rtw_free_recvframe() */
+	precv_frame->pkt = NULL;
+
+	rtw_free_recvframe(precv_frame, pfree_recv_queue);
+
+	return _SUCCESS;
+
+_recv_indicatepkt_drop:
+
+	/* enqueue back to free_recv_queue */
+	rtw_free_recvframe(precv_frame, pfree_recv_queue);
+
+	return _FAIL;
+}
+
 static bool recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctrl *preorder_ctrl, int bforced)
 {
 	struct list_head *phead, *plist;
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index 135fbb24fcbb..e824bfac067e 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -11,7 +11,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void _rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 s32  rtw_recv_entry(struct recv_frame *precv_frame);
-int rtw_recv_indicatepkt(struct adapter *adapter, struct recv_frame *recv_frame);
 void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
 
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 08dfe4482b8e..ccf23e7fc4ab 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -12,87 +12,6 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
 
-int rtw_recv_indicatepkt(struct adapter *padapter,
-			 struct recv_frame *precv_frame)
-{
-	struct recv_priv *precvpriv;
-	struct __queue *pfree_recv_queue;
-	struct sk_buff *skb;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	precvpriv = &padapter->recvpriv;
-	pfree_recv_queue = &precvpriv->free_recv_queue;
-
-	skb = precv_frame->pkt;
-	if (!skb)
-		goto _recv_indicatepkt_drop;
-
-	skb->data = precv_frame->rx_data;
-
-	skb_set_tail_pointer(skb, precv_frame->len);
-
-	skb->len = precv_frame->len;
-
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		struct sk_buff *pskb2 = NULL;
-		struct sta_info *psta = NULL;
-		struct sta_priv *pstapriv = &padapter->stapriv;
-		struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-		bool bmcast = is_multicast_ether_addr(pattrib->dst);
-
-		if (memcmp(pattrib->dst, myid(&padapter->eeprompriv),
-				 ETH_ALEN)) {
-			if (bmcast) {
-				psta = rtw_get_bcmc_stainfo(padapter);
-				pskb2 = skb_clone(skb, GFP_ATOMIC);
-			} else {
-				psta = rtw_get_stainfo(pstapriv, pattrib->dst);
-			}
-
-			if (psta) {
-				struct net_device *pnetdev;
-
-				pnetdev = (struct net_device *)padapter->pnetdev;
-				skb->dev = pnetdev;
-				skb_set_queue_mapping(skb, rtw_recv_select_queue(skb));
-
-				rtw_xmit_entry(skb, pnetdev);
-
-				if (bmcast)
-					skb = pskb2;
-				else
-					goto _recv_indicatepkt_end;
-			}
-		}
-	}
-
-	rcu_read_lock();
-	rcu_dereference(padapter->pnetdev->rx_handler_data);
-	rcu_read_unlock();
-
-	skb->ip_summed = CHECKSUM_NONE;
-	skb->dev = padapter->pnetdev;
-	skb->protocol = eth_type_trans(skb, padapter->pnetdev);
-
-	netif_rx(skb);
-
-_recv_indicatepkt_end:
-
-	/*  pointers to NULL before rtw_free_recvframe() */
-	precv_frame->pkt = NULL;
-
-	rtw_free_recvframe(precv_frame, pfree_recv_queue);
-
-	return _SUCCESS;
-
-_recv_indicatepkt_drop:
-
-	 /* enqueue back to free_recv_queue */
-		rtw_free_recvframe(precv_frame, pfree_recv_queue);
-
-	 return _FAIL;
-}
-
 static void _rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
 {
 	struct recv_reorder_ctrl *preorder_ctrl;
-- 
2.37.1

