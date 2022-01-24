Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B142749ADB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445817AbiAYHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384884AbiAYDdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:33:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C49C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:59:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a13so16422700wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIvXI8t6EItnsvd8/VeaRNMMu5vgvkLf5krJnCpeeSo=;
        b=A+c5sVsYTLc3zAGl14REUlVyv3+lFhII/0WhDLkvAtIs3ocOEx9iAjwgQh2+B7uSHc
         6C3a1IWf9yzU0xwuI/Ova71IzxadrrGzaED0NH1CY31bzc9Fen3EYG+3IFK21YgQEahj
         dIjknXBcj3Gy1FZX8VABJ6hebqjC63Y6Rt/3w9M8FfGL/+BcNnewsVs3Frf73TP7jyH0
         CvBmcxEpBpzF16HecBrvr5VAk2w8tyHUrCLjsZcdasBdP9StzVgTCD0fvLnZ8RKcjOIC
         3abHLq8maoGcGbzP1iMTDbSYFLnMsK9nhiEGV3H2bwzR/3FpQrj0nOM6NQNtQXEcvm7V
         cDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIvXI8t6EItnsvd8/VeaRNMMu5vgvkLf5krJnCpeeSo=;
        b=gbKVVgp5a+yoqmt52cCggzG5SL3c1mmeJdC48hy0BAUrR0XRYhPpEvpTE49fd9O9l2
         XZnKrX9F0DaSeL0vIMbzqytzgdW7lOOZwmtuHlyjE4FiKYxAnpvw1zKer4MTQF27hFx3
         svyWt8Ta5Y99DIWd70QpSUa9BbESzDaJoWRt5pi3QRiWYmjcFYSH9n8WauSDGwaL0j5/
         0CAcHxQnORweLkAMFTrX2NmCeb0g/psFh0K4/Dpl2c1lRAn83SLosJaZQP/vaFg/U8Ts
         K8UVL50+p45P4oTCxMQIvMi/VdslSHBsGSb2Hxaly/7EQWlRvuj7rRpD16+FxNjBGxoT
         VTfA==
X-Gm-Message-State: AOAM5316cMmifIiTHumO10jwprMPpiE4+Wpttmj3vRtHCqgJvD8JzyJn
        UXtI8If44oNxw1mLvJ/VvbLQbg==
X-Google-Smtp-Source: ABdhPJwowTcZfju7nIyIU5pPUXtXcVDNu5/r43BtOuF4Qi9IbPEcp8YUcNtxJ6pt8EKBJtdex/WLkA==
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr16427977wrs.447.1643065192533;
        Mon, 24 Jan 2022 14:59:52 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id b2sm7705113wrd.64.2022.01.24.14.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:59:51 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 08/10] staging: r8188eu: remove all remaining aliased DBG_88E calls
Date:   Mon, 24 Jan 2022 22:59:48 +0000
Message-Id: <20220124225950.784-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124225032.860-1-phil@philpotter.co.uk>
References: <20220124225032.860-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all remaining calls to preprocessor aliases of DBG_88E, as well
as these definitions themselves, so that we can finally remove DBG_88E.
This patch triggers several style related checkpatch warnings due to
line lengths, placement of constants and '+' operators being too
squished together. As these are pre-existing issues, they are better
solved with a separate patch series that is more in scope.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c    | 59 +++-----------------
 drivers/staging/r8188eu/core/rtw_xmit.c      | 22 ++------
 drivers/staging/r8188eu/include/rtw_br_ext.h |  5 --
 3 files changed, 13 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 4951f835feaf..5516d35b2c36 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -71,10 +71,8 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	int data_len;
 
 	data_len = tag->tag_len + TAG_HDR_LEN;
-	if (skb_tailroom(skb) < data_len) {
-		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
+	if (skb_tailroom(skb) < data_len)
 		return -1;
-	}
 
 	skb_put(skb, data_len);
 	/*  have a room for new tag */
