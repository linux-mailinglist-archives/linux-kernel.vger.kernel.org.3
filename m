Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5147849A943
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1322391AbiAYDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1319436AbiAYDIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:08:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F8C0E532A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c2so23998202wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hti/VRMy5VrdF6lS3aAYgx+qQzMnJmzW4HAuPvStGfU=;
        b=uGCtqc0GtDmy6419RNztAjKDVgWOkvQch3nxYeGRXyeCFYKfZbM7K9qbQseD6Dkva6
         X+nU8oQdcS92ATK1DOieI+88zCVJgDWfumpO1APtGe3VrgV7GuLtBqf1/5mFwJrqUfGj
         3k1mCc58V/g+o/3gDvaeSaqVMhDP7HuTznA5WX4tpjKjH9JBNle10Yn4dGz60JAScL4B
         K04/cAVth2iXX40T9ETLkSKQFHQoM0hrIztaRTfo9FW7CaWlBp0rVPo7wShnq7UgIneh
         ktElk0qoS9sty/BR4P2i7z2gDJ0uemePFBiAlSpaJAXBc5c+6Teyp3IveCUYDnOLDiQR
         fhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hti/VRMy5VrdF6lS3aAYgx+qQzMnJmzW4HAuPvStGfU=;
        b=0BS+XZ4f0FRwAaN1j/EbWp7O0kWpdvmTwXIuA16oCpvVB6y9zXv3P50rZ+VtTIH4BP
         ICaCdOkqjyZFtjRG4S0aeC0NyNartM45nMPTj73uvj5mg9B7svrWtgf7lQQp7OgPiyqZ
         c2p+bmPG0jj8U9ojr49hgbefB7b+c4BtLuZdf8OtWpgD3ASjoY7PwrketX2b3mbYYArN
         tV/EEe2CO6lf2TcPGQS0UyzJ9MTn1E0TXyZMa8Nlrp5Hd0t5C4AjxFwo9wFcGf7TwWYF
         jytt2b04tn5+9DtYbVTxrECHccKGp0bzWvC0q29LzK6S/lUIZEl35/1m+g2UTheglPvK
         oiRQ==
X-Gm-Message-State: AOAM5311+ScRz5E6m/Tpah5w25ag223K5wOxMyvJOh4rYend89rDI8ja
        6W/avpew5i7jQWU46/c9gAlrFg==
X-Google-Smtp-Source: ABdhPJw53FVDzS9Sj27JHcSbHoaHzvTRqWN9f+f1DIt32Emq0tPNUHuqi27jdsgN7W3WY4vXZBpLVw==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr371711wmk.95.1643064275395;
        Mon, 24 Jan 2022 14:44:35 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:34 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 06/10] staging: r8188eu: remove DBG_88E calls from os_dep/ioctl_linux.c
Date:   Mon, 24 Jan 2022 22:44:11 +0000
Message-Id: <20220124224415.831-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124224415.831-1-phil@philpotter.co.uk>
References: <20220124224415.831-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from os_dep/ioctl_linux.c, as they do not
conform to kernel coding standards and are superfluous. Also restructure
where appropriate to remove no longer needed code left behind by removal
of these calls. This will allow the eventual removal of the DBG_88E macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 414 +------------------
 1 file changed, 10 insertions(+), 404 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index b8ea599fd7cf..51766ba3322b 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -342,26 +342,20 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 	int ret = 0;
 
 	if ((value & AUTH_ALG_SHARED_KEY) && (value & AUTH_ALG_OPEN_SYSTEM)) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_SHARED_KEY and  AUTH_ALG_OPEN_SYSTEM [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
 	} else if (value & AUTH_ALG_SHARED_KEY) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_SHARED_KEY  [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_OPEN_SYSTEM\n");
 		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
-	} else if (value & AUTH_ALG_LEAP) {
-		DBG_88E("wpa_set_auth_algs, AUTH_ALG_LEAP\n");
-	} else {
-		DBG_88E("wpa_set_auth_algs, error!\n");
+	} else if ((value & AUTH_ALG_LEAP) == 0) {
 		ret = -EINVAL;
 	}
 	return ret;
@@ -398,8 +392,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		DBG_88E("wpa_set_encryption, crypt.alg = WEP\n");
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
@@ -407,8 +399,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		DBG_88E("(1)wep_key_idx =%d\n", wep_key_idx);
-
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
@@ -433,11 +423,9 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		pwep->KeyIndex |= 0x80000000;
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 		if (param->u.crypt.set_tx) {
-			DBG_88E("wep, set_tx = 1\n");
 			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
 				ret = -EOPNOTSUPP;
 		} else {
-			DBG_88E("wep, set_tx = 0\n");
 			if (wep_key_idx >= WEP_KEYS) {
 				ret = -EOPNOTSUPP;
 				goto exit;
@@ -474,15 +462,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 						padapter->securitypriv.busetkipkey = false;
 					}
 
-					DBG_88E(" ~~~~set sta key:unicastkey\n");
-
 					rtw_setstakey_cmd(padapter, (unsigned char *)psta, true);
 				} else { /* group key */
 					memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey,  param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 					memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
 					memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 					padapter->securitypriv.binstallGrpkey = true;
-					DBG_88E(" ~~~~set sta key:groupkey\n");
 
 					padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 
@@ -535,14 +520,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			goto exit;
 		}
 
