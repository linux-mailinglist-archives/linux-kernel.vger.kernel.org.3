Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450234B7C33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiBPBI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:08:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245294AbiBPBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B97C7916
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so506865wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQeUL6hBFjGG5/ri65zEZYIgiZNYomsNgGD83ZDdqSg=;
        b=LLlNisjsbePSFTLapisou9ipJBC7jTqBn9chMDefehiCh7BB8qJvVcBBg8n2ytwkyS
         i+fwHtdohwl7rTJWoUdBiZx/090Oj6ateBF+m88W8BoYta992SIW+u6wX5DLWr/8QwK2
         mPu0e750zOdDzHkB9P8ScxBsbAfFE5cg3WOxWk4tdqpYlC3J9s/qQPTfO3CCVKs1B5lo
         oikxIpDk+Sgp7UruEljQrsYdky+4cBTcmVJy+O//wOp4SnQgbazFFW5+SpafW39TSWL7
         9ctf3xHj3V12gn/hklvduSOfG85E5dJp4JSbtzA41hxYLDRB50A1HwDWel/8Av3VGSyo
         4hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQeUL6hBFjGG5/ri65zEZYIgiZNYomsNgGD83ZDdqSg=;
        b=oJ4+ESYhLjeu0iO8bwEl4MyohmW9Zfw3GmVmKVOcmXS9TK7CIgbRbFJfcjI9gN26FQ
         ZNd/QNIApil4iSS+VXlX2V9+Vxp21AkqSl8akM6RZVH4Eu6SAsGZ5QPuuAHWLJXMkb7p
         uiEb11pwkSGblwuRUhB/h0na9dpOykg2jAHLnBE1ZW2NIHBS6lbdeC5SVvFSdzKHDpz1
         WVeIH09G+m10VHIKyRvbKy5Y24qctP66JEiKjim+iAMP5ghoG7+rQrhugYTTtMyn9G49
         oJARf/93GtTZQZuTcrV/SyuSB3rDFkd3iaGj64L/woSCs6zHPaF0bGxV69moySrAwmwO
         mvMw==
X-Gm-Message-State: AOAM530BaXDSrQ4Or3mUTcZcDoPJmpVwjwTGIgxSIMAhH3MEVKxVZpW8
        xpRsq4oZr6P7XVY74bY1RLCeNoghZNYhJ4JG
X-Google-Smtp-Source: ABdhPJzw7u5v6zczrnPV+omBUYP7kjMIxq5eKgIuFeUEXuzUoErkK7imd9+pFbhRomfcpOtkZiOkjQ==
X-Received: by 2002:a7b:c7c7:0:b0:37b:d0a7:c98d with SMTP id z7-20020a7bc7c7000000b0037bd0a7c98dmr365426wmk.191.1644973641562;
        Tue, 15 Feb 2022 17:07:21 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:20 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 12/15] staging: r8188eu: fix lines modified by DBG_88E cleanup
Date:   Wed, 16 Feb 2022 01:07:06 +0000
Message-Id: <20220216010709.791-13-phil@philpotter.co.uk>
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

A number of style problems were left behind by the DBG_88E cleanup:
(1) Empty if/else blocks.
(2) Parenthesised if/while statements containing only one line.
(3) Entire blocks which server zero purpose after removal of DBG_88E.
(4) Various warnings about whitespace, and constant comparison order.
(5) Use of __constant_htons instead when htons should be used.

Fix up these issues across the driver in any file touched by the
previous cleanup. Long line warnings will be addresses in a later
patch.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ap.c         |   4 -
 drivers/staging/r8188eu/core/rtw_br_ext.c     |  22 ++--
 drivers/staging/r8188eu/core/rtw_cmd.c        |   6 +-
 drivers/staging/r8188eu/core/rtw_fw.c         |  12 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |  18 +--
 drivers/staging/r8188eu/core/rtw_iol.c        |   6 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       |  11 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 123 ++++--------------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  25 ++--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  14 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  41 ++----
 drivers/staging/r8188eu/core/rtw_security.c   |   3 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  10 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  57 +++-----
 drivers/staging/r8188eu/core/rtw_xmit.c       |  43 +++---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   3 +-
 drivers/staging/r8188eu/hal/hal_intf.c        |   2 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  24 +---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  31 ++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   3 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   5 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |   6 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  22 +---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  12 +-
 drivers/staging/r8188eu/include/usb_ops.h     |   4 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 115 +++-------------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   9 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  24 ++--
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |   3 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   3 +-
 30 files changed, 161 insertions(+), 500 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 505517dbbf8c..ed66331de319 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -382,7 +382,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		psta->raid = raid;
 		psta->init_rate = init_rate;
 
-	} else {
 	}
 }
 
@@ -457,7 +456,6 @@ void update_bmc_sta(struct adapter *padapter)
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
 
-	} else {
 	}
 }
 
@@ -873,8 +871,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			psta->no_ht_set = 1;
 			pmlmepriv->num_sta_no_ht++;
 		}
-		if (pmlmepriv->htpriv.ht_option) {
-		}
 	}
 
 	if (rtw_ht_operation_update(padapter) > 0) {
diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 6fa27b66920e..ddc3a2c8aaca 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -71,9 +71,8 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	int data_len;
 
 	data_len = tag->tag_len + TAG_HDR_LEN;
-	if (skb_tailroom(skb) < data_len) {
+	if (skb_tailroom(skb) < data_len)
 		return -1;
-	}
 
 	skb_put(skb, data_len);
 	/*  have a room for new tag */
@@ -383,9 +382,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 	if (protocol == ETH_P_IP) {
 		struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
 
-		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len)) {
+		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len))
 			return -1;
-		}
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -411,9 +409,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		unsigned char *arp_ptr = (unsigned char *)(arp + 1);
 		unsigned int *sender;
 
-		if (arp->ar_pro != __constant_htons(ETH_P_IP)) {
+		if (arp->ar_pro != htons(ETH_P_IP))
 			return -1;
-		}
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -454,16 +451,15 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						pOldTag = (struct pppoe_tag *)__nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
 						if (pOldTag) { /*  if SID existed, copy old value and delete it */
 							old_tag_len = ntohs(pOldTag->tag_len);
-							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf)) {
+							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf))
 								return -1;
-							}
 
 							memcpy(tag->tag_data+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN,
 								pOldTag->tag_data, old_tag_len);
 
-							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0) {
+							if (skb_pull_and_merge(skb, (unsigned char *)pOldTag, TAG_HDR_LEN+old_tag_len) < 0)
 								return -1;
-							}
+
 							ph->length = htons(ntohs(ph->length)-TAG_HDR_LEN-old_tag_len);
 						}
 
@@ -480,9 +476,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 							return -1;
 					} else { /*  not add relay tag */
 						if (priv->pppoe_connection_in_progress &&
-								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))	 {
+								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
 							return -2;
-						}
 
 						if (priv->pppoe_connection_in_progress == 0)
 							memcpy(priv->pppoe_addr, skb->data+ETH_ALEN, ETH_ALEN);
