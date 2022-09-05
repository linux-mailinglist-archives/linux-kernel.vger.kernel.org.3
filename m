Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E65AD9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiIET4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIET4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:56:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD05C9C5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:56:32 -0700 (PDT)
Received: from dslb-178-004-201-030.178.004.pools.vodafone-ip.de ([178.4.201.30] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oVICo-00060M-8I; Mon, 05 Sep 2022 21:56:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove channel parameters from rtw_sitesurvey_cmd
Date:   Mon,  5 Sep 2022 21:56:12 +0200
Message-Id: <20220905195612.81945-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
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

The rtw_sitesurvey_cmd function may receive an array of channels in the
ch and ch_num parameters. All of the callers set ch = NULL and ch_num = 0.

Remove the two parameters from rtw_sitesurvey_cmd and the code to process
them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c       | 14 +-------------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  6 +++---
 drivers/staging/r8188eu/core/rtw_mlme.c      |  2 +-
 drivers/staging/r8188eu/include/rtw_cmd.h    |  4 +---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  2 +-
 5 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 5b6a891b5d67..b9e49781c7a9 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -288,8 +288,7 @@ int rtw_cmd_thread(void *context)
  *	### NOTE:#### (!!!!)
  *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
  */
-u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
-	struct rtw_ieee80211_channel *ch, int ch_num)
+u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num)
 {
 	u8 res = _FAIL;
 	struct cmd_obj		*ph2c;
@@ -331,17 +330,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		}
 	}
 
-	/* prepare channel list */
-	if (ch) {
-		int i;
-		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
-			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
-				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
-				psurveyPara->ch_num++;
-			}
-		}
-	}
-
 	set_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
 
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 17f6bcbeebf4..5d8958303151 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -43,7 +43,7 @@ u8 rtw_do_join(struct adapter *padapter)
 		if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 		    pmlmepriv->to_roaming > 0) {
 			/*  submit site_survey_cmd */
-			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
+			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1);
 			if (ret != _SUCCESS)
 				pmlmepriv->to_join = false;
 		} else {
@@ -89,7 +89,7 @@ u8 rtw_do_join(struct adapter *padapter)
 				/* we try to issue sitesurvey firstly */
 				if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 				    pmlmepriv->to_roaming > 0) {
-					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
+					ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1);
 					if (ret != _SUCCESS)
 						pmlmepriv->to_join = false;
 				} else {
@@ -360,7 +360,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 
 		spin_lock_bh(&pmlmepriv->lock);
 
-		res = rtw_sitesurvey_cmd(padapter, pssid, ssid_max_num, NULL, 0);
+		res = rtw_sitesurvey_cmd(padapter, pssid, ssid_max_num);
 
 		spin_unlock_bh(&pmlmepriv->lock);
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 8f21d34a317f..12dd9f202ee5 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -744,7 +744,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0) != _SUCCESS) {
+					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1) != _SUCCESS) {
 						rtw_set_roaming(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6b6d560d7143..9a76aa85de94 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -730,9 +730,7 @@ struct TDLSoption_param
 #define H2C_CMD_OVERFLOW	0x06
 #define H2C_RESERVED		0x07
 
-u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
-		      int ssid_num, struct rtw_ieee80211_channel *ch,
-		      int ch_num);
+u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num);
 u8 rtw_createbss_cmd(struct adapter  *padapter);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
 u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d6b6021a4250..2de2e1e32738 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1099,7 +1099,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 			spin_lock_bh(&pmlmepriv->lock);
 
-			_status = rtw_sitesurvey_cmd(padapter, ssid, 1, NULL, 0);
+			_status = rtw_sitesurvey_cmd(padapter, ssid, 1);
 
 			spin_unlock_bh(&pmlmepriv->lock);
 		}
-- 
2.30.2

