Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956C04B7C34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbiBPBId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:08:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbiBPBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A207CF5410
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i14so807539wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5XUg70gZkpOGWFRM7BsYfw7k+GheIQvpvliR21ybWI=;
        b=7n44dCmWW5IqB/PHOcYQFsqos7BWejhVCuPLcSY0MJ4uPUdDsIUHUCQ8AeqC5cJZUf
         In+LKbE5RM1xhCZUqkrykRHRBNUbc9Tf8nNM3qFh2xlMWSvNyjOAgSZbZIXEZEuSh3hA
         x9l+mLZG0q/y0VRVgFqiAoxRAqjMDzrtATPd1aqOb5WPZxzocGnF339JoOOhemvMZvMr
         SHzxYY2FzpLfn2HVBpdUQLoOxviA4uoX6USzjkdxBHS/I1AFFFpQwTCVRREKAgMVOhnm
         Mi80yZsHeLcAaGK4TzNoMUw8SSNplzNEkVOFqaMzwhsvSP+DDs9+UqGsCPi7CzkpW0YK
         1ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5XUg70gZkpOGWFRM7BsYfw7k+GheIQvpvliR21ybWI=;
        b=ACgDlWX6HmKWY7ar8KRYs6lefmAe5qDu140+F1a/hfLIe4+T+me+doO9p2kKnxlMGL
         OjT7iC74cGJuOxaUUNx8X7WcXCv7LBRgXTmgjJDJ+hk+dajOw7OXaY5BVamQNRRpvzsD
         W/7/+yVIr3vRRLPbpX1xmXFirAjMCh41Wk7Pi9U8t2BgUxUMOMXFCknV2Hu7axbJ85qI
         HYXExqfe2jRmNq4OGAeWCDIyYGT4epwjHbt2SZRUaMT2qVLz6fs9+4WIlP7clQ4CDdUi
         8CGbKhTupB3PkQ4hI6c+l8AnmLE6EZhAbHJFKP0lSFqw3or2HsrMvFtJCtcy/uUKzPhC
         xmgA==
X-Gm-Message-State: AOAM532h3eQK5G5Eb41GvSUcAx5x0GBkdGHL+9+ga2+yz081hOxVcKqf
        KYYfBbXnap8zHr7MMNwwh3kiww==
X-Google-Smtp-Source: ABdhPJwiJo7m8gPqzERIDDALzJeTtjox7rMaUYQSzk6N3FeygfM04lQWQe1/zBzxKRzcsVSRADNyrg==
X-Received: by 2002:a5d:64e3:0:b0:1e4:a380:bb6f with SMTP id g3-20020a5d64e3000000b001e4a380bb6fmr353729wri.463.1644973644149;
        Tue, 15 Feb 2022 17:07:24 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:23 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 15/15] staging: r8188eu: correct long line warnings near prior DBG_88E calls
Date:   Wed, 16 Feb 2022 01:07:09 +0000
Message-Id: <20220216010709.791-16-phil@philpotter.co.uk>
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

Where it is possible (without out-of-patch-series-scope large scale
refactoring), correct code to remove checkpatch warnings about lines
that are too long, also correcting operator spacing where appropriate
for these lines as well. These warnings occur mostly due to so many
DBG_88E removals and parentheses tweaks etc. being adjacent to such
long lines, which are therefore included in the resultant diff.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c    | 12 +++++++++---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  3 ++-
 drivers/staging/r8188eu/core/rtw_p2p.c       | 15 ++++++++++++---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   |  3 ++-
 drivers/staging/r8188eu/core/rtw_wlan_util.c |  6 ++++--
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index ddc3a2c8aaca..d68611ef22f8 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -382,7 +382,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 	if (protocol == ETH_P_IP) {
 		struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);
 
