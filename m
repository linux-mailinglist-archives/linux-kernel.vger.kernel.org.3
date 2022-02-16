Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276294B7C42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiBPBH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:07:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbiBPBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D74C7916
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f3so666880wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/AmcKAI7S4CQwFP9krb3eotpVDb6rQ2naruRhtvDnjM=;
        b=ZQ2i3XHrfP/PCkNXEU/wMocjfDNRHM8WPUvo4DjL17KrQKnlEWyQXduWgtpxhjmvxI
         eXm6+YbS1qmucRMD9r8c4dTGLobdgdnT5v8xPN/8d8sKkzQnjIoqhSjgFhgxA7mNE+fj
         aPehSKNj9DuNaCDR8LXPabwJyrW5FR2M1HFvnSRMZ3iJg9YGWvFTcY5EctyUYUNAa4xJ
         25QBrZ/Yyp0Wqe8PatKuJVBrYtK8V+qduQEVQeEVp7t8W67iBdemRBont2yhNb7Xx/J/
         t5iJsal00Fi8agueBRTzKPxqiibH4nHz497NXReOILptHhLPj2gY1y6ELupRP5rg28dv
         aOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AmcKAI7S4CQwFP9krb3eotpVDb6rQ2naruRhtvDnjM=;
        b=6uRPqDxKANdgsYshO3i3PQ1FqbQur6F6dQ1lnQ+IM8zPV05ayMsOKn9gpVkaUJIweM
         vyv6rCSquz1rQjkVF0r37OHJGhKDTH5Oxc7HVc25B2/KvbsSVyhDlK39ncJ1ruNTPH7m
         w78hVVmr9XZv2hVPbEkrIEGglZJKnZbQHPI+0wMHDX8E8oBx1oWnwk8z2RB6gPes1H3c
         p+ul701e0PKHSbp58bN/sbtP02tCZPxCDFeN/ww0sL7DXS/skzvPObt6FWl1xdfqSmIW
         Rl0fcBbtfVfyJ31m7OqGD0qhGJ9dIe+a7MpB/aTTKT44d217h9QrdMg8TsKbSF9v3kCK
         15TQ==
X-Gm-Message-State: AOAM5312gHAlI+Y+ecUWVKjy8bGwzxHMM0X8ScJlVQROs1wEszr6QfIu
        X3ZB41fVgEtXZKkU1N7B65VoLA==
X-Google-Smtp-Source: ABdhPJyzfn0LMXOINo64Ga1HiFahm9rJZenR7v5E9TqXbH2ICOIu19aG3E4u8Ir4EFLRlM8FpRcTqQ==
X-Received: by 2002:a5d:4bc8:0:b0:1e4:a4a2:63b0 with SMTP id l8-20020a5d4bc8000000b001e4a4a263b0mr376575wrt.596.1644973631654;
        Tue, 15 Feb 2022 17:07:11 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:11 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 01/15] staging: r8188eu: remove previously converted DBG_88E_LEVEL calls
Date:   Wed, 16 Feb 2022 01:06:55 +0000
Message-Id: <20220216010709.791-2-phil@philpotter.co.uk>
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

Remove all netdev_dbg and dev_dbg calls that were previously converted
from DBG_88E_LEVEL. After some thought, it makes more sense to just
entirely strip all of these calls, so that debugging code in the driver
can be more consistent and useful going forwards.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_fw.c        |  1 -
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  5 ----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 28 --------------------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   |  8 ------
 drivers/staging/r8188eu/core/rtw_xmit.c      |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  2 --
 6 files changed, 45 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index f591b091b8af..ce0e4e3b21f9 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -243,7 +243,6 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 		goto exit;
 	}
 	rtfw->size = fw->size;
-	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->size);
 
 exit:
 	release_firmware(fw);
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index c95ca471ae55..e7f35370b69c 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -110,8 +110,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	u32 cur_time = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	netdev_dbg(padapter->pnetdev, "set bssid:%pM\n", bssid);
-
 	if ((bssid[0] == 0x00 && bssid[1] == 0x00 && bssid[2] == 0x00 &&
 	     bssid[3] == 0x00 && bssid[4] == 0x00 && bssid[5] == 0x00) ||
 	    (bssid[0] == 0xFF && bssid[1] == 0xFF && bssid[2] == 0xFF &&
@@ -186,9 +184,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *pnetwork = &pmlmepriv->cur_network;
 
-	netdev_dbg(padapter->pnetdev, "set ssid [%s] fw_state=0x%08x\n",
-		   ssid->Ssid, get_fwstate(pmlmepriv));
-
 	if (!padapter->hw_init_completed) {
 		status = _FAIL;
 		goto exit;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ceca6751cdee..6c354383c1d2 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -649,8 +649,6 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
-					netdev_dbg(padapter->pnetdev,
-						   "ap has changed, disconnect now\n");
 					receive_disconnect(padapter,
 							   pmlmeinfo->network.MacAddress, 0);
 					return _SUCCESS;
@@ -932,7 +930,6 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	}
 
 	if (go2asoc) {
-		netdev_dbg(padapter->pnetdev, "auth success, start assoc\n");
 		start_clnt_assoc(padapter);
 		return _SUCCESS;
 	}
@@ -1507,10 +1504,6 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		netdev_dbg(padapter->pnetdev,
-			   "ap recv deauth reason code(%d) sta:%pM\n",
-			   reason, GetAddr2Ptr(pframe));
-
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
 			u8 updated = 0;
@@ -1545,10 +1538,6 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			}
 		}
 
