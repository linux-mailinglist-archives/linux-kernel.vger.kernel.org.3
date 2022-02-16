Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6234B7C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbiBPBIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:08:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiBPBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A94F5426
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k41so302812wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pe1YhcenILuxLMzLegUaCOIgZ9zKkkyLJdVofXmoRlI=;
        b=vZsq0j+TuFR7s+y8MK7IsKnXmNwJrTHOBP6FmnPimvCKYQXz6fpf9xH1yizlkq0pFX
         sthBIvtqgVyEiePuMr56AYPb4v/9WL3g6wlIZvBrgJ328epHBe0cwDZ76ZJZzmtnS5vW
         6uMjKPQIjzNS0y9M6/CH4MOpZnZa1d4N3AnmHxq4aeF0SyBvBtouzsIdsAjT9Y6bSiTz
         GBKsR6nkPP7Ref9yYZgRYif0J2QVN8fftGYmR8bZPAftMWkoJwIfNMMY5+jXQh74s7jr
         SrxqhlEMvjSbANAX3KZZfJkvXe2BM5AjnkCB9QG1xVWwCCsfObxgwzQ1sWDIaziiwcBT
         4Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pe1YhcenILuxLMzLegUaCOIgZ9zKkkyLJdVofXmoRlI=;
        b=FbJYkdiCLOOY9rvpSEV98WDeUUgff/BAYNnCZGqE4WYM3lzLD1f4GugoT7Es+McjlK
         W/NTWTIidMJeza7d4+Mhq1i0Bp0dsFjeKIj1FhNEO6ootf0BWGlDsq1QKU1xKG68nIOa
         KfexsvYvRM/bCSgZeOxLpCZZICeMWVoK8XEn+xF4gNm8cE1O9GF4FCW5Cy2G2j0mW/8e
         ls0j5EJIRcecdKo5NoY0hAW2QMtvFYZCUyO/BwjX16n381txon0Wwh4oV6uMZ4tIiZet
         OQRN9Wocf8OpTJXrkA59VuTs2FPBYmZr8BgD4RXpFifZFNRRtvaqXf1TlV4dcDUMfs+E
         dkpg==
X-Gm-Message-State: AOAM53057yo4YrrvoL6z5zdawmY2rbUaEwZDn6hHqQtzvZtMyZx8QTUT
        e12oL04KGiHoTOAE/LSAzdERHQ==
X-Google-Smtp-Source: ABdhPJxxa/CL55oEDhNXzABKxnMPmaW/dA3iDp86Y11vpgIN5YyW5jcmF76opU4n5uAX8BYlYFqEfA==
X-Received: by 2002:a7b:c44c:0:b0:37b:baaf:ae36 with SMTP id l12-20020a7bc44c000000b0037bbaafae36mr367673wmi.81.1644973638941;
        Tue, 15 Feb 2022 17:07:18 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:18 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 09/15] staging: r8188eu: remove all aliased DBG_88E calls
Date:   Wed, 16 Feb 2022 01:07:03 +0000
Message-Id: <20220216010709.791-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all remaining calls to preprocessor aliases of DBG_88E, as well
as these definitions themselves. This is a prerequisite for removing
the DBG_88E macro itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c    | 39 --------------------
 drivers/staging/r8188eu/core/rtw_xmit.c      |  7 +---
 drivers/staging/r8188eu/include/rtw_br_ext.h |  5 ---
 3 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 5c40babcd45c..6fa27b66920e 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -72,7 +72,6 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 
 	data_len = tag->tag_len + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
-		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
 	}
 