@@ -536,9 +531,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*------------------------------------------------*/
 		struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + ETH_HLEN);
 
-		if (sizeof(*iph) >= (skb->len - ETH_HLEN)) {
+		if (sizeof(*iph) >= (skb->len - ETH_HLEN))
 			return -1;
-		}
 
 		switch (method) {
 		case NAT25_CHECK:
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 0ef74eb47893..a2ab4f0029bd 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -252,9 +252,8 @@ int rtw_cmd_thread(void *context)
 
 _next:
 		if (padapter->bDriverStopped ||
-		    padapter->bSurpriseRemoved) {
+		    padapter->bSurpriseRemoved)
 			break;
-		}
 
 		pcmd = rtw_dequeue_cmd(pcmdpriv);
 		if (!pcmd)
@@ -938,9 +937,8 @@ static void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 	u32 txdma_status;
 
 	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
-	if (txdma_status != 0x00) {
+	if (txdma_status != 0x00)
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
-	}
 	/* total xmit irp = 4 */
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 6d07927397de..625d186c3647 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -190,9 +190,8 @@ static int fw_free_to_go(struct adapter *padapter)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
-	if (counter >= POLLING_READY_TIMEOUT_COUNT) {
+	if (counter >= POLLING_READY_TIMEOUT_COUNT)
 		return _FAIL;
-	}
 
 	value32 = rtw_read32(padapter, REG_MCUFWDL);
 	value32 |= MCUFWDL_RDY;
@@ -205,9 +204,8 @@ static int fw_free_to_go(struct adapter *padapter)
 	counter = 0;
 	do {
 		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & WINTINI_RDY) {
+		if (value32 & WINTINI_RDY)
 			return _SUCCESS;
-		}
 		udelay(5);
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
@@ -304,14 +302,12 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 			break;
 	}
 	fw_download_enable(padapter, false);
-	if (ret != _SUCCESS) {
+	if (ret != _SUCCESS)
 		goto exit;
-	}
 
 	ret = fw_free_to_go(padapter);
-	if (ret != _SUCCESS) {
+	if (ret != _SUCCESS)
 		goto exit;
-	}
 
 exit:
 	return ret;
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index c8998cb276be..62354c3194bd 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -653,11 +653,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	/* first 3 bytes in vendor specific information element are the IEEE
 	 * OUI of the vendor. The following byte is used a vendor specific
 	 * sub-type. */
-	if (elen < 4) {
-		if (show_errors) {
-		}
+	if (elen < 4)
 		return -1;
-	}
 
 	oui = RTW_GET_BE24(pos);
 	switch (oui) {
@@ -672,9 +669,8 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wpa_ie_len = elen;
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
-			if (elen < 5) {
+			if (elen < 5)
 				return -1;
-			}
 			switch (pos[4]) {
 			case WME_OUI_SUBTYPE_INFORMATION_ELEMENT:
 			case WME_OUI_SUBTYPE_PARAMETER_ELEMENT:
@@ -740,11 +736,8 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 		elen = *pos++;
 		left -= 2;
 
-		if (elen > left) {
-			if (show_errors) {
-			}
+		if (elen > left)
 			return ParseFailed;
-		}
 
 		switch (id) {
 		case WLAN_EID_SSID:
@@ -825,8 +818,6 @@ enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			break;
 		default:
 			unknown++;
-			if (!show_errors)
-				break;
 			break;
 		}
 		left -= elen;
@@ -874,9 +865,8 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		ether_addr_copy(mac, mac_addr);
 	}
 
-	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac))
 		eth_random_addr(mac_addr);
-	}
 }
 
 /**
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 5f73413a4511..e14e3746efdd 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -11,9 +11,8 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 	struct xmit_priv	*pxmitpriv = &adapter->xmitpriv;
 
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
-	if (!xmit_frame) {
+	if (!xmit_frame)
 		return NULL;
-	}
 
 	xmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 	if (!xmitbuf) {
@@ -46,9 +45,8 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
 	ori_len = buf_offset + pattrib->pktlen;
 
 	/* check if the io_buf can accommodate new cmds */
-	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ) {
+	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ)
 		return _FAIL;
-	}
 
 	memcpy(xmit_frame->buf_addr + buf_offset + pattrib->pktlen, IOL_cmds, cmd_len);
 	pattrib->pktlen += cmd_len;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d7494d820756..45eff3018d73 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -610,9 +610,8 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 		}
 	}
 
-	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
+	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0))
 		bselected = false;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -1318,9 +1317,8 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 			pmlmepriv->to_roaming--;
 			if (rtw_to_roaming(adapter) != 0) { /* try another */
 				do_join_r = rtw_do_join(adapter);
-				if (_SUCCESS != do_join_r) {
+				if (do_join_r != _SUCCESS)
 					continue;
-				}
 				break;
 			} else {
 				rtw_indicate_disconnect(adapter);
@@ -1446,8 +1444,6 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 		*candidate = competitor;
 		updated = true;
 	}
-	if (updated) {
-	}
 
 exit:
 	return updated;
@@ -1486,7 +1482,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	if (!candidate) {
 		ret = _FAIL;
 		goto exit;
-	} else {
 	}
 
 	/*  check for situation of  _FW_LINKED */
@@ -1960,8 +1955,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 
 	/*  Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		;
 
 	/*  Config current HT Protection mode. */
 	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 4c557c279818..2b6dbabe47c8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -314,9 +314,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 
 	memset(channel_set, 0, sizeof(struct rt_channel_info) * MAX_CHANNEL_NUM);
 
-	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
+	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 		return chanset_size;
-	}
 
 	if (padapter->registrypriv.wireless_mode & WIRELESS_11G) {
 		b2_4GBand = true;
@@ -433,10 +432,9 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	if (psta) {
 		if (GetRetry(pframe)) {
-			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum) {
+			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum)
 				/* drop the duplicate management frame */
 				return;
-			}
 		}
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
@@ -931,15 +929,13 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		return _FAIL;
 
 	frame_type = GetFrameSubType(pframe);
-	if (frame_type == WIFI_ASSOCREQ) {
+	if (frame_type == WIFI_ASSOCREQ)
 		ie_offset = _ASOCREQ_IE_OFFSET_;
-	} else { /*  WIFI_REASSOCREQ */
+	else /*  WIFI_REASSOCREQ */
 		ie_offset = _REASOCREQ_IE_OFFSET_;
-	}
 
-	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset) {
+	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset)
 		return _FAIL;
