Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBCA4F1B88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiDDVUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380690AbiDDVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:02:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E65A38A3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:00:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d29so10317844wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zg14HKB8Tn7Zkt9AnuTFrogrSTPKR6syFIM0HfENyTw=;
        b=AvMyV1kK4/g5y5+g/++IKdQ13rHCkaFko6oOh2JFQkN5qcmS604s5CoC3yRwIaMUiM
         CvsXSoFK0wdmbhy6+s/+0Jjeidr/vkQ6+M6fyCH1XZaFZbnU/Sv8dbqUd6GimVLhDNzA
         0Mroa5MzT6lFnfkfFQbAM3X741eYAd6JfFFCfBOwaAtfQP/Hovfyk3mWq14kAhzEYg0G
         XECSOKeH+wHp56JAzSNBO4VtcX3lkjXiycz1bTxU6G8WPaVeXtuKFD+RtSZVj7G3um+x
         DEtblWoM8zMNLj/ailnkMBvfxH50JdzfV9x6MTA5x+cf6cysy6vAZQN3gEVWmVZ3Qs/s
         r0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zg14HKB8Tn7Zkt9AnuTFrogrSTPKR6syFIM0HfENyTw=;
        b=xrgoQxBoExGVk/NrwFacCZi1GsMC+Xc9us+7Px1G34XZrU3fAm376AfWY4TCafhNfa
         iru1E1aLpiYzR+MotFSyekUulQy4pyFIUonBjTGVk60/PxTd0MrzYsYFAEVfJiLdSbv0
         hdCfZ2c0Geuk3y+qMMGi8hZOEJshh4xENrM95z6MyDrKQsukeZ4Uo5vCB2SdmDoes+0j
         0UTYMpkhuhxIAbkMIYJZ2qTsbamwbQcM00cYcdgpgs5QMFMjWlK5KtrhDSU0Vunz6kMw
         pA8S1+aQw2SQ4iD0HaGy9hAjWeqNvVKUji+l+e5ZVCVSCF+yzM+pZCliXROkilektTKG
         NnhQ==
X-Gm-Message-State: AOAM533mZuRRpw4qDj/9BTJfj/NhS/lFbzpm1/o32uWH/Ja8uMeb+oXz
        f3q39b4tq45OAn9g2NBgHrVLrfuMb/k=
X-Google-Smtp-Source: ABdhPJyYfvJ6npuFsstgJYWJ0aTV/xG8rAhVsj7Yzhv6TKaA0uRCh4m9BcqLhEy+4OSAIOZcuLVDjw==
X-Received: by 2002:a5d:59a1:0:b0:204:1777:fc08 with SMTP id p1-20020a5d59a1000000b002041777fc08mr57988wrr.545.1649106014971;
        Mon, 04 Apr 2022 14:00:14 -0700 (PDT)
Received: from alaa-emad ([41.42.174.117])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm120757wmq.24.2022.04.04.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:00:13 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: rtl8712: Fix multiple line dereference
Date:   Mon,  4 Apr 2022 23:00:10 +0200
Message-Id: <20220404210010.9795-1-eng.alaamohamedsoliman.am@gmail.com>
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

Reported by checkpatch:

WARNING: Avoid multiple line dereference

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 77 +++++++++-----------------
 1 file changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 92b7c9c07df6..6406132ca5ea 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -431,8 +431,7 @@ static int is_desired_network(struct _adapter *adapter,
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
-			adapter->mlmepriv.cur_network.network.
-			InfrastructureMode)
+			adapter->mlmepriv.cur_network.network.InfrastructureMode)
 			bselected = false;
 	}
 	return bselected;
@@ -539,8 +538,7 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 					struct wlan_bssid_ex *pdev_network =
 					  &(adapter->registrypriv.dev_network);
 					u8 *pibss =
-						 adapter->registrypriv.
-							dev_network.MacAddress;
+						 adapter->registrypriv.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
 					memcpy(&pdev_network->Ssid,
 						&pmlmepriv->assoc_ssid,
@@ -688,11 +686,9 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	pnetwork->network.Configuration.DSConfig =
 		 le32_to_cpu(pnetwork->network.Configuration.DSConfig);
 	pnetwork->network.Configuration.FHConfig.DwellTime =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.
-			     DwellTime);
+		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
 	pnetwork->network.Configuration.FHConfig.HopPattern =
-		 le32_to_cpu(pnetwork->network.Configuration.
-			     FHConfig.HopPattern);
+		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
 	pnetwork->network.Configuration.FHConfig.HopSet =
 		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
 	pnetwork->network.Configuration.FHConfig.Length =