-		/* dump */
-		{
-			int i;
-			DBG_88E("\n wpa_ie(length:%d):\n", ielen);
-			for (i = 0; i < ielen; i += 8)
-				DBG_88E("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4], buf[i + 5], buf[i + 6], buf[i + 7]);
-		}
-
 		if (ielen < RSN_HEADER_LEN) {
 			ret  = -1;
 			goto exit;
@@ -614,8 +591,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			while (cnt < ielen) {
 				eid = buf[cnt];
 				if ((eid == _VENDOR_SPECIFIC_IE_) && (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
-					DBG_88E("SET WPS_IE\n");
-
 					padapter->securitypriv.wps_ie_len = ((buf[cnt + 1] + 2) < (MAX_WPA_IE_LEN << 2)) ? (buf[cnt + 1] + 2) : (MAX_WPA_IE_LEN << 2);
 
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
@@ -728,19 +703,15 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 	switch (wrqu->mode) {
 	case IW_MODE_AUTO:
 		networkType = Ndis802_11AutoUnknown;
-		DBG_88E("set_mode = IW_MODE_AUTO\n");
 		break;
 	case IW_MODE_ADHOC:
 		networkType = Ndis802_11IBSS;
-		DBG_88E("set_mode = IW_MODE_ADHOC\n");
 		break;
 	case IW_MODE_MASTER:
 		networkType = Ndis802_11APMode;
-		DBG_88E("set_mode = IW_MODE_MASTER\n");
 		break;
 	case IW_MODE_INFRA:
 		networkType = Ndis802_11Infrastructure;
-		DBG_88E("set_mode = IW_MODE_INFRA\n");
 		break;
 	default:
 		ret = -EINVAL;
@@ -791,7 +762,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 	memcpy(strIssueBssid, pPMK->bssid.sa_data, ETH_ALEN);
 	if (pPMK->cmd == IW_PMKSA_ADD) {
-		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_ADD!\n");
 		if (!memcmp(strIssueBssid, strZeroMacAddress, ETH_ALEN))
 			return ret;
 		else
@@ -802,7 +772,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => rewrite with new PMKID. */
-				DBG_88E("[rtw_wx_set_pmkid] BSSID exists in the PMKList.\n");
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 				psecuritypriv->PMKIDList[j].bUsed = true;
 				psecuritypriv->PMKIDIndex = j + 1;
@@ -813,9 +782,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 		if (!blInserted) {
 			/*  Find a new entry */
-			DBG_88E("[rtw_wx_set_pmkid] Use the new entry index = %d for this PMKID.\n",
-				psecuritypriv->PMKIDIndex);
-
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, strIssueBssid, ETH_ALEN);
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 
@@ -825,7 +791,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 				psecuritypriv->PMKIDIndex = 0;
 		}
 	} else if (pPMK->cmd == IW_PMKSA_REMOVE) {
-		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_REMOVE!\n");
 		ret = true;
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
@@ -836,7 +801,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			}
 	       }
 	} else if (pPMK->cmd == IW_PMKSA_FLUSH) {
-		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_FLUSH!\n");
 		memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		psecuritypriv->PMKIDIndex = 0;
 		ret = true;
@@ -1062,12 +1026,8 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 	if (!mlme)
 		return -1;
 
-	DBG_88E("%s\n", __func__);
-
 	reason = mlme->reason_code;
 
-	DBG_88E("%s, cmd =%d, reason =%d\n", __func__, mlme->cmd, reason);
-
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 		if (!rtw_set_802_11_disassociate(padapter))
@@ -1099,7 +1059,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	}
 
 	if (padapter->bDriverStopped) {
-		DBG_88E("bDriverStopped =%d\n", padapter->bDriverStopped);
 		ret = -1;
 		goto exit;
 	}
@@ -1149,15 +1108,11 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			memcpy(ssid[0].Ssid, req->essid, len);
 			ssid[0].SsidLength = len;
 
-			DBG_88E("IW_SCAN_THIS_ESSID, ssid =%s, len =%d\n", req->essid, req->essid_len);
-
 			spin_lock_bh(&pmlmepriv->lock);
 
 			_status = rtw_sitesurvey_cmd(padapter, ssid, 1, NULL, 0);
 
 			spin_unlock_bh(&pmlmepriv->lock);
-		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
-			DBG_88E("rtw_wx_set_scan, req->scan_type == IW_SCAN_TYPE_PASSIVE\n");
 		}
 	} else {
 		if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE &&
@@ -1320,13 +1275,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 	authmode = padapter->securitypriv.ndisauthtype;
-	DBG_88E("=>%s\n", __func__);
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
-		if (wrqu->essid.length != 33)
-			DBG_88E("ssid =%s, len =%d\n", extra, wrqu->essid.length);
-
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
 		memcpy(ndis_ssid.Ssid, extra, len);
@@ -1369,11 +1320,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 exit:
-
-	DBG_88E("<=%s, ret %d\n", __func__, ret);
-
-
-
 	return ret;
 }
 
@@ -1513,10 +1459,6 @@ static int rtw_wx_set_rts(struct net_device *dev,
 		padapter->registrypriv.rts_thresh = wrqu->rts.value;
 	}
 
-	DBG_88E("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
-
-
 	return 0;
 }
 
@@ -1526,16 +1468,10 @@ static int rtw_wx_get_rts(struct net_device *dev,
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-
-
-	DBG_88E("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
 	wrqu->rts.value = padapter->registrypriv.rts_thresh;
 	wrqu->rts.fixed = 0;	/* no auto select */
 	/* wrqu->rts.disabled = (wrqu->rts.value == DEFAULT_RTS_THRESHOLD); */
 
-
-
 	return 0;
 }
 
@@ -1545,8 +1481,6 @@ static int rtw_wx_set_frag(struct net_device *dev,
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-
-
 	if (wrqu->frag.disabled) {
 		padapter->xmitpriv.frag_len = MAX_FRAG_THRESHOLD;
 	} else {
@@ -1557,10 +1491,6 @@ static int rtw_wx_set_frag(struct net_device *dev,
 		padapter->xmitpriv.frag_len = wrqu->frag.value & ~0x1;
 	}
 
-	DBG_88E("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
-
-
 	return 0;
 }
 
@@ -1570,15 +1500,9 @@ static int rtw_wx_get_frag(struct net_device *dev,
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-
-
-	DBG_88E("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
 	wrqu->frag.value = padapter->xmitpriv.frag_len;
 	wrqu->frag.fixed = 0;	/* no auto select */
 
-
-
 	return 0;
 }
 
@@ -1605,7 +1529,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	struct iw_point *erq = &wrqu->encoding;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	DBG_88E("+rtw_wx_set_enc, flags = 0x%x\n", erq->flags);
 
 	memset(&wep, 0, sizeof(struct ndis_802_11_wep));
 
@@ -1614,7 +1537,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 
 	if (erq->flags & IW_ENCODE_DISABLED) {
-		DBG_88E("EncryptionDisabled\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
@@ -1633,12 +1555,10 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	} else {
 		keyindex_provided = 0;
 		key = padapter->securitypriv.dot11PrivacyKeyIndex;
-		DBG_88E("rtw_wx_set_enc, key =%d\n", key);
 	}
 
 	/* set authentication mode */
 	if (erq->flags & IW_ENCODE_OPEN) {
-		DBG_88E("rtw_wx_set_enc():IW_ENCODE_OPEN\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1646,7 +1566,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else if (erq->flags & IW_ENCODE_RESTRICTED) {
-		DBG_88E("rtw_wx_set_enc():IW_ENCODE_RESTRICTED\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -1654,8 +1573,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeShared;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else {
-		DBG_88E("rtw_wx_set_enc():erq->flags = 0x%x\n", erq->flags);
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1676,8 +1593,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 			/*  set key_id only, no given KeyMaterial(erq->length == 0). */
 			padapter->securitypriv.dot11PrivacyKeyIndex = key;
 
-			DBG_88E("(keyindex_provided == 1), keyid =%d, key_len =%d\n", key, padapter->securitypriv.dot11DefKeylen[key]);
-
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
 			case 5:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -1865,7 +1780,6 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 			LeaveAllPowerSaveMode(padapter);
 			rtw_disassoc_cmd(padapter, 500, false);
-			DBG_88E("%s...call rtw_indicate_disconnect\n ", __func__);
 			rtw_indicate_disconnect(padapter);
 			rtw_free_assoc_resources(padapter, 1);
 		}
@@ -2003,11 +1917,9 @@ static int rtw_wx_read32(struct net_device *dev,
 		sprintf(extra, "0x%08X", data32);
 		break;
 	default:
-		DBG_88E(KERN_INFO "%s: usage> read [bytes],[address(hex)]\n", __func__);
 		ret = -EINVAL;
 		goto err_free_ptmp;
 	}
-	DBG_88E(KERN_INFO "%s: addr = 0x%08X data =%s\n", __func__, addr, extra);
 
 	kfree(ptmp);
 	return 0;
@@ -2035,18 +1947,14 @@ static int rtw_wx_write32(struct net_device *dev,
 	switch (bytes) {
 	case 1:
 		rtw_write8(padapter, addr, (u8)data32);
-		DBG_88E(KERN_INFO "%s: addr = 0x%08X data = 0x%02X\n", __func__, addr, (u8)data32);
 		break;
 	case 2:
 		rtw_write16(padapter, addr, (u16)data32);
-		DBG_88E(KERN_INFO "%s: addr = 0x%08X data = 0x%04X\n", __func__, addr, (u16)data32);
 		break;
 	case 4:
 		rtw_write32(padapter, addr, data32);
-		DBG_88E(KERN_INFO "%s: addr = 0x%08X data = 0x%08X\n", __func__, addr, data32);
 		break;
 	default:
-		DBG_88E(KERN_INFO "%s: usage> write [bytes],[address(hex)],[data(hex)]\n", __func__);
 		return -EINVAL;
 	}
 
@@ -2093,12 +2001,9 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 			       union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
-	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1))
-		DBG_88E("%s set channel_plan = 0x%02X\n", __func__, pmlmepriv->ChannelPlan);
-	else
+	if (rtw_set_chplan_cmd(padapter, channel_plan_req, 1) != _SUCCESS)
 		return -EPERM;
 
 	return 0;
@@ -2120,8 +2025,6 @@ static int rtw_get_ap_info(struct net_device *dev,
 	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct iw_point *pdata = &wrqu->data;
 
-	DBG_88E("+rtw_get_aplist_info\n");
-
 	if (padapter->bDriverStopped || !pdata) {
 		ret = -EINVAL;
 		goto exit;
@@ -2153,15 +2056,12 @@ static int rtw_get_ap_info(struct net_device *dev,
 		pnetwork = container_of(plist, struct wlan_network, list);
 
 		if (!mac_pton(data, bssid)) {
-			DBG_88E("Invalid BSSID '%s'.\n", (u8 *)data);
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			return -EINVAL;
 		}
 
 		if (!memcmp(bssid, pnetwork->network.MacAddress, ETH_ALEN)) {
 			/* BSSID match, then check if supporting wpa/wpa2 */
-			DBG_88E("BSSID:%pM\n", (bssid));
-
 			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength - 12);
 			if (pbuf && (wpa_ielen > 0)) {
 				pdata->flags = 1;
@@ -2210,9 +2110,6 @@ static int rtw_set_pid(struct net_device *dev,
 	if (selector < 3 && selector >= 0) {
 		padapter->pid[selector] = *(pdata + 1);
 		ui_pid[selector] = *(pdata + 1);
-		DBG_88E("%s set pid[%d] =%d\n", __func__, selector, padapter->pid[selector]);
-	} else {
-		DBG_88E("%s selector %d error\n", __func__, selector);
 	}
 exit:
 	return ret;
@@ -2243,8 +2140,6 @@ static int rtw_wps_start(struct net_device *dev,
 	if (u32wps_start == 0)
 		u32wps_start = *extra;
 
-	DBG_88E("[%s] wps_start = %d\n", __func__, u32wps_start);
-
 	if (u32wps_start == 1) /*  WPS Start */
 		rtw_led_control(padapter, LED_CTL_START_WPS);
 	else if (u32wps_start == 2) /*  WPS Stop because of wps success */
@@ -2314,7 +2209,6 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] ssid = %s, len = %zu\n", __func__, extra, strlen(extra));
 	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
 	pwdinfo->nego_ssidlen = strlen(extra);
 
@@ -2342,7 +2236,6 @@ static int rtw_p2p_set_intent(struct net_device *dev,
 		pwdinfo->intent = intent;
 	else
 		ret = -1;
-	DBG_88E("[%s] intent = %d\n", __func__, intent);
 	return ret;
 }
 
@@ -2371,8 +2264,6 @@ static int rtw_p2p_set_listen_ch(struct net_device *dev,
 		ret = -1;
 	}
 
-	DBG_88E("[%s] listen_ch = %d\n", __func__, pwdinfo->listen_channel);
-
 	return ret;
 }
 
@@ -2402,8 +2293,6 @@ static int rtw_p2p_set_op_ch(struct net_device *dev,
 	else
 		ret = -1;
 
-	DBG_88E("[%s] op_ch = %d\n", __func__, pwdinfo->operating_channel);
-
 	return ret;
 }
 
@@ -2425,8 +2314,6 @@ static int rtw_p2p_profilefound(struct net_device *dev,
 	/*	YY => SSID Length */
 	/*	SSID => SSID for persistence group */
 
-	DBG_88E("[%s] In value = %s, len = %d\n", __func__, extra, wrqu->data.length - 1);
-
 	/*	The upper application should pass the SSID to driver by using this rtw_p2p_profilefound function. */
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		if (extra[0] == '0') {
@@ -2462,7 +2349,6 @@ static int rtw_p2p_setDN(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] %s %d\n", __func__, extra, wrqu->data.length - 1);
 	memset(pwdinfo->device_name, 0x00, WPS_MAX_DEVICE_NAME_LEN);
 	memcpy(pwdinfo->device_name, extra, wrqu->data.length - 1);
 	pwdinfo->device_name_len = wrqu->data.length - 1;
@@ -2478,11 +2364,6 @@ static int rtw_p2p_get_status(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	if (padapter->bShowGetP2PState)
-		DBG_88E("[%s] Role = %d, Status = %d, peer addr = %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n", __func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-			pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1], pwdinfo->p2p_peer_interface_addr[2],
-			pwdinfo->p2p_peer_interface_addr[3], pwdinfo->p2p_peer_interface_addr[4], pwdinfo->p2p_peer_interface_addr[5]);
-
 	/*	Commented by Albert 2010/10/12 */
 	/*	Because of the output size limitation, I had removed the "Role" information. */
 	/*	About the "Role" information, we will use the new private IOCTL to get the "Role" information. */
@@ -2518,10 +2399,6 @@ static int rtw_p2p_get_role(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n", __func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-			pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1], pwdinfo->p2p_peer_interface_addr[2],
-			pwdinfo->p2p_peer_interface_addr[3], pwdinfo->p2p_peer_interface_addr[4], pwdinfo->p2p_peer_interface_addr[5]);
-
 	sprintf(extra, "\n\nRole =%.2d\n", rtw_p2p_role(pwdinfo));
 	wrqu->data.length = strlen(extra);
 	return ret;
@@ -2535,9 +2412,6 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n", __func__,
-		rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-		pwdinfo->p2p_peer_interface_addr);
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_interface_addr);
 	wrqu->data.length = strlen(extra);
@@ -2553,9 +2427,6 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n", __func__,
-		rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	sprintf(extra, "\n%pM",
 		pwdinfo->rx_prov_disc_info.peerDevAddr);
 	wrqu->data.length = strlen(extra);
@@ -2571,9 +2442,6 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n",
-		__func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
-		pwdinfo->p2p_peer_device_addr);
 	sprintf(extra, "\nMAC %pM",
 		pwdinfo->p2p_peer_device_addr);
 	wrqu->data.length = strlen(extra);
@@ -2607,8 +2475,6 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] Op_ch = %02x\n", __func__, pwdinfo->operating_channel);
-
 	sprintf(extra, "\n\nOp_ch =%.2d\n", pwdinfo->operating_channel);
 	wrqu->data.length = strlen(extra);
 	return ret;
@@ -2638,7 +2504,6 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 	/*	After knowing its WPS config method, the application can decide the config method for provisioning discovery. */
 	/*	Format: iwpriv wlanx p2p_get_wpsCM 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 6, 17))
 		return -EFAULT;
 
@@ -2707,7 +2572,6 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 	/*	The input data is the GO's interface address which the application wants to know its device address. */
 	/*	Format: iwpriv wlanx p2p_get2 go_devadd = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 10, 17))
 		return -EFAULT;
 
@@ -2788,7 +2652,6 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 	/*	Such user interface could know the device type. */
 	/*	Format: iwpriv wlanx p2p_get2 dev_type = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 9, 17))
 		return -EFAULT;
 
@@ -2864,7 +2727,6 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 	/*	Such user interface could show peer device's device name instead of ssid. */
 	/*	Format: iwpriv wlanx p2p_get2 devN = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 5, 17))
 		return -EFAULT;
 
@@ -2932,7 +2794,6 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 	/*	The application wants to know P2P initiation procedure is supported or not. */
 	/*	Format: iwpriv wlanx p2p_get2 InvProc = 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, (char *)extra);
 	if (copy_from_user(peerMACStr, wrqu->data.pointer + 8, 17))
 		return -EFAULT;
 
@@ -3005,12 +2866,8 @@ static int rtw_p2p_connect(struct net_device *dev,
 	/*	Format: 00:E0:4C:00:00:05 */
 	/*	Format: 00:E0:4C:00:00:05 */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
-	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
+	if (pwdinfo->p2p_state == P2P_STATE_NONE)
 		return ret;
-	}
 
 	if (pwdinfo->ui_got_wps_info == P2P_NO_WPSINFO)
 		return -1;
@@ -3052,11 +2909,9 @@ static int rtw_p2p_connect(struct net_device *dev,
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_ING);
 
-		DBG_88E("[%s] Start PreTx Procedure!\n", __func__);
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_GO_NEGO_TIMEOUT);
 	} else {
-		DBG_88E("[%s] Not Found in Scanning Queue~\n", __func__);
 		ret = -1;
 	}
 	return ret;
@@ -3086,15 +2941,10 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	/*	Command line sample: iwpriv wlan0 p2p_set invite ="00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy" */
 	/*	Format: 00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
-	if (wrqu->data.length <=  37) {
-		DBG_88E("[%s] Wrong format!\n", __func__);
+	if (wrqu->data.length <=  37)
 		return ret;
-	}
 
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
 		return ret;
 	} else {
 		/*	Reset the content of struct tx_invite_req_info */
@@ -3165,8 +3015,6 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_INVITE_TIMEOUT);
-	} else {
-		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
 	return ret;
 }
@@ -3183,10 +3031,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 	/*	0: disable persistent group functionality */
 	/*	1: enable persistent group founctionality */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
 		return ret;
 	} else {
 		if (extra[0] == '0')	/*	Disable the persistent group function. */
@@ -3226,10 +3071,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	/*	Format: 00:E0:4C:00:00:05_pbc */
 	/*	Format: 00:E0:4C:00:00:05_label */
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
-
 	if (pwdinfo->p2p_state == P2P_STATE_NONE) {
-		DBG_88E("[%s] WiFi Direct is disable!\n", __func__);
 		return ret;
 	} else {
 		/*	Reset the content of struct tx_provdisc_req_info excluded the wps_config_method_request. */
@@ -3253,7 +3095,6 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	} else if (!memcmp(&extra[18], "label", 5)) {
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
 	} else {
-		DBG_88E("[%s] Unknown WPS config methodn", __func__);
 		return ret;
 	}
 
@@ -3303,7 +3144,6 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 
 	if (peer_channel) {
-		DBG_88E("[%s] peer channel: %d!\n", __func__, peer_channel);
 		memcpy(pwdinfo->tx_prov_disc_info.peerIFAddr, pnetwork->network.MacAddress, ETH_ALEN);
 		memcpy(pwdinfo->tx_prov_disc_info.peerDevAddr, peerMAC, ETH_ALEN);
 		pwdinfo->tx_prov_disc_info.peer_channel_num[0] = (u16)peer_channel;
@@ -3323,8 +3163,6 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 		_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_PROVISION_TIMEOUT);
-	} else {
-		DBG_88E("[%s] NOT Found in the Scanning Queue!\n", __func__);
 	}
 	return ret;
 }
@@ -3340,7 +3178,6 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	DBG_88E("[%s] data = %s\n", __func__, extra);
 	/*	Added by Albert 20110328 */
 	/*	if the input data is P2P_NO_WPSINFO -> reset the wpsinfo */
 	/*	if the input data is P2P_GOT_WPSINFO_PEER_DISPLAY_PIN -> the utility just input the PIN code got from the peer P2P device. */
@@ -3366,7 +3203,6 @@ static int rtw_p2p_set(struct net_device *dev,
 {
 	int ret = 0;
 
-	DBG_88E("[%s] extra = %s\n", __func__, extra);
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3422,10 +3258,6 @@ static int rtw_p2p_get(struct net_device *dev,
 {
 	int ret = 0;
 
-	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	if (padapter->bShowGetP2PState)
-		DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
 	if (!memcmp(wrqu->data.pointer, "status", 6)) {
 		rtw_p2p_get_status(dev, info, wrqu, extra);
 	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
@@ -3454,7 +3286,6 @@ static int rtw_p2p_get2(struct net_device *dev,
 {
 	int ret = 0;
 
-	DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
 	if (!memcmp(extra, "wpsCM =", 6)) {
 		wrqu->data.length -= 6;
 		rtw_p2p_get_wps_configmethod(dev, info, wrqu,  &extra[6]);
@@ -3501,7 +3332,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	if (0 == strcmp(rereg_priv->old_ifname, new_ifname))
 		return ret;
 
-	DBG_88E("%s new_ifname:%s\n", __func__, new_ifname);
 	ret = rtw_change_ifname(padapter, new_ifname);
 	if (0 != ret)
 		goto exit;
@@ -3516,7 +3346,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	rereg_priv->old_ifname[IFNAMSIZ - 1] = 0;
 
 	if (!memcmp(new_ifname, "disable%d", 9)) {
-		DBG_88E("%s disable\n", __func__);
 		/*  free network queue for Android's timming issue */
 		rtw_free_network_queue(padapter, true);
 
@@ -3594,14 +3423,9 @@ static int rtw_dbg_port(struct net_device *dev,
 	u16 arg;
 	s32 extra_arg;
 	u32 *pdata, val32;
-	struct sta_info *psta;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct wlan_network *cur_network = &pmlmepriv->cur_network;
-	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	pdata = (u32 *)&wrqu->data;
 
@@ -3613,48 +3437,24 @@ static int rtw_dbg_port(struct net_device *dev,
 	extra_arg = *(pdata + 1);
 
 	switch (major_cmd) {
-	case 0x70:/* read_reg */
-		switch (minor_cmd) {
-		case 1:
-			DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
-			break;
-		case 2:
-			DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
-			break;
-		case 4:
-			DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
-			break;
-		}
-		break;
 	case 0x71:/* write_reg */
 		switch (minor_cmd) {
 		case 1:
 			rtw_write8(padapter, arg, extra_arg);
-			DBG_88E("rtw_write8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
 			break;
 		case 2:
 			rtw_write16(padapter, arg, extra_arg);
-			DBG_88E("rtw_write16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
 			break;
 		case 4:
 			rtw_write32(padapter, arg, extra_arg);
-			DBG_88E("rtw_write32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
 			break;
 		}
 		break;
-	case 0x72:/* read_bb */
-		DBG_88E("read_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
-		break;
 	case 0x73:/* write_bb */
 		rtl8188e_PHY_SetBBReg(padapter, arg, 0xffffffff, extra_arg);
-		DBG_88E("write_bbreg(0x%x) = 0x%x\n", arg, rtl8188e_PHY_QueryBBReg(padapter, arg, 0xffffffff));
-		break;
-	case 0x74:/* read_rf */
-		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 	case 0x75:/* write_rf */
 		rtl8188e_PHY_SetRFReg(padapter, minor_cmd, arg, 0xffffffff, extra_arg);
-		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 
 	case 0x76:
@@ -3717,7 +3517,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 start_value = 0;
 			u32 write_num = extra_arg;
 			int i;
-			u8 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3731,11 +3530,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			final = rtw_read8(padapter, reg);
-			if (start_value + write_num - 1 == final)
-				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
-			else
-				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
+			rtw_read8(padapter, reg);
 		}
 			break;
 
@@ -3746,7 +3541,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 write_num = extra_arg;
 
 			int i;
-			u16 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3760,11 +3554,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			final = rtw_read16(padapter, reg);
-			if (start_value + write_num - 1 == final)
-				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
-			else
-				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
+			rtw_read16(padapter, reg);
 		}
 			break;
 		case 0x08: /* continuous write dword test */
@@ -3774,7 +3564,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 write_num = extra_arg;
 
 			int i;
-			u32 final;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3788,13 +3577,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			final = rtw_read32(padapter, reg);
-			if (start_value + write_num - 1 == final)
-				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Success, start:%u, final:%u\n",
-					reg, write_num, start_value, final);
-			else
-				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Fail, start:%u, final:%u\n",
-					reg, write_num, start_value, final);
+			rtw_read32(padapter, reg);
 		}
 			break;
 		}
@@ -3809,8 +3592,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			u8 sign = minor_cmd;
 			u16 write_value = 0;
 
-			DBG_88E("%s set RESP_TXAGC to %s %u\n", __func__, sign ? "minus" : "plus", value);
-
 			if (sign)
 				value = value | 0x10;
 
@@ -3824,140 +3605,23 @@ static int rtw_dbg_port(struct net_device *dev,
 		break;
 	case 0x7F:
 		switch (minor_cmd) {
-		case 0x0:
-			DBG_88E("fwstate = 0x%x\n", get_fwstate(pmlmepriv));
-			break;
-		case 0x01:
-			DBG_88E("auth_alg = 0x%x, enc_alg = 0x%x, auth_type = 0x%x, enc_type = 0x%x\n",
-				psecuritypriv->dot11AuthAlgrthm, psecuritypriv->dot11PrivacyAlgrthm,
-				psecuritypriv->ndisauthtype, psecuritypriv->ndisencryptstatus);
-			break;
-		case 0x02:
-			DBG_88E("pmlmeinfo->state = 0x%x\n", pmlmeinfo->state);
-			break;
-		case 0x03:
-			DBG_88E("qos_option =%d\n", pmlmepriv->qospriv.qos_option);
-			DBG_88E("ht_option =%d\n", pmlmepriv->htpriv.ht_option);
-			break;
-		case 0x04:
-			DBG_88E("cur_ch =%d\n", pmlmeext->cur_channel);
-			DBG_88E("cur_bw =%d\n", pmlmeext->cur_bwmode);
-			DBG_88E("cur_ch_off =%d\n", pmlmeext->cur_ch_offset);
-			break;
-		case 0x05:
-			psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
-			if (psta) {
-				int i;
-				struct recv_reorder_ctrl *preorder_ctrl;
-
-				DBG_88E("SSID =%s\n", cur_network->network.Ssid.Ssid);
-				DBG_88E("sta's macaddr: %pM\n", psta->hwaddr);
-				DBG_88E("cur_channel =%d, cur_bwmode =%d, cur_ch_offset =%d\n", pmlmeext->cur_channel, pmlmeext->cur_bwmode, pmlmeext->cur_ch_offset);
-				DBG_88E("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
-				DBG_88E("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
-				DBG_88E("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
-				DBG_88E("bwmode =%d, ch_offset =%d, sgi =%d\n", psta->htpriv.bwmode, psta->htpriv.ch_offset, psta->htpriv.sgi);
-				DBG_88E("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
-				DBG_88E("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
-				for (i = 0; i < 16; i++) {
-					preorder_ctrl = &psta->recvreorder_ctrl[i];
-					if (preorder_ctrl->enable)
-						DBG_88E("tid =%d, indicate_seq =%d\n", i, preorder_ctrl->indicate_seq);
-				}
-			} else {
-				DBG_88E("can't get sta's macaddr, cur_network's macaddr:%pM\n", (cur_network->network.MacAddress));
-			}
-			break;
 		case 0x06:
 			{
 				u32	ODMFlag;
 				GetHwReg8188EU(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
-				DBG_88E("(B)DMFlag = 0x%x, arg = 0x%x\n", ODMFlag, arg);
 				ODMFlag = (u32)(0x0f & arg);
-				DBG_88E("(A)DMFlag = 0x%x\n", ODMFlag);
 				SetHwReg8188EU(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 			}
 			break;
-		case 0x07:
-			DBG_88E("bSurpriseRemoved =%d, bDriverStopped =%d\n",
-				padapter->bSurpriseRemoved, padapter->bDriverStopped);
-			break;
-		case 0x08:
-			{
-				struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-				struct recv_priv  *precvpriv = &padapter->recvpriv;
-
-				DBG_88E("free_xmitbuf_cnt =%d, free_xmitframe_cnt =%d, free_xmit_extbuf_cnt =%d\n",
-					pxmitpriv->free_xmitbuf_cnt, pxmitpriv->free_xmitframe_cnt, pxmitpriv->free_xmit_extbuf_cnt);
-				DBG_88E("rx_urb_pending_cn =%d\n", precvpriv->rx_pending_cnt);
-			}
-			break;
-		case 0x09:
-			{
-				int i, j;
-				struct list_head *plist, *phead;
-				struct recv_reorder_ctrl *preorder_ctrl;
-
-				DBG_88E("sta_dz_bitmap = 0x%x, tim_bitmap = 0x%x\n", pstapriv->sta_dz_bitmap, pstapriv->tim_bitmap);
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
-							DBG_88E("sta's macaddr:%pM\n", (psta->hwaddr));
-							DBG_88E("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
-							DBG_88E("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
-							DBG_88E("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
-							DBG_88E("bwmode =%d, ch_offset =%d, sgi =%d\n", psta->htpriv.bwmode, psta->htpriv.ch_offset, psta->htpriv.sgi);
-							DBG_88E("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
-							DBG_88E("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
-
-							DBG_88E("capability = 0x%x\n", psta->capability);
-							DBG_88E("flags = 0x%x\n", psta->flags);
-							DBG_88E("wpa_psk = 0x%x\n", psta->wpa_psk);
-							DBG_88E("wpa2_group_cipher = 0x%x\n", psta->wpa2_group_cipher);
-							DBG_88E("wpa2_pairwise_cipher = 0x%x\n", psta->wpa2_pairwise_cipher);
-							DBG_88E("qos_info = 0x%x\n", psta->qos_info);
-							DBG_88E("dot118021XPrivacy = 0x%x\n", psta->dot118021XPrivacy);
-
-							for (j = 0; j < 16; j++) {
-								preorder_ctrl = &psta->recvreorder_ctrl[j];
-								if (preorder_ctrl->enable)
-									DBG_88E("tid =%d, indicate_seq =%d\n", j, preorder_ctrl->indicate_seq);
-							}
-						}
-					}
-				}
-				spin_unlock_bh(&pstapriv->sta_hash_lock);
-			}
-			break;
 		case 0x0c:/* dump rx/tx packet */
-			if (arg == 0) {
-				DBG_88E("dump rx packet (%d)\n", extra_arg);
+			if (arg == 0)
 				SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DUMP_RXPKT, &extra_arg);
-			} else if (arg == 1) {
-				DBG_88E("dump tx packet (%d)\n", extra_arg);
+			else if (arg == 1)
 				SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DUMP_TXPKT, &extra_arg);
-			}
-			break;
-		case 0x15:
-			{
-				struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-				DBG_88E("==>silent resete cnts:%d\n", pwrpriv->ips_enter_cnts);
-			}
 			break;
 		case 0x10:/*  driver version display */
-			DBG_88E("rtw driver version =%s\n", DRIVERVERSION);
 			break;
 		case 0x11:
-			DBG_88E("turn %s Rx RSSI display function\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bRxRSSIDisplay = extra_arg;
 			break;
 		case 0x12: /* set rx_stbc */
@@ -3970,9 +3634,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			    extra_arg == 2 ||
 			    extra_arg == 3) {
 				pregpriv->rx_stbc = extra_arg;
-				DBG_88E("set rx_stbc =%d\n", pregpriv->rx_stbc);
-			} else {
-				DBG_88E("get rx_stbc =%d\n", pregpriv->rx_stbc);
 			}
 		}
 			break;
@@ -3982,24 +3643,13 @@ static int rtw_dbg_port(struct net_device *dev,
 			/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 			if (extra_arg >= 0 && extra_arg < 3) {
 				pregpriv->ampdu_enable = extra_arg;
-				DBG_88E("set ampdu_enable =%d\n", pregpriv->ampdu_enable);
-			} else {
-				DBG_88E("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
 			}
 		}
 			break;
-		case 0x14: /* get wifi_spec */
-		{
-			struct registry_priv	*pregpriv = &padapter->registrypriv;
-			DBG_88E("get wifi_spec =%d\n", pregpriv->wifi_spec);
-		}
-			break;
 		case 0x23:
-			DBG_88E("turn %s the bNotifyChannelChange Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bNotifyChannelChange = extra_arg;
 			break;
 		case 0x24:
-			DBG_88E("turn %s the bShowGetP2PState Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bShowGetP2PState = extra_arg;
 			break;
 		case 0xdd:/* registers dump, 0 for mac reg, 1 for bb reg, 2 for rf reg */
@@ -4014,16 +3664,8 @@ static int rtw_dbg_port(struct net_device *dev,
 			{
 				u32 odm_flag;
 
-				if (0xf == extra_arg) {
+				if (extra_arg == 0xf) {
 					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
-					DBG_88E("extra_arg = 0  - disable all dynamic func\n");
-					DBG_88E("extra_arg = 1  - disable DIG- BIT(0)\n");
-					DBG_88E("extra_arg = 2  - disable High power - BIT(1)\n");
-					DBG_88E("extra_arg = 3  - disable tx power tracking - BIT(2)\n");
-					DBG_88E("extra_arg = 4  - disable BT coexistence - BIT(3)\n");
-					DBG_88E("extra_arg = 5  - disable antenna diversity - BIT(4)\n");
-					DBG_88E("extra_arg = 6  - enable all dynamic func\n");
 				} else {
 					/*	extra_arg = 0  - disable all dynamic func
 						extra_arg = 1  - disable DIG
@@ -4032,51 +3674,17 @@ static int rtw_dbg_port(struct net_device *dev,
 					*/
 					SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &extra_arg);
 					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
 				}
 			}
 			break;
 
 		case 0xfd:
 			rtw_write8(padapter, 0xc50, arg);
-			DBG_88E("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
 			rtw_write8(padapter, 0xc58, arg);
-			DBG_88E("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
-			break;
-		case 0xfe:
-			DBG_88E("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
-			DBG_88E("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
-			break;
-		case 0xff:
-			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
-			DBG_88E("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608));
-			DBG_88E("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280));
-			DBG_88E("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284));
-			DBG_88E("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288));
-
-			DBG_88E("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664));
-
-			DBG_88E("\n");
-
-			DBG_88E("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430));
-			DBG_88E("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438));
-
-			DBG_88E("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440));
-
-			DBG_88E("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458));
-
-			DBG_88E("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484));
-			DBG_88E("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488));
-
-			DBG_88E("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444));
-			DBG_88E("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448));
-			DBG_88E("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c));
-			DBG_88E("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
 			break;
 		}
 		break;
 	default:
-		DBG_88E("error dbg cmd!\n");
 		break;
 	}
 	return ret;
@@ -4153,8 +3761,6 @@ static int rtw_pm_set(struct net_device *dev,
 	unsigned	mode = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
-	DBG_88E("[%s] extra = %s\n", __func__, extra);
-
 	if (!memcmp(extra, "lps =", 4)) {
 		sscanf(extra + 4, "%u", &mode);
 		ret = rtw_pm_set_lps(padapter, mode);
-- 
2.34.1