-	}
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (pstat == (struct sta_info *)NULL) {
@@ -1085,14 +1081,13 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
 	if (!wpa_ie) {
-		if (elems.wps_ie) {
+		if (elems.wps_ie)
 			pstat->flags |= WLAN_STA_WPS;
 			/* wpabuf_free(sta->wps_ie); */
 			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
 			/*				elems.wps_ie_len - 4); */
-		} else {
+		else
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
-		}
 
 		/*  AP support WPA/RSN, and sta is going to do WPS, but AP is not ready */
 		/*  that the selected registrar of AP is _FLASE */
@@ -1202,14 +1197,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		goto OnAssocReqFail;
 	}
 
-	if ((pstat->flags & WLAN_STA_HT) &&
-	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
-	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
-
-		/* status = WLAN_STATUS_CIPHER_REJECTED_PER_POLICY; */
-		/* goto OnAssocReqFail; */
-	}
-
 	pstat->flags |= WLAN_STA_NONERP;
 	for (i = 0; i < pstat->bssratelen; i++) {
 		if ((pstat->bssrateset[i] & 0x7f) > 22) {
@@ -1248,8 +1235,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/*  Customer proprietary IE */
 
 	/* get a unique AID */
-	if (pstat->aid > 0) {
-	} else {
+	if (pstat->aid == 0) {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (!pstapriv->sta_aid[pstat->aid - 1])
 				break;
@@ -3597,13 +3583,11 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 
 	if (GetRetry(frame)) {
 		if (token >= 0) {
-			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token)) {
+			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token))
 				return _FAIL;
-			}
 		} else {
-			if (seq_ctrl == mlmeext->action_public_rxseq) {
+			if (seq_ctrl == mlmeext->action_public_rxseq)
 				return _FAIL;
-			}
 		}
 	}
 
@@ -3693,7 +3677,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 			pwdinfo->negotiation_dialog_token = 1;
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_FAIL))
 				_set_timer(&pwdinfo->restore_p2p_state_timer, 5000);
-		} else {
 		}
 		break;
 	case P2P_GO_NEGO_CONF:
@@ -3728,9 +3711,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 				/*	#> iwpriv wlan0 p2p_get peer_ifa */
 				/*	After having the peer interface address, the sigma can find the correct conf file for wpa_supplicant. */
 
-				if (attr_contentlen) {
-				}
-
 				if (invitation_flag & P2P_INVITATION_FLAGS_PERSISTENT) {
 					/*	Re-invoke the persistent group. */
 
@@ -4022,9 +4002,8 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 	struct xmit_buf				*pxmitbuf;
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		return NULL;
-	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (!pxmitbuf) {
@@ -4184,9 +4163,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		return;
-	}
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 
 	/* update attribute */
@@ -4366,9 +4344,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
-	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
+	if ((pattrib->pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -4397,9 +4374,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
+	if (!pmgntframe)
 		return;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -4641,13 +4617,6 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			;
-		else
-			;
-	}
 exit:
 	return ret;
 }
@@ -4979,11 +4948,6 @@ void issue_assocreq(struct adapter *padapter)
 	if (pmlmeext->cur_channel == 14)/*  for JAPAN, channel 14 can only uses B Mode(CCK) */
 		sta_bssrate_len = 4;
 
-	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
-		if (pmlmeinfo->network.SupportedRates[i] == 0)
-			break;
-	}
-
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
 		if (pmlmeinfo->network.SupportedRates[i] == 0)
 			break;
@@ -4996,12 +4960,9 @@ void issue_assocreq(struct adapter *padapter)
 				break;
 		}
 
-		if (j == sta_bssrate_len) {
-			/*  the rate is not supported by STA */
-		} else {
+		if (j != sta_bssrate_len)
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
-		}
 	}
 
 	bssrate_len = index;
@@ -5312,13 +5273,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			;
-		else
-			;
-	}
 exit:
 	return ret;
 }
@@ -5425,13 +5379,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			;
-		else
-			;
-	}
 exit:
 	return ret;
 }
@@ -5526,13 +5473,6 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			;
-		else
-			;
-	}
 exit:
 	return ret;
 }
@@ -5839,10 +5779,7 @@ unsigned int send_beacon(struct adapter *padapter)
 	if (!bxmitok) {
 		return _FAIL;
 	} else {
-		u32 passing_time = rtw_get_passing_time_ms(start);
-
-		if (passing_time > 100 || issue > 3)
-			;
+		rtw_get_passing_time_ms(start);
 
 		return _SUCCESS;
 	}
@@ -6051,14 +5988,12 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
-	if (!p) {
+	if (!p)
 		return _FAIL;
-	}
 
 	if (*(p + 1)) {
-		if (len > NDIS_802_11_LENGTH_SSID) {
+		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
-		}
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
 		bssid->Ssid.SsidLength = *(p + 1);
 	} else {
@@ -6071,18 +6006,16 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	i = 0;
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > NDIS_802_11_LENGTH_RATES_EX) {
+		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
-		}
 		memcpy(bssid->SupportedRates, (p + 2), len);
 		i = len;
 	}
 
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
 	if (p) {
-		if (len > (NDIS_802_11_LENGTH_RATES_EX - i)) {
+		if (len > (NDIS_802_11_LENGTH_RATES_EX - i))
 			return _FAIL;
-		}
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
 	}
 
@@ -6936,17 +6869,11 @@ static u8 chk_ap_is_alive(struct sta_info *psta)
 static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
 	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
-	u8 fw_status;
 
-	if (rx_dma_status != 0x00) {
+	if (rx_dma_status != 0x00)
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
-	}
 
-	fw_status = rtw_read8(padapter, REG_FMETHR);
-	if (fw_status == 1)
-		;
-	else if (fw_status == 2)
-		;
+	rtw_read8(padapter, REG_FMETHR);
 }
 
 void linked_status_chk(struct adapter *padapter)
@@ -7320,8 +7247,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 					default:
 						pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 						break;
-				}
-
+					}
 				}
 			}
 			break;
@@ -7574,9 +7500,8 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 		if (psta) {
 			ctrl = (BIT(15) | ((pparm->algorithm) << 2));
 
-			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4))) {
+			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4)))
 				return H2C_REJECTED;
-			}
 
 			cam_id = (psta->mac_id + 3);/* 0~3 for default key, cmd_id = macid + 3, macid = aid+1; */
 
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 8f4bad399bc4..9467a5dcc990 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -818,10 +818,8 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 
 	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
 
-	if (!p2p_ie) {
+	if (!p2p_ie)
 		status_code =  P2P_STATUS_FAIL_INVALID_PARAM;
-	} else {
-	}
 
 	while (p2p_ie) {
 		/* Check P2P Capability ATTR */
@@ -1156,15 +1154,14 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 						peer_operating_ch = operatingch_info[4];
 
 					if (rtw_p2p_is_channel_list_ok(peer_operating_ch,
-							       ch_list_inclusioned, ch_num_inclusioned)) {
+							       ch_list_inclusioned, ch_num_inclusioned))
 						/**
 						 *	Change our operating channel as peer's for compatibility.
 						 */
 						pwdinfo->operating_channel = peer_operating_ch;
-					} else {
+					else
 						/*  Take first channel of ch_list_inclusioned as operating channel */
 						pwdinfo->operating_channel = ch_list_inclusioned[0];
-					}
 				}
 			}
 		}