-		if (((unsigned char *)(iph) + (iph->ihl<<2)) >= (skb->data + ETH_HLEN + skb->len))
+		if (((unsigned char *)(iph) + (iph->ihl << 2)) >= (skb->data + ETH_HLEN + skb->len))
 			return -1;
 
 		switch (method) {
@@ -451,7 +451,11 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						pOldTag = (struct pppoe_tag *)__nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
 						if (pOldTag) { /*  if SID existed, copy old value and delete it */
 							old_tag_len = ntohs(pOldTag->tag_len);
-							if (old_tag_len+TAG_HDR_LEN+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN > sizeof(tag_buf))
+							if (old_tag_len +
+							    TAG_HDR_LEN +
+							    MAGIC_CODE_LEN +
+							    RTL_RELAY_TAG_LEN >
+							    sizeof(tag_buf))
 								return -1;
 
 							memcpy(tag->tag_data+MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN,
@@ -476,7 +480,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 							return -1;
 					} else { /*  not add relay tag */
 						if (priv->pppoe_connection_in_progress &&
-								memcmp(skb->data+ETH_ALEN, priv->pppoe_addr, ETH_ALEN))
+						    memcmp(skb->data + ETH_ALEN,
+							   priv->pppoe_addr,
+							   ETH_ALEN))
 							return -2;
 
 						if (priv->pppoe_connection_in_progress == 0)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 2b6dbabe47c8..0d9351903ae5 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3583,7 +3583,8 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 
 	if (GetRetry(frame)) {
 		if (token >= 0) {
-			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token))
+			if ((seq_ctrl == mlmeext->action_public_rxseq) &&
+			    (token == mlmeext->action_public_dialog_token))
 				return _FAIL;
 		} else {
 			if (seq_ctrl == mlmeext->action_public_rxseq)
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 9467a5dcc990..48500fb82250 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1154,7 +1154,8 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 						peer_operating_ch = operatingch_info[4];
 
 					if (rtw_p2p_is_channel_list_ok(peer_operating_ch,
-							       ch_list_inclusioned, ch_num_inclusioned))
+								       ch_list_inclusioned,
+								       ch_num_inclusioned))
 						/**
 						 *	Change our operating channel as peer's for compatibility.
 						 */
@@ -1270,7 +1271,11 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			/*	Try to get the operation channel information */
 
 			attr_contentlen = 0;
-			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen))
+			if (rtw_get_p2p_attr_content(p2p_ie,
+						     p2p_ielen,
+						     P2P_ATTR_OPERATING_CH,
+						     operatingch_info,
+						     &attr_contentlen))
 				pwdinfo->peer_operating_ch = operatingch_info[4];
 
 			/*	Try to get the channel list information */
@@ -1377,7 +1382,11 @@ u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo, u8 *pfr
 		}
 
 		attr_contentlen = 0;
-		if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_OPERATING_CH, operatingch_info, &attr_contentlen))
+		if (rtw_get_p2p_attr_content(p2p_ie,
+					     p2p_ielen,
+					     P2P_ATTR_OPERATING_CH,
+					     operatingch_info,
+					     &attr_contentlen))
 			pwdinfo->peer_operating_ch = operatingch_info[4];
 
 		/* Get the next P2P IE */
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index c7c79cd9e213..b20436f75459 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -171,7 +171,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 		return false;
 	if (pwrpriv->bInSuspend)
 		return false;
-	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X && !padapter->securitypriv.binstallGrpkey)
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X &&
+	    !padapter->securitypriv.binstallGrpkey)
 		return false;
 	return true;
 }
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index e8bf5672ff6c..33c0228204ad 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -926,7 +926,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 	    bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) /* not hidden ssid */
+		/* not hidden ssid */
+		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0)
 			goto _mismatch;
 	}
 
@@ -966,7 +967,8 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is_8021x);
 		}
 
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher)
+		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher ||
+		    group_cipher != cur_network->BcnInfo.group_cipher)
 			goto _mismatch;
 
 		if (is_8021x != cur_network->BcnInfo.is_8021x)
-- 
2.34.1

