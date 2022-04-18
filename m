Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4625505DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiDRSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiDRSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:12:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFC369F4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:09:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k23so28255923ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leFsRIz8fC1qn6HzU5He/nmT2hxS4bWgcdjHO6j1gtE=;
        b=eiDeOu264umasQ6qbIVyIzP+mdlrXmqXRSjCxSA9o/wNlK2CcpogJwDD8mP5wfJmlc
         07wscBavT7O0snfRz04xyS/pCqVAk79xy8CTRw93bpCVuyW3Zd5hCxqyAgJDVDS7jmHN
         saa0tDxahuSptn7OK2FEy/xzgNXQLrinbP0ug7i1ij+Mv9HppgCpw8dz84BdOdH0g7FW
         SkPJn1ZOxUrLjL2yIanC8d4zPn2y827vJLtRDvuuSIgp5LsDzbbI5y1pWRwbZmUx94pf
         MSYmTN8ARadDviyfaXIn4BZQnuRdE7vQj0B0Kjo1RgXqqY8s6hP7SxY6uofZ9FdSk9Dk
         7WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leFsRIz8fC1qn6HzU5He/nmT2hxS4bWgcdjHO6j1gtE=;
        b=KBzZc8MfrHHTqP4MOmC8VqjiGsygKUeIw/yBm/wHwCgOVBvvgEZTUgcIL1sFjb7uOU
         +QB9YKkIxML6OS+RJVRhF0FzIgTyU7ZbmnQ+UQr93NSi2fte56y9ebgjTkBlgJmdSxGm
         KFN5qF3CHvfSm7Ox2IYHr3HJefDnMmI+V5dvP80pX493mYyGn1q1tl9ld6t9T8pbQ5Hv
         rmd8bl8evC1xpFbf2lTvRVahocYtVK3UjNtlo4tAPbZx6U7QBbmjUDbYXt4bqlLJnQuk
         G3WB3ZV3aaaaZhQ1PSeZ2jAXbKdyNWbGwnWIyZN+13iVzzanr6QS+Kyw4LAK80yFCpfA
         cruw==
X-Gm-Message-State: AOAM530pWq40tWnEor1sSu6lRI/Vb+/YpklJMFkhQgMbV7fFZI6Jnk7N
        fk23p62OCCdSjYVvSymYSB6pgdj5EaM=
X-Google-Smtp-Source: ABdhPJychzAFpKY4YLzFStfKPFkOlmYajUKutj4XwMlkJcPm3liwBjkKeHmHBv+uOMjYvXAOKUlCqQ==
X-Received: by 2002:a17:907:2cc2:b0:6ec:d5d:f915 with SMTP id hg2-20020a1709072cc200b006ec0d5df915mr10304986ejc.660.1650305363543;
        Mon, 18 Apr 2022 11:09:23 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.165])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm4788953ejc.85.2022.04.18.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 11:09:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: use in-kernel ieee80211 header structures
Date:   Mon, 18 Apr 2022 20:09:16 +0200
Message-Id: <20220418180916.11311-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The structures

rtw_ieee80211_hdr
rtw_ieee80211_hdr_3addr
rtw_ieee80211_hdr_3addr_qos

in drivers/staging/r8188eu/include/ieee80211.h just duplicate the
in-kernel structures from include/linux/ieee80211.h.

ieee80211_hdr
ieee80211_hdr_3addr
ieee80211_qos_hdr

Remove the rtw_ prefixed structures and use the in-kernel versions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 216 +++++++++----------
 drivers/staging/r8188eu/core/rtw_p2p.c       |  46 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c |   6 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      |   4 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c   |  42 ++--
 drivers/staging/r8188eu/include/ieee80211.h  |  29 ---
 6 files changed, 157 insertions(+), 186 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 66dd06371991..b5a00ad4a3cc 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -610,7 +610,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			}
 
 			/* check the vendor of the assoc AP */
-			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct rtw_ieee80211_hdr_3addr), len - sizeof(struct rtw_ieee80211_hdr_3addr));
+			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct ieee80211_hdr_3addr), len - sizeof(struct ieee80211_hdr_3addr));
 
 			/* update TSF Value */
 			update_TSF(pmlmeext, pframe, len);