@@ -163,9 +161,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 8) {
 			mac = scan_tlv(&data[8], len-8, 1, 1);
 			if (mac) {
-				_DEBUG_INFO("Router Solicitation, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -174,9 +169,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 16) {
 			mac = scan_tlv(&data[16], len-16, 1, 1);
 			if (mac) {
-				_DEBUG_INFO("Router Advertisement, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -185,9 +177,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 24) {
 			mac = scan_tlv(&data[24], len-24, 1, 1);
 			if (mac) {
-				_DEBUG_INFO("Neighbor Solicitation, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -196,9 +185,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 24) {
 			mac = scan_tlv(&data[24], len-24, 2, 1);
 			if (mac) {
-				_DEBUG_INFO("Neighbor Advertisement, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -207,9 +193,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 40) {
 			mac = scan_tlv(&data[40], len-40, 2, 1);
 			if (mac) {
-				_DEBUG_INFO("Redirect,  replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -404,10 +387,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 	if (protocol == ETH_P_IP) {
 		struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
 
-		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len)) {
-			DEBUG_WARN("NAT25: malformed IP packet !\n");
+		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len))
 			return -1;
-		}
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -418,7 +399,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			if (iph->saddr == 0)
 				return 0;
 			tmp = be32_to_cpu(iph->saddr);
-			DEBUG_INFO("NAT25: Insert IP, SA =%08x, DA =%08x\n", tmp, iph->daddr);
 			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
 			/* record source IP address and , source mac address into db */
 			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
@@ -436,18 +416,13 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		unsigned char *arp_ptr = (unsigned char *)(arp + 1);
 		unsigned int *sender;
 
-		if (arp->ar_pro != __constant_htons(ETH_P_IP)) {
-			DEBUG_WARN("NAT25: arp protocol unknown (%4x)!\n", be16_to_cpu(arp->ar_pro));
+		if (arp->ar_pro != __constant_htons(ETH_P_IP))
 			return -1;
-		}
 
 		switch (method) {
 		case NAT25_CHECK:
 			return 0;	/*  skb_copy for all ARP frame */
 		case NAT25_INSERT:
-			DEBUG_INFO("NAT25: Insert ARP, MAC =%02x%02x%02x%02x%02x%02x\n", arp_ptr[0],
-				arp_ptr[1], arp_ptr[2], arp_ptr[3], arp_ptr[4], arp_ptr[5]);
-
 			/*  change to ARP sender mac address to wlan STA address */
 			memcpy(arp_ptr, GET_MY_HWADDR(priv), ETH_ALEN);
 			arp_ptr += arp->ar_hln;
@@ -484,18 +459,14 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						pOldTag = (struct pppoe_tag *)__nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
 						if (pOldTag) { /*  if SID existed, copy old value and delete it */
 							old_tag_len = ntohs(pOldTag->tag_len);
-							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf)) {
-								DEBUG_ERR("SID tag length too long!\n");
+							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf))
 								return -1;
-							}
 
 							memcpy(tag->tag_data+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN,
 								pOldTag->tag_data, old_tag_len);
 
-							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0) {
-								DEBUG_ERR("call skb_pull_and_merge() failed in PADI/R packet!\n");
+							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0)
 								return -1;
-							}
 							ph->length = htons(ntohs(ph->length)-TAG_HDR_LEN-old_tag_len);
 						}
 
@@ -511,14 +482,10 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						if (__nat25_add_pppoe_tag(skb, tag) < 0)
 							return -1;
 
-						DEBUG_INFO("NAT25: Insert PPPoE, forward %s packet\n",
-										(ph->code == PADI_CODE ? "PADI" : "PADR"));
 					} else { /*  not add relay tag */
 						if (priv->pppoe_connection_in_progress &&
-								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))	 {
-							DEBUG_ERR("Discard PPPoE packet due to another PPPoE connection is in progress!\n");
+								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
 							return -2;
-						}
 
 						if (priv->pppoe_connection_in_progress == 0)
 							memcpy(priv->pppoe_addr, skb->data+ETH_ALEN, ETH_ALEN);
@@ -529,8 +496,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					return -1;
 				}
 			} else {	/*  session phase */
-				DEBUG_INFO("NAT25: Insert PPPoE, insert session packet to %s\n", skb->dev->name);
-
 				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
 
 				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
@@ -576,10 +541,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*------------------------------------------------*/
 		struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + ETH_HLEN);
 
