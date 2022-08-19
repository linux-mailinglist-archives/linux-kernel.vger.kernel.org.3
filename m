Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED12599C67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349091AbiHSMzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349138AbiHSMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C877D785
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o22so5542705edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tAmQnmMG9ngyzqoxqUFov3vhCv4LuzEIa0OtSUt5erk=;
        b=jo0fx+NYJC1/UVGcqXo9qyO+QFAdYLpa5ReA1N1BWsm+LZKGPFdLMOxHuoVX9cVhN2
         mqZ8m00O0N3CkVR8yF/r3RZKFWCla9Q5yXsXLjPrm4Z0YdgZE4ECu2fAJX7ZSyHDDCyn
         vUgKMH7ocjYWj5M7y78UFMjfcHSlR+BT4iCIoKDYkeT/6RMe6c5Fx5V8trJDcngzBOfg
         v6PKD/k9TsWtoQTFKOySwt+NSUK+jNq7C1q80i9amu9/y5Z48zt/qe2aFZOKIRgyTSWz
         hY4QTNi2zjnGyE1fXcFu9M/oSh03CKkuDYwpGfciTDvc6kLNaniyVLuzDhLR5UIlMnzV
         psIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tAmQnmMG9ngyzqoxqUFov3vhCv4LuzEIa0OtSUt5erk=;
        b=ickK9Cvb6lQG/Xb+kMZVx3t8LUs7/V9M+kD2dTThQdNU4lZPj5RjllozdAVFtoxepb
         tnE+ehjT0Csqk2SZuzQGPhHwG4WODZnNGWGu5GQiYurcp5PQ9xbFq6Zt6ZgVmQkRoLF9
         0ivLPPZC+BiyogzZKvzZgEcV55cvKSQa9zApQiLS3Gym7fTWkZGnsHc16ypItbt8q59H
         8o3RIKj0M8pL6EtCOyGwK4Vf7GMWrdvb6WkdfuS849Tb8QoTsf23ojJ6AasJUm4+gPEB
         f9ed57kecbcsWxDpKNBa0XcHhFB0HBNZ2WUx0xgMCWrkWAiGP8+6qrk3w9hG0EY9gKee
         KSog==
X-Gm-Message-State: ACgBeo1xCf0gsu9+aQoU58y4uFbeRbjFpTmb/cayVJ/+QBCwJDF3jmVA
        GsyybNZdTeFIRP3VfkVPDTM=
X-Google-Smtp-Source: AA6agR54ilZIKV+QdyHINpGf9KP2HA9n7Yep9v+eE8XoH/t/YLXviYs3rsm82Qf7cRtV5Ww2ZOxRZA==
X-Received: by 2002:a05:6402:90a:b0:443:8b10:bcad with SMTP id g10-20020a056402090a00b004438b10bcadmr6110556edz.416.1660913683255;
        Fri, 19 Aug 2022 05:54:43 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/11] staging: r8188eu: make rtw_reset_securitypriv() static
Date:   Fri, 19 Aug 2022 14:54:24 +0200
Message-Id: <20220819125428.8412-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
References: <20220819125428.8412-1-straube.linux@gmail.com>
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

The function rtw_reset_securitypriv() is only used in rtw_mlme.c.
Make rtw_reset_securitypriv() and its user
rtw_os_indicate_disconnect() static to get one step closer to
removing os_dep/mlme_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      | 51 ++++++++++++++++++++
 drivers/staging/r8188eu/include/mlme_osdep.h |  2 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c  | 50 -------------------
 3 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 213c64303b01..6e51d735b2bb 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -795,6 +795,57 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 
 }
 