@@ -717,36 +713,29 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (the_same_macaddr) {
 					ptarget_wlan =
-					    r8712_find_network(&pmlmepriv->
-					    scanned_queue,
+					    r8712_find_network(&pmlmepriv->scanned_queue,
 					    cur_network->network.MacAddress);
 				} else {
 					pcur_wlan =
-					     r8712_find_network(&pmlmepriv->
-					     scanned_queue,
+					     r8712_find_network(&pmlmepriv->scanned_queue,
 					     cur_network->network.MacAddress);
 					if (pcur_wlan)
 						pcur_wlan->fixed = false;
 
 					pcur_sta = r8712_get_stainfo(pstapriv,
 					     cur_network->network.MacAddress);
-					spin_lock_irqsave(&pstapriv->
-						sta_hash_lock, irqL2);
+					spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
 					r8712_free_stainfo(adapter, pcur_sta);
-					spin_unlock_irqrestore(&(pstapriv->
-						sta_hash_lock), irqL2);
+					spin_unlock_irqrestore(&(pstapriv->sta_hash_lock), irqL2);
 
 					ptarget_wlan =
-						 r8712_find_network(&pmlmepriv->
-						 scanned_queue,
-						 pnetwork->network.
-						 MacAddress);
+						 r8712_find_network(&pmlmepriv->scanned_queue,
+						 pnetwork->network.MacAddress);
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
 				}
 			} else {
-				ptarget_wlan = r8712_find_network(&pmlmepriv->
-						scanned_queue,
+				ptarget_wlan = r8712_find_network(&pmlmepriv->scanned_queue,
 						pnetwork->network.MacAddress);
 				if (ptarget_wlan)
 					ptarget_wlan->fixed = true;
@@ -779,39 +768,25 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 					ptarget_sta->aid = pnetwork->join_res;
 					ptarget_sta->qos_option = 1;
 					ptarget_sta->mac_id = 5;
-					if (adapter->securitypriv.
-					    AuthAlgrthm == 2) {
-						adapter->securitypriv.
-							binstallGrpkey =
-							 false;
-						adapter->securitypriv.
-							busetkipkey =
-							 false;
-						adapter->securitypriv.
-							bgrpkey_handshake =
-							 false;
-						ptarget_sta->ieee8021x_blocked
-							 = true;
-						ptarget_sta->XPrivacy =
-							 adapter->securitypriv.
-							 PrivacyAlgrthm;
-						memset((u8 *)&ptarget_sta->
-							 x_UncstKey,
+					if (adapter->securitypriv.AuthAlgrthm == 2) {
+						adapter->securitypriv.binstallGrpkey = false;
+						adapter->securitypriv.busetkipkey = false;
+						adapter->securitypriv.bgrpkey_handshake = false;
+						ptarget_sta->ieee8021x_blocked = true;
+						ptarget_sta->XPrivacy = adapter->
+						securitypriv.PrivacyAlgrthm;
+						memset((u8 *)&ptarget_sta->x_UncstKey,
 							 0,
 							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->
-							 tkiprxmickey,
+						memset((u8 *)&ptarget_sta->tkiprxmickey,
 							 0,
 							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->
-							 tkiptxmickey,
+						memset((u8 *)&ptarget_sta->tkiptxmickey,
 							 0,
 							 sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->
-							 txpn, 0,
+						memset((u8 *)&ptarget_sta->txpn, 0,
 							 sizeof(union pn48));
-						memset((u8 *)&ptarget_sta->
-							 rxpn, 0,
+						memset((u8 *)&ptarget_sta->rxpn, 0,
 							 sizeof(union pn48));
 					}
 				} else {
@@ -942,8 +917,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 			pdev_network = &(adapter->registrypriv.dev_network);
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
-				r8712_get_wlan_bssid_ex_sz(&tgt_network->
-							network));
+				r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
 			memcpy(&pdev_network->Ssid,
 				&pmlmepriv->assoc_ssid,
 				sizeof(struct ndis_802_11_ssid));
@@ -1092,8 +1066,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 			src_ssid = pmlmepriv->assoc_bssid;
 			if (!memcmp(dst_ssid, src_ssid, ETH_ALEN)) {
 				if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-					if (is_same_network(&pmlmepriv->
-					    cur_network.network,
+					if (is_same_network(&pmlmepriv->cur_network.network,
 					    &pnetwork->network)) {
 						_clr_fwstate_(pmlmepriv,
 							_FW_UNDER_LINKING);
-- 
2.35.1