@@ -1189,8 +1186,7 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 
 	/*	Be able to know which one is the P2P GO and which one is P2P client. */
 
-	if (rtw_get_wps_ie(ies, ies_len, NULL, &wps_ielen)) {
-	} else {
+	if (!rtw_get_wps_ie(ies, ies_len, NULL, &wps_ielen)) {
 		result = P2P_STATUS_FAIL_INCOMPATIBLE_PARAM;
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
 	}
@@ -1274,9 +1270,8 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			/*	Try to get the operation channel information */
 
 			attr_contentlen = 0;
-			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen)) {
+			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen))
 				pwdinfo->peer_operating_ch = operatingch_info[4];
-			}
 
 			/*	Try to get the channel list information */
 			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_CH_LIST, pwdinfo->channel_list_attr, &pwdinfo->channel_list_attr_len)) {
@@ -1300,18 +1295,16 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 							peer_operating_ch = operatingch_info[4];
 
 						if (rtw_p2p_is_channel_list_ok(peer_operating_ch,
-						    ch_list_inclusioned, ch_num_inclusioned)) {
+						    ch_list_inclusioned, ch_num_inclusioned))
 							/**
 							 *	Change our operating channel as peer's for compatibility.
 							 */
 							pwdinfo->operating_channel = peer_operating_ch;
-						} else {
+						else
 							/*  Take first channel of ch_list_inclusioned as operating channel */
 							pwdinfo->operating_channel = ch_list_inclusioned[0];
-						}
 					}
 				}
-			} else {
 			}
 
 			/*	Try to get the group id information if peer is GO */
@@ -1384,9 +1377,8 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		}
 
 		attr_contentlen = 0;
-		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen)) {
+		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen))
 			pwdinfo->peer_operating_ch = operatingch_info[4];
-		}
 
 		/* Get the next P2P IE */
 		p2p_ie = rtw_get_p2p_ie(p2p_ie + p2p_ielen, ies_len - (p2p_ie - ies + p2p_ielen), NULL, &p2p_ielen);
@@ -1743,7 +1735,6 @@ static void pre_tx_scan_timer_process(struct timer_list *t)
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_INVITE_REQ)) {
 		if (pwdinfo->invitereq_info.benable)
 			p2p_protocol_wk_cmd(adapter, P2P_PRE_TX_INVITEREQ_PROCESS_WK);
-	} else {
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index db7074bf5741..c7c79cd9e213 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -14,9 +14,8 @@ void ips_enter(struct adapter *padapter)
 	struct xmit_priv *pxmit_priv = &padapter->xmitpriv;
 
 	if (pxmit_priv->free_xmitbuf_cnt != NR_XMITBUFF ||
-	    pxmit_priv->free_xmit_extbuf_cnt != NR_XMIT_EXTBUFF) {
+	    pxmit_priv->free_xmit_extbuf_cnt != NR_XMIT_EXTBUFF)
 		return;
-	}
 
 	mutex_lock(&pwrpriv->lock);
 
@@ -172,9 +171,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 		return false;
 	if (pwrpriv->bInSuspend)
 		return false;
-	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && !padapter->securitypriv.binstallGrpkey) {
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && !padapter->securitypriv.binstallGrpkey)
 		return false;
-	}
 	return true;
 }
 
@@ -367,10 +365,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	if (pwrpriv->ps_processing) {
 		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
 			msleep(10);
-		if (pwrpriv->ps_processing)
-			;
-		else
-			;
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -379,10 +373,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 		       (rtw_get_passing_time_ms(start) <= 3000 ||
 		       (rtw_get_passing_time_ms(start) <= 500)))
 				msleep(10);
-		if (pwrpriv->bInSuspend)
-			;
-		else
-			;
 	}
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 0f8f757de02a..0144c4642911 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -299,10 +299,9 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 				if (is_multicast_ether_addr(prxattrib->ra) && prxattrib->key_index != pmlmeinfo->key_index)
 					brpt_micerror = false;
 
-				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
+				if ((prxattrib->bdecrypted) && (brpt_micerror))
 					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
-				} else {
-				}
+
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
@@ -679,9 +678,8 @@ static int ap2sta_data_frame(
 		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		    !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			if (!bmcast) {
+			if (!bmcast)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 
 			ret = _FAIL;
 			goto exit;
@@ -729,9 +727,8 @@ static int ap2sta_data_frame(
 	} else {
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && (!bmcast)) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-			if (!*psta) {
+			if (!*psta)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 		}
 
 		ret = _FAIL;
@@ -889,12 +886,11 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 				}
 			} else {
 				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
-					if (psta->sleepq_len == 0) {
+					if (psta->sleepq_len == 0)
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
 						issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
-					} else {
+					else
 						psta->sleepq_len = 0;
-					}
 
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
@@ -1097,25 +1093,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	/* Dump rx packets */
 	GetHalDefVar8188EUsb(adapter, HAL_DEF_DBG_DUMP_RXPKT, &bDumpRxPkt);
-	if (bDumpRxPkt == 1) {/* dump all rx packets */
-		int i;
-
-		for (i = 0; i < 64; i = i + 8)
-			;
-	} else if (bDumpRxPkt == 2) {
-		if (type == WIFI_MGT_TYPE) {
-			int i;
-
-			for (i = 0; i < 64; i = i + 8)
-				;
-		}
-	} else if (bDumpRxPkt == 3) {
-		if (type == WIFI_DATA_TYPE) {
-			int i;
-			for (i = 0; i < 64; i = i + 8)
-				;
-		}
-	}
 	switch (type) {
 	case WIFI_MGT_TYPE: /* mgnt */
 		validate_recv_mgnt_frame(adapter, precv_frame);
@@ -1419,9 +1396,8 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = RTW_GET_BE16(pdata + 12);
 
-		if (a_len < ETH_HLEN + nSubframe_Length) {
+		if (a_len < ETH_HLEN + nSubframe_Length)
 			goto exit;
-		}
 
 		/* move the data point to data content */
 		pdata += ETH_HLEN;
@@ -1446,9 +1422,8 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 		subframes[nr_subframes++] = sub_skb;
 
-		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
+		if (nr_subframes >= MAX_SUBFRAME_COUNT)
 			break;
-		}
 
 		pdata += nSubframe_Length;
 		a_len -= nSubframe_Length;
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index fdd2dbf65eb7..7861dfa235c0 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1327,9 +1327,8 @@ static int aes_decipher(struct adapter *padapter, u8 *key, uint hdrlen,
 
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
-		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i]) {
+		if (pframe[hdrlen + 8 + plen - 8 + i] != message[hdrlen + 8 + plen - 8 + i])
 			res = _FAIL;
-		}
 	}
 
 	return res;
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 1fb9b6cc7eda..91ff82f24f1f 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -101,19 +101,11 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 
 inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 {
-	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
-
-	if (!stainfo_offset_valid(offset))
-		;
-
-	return offset;
+	return (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
 }
 
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
-	if (!stainfo_offset_valid(offset))
-		;
-
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index abc2386dc8d9..e8bf5672ff6c 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -334,9 +334,6 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 {
 	u8 center_ch;
 
-	if (padapter->bNotifyChannelChange)
-		;
-
 	if ((bwmode == HT_CHANNEL_WIDTH_20) ||
 	    (channel_offset == HAL_PRIME_CHNL_OFFSET_DONT_CARE)) {
 		/* SelectChannel(padapter, channel); */
@@ -606,9 +603,8 @@ void WMMOnAssocRsp(struct adapter *padapter)
 		}
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 4; i++)
 		pxmitpriv->wmm_para_seq[i] = inx[i];
-	}
 }
 
 static void bwmode_update_check(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
@@ -852,13 +848,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
 
-	if (len > MAX_IE_SZ) {
+	if (len > MAX_IE_SZ)
 		return _FAIL;
-	}
 
-	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
+	if (memcmp(cur_network->network.MacAddress, pbssid, 6))
 		return true;
-	}
 
 	bssid = kzalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
 	if (!bssid)