-		if (sizeof(*iph) >= (skb->len - ETH_HLEN)) {
-			DEBUG_WARN("NAT25: malformed IPv6 packet !\n");
+		if (sizeof(*iph) >= (skb->len - ETH_HLEN))
 			return -1;
-		}
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -587,13 +550,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 				return 0;
 			return -1;
 		case NAT25_INSERT:
-			DEBUG_INFO("NAT25: Insert IP, SA =%4x:%4x:%4x:%4x:%4x:%4x:%4x:%4x,"
-							" DA =%4x:%4x:%4x:%4x:%4x:%4x:%4x:%4x\n",
-				iph->saddr.s6_addr16[0], iph->saddr.s6_addr16[1], iph->saddr.s6_addr16[2], iph->saddr.s6_addr16[3],
-				iph->saddr.s6_addr16[4], iph->saddr.s6_addr16[5], iph->saddr.s6_addr16[6], iph->saddr.s6_addr16[7],
-				iph->daddr.s6_addr16[0], iph->daddr.s6_addr16[1], iph->daddr.s6_addr16[2], iph->daddr.s6_addr16[3],
-				iph->daddr.s6_addr16[4], iph->daddr.s6_addr16[5], iph->daddr.s6_addr16[6], iph->daddr.s6_addr16[7]);
-
 			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
 				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
 				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
@@ -669,7 +625,6 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 							/*  if not broadcast */
 							register int sum = 0;
 
-							DEBUG_INFO("DHCP: change flag of DHCP request to broadcast.\n");
 							/*  or BROADCAST flag */
 							dhcph->flags |= htons(BROADCAST_FLAG);
 							/*  recalculate checksum */
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index eebadb0bee5b..ab6d13aba744 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1588,10 +1588,8 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 				}
 
 				newskb = skb_copy(skb, GFP_ATOMIC);
-				if (!newskb) {
-					DEBUG_ERR("TX DROP: skb_copy fail!\n");
+				if (!newskb)
 					return -1;
-				}
 				dev_kfree_skb_any(skb);
 
 				*pskb = skb = newskb;
@@ -1603,21 +1601,15 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 				}
 			}
 
-			if (skb_is_nonlinear(skb))
-				DEBUG_ERR("%s(): skb_is_nonlinear!!\n", __func__);
-
 			res = skb_linearize(skb);
-			if (res < 0) {
-					DEBUG_ERR("TX DROP: skb_linearize fail!\n");
+			if (res < 0)
 					return -1;
-			}
 
 			res = nat25_db_handle(padapter, skb, NAT25_INSERT);
 			if (res < 0) {
-				if (res == -2) {
-					DEBUG_ERR("TX DROP: nat25_db_handle fail!\n");
+				if (res == -2)
 					return -1;
-				}
+
 				return 0;
 			}
 		}
@@ -1636,11 +1628,9 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	}
 
 	/*  check if SA is equal to our MAC */
-	if (memcmp(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN)) {
-		DEBUG_ERR("TX DROP: untransformed frame SA:%02X%02X%02X%02X%02X%02X!\n",
-			  skb->data[6], skb->data[7], skb->data[8], skb->data[9], skb->data[10], skb->data[11]);
+	if (memcmp(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN))
 		return -1;
-	}
+
 	return 0;
 }
 
diff --git a/drivers/staging/r8188eu/include/rtw_br_ext.h b/drivers/staging/r8188eu/include/rtw_br_ext.h
index 17a6154e760a..56772af3bec5 100644
--- a/drivers/staging/r8188eu/include/rtw_br_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_br_ext.h
@@ -4,11 +4,6 @@
 #ifndef _RTW_BR_EXT_H_
 #define _RTW_BR_EXT_H_
 
-#define _DEBUG_ERR		DBG_88E
-#define _DEBUG_INFO		DBG_88E
-#define DEBUG_WARN		DBG_88E
-#define DEBUG_INFO		DBG_88E
-#define DEBUG_ERR		DBG_88E
 #define GET_MY_HWADDR(padapter)		((padapter)->eeprompriv.mac_addr)
 
 #define NAT25_HASH_BITS		4
-- 
2.34.1