-		netdev_dbg(padapter->pnetdev,
-			   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
-			   reason, GetAddr3Ptr(pframe), ignore_received_deauth);
-
 		if (!ignore_received_deauth)
 			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
@@ -1582,10 +1571,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		netdev_dbg(padapter->pnetdev,
-			   "ap recv disassoc reason code(%d) sta:%pM\n",
-			   reason, GetAddr2Ptr(pframe));
-
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
 			u8 updated = 0;
@@ -1603,10 +1588,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 		return _SUCCESS;
 	} else {
-		netdev_dbg(padapter->pnetdev,
-			   "ap recv disassoc reason code(%d) sta:%pM\n",
-			   reason, GetAddr3Ptr(pframe));
-
 		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
@@ -6506,7 +6487,6 @@ void start_clnt_auth(struct adapter *padapter)
 	/*	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
 	issue_deauth(padapter, (&pmlmeinfo->network)->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
 
-	netdev_dbg(padapter->pnetdev, "start auth\n");
 	issue_auth(padapter, NULL, 0);
 
 	set_link_timer(pmlmeext, REAUTH_TO);
@@ -7266,8 +7246,6 @@ void linked_status_chk(struct adapter *padapter)
 			if (rx_chk == _FAIL) {
 				pmlmeext->retry++;
 				if (pmlmeext->retry > rx_chk_limit) {
-					netdev_dbg(padapter->pnetdev,
-						   "disconnect or roaming\n");
 					receive_disconnect(padapter, pmlmeinfo->network.MacAddress,
 							   WLAN_REASON_EXPIRATION_CHK);
 					return;
@@ -7793,9 +7771,6 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	/* write cam */
 	ctrl = BIT(15) | ((pparm->algorithm) << 2) | pparm->keyid;
 
-	netdev_dbg(padapter->pnetdev,
-		   "set group key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) keyid:%d\n",
-		   pparm->algorithm, pparm->keyid);
 	write_cam(padapter, pparm->keyid, ctrl, null_sta, pparm->key);
 
 	return H2C_SUCCESS;
@@ -7824,9 +7799,6 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 	cam_id = 4;
 
-	netdev_dbg(padapter->pnetdev,
-		   "set pairwise key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) camid:%d\n",
-		   pparm->algorithm, cam_id);
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 46e44aee587f..ff35685eaa12 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -15,12 +15,6 @@ void ips_enter(struct adapter *padapter)
 
 	if (pxmit_priv->free_xmitbuf_cnt != NR_XMITBUFF ||
 	    pxmit_priv->free_xmit_extbuf_cnt != NR_XMIT_EXTBUFF) {
-		netdev_dbg(padapter->pnetdev,
-			   "There are some pkts to transmit\n");
-		netdev_dbg(padapter->pnetdev,
-			   "free_xmitbuf_cnt: %d, free_xmit_extbuf_cnt: %d\n",
-			   pxmit_priv->free_xmitbuf_cnt,
-			   pxmit_priv->free_xmit_extbuf_cnt);
 		return;
 	}
 
@@ -35,7 +29,6 @@ void ips_enter(struct adapter *padapter)
 	DBG_88E("==>ips_enter cnts:%d\n", pwrpriv->ips_enter_cnts);
 	if (rf_off == pwrpriv->change_rfpwrstate) {
 		pwrpriv->bpower_saving = true;
-		netdev_dbg(padapter->pnetdev, "nolinked power save enter\n");
 
 		if (pwrpriv->ips_mode == IPS_LEVEL_2)
 			pwrpriv->bkeepfwalive = true;
@@ -68,7 +61,6 @@ int ips_leave(struct adapter *padapter)
 		if (result == _SUCCESS) {
 			pwrpriv->rf_pwrstate = rf_on;
 		}
-		netdev_dbg(padapter->pnetdev, "nolinked power save leave\n");
 
 		if ((_WEP40_ == psecuritypriv->dot11PrivacyAlgrthm) || (_WEP104_ == psecuritypriv->dot11PrivacyAlgrthm)) {
 			DBG_88E("==>%s, channel(%d), processing(%x)\n", __func__, padapter->mlmeextpriv.cur_channel, pwrpriv->bips_processing);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f3e788e42b18..30714fee1921 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -460,7 +460,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 			}
 		}
 	} else if (0x888e == pattrib->ether_type) {
-		netdev_dbg(padapter->pnetdev, "send eapol packet\n");
 	}
 
 	if ((pattrib->ether_type == 0x888e) || (pattrib->dhcp_pkt == 1))
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index f6a683cda614..3bb2714a6a54 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -58,7 +58,6 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 
 	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
 
-	netdev_dbg(padapter->pnetdev, "assoc success\n");
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
@@ -71,7 +70,6 @@ void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 	memset(wrqu.ap_addr.sa_data, 0, ETH_ALEN);
 
-	netdev_dbg(padapter->pnetdev, "indicate disassoc\n");
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
-- 
2.34.1