@@ -907,23 +901,20 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
 			p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-			if (pht_info) {
-					bcn_channel = pht_info->primary_channel;
-			} else { /* we don't find channel IE, so don't check it */
-					bcn_channel = Adapter->mlmeextpriv.cur_channel;
-			}
-	}
-	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
-			goto _mismatch;
+			if (pht_info)
+				bcn_channel = pht_info->primary_channel;
+			else /* we don't find channel IE, so don't check it */
+				bcn_channel = Adapter->mlmeextpriv.cur_channel;
 	}
+	if (bcn_channel != Adapter->mlmeextpriv.cur_channel)
+		goto _mismatch;
 
 	/* checking SSID */
 	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-	if (!p) {
+	if (!p)
 		hidden_ssid = true;
-	} else {
+	else
 		hidden_ssid = false;
-	}
 
 	if ((NULL != p) && (false == hidden_ssid && (*(p + 1)))) {
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
@@ -935,9 +926,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 	    bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
+		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) /* not hidden ssid */
 			goto _mismatch;
-		}
 	}
 
 	/* check encryption info */
@@ -948,9 +938,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	else
 		bssid->Privacy = 0;
 
-	if (cur_network->network.Privacy != bssid->Privacy) {
+	if (cur_network->network.Privacy != bssid->Privacy)
 		goto _mismatch;
-	}
 
 	rtw_get_sec_ie(bssid->IEs, bssid->IELength, NULL, &rsn_len, NULL, &wpa_len);
 
@@ -963,9 +952,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
+	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
 		goto _mismatch;
-	}
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
 		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength - 12);
@@ -978,13 +966,11 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x);
 		}
 
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
-		}
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x) {
+		if (is_8021x != cur_network->BcnInfo.is_8021x)
 			goto _mismatch;
-		}
 	}
 
 	kfree(bssid);
@@ -1253,10 +1239,8 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 				return HT_IOT_PEER_AIRGO;
 			} else if (!memcmp(pIE->data, EPIGRAM_OUI, 3)) {
 				epigram_vendor_flag = 1;
-				if (ralink_vendor_flag) {
+				if (ralink_vendor_flag)
 					return HT_IOT_PEER_TENDA;
-				} else {
-				}
 			} else {
 				break;
 			}
@@ -1268,13 +1252,12 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		i += (pIE->Length + 2);
 	}
 
-	if (ralink_vendor_flag && !epigram_vendor_flag) {
+	if (ralink_vendor_flag && !epigram_vendor_flag)
 		return HT_IOT_PEER_RALINK;
-	} else if (ralink_vendor_flag && epigram_vendor_flag) {
+	else if (ralink_vendor_flag && epigram_vendor_flag)
 		return HT_IOT_PEER_TENDA;
-	} else {
+	else
 		return HT_IOT_PEER_UNKNOWN;
-	}
 }
 
 void update_IOT_info(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3ad124f6f3c7..0b87ce342bfb 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -458,7 +458,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 				}
 			}
 		}
-	} else if (0x888e == pattrib->ether_type) {
 	}
 
 	if ((pattrib->ether_type == 0x888e) || (pattrib->dhcp_pkt == 1))
@@ -887,9 +886,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	if (!psta)
 		return _FAIL;
 
-	if (!pxmitframe->buf_addr) {
+	if (!pxmitframe->buf_addr)
 		return _FAIL;
-	}
 
 	pbuf_start = pxmitframe->buf_addr;
 
@@ -1123,9 +1121,8 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		pxmitbuf->priv_data = NULL;
 		/* pxmitbuf->ext_tag = true; */
 
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 
 	spin_unlock_irqrestore(&pfree_queue->lock, flags);
@@ -1177,9 +1174,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	if (pxmitbuf) {
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
-		if (pxmitbuf->sctx) {
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, flags);
 
@@ -1194,9 +1190,8 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	if (!pxmitbuf)
 		return _FAIL;
 
-	if (pxmitbuf->sctx) {
+	if (pxmitbuf->sctx)
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
-	}
 
 	if (pxmitbuf->ext_tag) {
 		rtw_free_xmitbuf_ext(pxmitpriv, pxmitbuf);
@@ -1588,9 +1583,8 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 				}
 
 				newskb = skb_copy(skb, GFP_ATOMIC);
-				if (!newskb) {
+				if (!newskb)
 					return -1;
-				}
 				dev_kfree_skb_any(skb);
 
 				*pskb = skb = newskb;
@@ -1602,19 +1596,15 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 				}
 			}
 
-			if (skb_is_nonlinear(skb))
-				;
-
 			res = skb_linearize(skb);
-			if (res < 0) {
-					return -1;
-			}
+			if (res < 0)
+				return -1;
 
 			res = nat25_db_handle(padapter, skb, NAT25_INSERT);
 			if (res < 0) {
-				if (res == -2) {
+				if (res == -2)
 					return -1;
-				}
+
 				return 0;
 			}
 		}
@@ -1633,9 +1623,9 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	}
 
 	/*  check if SA is equal to our MAC */
-	if (memcmp(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN)) {
+	if (memcmp(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN))
 		return -1;
-	}
+
 	return 0;
 }
 
@@ -1702,9 +1692,8 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	s32 res;
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pxmitframe) {
+	if (!pxmitframe)
 		return -1;
-	}
 
 	rcu_read_lock();
 	br_port = rcu_dereference(padapter->pnetdev->rx_handler_data);
@@ -2124,12 +2113,11 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	int status = 0;
 
 	expire = sctx->timeout_ms ? msecs_to_jiffies(sctx->timeout_ms) : MAX_SCHEDULE_TIMEOUT;
-	if (!wait_for_completion_timeout(&sctx->done, expire)) {
+	if (!wait_for_completion_timeout(&sctx->done, expire))
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-	} else {
+	else
 		status = sctx->status;
-	}
 
 	if (status == RTW_SCTX_DONE_SUCCESS)
 		ret = _SUCCESS;