+static struct rt_pmkid_list backup_pmkid[NUM_PMKID_CACHE];
+
+static void rtw_reset_securitypriv(struct adapter *adapter)
+{
+	u8 backup_index;
+	u8 backup_counter;
+	u32 backup_time;
+
+	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+		/* 802.1x */
+		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
+		/*  Backup the btkip_countermeasure information. */
+		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
+		memcpy(&backup_pmkid[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		backup_index = adapter->securitypriv.PMKIDIndex;
+		backup_counter = adapter->securitypriv.btkip_countermeasure;
+		backup_time = adapter->securitypriv.btkip_countermeasure_time;
+		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
+
+		/*  Restore the PMK information to securitypriv structure for the following connection. */
+		memcpy(&adapter->securitypriv.PMKIDList[0],
+			    &backup_pmkid[0],
+			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		adapter->securitypriv.PMKIDIndex = backup_index;
+		adapter->securitypriv.btkip_countermeasure = backup_counter;
+		adapter->securitypriv.btkip_countermeasure_time = backup_time;
+		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
+		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
+	} else {
+		/* reset values in securitypriv */
+		struct security_priv *psec_priv = &adapter->securitypriv;
+
+		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;  /* open system */
+		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
+		psec_priv->dot11PrivacyKeyIndex = 0;
+		psec_priv->dot118021XGrpPrivacy = _NO_PRIVACY_;
+		psec_priv->dot118021XGrpKeyid = 1;
+		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
+		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
+	}
+}
+
+static void rtw_os_indicate_disconnect(struct adapter *adapter)
+{
+	/*  Do it first for tx broadcast pkt after disconnection issue! */
+	netif_carrier_off(adapter->pnetdev);
+
+	rtw_indicate_wx_disassoc_event(adapter);
+	rtw_reset_securitypriv(adapter);
+}
+
 /*
 *rtw_indicate_connect: the caller has to lock pmlmepriv->lock
 */
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
index 2c0ce06bce82..9cee84acff6b 100644
--- a/drivers/staging/r8188eu/include/mlme_osdep.h
+++ b/drivers/staging/r8188eu/include/mlme_osdep.h
@@ -8,11 +8,9 @@
 #include "drv_types.h"
 
 void rtw_init_mlme_timer(struct adapter *padapter);
-void rtw_os_indicate_disconnect(struct adapter *adapter);
 void rtw_os_indicate_connect(struct adapter *adapter);
 void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted);
 
-void rtw_reset_securitypriv(struct adapter *adapter);
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 
 #endif	/* _MLME_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 48287aeaf502..d439ffaf9797 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -52,53 +52,3 @@ void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
 	indicate_wx_scan_complete_event(padapter);
 }
-
-static struct rt_pmkid_list backup_pmkid[NUM_PMKID_CACHE];
-
-void rtw_reset_securitypriv(struct adapter *adapter)
-{
-	u8 backup_index;
-	u8 backup_counter;
-	u32 backup_time;
-
-	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
-		/* 802.1x */
-		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
-		/*  Backup the btkip_countermeasure information. */
-		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
-		memcpy(&backup_pmkid[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		backup_index = adapter->securitypriv.PMKIDIndex;
-		backup_counter = adapter->securitypriv.btkip_countermeasure;
-		backup_time = adapter->securitypriv.btkip_countermeasure_time;
-		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
-
-		/*  Restore the PMK information to securitypriv structure for the following connection. */
-		memcpy(&adapter->securitypriv.PMKIDList[0],
-			    &backup_pmkid[0],
-			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		adapter->securitypriv.PMKIDIndex = backup_index;
-		adapter->securitypriv.btkip_countermeasure = backup_counter;
-		adapter->securitypriv.btkip_countermeasure_time = backup_time;
-		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
-	} else {
-		/* reset values in securitypriv */
-		struct security_priv *psec_priv = &adapter->securitypriv;
-
-		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;  /* open system */
-		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		psec_priv->dot11PrivacyKeyIndex = 0;
-		psec_priv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-		psec_priv->dot118021XGrpKeyid = 1;
-		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
-		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
-	}
-}
-
-void rtw_os_indicate_disconnect(struct adapter *adapter)
-{
-
-	netif_carrier_off(adapter->pnetdev); /*  Do it first for tx broadcast pkt after disconnection issue! */
-	rtw_indicate_wx_disassoc_event(adapter);
-	rtw_reset_securitypriv(adapter);
-}
-- 
2.37.1