@@ -1507,7 +1507,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
-	u8 *frame_body = (u8 *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	u8 *frame_body = (u8 *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 	u8 category;
 	u8 action;
 
@@ -1573,7 +1573,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	if (!psta)
 		return _SUCCESS;
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	category = frame_body[0];
 	if (category == RTW_WLAN_CATEGORY_BACK) { /*  representing Block Ack */
@@ -1643,7 +1643,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	struct xmit_frame *pmgntframe;
 	struct pkt_attrib *pattrib;
 	unsigned char *pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -1660,9 +1660,9 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
@@ -1673,8 +1673,8 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -1978,7 +1978,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -1995,9 +1995,9 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
@@ -2008,8 +2008,8 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -2335,7 +2335,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -2352,9 +2352,9 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
@@ -2365,8 +2365,8 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -2497,7 +2497,7 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -2514,9 +2514,9 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
@@ -2527,8 +2527,8 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -2743,7 +2743,7 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -2760,9 +2760,9 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
@@ -2773,8 +2773,8 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -2934,7 +2934,7 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -2951,9 +2951,9 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, pdev_raddr, ETH_ALEN);
@@ -2964,8 +2964,8 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -3033,7 +3033,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned char					*mac;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
@@ -3055,11 +3055,11 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&padapter->eeprompriv);
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -3071,7 +3071,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(fctrl, WIFI_PROBERSP);
 
-	pattrib->hdrlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pattrib->hdrlen = sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = pattrib->hdrlen;
 	pframe += pattrib->hdrlen;
 
@@ -3279,7 +3279,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
 	unsigned char			*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned char			*mac;
 	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
@@ -3300,11 +3300,11 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&padapter->eeprompriv);
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	if (da) {
@@ -3327,8 +3327,8 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_PROBEREQ);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ))
 		pframe = rtw_set_ie(pframe, _SSID_IE_, pwdinfo->tx_prov_disc_info.ssid.SsidLength, pwdinfo->tx_prov_disc_info.ssid.Ssid, &pattrib->pktlen);
@@ -3602,7 +3602,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	u8	result = P2P_STATUS_SUCCESS;
 	u8	empty_addr[ETH_ALEN] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	dialogToken = frame_body[7];
 
@@ -3614,7 +3614,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE) || rtw_p2p_chk_state(pwdinfo, P2P_STATE_IDLE))
 		return _SUCCESS;
 