@@ -2155,8 +2143,7 @@ static bool rtw_sctx_chk_waring_status(int status)
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_waring_status(status))
-			;
+		rtw_sctx_chk_waring_status(status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index eb22ac17c586..5b91aec6a7e3 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -63,9 +63,8 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, struct wl_pwr_cfg pwrseqcmd[])
 				else
 					udelay(10);
 
-				if (poll_count++ > max_poll_count) {
+				if (poll_count++ > max_poll_count)
 					return false;
-				}
 			} while (!poll_bit);
 			break;
 		case PWR_CMD_DELAY:
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 008098040a07..37935aef71ea 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -34,8 +34,6 @@ uint rtw_hal_deinit(struct adapter *adapt)
 
 	if (status == _SUCCESS)
 		adapt->hw_init_completed = false;
-	else
-		;
 
 	return status;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 93dfd3dee59b..f1464e4ba429 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -54,9 +54,8 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	u32 h2c_cmd = 0;
 	u32 h2c_cmd_ex = 0;
 
-	if (!adapt->bFWReady) {
+	if (!adapt->bFWReady)
 		return _FAIL;
-	}
 
 	if (!pCmdBuffer || CmdLen > RTL88E_MAX_CMD_LEN || adapt->bSurpriseRemoved)
 		return _FAIL;
@@ -65,9 +64,8 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	do {
 		h2c_box_num = haldata->LastHMEBoxNum;
 
-		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
+		if (!_is_fw_read_cmd_down(adapt, h2c_box_num))
 			return _FAIL;
-		}
 
 		*(u8 *)(&h2c_cmd) = ElementID;
 
@@ -275,9 +273,8 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 
 _ConstructBeacon:
 
-	if ((pktlen + TXDESC_SIZE) > 512) {
+	if ((pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	*pLength = pktlen;
 }
@@ -443,9 +440,8 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	struct rsvdpage_loc RsvdPageLoc;
 
 	ReservedPagePacket = kzalloc(1000, GFP_KERNEL);
-	if (!ReservedPagePacket) {
+	if (!ReservedPagePacket)
 		return;
-	}
 
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
@@ -554,9 +550,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(4));
 
-		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
+		if (haldata->RegFwHwTxQCtrl & BIT(6))
 			bSendBeacon = true;
-		}
 
 		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
 		rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
@@ -579,12 +574,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 
-		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
-			;
-		else if (!bcn_valid)
-			;
-		else
-			;
 		/*  */
 		/*  We just can send the reserved page twice during the time that Tx thread is stopped (e.g. pnpsetpower) */
 		/*  because we need to free the Tx BCN Desc which is used by the first reserved page packet. */
@@ -607,9 +596,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		}
 
 		/*  Update RSVD page location H2C to Fw. */
-		if (bcn_valid) {
+		if (bcn_valid)
 			SetHwReg8188EU(adapt, HW_VAR_BCN_VALID, NULL);
-		}
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f83ae7a7e5d9..cf58dfc3ff4d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -19,9 +19,8 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
-		if (!padapter->bFWReady) {
+		if (!padapter->bFWReady)
 			rtw_reset_8051(padapter);
-		}
 
 	} else {
 		/* disable initial offload */
@@ -76,14 +75,12 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	u8 u1temp = 0;
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
-	if (!efuseTbl) {
+	if (!efuseTbl)
 		goto exit;
-	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (!eFuseWord) {
+	if (!eFuseWord)
 		goto exit;
-	}
 
 	/*  0. Refresh efuse init map as all oxFF. */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
@@ -213,9 +210,8 @@ static void efuse_read_phymap_from_txpktbuf(
 		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		start = jiffies;
 		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
-		       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
+		       (passing_time = rtw_get_passing_time_ms(start)) < 1000)
 			rtw_usleep_os(100);
-		}
 
 		/* data from EEPROM needs to be in LE */
 		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
@@ -373,19 +369,16 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
-	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) {/*  total E-Fuse table is 512bytes */
+	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) /*  total E-Fuse table is 512bytes */
 		goto exit;
-	}
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
-	if (!efuseTbl) {
+	if (!efuseTbl)
 		goto exit;
-	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (!eFuseWord) {
+	if (!eFuseWord)
 		goto exit;
-	}
 
 	/*  0. Refresh efuse init map as all oxFF. */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
@@ -536,11 +529,10 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet)
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
-	if (enable) {
+	if (enable)
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
-	} else {
+	else
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
-	}
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
@@ -764,15 +756,14 @@ static void hal_get_chnl_group_88e(u8 chnl, u8 *group)
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
 {
-	if (AutoLoadFail) {
+	if (AutoLoadFail)
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = false;
-	} else {
+	else
 		/* hw power down mode selection , 0:rf-off / 1:power down */
 
 		/*  decide hw if support remote wakeup function */
 		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
-	}
 }
 
 void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool AutoLoadFail)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 5c8d43014603..ea75ff11ad17 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -684,9 +684,6 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	u32 param1, param2;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
-	if (Adapter->bNotifyChannelChange)
-		;
-
 	/* s1. pre common command - CmdID_SetTxPowerLevel */
 	PHY_SetTxPowerLevel8188E(Adapter, channel);
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 08bdf715d872..6af72b3e7a7d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -106,12 +106,7 @@ void rtl8188eu_free_recv_priv(struct adapter *padapter)
 
 	kfree(precvpriv->pallocated_recv_buf);
 
-	if (skb_queue_len(&precvpriv->rx_skb_queue))
-		;
 	skb_queue_purge(&precvpriv->rx_skb_queue);
 
-	if (skb_queue_len(&precvpriv->free_recv_skb_queue))
-		;
-
 	skb_queue_purge(&precvpriv->free_recv_skb_queue);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index db6ad97d6a2b..69b66eb458b0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -264,8 +264,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 			ptxdesc->txdw5 |= cpu_to_le32(0x00300000);/* retry limit = 12 */
 
 		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
-	} else if ((pxmitframe->frame_tag & 0x0f) == TXAGG_FRAMETAG) {
-	} else {
+	} else if ((pxmitframe->frame_tag & 0x0f) != TXAGG_FRAMETAG) {
 		/* offset 4 */
 		ptxdesc->txdw1 |= cpu_to_le32((4) & 0x3f);/* CAM_ID(MAC_ID) */
 
@@ -569,8 +568,7 @@ static s32 xmitframe_direct(struct adapter *adapt, struct xmit_frame *pxmitframe
 	res = rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
 	if (res == _SUCCESS)
 		rtw_dump_xframe(adapt, pxmitframe);
-	else
-		;
+
 	return res;
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index cc11ddac86b7..b3d6c4b0af15 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -57,9 +57,8 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
-	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW)) {
+	if (!HalPwrSeqCmdParsing(adapt, Rtl8188E_NIC_PWR_ON_FLOW))
 		return _FAIL;
-	}
 
 	/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
 	/*  Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
@@ -582,27 +581,23 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	haldata->LastHMEBoxNum = 0;
 
 	status = PHY_MACConfig8188E(Adapter);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	/*  */
 	/* d. Initialize BB related configurations. */
 	/*  */
 	status = PHY_BBConfig8188E(Adapter);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	status = PHY_RFConfig8188E(Adapter);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	status = rtl8188e_iol_efuse_patch(Adapter);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
 