@@ -162,9 +161,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 8) {
 			mac = scan_tlv(&data[8], len-8, 1, 1);
 			if (mac) {
-				_DEBUG_INFO("Router Solicitation, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -173,9 +169,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 16) {
 			mac = scan_tlv(&data[16], len-16, 1, 1);
 			if (mac) {
-				_DEBUG_INFO("Router Advertisement, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -184,9 +177,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 24) {
 			mac = scan_tlv(&data[24], len-24, 1, 1);
 			if (mac) {
-				_DEBUG_INFO("Neighbor Solicitation, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -195,9 +185,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 24) {
 			mac = scan_tlv(&data[24], len-24, 2, 1);
 			if (mac) {
-				_DEBUG_INFO("Neighbor Advertisement, replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -206,9 +193,6 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 		if (len >= 40) {
 			mac = scan_tlv(&data[40], len-40, 2, 1);
 			if (mac) {
-				_DEBUG_INFO("Redirect,  replace MAC From: %02x:%02x:%02x:%02x:%02x:%02x, To: %02x:%02x:%02x:%02x:%02x:%02x\n",
-					mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
-					replace_mac[0], replace_mac[1], replace_mac[2], replace_mac[3], replace_mac[4], replace_mac[5]);
 				memcpy(mac, replace_mac, 6);
 				return 1;
 			}
@@ -400,7 +384,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
 
 		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len)) {
-			DEBUG_WARN("NAT25: malformed IP packet !\n");
 			return -1;
 		}
 
@@ -413,7 +396,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			if (iph->saddr == 0)
 				return 0;
 			tmp = be32_to_cpu(iph->saddr);
-			DEBUG_INFO("NAT25: Insert IP, SA =%08x, DA =%08x\n", tmp, iph->daddr);
 			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
 			/* record source IP address and , source mac address into db */
 			__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
@@ -430,7 +412,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		unsigned int *sender;
 
 		if (arp->ar_pro != __constant_htons(ETH_P_IP)) {
-			DEBUG_WARN("NAT25: arp protocol unknown (%4x)!\n", be16_to_cpu(arp->ar_pro));
 			return -1;
 		}
 
@@ -438,9 +419,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		case NAT25_CHECK:
 			return 0;	/*  skb_copy for all ARP frame */
 		case NAT25_INSERT:
-			DEBUG_INFO("NAT25: Insert ARP, MAC =%02x%02x%02x%02x%02x%02x\n", arp_ptr[0],
-				arp_ptr[1], arp_ptr[2], arp_ptr[3], arp_ptr[4], arp_ptr[5]);
-
 			/*  change to ARP sender mac address to wlan STA address */
 			memcpy(arp_ptr, GET_MY_HWADDR(priv), ETH_ALEN);
 			arp_ptr += arp->ar_hln;
@@ -477,7 +455,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						if (pOldTag) { /*  if SID existed, copy old value and delete it */
 							old_tag_len = ntohs(pOldTag->tag_len);
 							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf)) {
-								DEBUG_ERR("SID tag length too long!\n");
 								return -1;
 							}
 
@@ -485,7 +462,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 								pOldTag->tag_data, old_tag_len);
 
 							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0) {
-								DEBUG_ERR("call skb_pull_and_merge() failed in PADI/R packet!\n");
 								return -1;
 							}
 							ph->length = htons(ntohs(ph->length)-TAG_HDR_LEN-old_tag_len);
@@ -502,13 +478,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						/* Add relay tag */
 						if (__nat25_add_pppoe_tag(skb, tag) < 0)
 							return -1;
-
-						DEBUG_INFO("NAT25: Insert PPPoE, forward %s packet\n",
-										(ph->code == PADI_CODE ? "PADI" : "PADR"));
 					} else { /*  not add relay tag */
 						if (priv->pppoe_connection_in_progress &&
 								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))	 {
-							DEBUG_ERR("Discard PPPoE packet due to another PPPoE connection is in progress!\n");
 							return -2;
 						}
 
@@ -521,8 +493,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					return -1;
 				}
 			} else {	/*  session phase */
-				DEBUG_INFO("NAT25: Insert PPPoE, insert session packet to %s\n", skb->dev->name);
-
 				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
 
 				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
@@ -567,7 +537,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + ETH_HLEN);
 
 		if (sizeof(*iph) >= (skb->len - ETH_HLEN)) {
-			DEBUG_WARN("NAT25: malformed IPv6 packet !\n");
 			return -1;
 		}
 
@@ -577,13 +546,6 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
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
@@ -658,7 +620,6 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 							/*  if not broadcast */
 							register int sum = 0;
 
-							DEBUG_INFO("DHCP: change flag of DHCP request to broadcast.\n");
 							/*  or BROADCAST flag */
 							dhcph->flags |= htons(BROADCAST_FLAG);
 							/*  recalculate checksum */
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 7d616a409c0c..3ad124f6f3c7 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1589,7 +1589,6 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 
 				newskb = skb_copy(skb, GFP_ATOMIC);
 				if (!newskb) {
-					DEBUG_ERR("TX DROP: skb_copy fail!\n");
 					return -1;
 				}
 				dev_kfree_skb_any(skb);
@@ -1604,18 +1603,16 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 			}
 
 			if (skb_is_nonlinear(skb))
-				DEBUG_ERR("%s(): skb_is_nonlinear!!\n", __func__);
+				;
 
 			res = skb_linearize(skb);
 			if (res < 0) {
-					DEBUG_ERR("TX DROP: skb_linearize fail!\n");
 					return -1;
 			}
 
 			res = nat25_db_handle(padapter, skb, NAT25_INSERT);
 			if (res < 0) {
 				if (res == -2) {
-					DEBUG_ERR("TX DROP: nat25_db_handle fail!\n");
 					return -1;
 				}
 				return 0;
@@ -1637,8 +1634,6 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 
 	/*  check if SA is equal to our MAC */
 	if (memcmp(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN)) {
-		DEBUG_ERR("TX DROP: untransformed frame SA:%02X%02X%02X%02X%02X%02X!\n",
-			  skb->data[6], skb->data[7], skb->data[8], skb->data[9], skb->data[10], skb->data[11]);
 		return -1;
 	}
 	return 0;
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