-	len -= sizeof(struct rtw_ieee80211_hdr_3addr);
+	len -= sizeof(struct ieee80211_hdr_3addr);
 
 	switch (frame_body[6]) { /* OUI Subtype */
 	case P2P_GO_NEGO_REQ:
@@ -3855,7 +3855,7 @@ static unsigned int on_action_public_vendor(struct recv_frame *precv_frame)
 {
 	unsigned int ret = _FAIL;
 	u8 *pframe = precv_frame->rx_data;
-	u8 *frame_body = pframe + sizeof(struct rtw_ieee80211_hdr_3addr);
+	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
 
 	if (!memcmp(frame_body + 2, P2P_OUI, 4)) {
 		ret = on_action_public_p2p(precv_frame);
@@ -3868,7 +3868,7 @@ static unsigned int on_action_public_default(struct recv_frame *precv_frame)
 {
 	unsigned int ret = _FAIL;
 	u8 *pframe = precv_frame->rx_data;
-	u8 *frame_body = pframe + sizeof(struct rtw_ieee80211_hdr_3addr);
+	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
 	u8 token;
 
 	token = frame_body[2];
@@ -3886,7 +3886,7 @@ unsigned int on_action_public(struct adapter *padapter, struct recv_frame *precv
 {
 	unsigned int ret = _FAIL;
 	u8 *pframe = precv_frame->rx_data;
-	u8 *frame_body = pframe + sizeof(struct rtw_ieee80211_hdr_3addr);
+	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
 	u8 category, action;
 
 	/* check RA matches or not */
@@ -3933,7 +3933,7 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	category = frame_body[0];
 	if (category != RTW_WLAN_CATEGORY_P2P)
@@ -3942,7 +3942,7 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	if (be32_to_cpu(*((__be32 *)(frame_body + 1))) != P2POUI)
 		return _SUCCESS;
 
-	len -= sizeof(struct rtw_ieee80211_hdr_3addr);
+	len -= sizeof(struct ieee80211_hdr_3addr);
 	OUI_Subtype = frame_body[5];
 
 	switch (OUI_Subtype) {
@@ -3969,7 +3969,7 @@ unsigned int OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
 	unsigned char	*frame_body;
 	u8 *pframe = precv_frame->rx_data;
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	category = frame_body[0];
 
@@ -4142,7 +4142,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct xmit_frame	*pmgntframe;
 	struct pkt_attrib	*pattrib;
 	unsigned char	*pframe;
-	struct rtw_ieee80211_hdr *pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned int	rate_len;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
@@ -4165,9 +4165,9 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	eth_broadcast_addr(pwlanhdr->addr1);
@@ -4178,8 +4178,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	/* pmlmeext->mgnt_seq++; */
 	SetFrameSubType(pframe, WIFI_BEACON);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		/*  for P2P : Primary Device Type & Device Name */
@@ -4262,8 +4262,8 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			u8 *wps_ie;
 			uint wps_ielen;
 			u8 sr = 0;
-			wps_ie = rtw_get_wps_ie(pmgntframe->buf_addr + TXDESC_OFFSET + sizeof(struct rtw_ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_,
-				pattrib->pktlen - sizeof(struct rtw_ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_, NULL, &wps_ielen);
+			wps_ie = rtw_get_wps_ie(pmgntframe->buf_addr + TXDESC_OFFSET + sizeof(struct ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_,
+				pattrib->pktlen - sizeof(struct ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_, NULL, &wps_ielen);
 			if (wps_ie && wps_ielen > 0)
 				rtw_get_wps_attr_content(wps_ie,  wps_ielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
 			if (sr != 0)
@@ -4350,7 +4350,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned char					*mac, *bssid;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
@@ -4374,12 +4374,12 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&padapter->eeprompriv);
 	bssid = cur_network->MacAddress;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -4389,7 +4389,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(fctrl, WIFI_PROBERSP);
 
-	pattrib->hdrlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pattrib->hdrlen = sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = pattrib->hdrlen;
 	pframe += pattrib->hdrlen;
 
@@ -4499,7 +4499,7 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
 	unsigned char			*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned char			*mac;
 	unsigned char			bssrate[NumRates];
@@ -4519,11 +4519,11 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&padapter->eeprompriv);
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	if (da) {
@@ -4542,8 +4542,8 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_PROBEREQ);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (pssid)
 		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &pattrib->pktlen);
@@ -4617,7 +4617,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	struct xmit_frame *pmgntframe;
 	struct pkt_attrib *pattrib;
 	unsigned char *pframe;
-	struct rtw_ieee80211_hdr *pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned int val32;
 	u16 val16;
@@ -4638,17 +4638,17 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_AUTH);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (psta) {/*  for AP mode */
 		memcpy(pwlanhdr->addr1, psta->hwaddr, ETH_ALEN);
@@ -4722,7 +4722,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 
 			SetPrivacy(fctrl);
 
-			pattrib->hdrlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+			pattrib->hdrlen = sizeof(struct ieee80211_hdr_3addr);
 
 			pattrib->encrypt = _WEP40_;
 
@@ -4741,7 +4741,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_info *pstat, int pkt_type)
 {
 	struct xmit_frame	*pmgntframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	struct pkt_attrib *pattrib;
 	unsigned char	*pbuf, *pframe;
 	unsigned short val;
@@ -4766,9 +4766,9 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy((void *)GetAddr1Ptr(pwlanhdr), pstat->hwaddr, ETH_ALEN);
@@ -4782,7 +4782,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	else
 		return;
 
-	pattrib->hdrlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pattrib->hdrlen = sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen += pattrib->hdrlen;
 	pframe += pattrib->hdrlen;
 
@@ -4872,7 +4872,7 @@ void issue_assocreq(struct adapter *padapter)
 	struct xmit_frame	*pmgntframe;
 	struct pkt_attrib	*pattrib;
 	unsigned char		*pframe, *p;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	__le16		le_tmp;
 	unsigned int	i, j, ie_len, index = 0;
@@ -4898,9 +4898,9 @@ void issue_assocreq(struct adapter *padapter)
 
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
@@ -4910,8 +4910,8 @@ void issue_assocreq(struct adapter *padapter)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ASSOCREQ);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* caps */
 
@@ -5172,7 +5172,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv	*pxmitpriv;
 	struct mlme_ext_priv	*pmlmeext;
@@ -5197,9 +5197,9 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
@@ -5218,8 +5218,8 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_DATA_NULL);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -5274,7 +5274,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	unsigned short *qc;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
@@ -5298,9 +5298,9 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
@@ -5324,8 +5324,8 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr_qos);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr_qos);
+	pframe += sizeof(struct ieee80211_qos_hdr);
+	pattrib->pktlen = sizeof(struct ieee80211_qos_hdr);
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -5378,7 +5378,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -5404,9 +5404,9 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -5417,8 +5417,8 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_DEAUTH);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	le_tmp = cpu_to_le16(reason);
 	pframe = rtw_set_fixed_ie(pframe, _RSON_CODE_, (unsigned char *)&le_tmp, &pattrib->pktlen);
@@ -5479,7 +5479,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct xmit_frame *pmgntframe;
 	struct pkt_attrib *pattrib;
 	u8 *pframe;
-	struct rtw_ieee80211_hdr *pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -5499,9 +5499,9 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	/* memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN); */
@@ -5513,8 +5513,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &(action), &pattrib->pktlen);
@@ -5587,7 +5587,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char				*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct	wlan_network	*pnetwork = NULL;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
@@ -5617,9 +5617,9 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
@@ -5630,8 +5630,8 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -5958,7 +5958,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	__le32 le32_tmp;
 
-	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
+	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
 	if (len > MAX_IE_SZ)
 		return _FAIL;
@@ -5988,7 +5988,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	/* below is to copy the information element */
 	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct rtw_ieee80211_hdr_3addr)), bssid->IELength);