@@ -1336,8 +1331,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 					if (!(rtw_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
-				if (trycnt == 0)
-					;
 
 				/* RQPN Load 0 */
 				rtw_write16(Adapter, REG_RQPN_NPQ, 0x0);
@@ -1431,10 +1424,7 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
 		break;
 	case HW_DEF_RA_INFO_DUMP:
-		{
-			if (check_fwstate(&Adapter->mlmepriv, _FW_LINKED)) {
-			}
-		}
+		check_fwstate(&Adapter->mlmepriv, _FW_LINKED);
 		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 2f3cdc356d2a..6bd2164ce1fa 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -209,9 +209,8 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
-		if (!precvframe) {
+		if (!precvframe)
 			goto _exit_recvbuf2recvframe;
-		}
 
 		INIT_LIST_HEAD(&precvframe->list);
 		precvframe->precvbuf = NULL;	/* can't access the precvbuf for new arch. */
@@ -435,9 +434,8 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	/* re-assign for linux based on skb */
 	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
-		if (!precvbuf->pskb) {
+		if (!precvbuf->pskb)
 			return _FAIL;
-		}
 
 		tmpaddr = (size_t)precvbuf->pskb->data;
 		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
@@ -472,9 +470,8 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 			  precvbuf);/* context is precvbuf */
 
 	err = usb_submit_urb(purb, GFP_ATOMIC);
-	if ((err) && (err != (-EPERM))) {
+	if ((err) && (err != (-EPERM)))
 		ret = _FAIL;
-	}
 
 	return ret;
 }
@@ -491,9 +488,8 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
 	while (1) {
 		if ((adapt->bDriverStopped) ||
 		    (adapt->bSurpriseRemoved) ||
-		    (adapt->bWritePortCancel)) {
+		    (adapt->bWritePortCancel))
 			break;
-		}
 
 		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv, NULL);
 
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index edef3ad1ccd9..14526fcff4ae 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -30,9 +30,9 @@ static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 	int ret = false;
 	int value;
 	value = atomic_inc_return(&dvobj->continual_urb_error);
-	if (value > MAX_CONTINUAL_URB_ERR) {
+	if (value > MAX_CONTINUAL_URB_ERR)
 		ret = true;
-	}
+
 	return ret;
 }
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 97cce74b2b28..eb9375b0c660 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -355,8 +355,7 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & AUTH_ALG_LEAP) {
-	} else {
+	} else if (!(value & AUTH_ALG_LEAP)) {
 		ret = -EINVAL;
 	}
 	return ret;
@@ -521,13 +520,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			goto exit;
 		}
 
-		/* dump */
-		{
-			int i;
-			for (i = 0; i < ielen; i += 8)
-				;
-		}
-
 		if (ielen < RSN_HEADER_LEN) {
 			ret  = -1;
 			goto exit;
@@ -1118,7 +1110,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			_status = rtw_sitesurvey_cmd(padapter, ssid, 1, NULL, 0);
 
 			spin_unlock_bh(&pmlmepriv->lock);
-		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
 		}
 	} else {
 		if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE &&
@@ -1284,9 +1275,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
-		if (wrqu->essid.length != 33)
-			;
-
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
 		memcpy(ndis_ssid.Ssid, extra, len);
@@ -2028,9 +2016,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
-	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req))
-		;
-	else
+	if (rtw_set_chplan_cmd(padapter, channel_plan_req) != _SUCCESS)
 		return -EPERM;
 
 	return 0;
@@ -2137,7 +2123,6 @@ static int rtw_set_pid(struct net_device *dev,
 	if (selector < 3 && selector >= 0) {
 		padapter->pid[selector] = *(pdata + 1);
 		ui_pid[selector] = *(pdata + 1);
-	} else {
 	}
 exit:
 	return ret;
@@ -2385,9 +2370,6 @@ static void rtw_p2p_get_status(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	if (padapter->bShowGetP2PState)
-		;
-
 	/*	Commented by Albert 2010/10/12 */
 	/*	Because of the output size limitation, I had removed the "Role" information. */
 	/*	About the "Role" information, we will use the new private IOCTL to get the "Role" information. */
@@ -2870,9 +2852,8 @@ static int rtw_p2p_connect(struct net_device *dev,
 	/*	Format: 00:E0:4C:00:00:05 */
 	/*	Format: 00:E0:4C:00:00:05 */
 
-	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
+	if (pwdinfo->p2p_state == P2P_STATE_NONE)
 		return ret;
-	}
 
 	if (pwdinfo->ui_got_wps_info == P2P_NO_WPSINFO)
 		return -1;
@@ -2945,9 +2926,8 @@ static void rtw_p2p_invite_req(struct net_device *dev,
 	/*	Command line sample: iwpriv wlan0 p2p_set invite ="00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy" */
 	/*	Format: 00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy */
 
-	if (wrqu->data.length <=  37) {
+	if (wrqu->data.length <=  37)
 		return;
-	}
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		return;
@@ -3020,7 +3000,6 @@ static void rtw_p2p_invite_req(struct net_device *dev,
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_INVITE_TIMEOUT);
-	} else {
 	}
 }
 
@@ -3088,17 +3067,16 @@ static void rtw_p2p_prov_disc(struct net_device *dev,
 	for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3)
 		peerMAC[jj] = key_2char2num(extra[kk], extra[kk + 1]);
 
-	if (!memcmp(&extra[18], "display", 7)) {
+	if (!memcmp(&extra[18], "display", 7))
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_DISPLYA;
-	} else if (!memcmp(&extra[18], "keypad", 7)) {
+	else if (!memcmp(&extra[18], "keypad", 7))
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_KEYPAD;
-	} else if (!memcmp(&extra[18], "pbc", 3)) {
+	else if (!memcmp(&extra[18], "pbc", 3))
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_PUSH_BUTTON;
-	} else if (!memcmp(&extra[18], "label", 5)) {
+	else if (!memcmp(&extra[18], "label", 5))
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
-	} else {
+	else
 		return;
-	}
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
@@ -3165,7 +3143,6 @@ static void rtw_p2p_prov_disc(struct net_device *dev,
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_PROVISION_TIMEOUT);
-	} else {
 	}
 }
 
