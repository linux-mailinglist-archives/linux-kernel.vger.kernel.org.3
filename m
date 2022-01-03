Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085BE4837A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiACTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiACTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:41:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387F0C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:41:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z29so139646645edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rE3qedKmVb5C446x7Sy9zNSGhvL2eF6QjOM3Mn12t3k=;
        b=bSJtflp9SCsi5DyZxVbqhvJ/xXpvAxJ7oNeekkmRwXeYwFOTAhnDe5K/WtNm0HGBvw
         NirHJ50Rz3+clWPYmRphr2p9O2eLxHyqpnvAQ76jBvzZIVEf18hC/YiCOBso4mZTBZjD
         97rthvc2DPcpALzRGYU/QHeNqdG3mFAT3lhVLKAD57qbd7uUwLI6BU/4MXOtqE7iV0LW
         myzTObjpTAMfspjh4yxj8uVIP/ezr23upSv3Imsw4eDICe7sVkwlb+qNC5NcpwJslUX2
         i94SxLLOQs6sngmqAKYCfZQeYN5wUdsK5l5M+Xj6kSPIy40ccKl4bR5DysNp549f3shZ
         Sz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rE3qedKmVb5C446x7Sy9zNSGhvL2eF6QjOM3Mn12t3k=;
        b=QLhAp6wzfMhOHPCwNwLEumrAYGiU0E2BrePC3XXJ9Xs2R8Z0KPb0K3/LKvVTA9ls8M
         juNiai3Cg3pODI4pUoAUTsx7EzJMPbLydUDNT6TgOinxMpXb9geHVzsn4nijMZ0Fyz3v
         q74OsIFneMKfM//zKOYuEunpl86MecvVzYwsXnG/3SmyHBx2f4Aj06lwRIuStTpxdDZh
         uVa51I4l5TnXr9yZ9HMrC21mOusYGeVsfcLWREC34x+beNC5yN+BC2hary+GQjd37yb0
         m8uPiqMJmlwpsFhHY8YyyRQPkC98D72+MPQk5WyoiOo35hXusLJoRZRhMbsSzr+DEsIw
         YCmQ==
X-Gm-Message-State: AOAM532wtA1HvS0aFKAz0o0vPHW1bIJDRxGg0q2HZ5xoB9XfnnCClqh9
        hEuRjXiYm6pxNacLVyohu1w=
X-Google-Smtp-Source: ABdhPJyw1r5PzMrRb8wm2+zZDG3htQ/fP1oZCDGu/J5u43frkohbuMElvhqgICJZWXtJXqzNMP3sAQ==
X-Received: by 2002:aa7:d906:: with SMTP id a6mr44991045edr.363.1641238868788;
        Mon, 03 Jan 2022 11:41:08 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:41:08 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/56] staging: r8188eu: rename camelcase SetSeqNum to set_seq_num
Date:   Mon,  3 Jan 2022 20:02:13 +0100
Message-Id: <20220103190326.363960-39-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetSeqNum into set_seq_num.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 38 ++++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c      |  8 ++---
 drivers/staging/r8188eu/core/rtw_xmit.c     |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  |  6 ++--
 drivers/staging/r8188eu/include/wifi.h      |  2 +-
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index d11d9a21a0e1..e0cd1779d0c8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1795,7 +1795,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -2131,7 +2131,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -2489,7 +2489,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -2651,7 +2651,7 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, raddr,  ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -2897,7 +2897,7 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, raddr,  ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -3089,7 +3089,7 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pdev_raddr, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -3203,7 +3203,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	/*	Use the device address for BSSID field. */
 	memcpy(pwlanhdr->addr3, mac, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(fctrl, WIFI_PROBERSP);
 
@@ -3459,7 +3459,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	}
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_PROBEREQ);
 
@@ -4347,7 +4347,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
+	set_seq_num(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
 	/* pmlmeext->mgnt_seq++; */
 	set_frame_subtype(pframe, WIFI_BEACON);
 
@@ -4563,7 +4563,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, bssid, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(fctrl, WIFI_PROBERSP);
 
@@ -4716,7 +4716,7 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_PROBEREQ);
 
@@ -4833,7 +4833,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_AUTH);
 
@@ -4968,7 +4968,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	memcpy((void *)GetAddr2Ptr(pwlanhdr), myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy((void *)GetAddr3Ptr(pwlanhdr), get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	if ((pkt_type == WIFI_ASSOCRSP) || (pkt_type == WIFI_REASSOCRSP))
 		set_frame_subtype(pwlanhdr, pkt_type);
@@ -5099,7 +5099,7 @@ void issue_assocreq(struct adapter *padapter)
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ASSOCREQ);
 
@@ -5418,7 +5418,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_DATA_NULL);
 
@@ -5538,7 +5538,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_QOS_DATA_NULL);
 
@@ -5643,7 +5643,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_DEAUTH);
 
@@ -5755,7 +5755,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -5893,7 +5893,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 98b9d38ee59f..558646db06b3 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -145,7 +145,7 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	memcpy(pwlanhdr->addr2, pwdinfo->interface_addr, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pwdinfo->interface_addr, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -204,7 +204,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	memcpy(pwlanhdr->addr2, pwdinfo->device_addr, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pwdinfo->device_addr, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -274,7 +274,7 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
@@ -351,7 +351,7 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	memcpy(pwlanhdr->addr2, pwdinfo->interface_addr, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, pwdinfo->interface_addr, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	set_seq_num(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	set_frame_subtype(pframe, WIFI_ACTION);
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 16760806bd65..cb189758a2b1 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -784,7 +784,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 			pattrib->seqnum = psta->sta_xmitpriv.txseq_tid[pattrib->priority];
 
-			SetSeqNum(hdr, pattrib->seqnum);
+			set_seq_num(hdr, pattrib->seqnum);
 
 			/* check if enable ampdu */
 			if (pattrib->ht_en && psta->htpriv.ampdu_enable) {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 50b9fd72f6ff..502b3ee523be 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -227,7 +227,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
+	set_seq_num(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
 	set_frame_subtype(pframe, WIFI_BEACON);
 
 	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
@@ -364,7 +364,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 		break;
 	}
 
-	SetSeqNum(pwlanhdr, 0);
+	set_seq_num(pwlanhdr, 0);
 
 	if (bQoS) {
 		struct rtw_ieee80211_hdr_3addr_qos *pwlanqoshdr;
@@ -406,7 +406,7 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
 	memcpy(pwlanhdr->addr3, bssid, ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, 0);
+	set_seq_num(pwlanhdr, 0);
 	set_frame_subtype(fctrl, WIFI_PROBERSP);
 
 	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 4b5dd73c391e..5894d10c1652 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -223,7 +223,7 @@ enum WIFI_REG_DOMAIN {
 #define get_frag_num(pbuf)			\
 	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) & 0x0f)
 
-#define SetSeqNum(pbuf, num) \
+#define set_seq_num(pbuf, num) \
 	do {    \
 		*(__le16 *)((size_t)(pbuf) + 22) = \
 			((*(__le16 *)((size_t)(pbuf) + 22)) & cpu_to_le16((unsigned short)0x000f)) | \
-- 
2.25.1