+	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
 
 	/* get the signal strength */
 	bssid->Rssi = precv_frame->attrib.phy_info.recvpower; /*  in dBM.raw data */
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index dcf828a57179..fadacef44813 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -111,7 +111,7 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct adapter *padapter = pwdinfo->padapter;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
@@ -132,9 +132,9 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -145,8 +145,8 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* Build P2P action frame header */
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
@@ -166,7 +166,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct adapter *padapter = pwdinfo->padapter;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
@@ -189,9 +189,9 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -202,8 +202,8 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* Build P2P public action frame header */
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
@@ -243,7 +243,7 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -259,9 +259,9 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, raddr, ETH_ALEN);
@@ -272,8 +272,8 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
 	pframe = rtw_set_fixed_ie(pframe, 1, &action, &pattrib->pktlen);
@@ -311,7 +311,7 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	struct xmit_frame			*pmgntframe;
 	struct pkt_attrib			*pattrib;
 	unsigned char					*pframe;
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	struct adapter *padapter = pwdinfo->padapter;
 	struct xmit_priv			*pxmitpriv = &padapter->xmitpriv;
@@ -334,9 +334,9 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
@@ -347,8 +347,8 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	pmlmeext->mgnt_seq++;
 	SetFrameSubType(pframe, WIFI_ACTION);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* Build P2P action frame header */
 	pframe = rtw_set_fixed_ie(pframe, 1, &category, &pattrib->pktlen);
@@ -900,7 +900,7 @@ u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 	u8 *p2p_ie;
 	u32	p2p_ielen = 0;
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	dialogToken = frame_body[7];
 	status = P2P_STATUS_FAIL_UNKNOWN_P2PGROUP;