@@ -3256,10 +3233,6 @@ static int rtw_p2p_get(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	if (padapter->bShowGetP2PState)
-		;
 	if (!memcmp(wrqu->data.pointer, "status", 6)) {
 		rtw_p2p_get_status(dev, info, wrqu, extra);
 	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
@@ -3425,7 +3398,6 @@ static int rtw_dbg_port(struct net_device *dev,
 	u16 arg;
 	s32 extra_arg;
 	u32 *pdata, val32;
-	struct sta_info *psta;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -3545,7 +3517,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 start_value = 0;
 			u32 write_num = extra_arg;
 			int i;
-			u8 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3559,11 +3530,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			final = rtw_read8(padapter, reg);
-			if (start_value + write_num - 1 == final)
-				;
-			else
-				;
+			rtw_read8(padapter, reg);
 		}
 			break;
 
@@ -3574,7 +3541,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 write_num = extra_arg;
 
 			int i;
-			u16 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3588,11 +3554,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			final = rtw_read16(padapter, reg);
-			if (start_value + write_num - 1 == final)
-				;
-			else
-				;
+			rtw_read16(padapter, reg);
 		}
 			break;
 		case 0x08: /* continuous write dword test */
@@ -3602,7 +3564,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 write_num = extra_arg;
 
 			int i;
-			u32 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3616,11 +3577,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			final = rtw_read32(padapter, reg);
-			if (start_value + write_num - 1 == final)
-				;
-			else
-				;
+			rtw_read32(padapter, reg);
 		}
 			break;
 		}
@@ -3659,18 +3616,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x04:
 			break;
 		case 0x05:
-			psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
-			if (psta) {
-				int i;
-				struct recv_reorder_ctrl *preorder_ctrl;
-
-				for (i = 0; i < 16; i++) {
-					preorder_ctrl = &psta->recvreorder_ctrl[i];
-					if (preorder_ctrl->enable)
-						;
-				}
-			} else {
-			}
+			rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
 			break;
 		case 0x06:
 			{
@@ -3685,33 +3631,6 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x08:
 			break;
 		case 0x09:
-			{
-				int i, j;
-				struct list_head *plist, *phead;
-				struct recv_reorder_ctrl *preorder_ctrl;
-
-				spin_lock_bh(&pstapriv->sta_hash_lock);
-
-				for (i = 0; i < NUM_STA; i++) {
-					phead = &pstapriv->sta_hash[i];
-					plist = phead->next;
-
-					while (phead != plist) {
-						psta = container_of(plist, struct sta_info, hash_list);
-
-						plist = plist->next;
-
-						if (extra_arg == psta->aid) {
-							for (j = 0; j < 16; j++) {
-								preorder_ctrl = &psta->recvreorder_ctrl[j];
-								if (preorder_ctrl->enable)
-									;
-							}
-						}
-					}
-				}
-				spin_unlock_bh(&pstapriv->sta_hash_lock);
-			}
 			break;
 		case 0x0c:/* dump rx/tx packet */
 			if (arg == 0) {
@@ -3735,20 +3654,16 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (extra_arg == 0 ||
 			    extra_arg == 1 ||
 			    extra_arg == 2 ||
-			    extra_arg == 3) {
+			    extra_arg == 3)
 				pregpriv->rx_stbc = extra_arg;
-			} else {
-			}
 		}
 			break;
 		case 0x13: /* set ampdu_enable */
 		{
 			struct registry_priv	*pregpriv = &padapter->registrypriv;
 			/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
-			if (extra_arg >= 0 && extra_arg < 3) {
+			if (extra_arg >= 0 && extra_arg < 3)
 				pregpriv->ampdu_enable = extra_arg;
-			} else {
-			}
 		}
 			break;
 		case 0x14: /* get wifi_spec */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 9884dbc6eab5..197568422ece 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -487,17 +487,14 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	if (init_mlme_ext_priv(padapter) == _FAIL)
 		return _FAIL;
 
-	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
+	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL)
 		return _FAIL;
-	}
 
-	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
+	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL)
 		return _FAIL;
-	}
 
-	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
+	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL)
 		return _FAIL;
-	}
 
 	padapter->stapriv.padapter = padapter;
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 79d2d640ddfa..ffd727fb32e3 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -139,14 +139,13 @@ static void usb_dvobj_deinit(struct usb_interface *usb_intf)
 		    dvobj->NumInterfaces != 3) ||
 	    (dvobj->InterfaceNumber == 1)) {
 			if (interface_to_usbdev(usb_intf)->state !=
-			    USB_STATE_NOTATTACHED) {
+			    USB_STATE_NOTATTACHED)
 				/* If we didn't unplug usb dongle and
 				 * remove/insert module, driver fails
 				 * on sitesurvey for the first time when
 				 * device is up . Reset usb port for sitesurvey
 				 * fail issue. */
 				usb_reset_device(interface_to_usbdev(usb_intf));
-			}
 		}
 		kfree(dvobj);
 	}
@@ -204,9 +203,8 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	int ret = 0;
 
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
-	    (padapter->bSurpriseRemoved)) {
+	    (padapter->bSurpriseRemoved))
 		goto exit;
-	}
 
 	pwrpriv->bInSuspend = true;
 	rtw_cancel_all_timer(padapter);
@@ -223,9 +221,8 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	rtw_disassoc_cmd(padapter, 0, false);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
-	    check_fwstate(pmlmepriv, _FW_LINKED)) {
+	    check_fwstate(pmlmepriv, _FW_LINKED))
 		pmlmepriv->to_roaming = 1;
-	}
 	/* s2-2.  indicate disconnect to os */
 	rtw_indicate_disconnect(padapter);
 	/* s2-3. */
@@ -272,9 +269,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 
 	mutex_unlock(&pwrpriv->lock);
 
-	if (padapter->pid[1] != 0) {
+	if (padapter->pid[1] != 0)
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
-	}
 
 	rtw_roaming(padapter, NULL);
 
@@ -355,13 +351,11 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
 	 * suspend influence */
-	if (usb_autopm_get_interface(pusb_intf) < 0)
-		;
+	usb_autopm_get_interface(pusb_intf);
 
 	/*  alloc dev name after read efuse. */
-	if (rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname) < 0) {
+	if (rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname) < 0)
 		goto free_drv_sw;
-	}
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
 	rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
 				  padapter->eeprompriv.mac_addr);
@@ -421,13 +415,11 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 		goto err;
 
 	if1 = rtw_usb_if1_init(dvobj, pusb_intf);
-	if (!if1) {
+	if (!if1)
 		goto free_dvobj;
-	}
 
-	if (ui_pid[1] != 0) {
+	if (ui_pid[1] != 0)
 		rtw_signal_process(ui_pid[1], SIGUSR2);
-	}
 
 	return 0;
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 82e680abcd61..c4b6dbc8d66d 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -62,9 +62,8 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	}
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
-	    padapter->bWritePortCancel) {
+	    padapter->bWritePortCancel)
 		goto check_completion;
-	}
 
 	if (purb->status) {
 		if (purb->status == -EINPROGRESS) {
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 6032831364c4..717b980a8c72 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -78,9 +78,8 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!pxmitbuf->pxmit_urb[i]) {
+		if (!pxmitbuf->pxmit_urb[i])
 			return _FAIL;
-		}
 	}
 	return _SUCCESS;
 }
-- 
2.34.1