@@ -967,7 +967,7 @@ u8 process_p2p_provdisc_req(struct wifidirect_info *pwdinfo,  u8 *pframe, uint l
 	u16	uconfig_method = 0;
 	__be16 be_tmp;
 
-	frame_body = (pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	wpsie = rtw_get_wps_ie(frame_body + _PUBLIC_ACTION_IE_OFFSET_, len - _PUBLIC_ACTION_IE_OFFSET_, NULL, &wps_ielen);
 	if (wpsie) {
@@ -1401,7 +1401,7 @@ u8 process_p2p_presence_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 	u8 dialogToken = 0;
 	u8 status = P2P_STATUS_SUCCESS;
 
-	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
+	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	dialogToken = frame_body[6];
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 84ced6a86df9..27035eac6e61 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -892,7 +892,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	if (!is_client_associated_to_ap(Adapter))
 		return true;
 
-	len = packet_len - sizeof(struct rtw_ieee80211_hdr_3addr);
+	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
 	if (len > MAX_IE_SZ)
 		return _FAIL;
@@ -913,7 +913,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	/* below is to copy the information element */
 	bssid->IELength = len;
-	memcpy(bssid->IEs, (pframe + sizeof(struct rtw_ieee80211_hdr_3addr)), bssid->IELength);
+	memcpy(bssid->IEs, (pframe + sizeof(struct ieee80211_hdr_3addr)), bssid->IELength);
 
 	/* check bw and channel offset */
 	/* parsing HT_CAP_IE */
@@ -1491,7 +1491,7 @@ void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 	u8 *pIE;
 	__le32 *pbuf;
 
-	pIE = pframe + sizeof(struct rtw_ieee80211_hdr_3addr);
+	pIE = pframe + sizeof(struct ieee80211_hdr_3addr);
 	pbuf = (__le32 *)pIE;
 
 	pmlmeext->TSFValue = le32_to_cpu(*(pbuf + 1));
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 029b994e1b71..d086812f8c0e 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -696,13 +696,13 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 {
 	u16 *qc;
 
-	struct rtw_ieee80211_hdr *pwlanhdr = (struct rtw_ieee80211_hdr *)hdr;
+	struct ieee80211_hdr *pwlanhdr = (struct ieee80211_hdr *)hdr;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
 	u8 qos_option = false;
 
 	int res = _SUCCESS;
-	__le16 *fctrl = &pwlanhdr->frame_ctl;
+	__le16 *fctrl = &pwlanhdr->frame_control;
 
 	struct sta_info *psta;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 45b788212628..475650dc7301 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -199,16 +199,16 @@ void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
 
 static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 {
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	u32 rate_len, pktlen;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
 	eth_broadcast_addr(pwlanhdr->addr1);
@@ -218,8 +218,8 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
 	SetFrameSubType(pframe, WIFI_BEACON);
 
-	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
-	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += sizeof(struct ieee80211_hdr_3addr);
+	pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	/* timestamp will be inserted by hardware */
 	pframe += 8;
@@ -281,15 +281,15 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 
 static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 {
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	__le16 *fctrl;
 
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	/*  Frame control. */
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	SetPwrMgt(fctrl);
 	SetFrameSubType(pframe, WIFI_PSPOLL);
@@ -314,7 +314,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	u8 bEosp,
 	u8 bForcePowerSave)
 {
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	u32 pktlen;
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
@@ -322,9 +322,9 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	if (bForcePowerSave)
 		SetPwrMgt(fctrl);
@@ -353,19 +353,19 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	SetSeqNum(pwlanhdr, 0);
 
 	if (bQoS) {
-		struct rtw_ieee80211_hdr_3addr_qos *pwlanqoshdr;
+		struct ieee80211_qos_hdr *pwlanqoshdr;
 
 		SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
 
-		pwlanqoshdr = (struct rtw_ieee80211_hdr_3addr_qos *)pframe;
-		SetPriority(&pwlanqoshdr->qc, AC);
-		SetEOSP(&pwlanqoshdr->qc, bEosp);
+		pwlanqoshdr = (struct ieee80211_qos_hdr *)pframe;
+		SetPriority(&pwlanqoshdr->qos_ctrl, AC);
+		SetEOSP(&pwlanqoshdr->qos_ctrl, bEosp);
 
-		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr_qos);
+		pktlen = sizeof(struct ieee80211_qos_hdr);
 	} else {
 		SetFrameSubType(pframe, WIFI_DATA_NULL);
 
-		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+		pktlen = sizeof(struct ieee80211_qos_hdr);
 	}
 
 	*pLength = pktlen;
@@ -373,7 +373,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 
 static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u8 *StaAddr, bool bHideSSID)
 {
-	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
 	u8 *mac, *bssid;
 	u32 pktlen;
@@ -381,12 +381,12 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 
-	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&adapt->eeprompriv);
 	bssid = cur_network->MacAddress;
 
-	fctrl = &pwlanhdr->frame_ctl;
+	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -395,7 +395,7 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	SetSeqNum(pwlanhdr, 0);
 	SetFrameSubType(fctrl, WIFI_PROBERSP);
 
-	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pktlen = sizeof(struct ieee80211_hdr_3addr);
 	pframe += pktlen;
 
 	if (cur_network->IELength > MAX_IE_SZ)
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index bf4ce3cba46f..0e37cd8974b5 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -178,35 +178,6 @@ struct ieee_param {
 /* this is stolen from ipw2200 driver */
 #define IEEE_IBSS_MAC_HASH_SIZE 31
 
-struct rtw_ieee80211_hdr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	u16 seq_ctl;
-	u8 addr4[ETH_ALEN];
-} __packed;
-
-struct rtw_ieee80211_hdr_3addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	u16 seq_ctl;
-} __packed;
-
-struct rtw_ieee80211_hdr_3addr_qos {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	u16 seq_ctl;
-	u16     qc;
-}  __packed;
-
 #define IEEE80211_3ADDR_LEN 24
 #define IEEE80211_4ADDR_LEN 30
 #define IEEE80211_FCS_LEN    4
-- 
2.35.1

