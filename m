Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382B95094E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383753AbiDUCBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349158AbiDUCBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:01:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA51572E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:58:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b7so3465758plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NEExhqRDw0bRgp5E7AoNs2nnV1yPZxjH9MJdfp/rqlQ=;
        b=X5PVhWvuRMP/CqIcJ3WL4XdJ4o4WT1mRaUdOKULTGK7DRcLg8i6Fy6ckjQsJVTBBkd
         vTPAP4sy95/ANLBx2el4DV89hUn0REGi313O9X+224HulE8IStLjY9pA3QRLfTock2BG
         oieVjJ3YBJ6f7B6dI8yh16w3aO9opphAqSe27mtEoWH9ei7fKKuojfJWuoXmQF6sDpPd
         ohwKc09kNcXFQQ6V4POBrsyDpxx/SeyFkLpWYmb3rY1tY3Op4A6Cru7wf0LJGx59/H/d
         FomPAgFCe1L07zUAvzYj9kR3m9/WPe8scHvvmCtfudaj5slZLgabQ8yo7ZkvwERRaz2W
         rCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NEExhqRDw0bRgp5E7AoNs2nnV1yPZxjH9MJdfp/rqlQ=;
        b=SY1AIB+mAJj11dTTZbY0zBkYa19YCNbvQtGn9pNhUzkjxkh8ZWRMbDhVfiU9OOqbE+
         xMbJVv9I9WDVHiYGNi/7eiYyAfM/yiD+VSWECgXan4KcswKKOJcoDlnj47blGkz/r80d
         cBJA4J9iPVGOSrer/YK4kaoIBDGlw3frJUx8cMZYF4NZj72mSehqFojRidgpN93UXbrA
         SLwTL9JCjpUrsSuLeZTOxVUIoLxpsCHEVvg/TdzSrTR7mg1VSagrG7cVQlcTiT9uJ/Pf
         YwfvpI+QQWtpQySK/6UYQXf0LXx78uBjfY+uFSE3LtSD19Jk//TS0PvI4jR2rFWLHkFi
         rfXQ==
X-Gm-Message-State: AOAM533QN+d9QHAHjf84NV5Uy/8VkMbi09MYUYgxevmp4S0aeA41mOGg
        aHaxOQXwd5xFTDM1eXxSlgE=
X-Google-Smtp-Source: ABdhPJyR4EvIyUhyYqN/yAHuJQ03u7demxrpHZ3SWqtwA8zLzBMVxDa7HkV7h2/n3GSUP1JH6IzRRQ==
X-Received: by 2002:a17:90b:1b0f:b0:1d2:90e4:26e2 with SMTP id nu15-20020a17090b1b0f00b001d290e426e2mr7668165pjb.148.1650506331216;
        Wed, 20 Apr 2022 18:58:51 -0700 (PDT)
Received: from localhost.localdomain ([14.100.48.186])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090a859700b001cd4989ff47sm489226pjn.14.2022.04.20.18.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:58:50 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk
Subject: [PATCH] staging: r8188eu: use in-kernel ieee channel
Date:   Thu, 21 Apr 2022 09:58:12 +0800
Message-Id: <20220421015811.2745-1-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtw_ieee80211_channel structure just duplicates the in-kernel
ieee80211_channel structure and flag from include/net/cfg80211.h.

Remove the rtw_ prefixes and use the in-kernel structure and flags.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c        |  6 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 18 +++++-----
 drivers/staging/r8188eu/include/ieee80211.h   | 34 +------------------
 drivers/staging/r8188eu/include/rtw_cmd.h     |  4 +--
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 5 files changed, 16 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index f036a980ec1a..ebe2479d1402 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -320,7 +320,7 @@ int rtw_cmd_thread(void *context)
  *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
  */
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
-	struct rtw_ieee80211_channel *ch, int ch_num)
+	struct ieee80211_channel *ch, int ch_num)
 {
 	u8 res = _FAIL;
 	struct cmd_obj		*ph2c;
@@ -366,8 +366,8 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	if (ch) {
 		int i;
 		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
-			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
-				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
+			if (ch[i].hw_value && !(ch[i].flags & IEEE80211_CHAN_DISABLED)) {
+				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct ieee80211_channel));
 				psurveyPara->ch_num++;
 			}
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index db61acc914d1..bc7cf54e1c6a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5811,11 +5811,11 @@ void site_survey(struct adapter *padapter)
 		else
 			ScanType = SCAN_ACTIVE;
 	} else {
-		struct rtw_ieee80211_channel *ch;
+		struct ieee80211_channel *ch;
 		if (pmlmeext->sitesurvey_res.channel_idx < pmlmeext->sitesurvey_res.ch_num) {
 			ch = &pmlmeext->sitesurvey_res.ch[pmlmeext->sitesurvey_res.channel_idx];
 			survey_channel = ch->hw_value;
-			ScanType = (ch->flags & RTW_IEEE80211_CHAN_PASSIVE_SCAN) ? SCAN_PASSIVE : SCAN_ACTIVE;
+			ScanType = (ch->flags & IEEE80211_CHAN_NO_IR) ? SCAN_PASSIVE : SCAN_ACTIVE;
 		}
 	}
 
@@ -7342,26 +7342,26 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	return	H2C_SUCCESS;
 }
 
-static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_channel *out,
-	u32 out_num, struct rtw_ieee80211_channel *in, u32 in_num)
+static int rtw_scan_ch_decision(struct adapter *padapter, struct ieee80211_channel *out,
+	u32 out_num, struct ieee80211_channel *in, u32 in_num)
 {
 	int i, j;
 	int set_idx;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	/* clear out first */
-	memset(out, 0, sizeof(struct rtw_ieee80211_channel) * out_num);
+	memset(out, 0, sizeof(struct ieee80211_channel) * out_num);
 
 	/* acquire channels from in */
 	j = 0;
 	for (i = 0; i < in_num; i++) {
 		set_idx = rtw_ch_set_search_ch(pmlmeext->channel_set, in[i].hw_value);
-		if (in[i].hw_value && !(in[i].flags & RTW_IEEE80211_CHAN_DISABLED) &&
+		if (in[i].hw_value && !(in[i].flags & IEEE80211_CHAN_DISABLED) &&
 		    set_idx >= 0) {
-			memcpy(&out[j], &in[i], sizeof(struct rtw_ieee80211_channel));
+			memcpy(&out[j], &in[i], sizeof(struct ieee80211_channel));
 
 			if (pmlmeext->channel_set[set_idx].ScanType == SCAN_PASSIVE)
-				out[j].flags &= RTW_IEEE80211_CHAN_PASSIVE_SCAN;
+				out[j].flags &= IEEE80211_CHAN_NO_IR;
 
 			j++;
 		}
@@ -7375,7 +7375,7 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 			out[i].hw_value = pmlmeext->channel_set[i].ChannelNum;
 
 			if (pmlmeext->channel_set[i].ScanType == SCAN_PASSIVE)
-				out[i].flags &= RTW_IEEE80211_CHAN_PASSIVE_SCAN;
+				out[i].flags &= IEEE80211_CHAN_NO_IR;
 
 			j++;
 		}
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 0e37cd8974b5..c67d81409c78 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -8,6 +8,7 @@
 #include "drv_types.h"
 #include "wifi.h"
 #include <linux/wireless.h>
+#include <net/cfg80211.h>
 
 #define MGMT_QUEUE_NUM 5
 
@@ -671,39 +672,6 @@ enum rtw_ieee80211_back_actioncode {
 
 #define VENDOR_HT_CAPAB_OUI_TYPE 0x33 /* 00-90-4c:0x33 */
 
-/**
- * enum rtw_ieee80211_channel_flags - channel flags
- *
- * Channel flags set by the regulatory control code.
- *
- * @RTW_IEEE80211_CHAN_DISABLED: This channel is disabled.
- * @RTW_IEEE80211_CHAN_PASSIVE_SCAN: Only passive scanning is permitted
- *      on this channel.
- * @RTW_IEEE80211_CHAN_NO_IBSS: IBSS is not allowed on this channel.
- * @RTW_IEEE80211_CHAN_RADAR: Radar detection is required on this channel.
- * @RTW_IEEE80211_CHAN_NO_HT40PLUS: extension channel above this channel
- *      is not permitted.
- * @RTW_IEEE80211_CHAN_NO_HT40MINUS: extension channel below this channel
- *      is not permitted.
- */
-enum rtw_ieee80211_channel_flags {
-	RTW_IEEE80211_CHAN_DISABLED	 = 1<<0,
-	RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1<<1,
-	RTW_IEEE80211_CHAN_NO_IBSS	  = 1<<2,
-	RTW_IEEE80211_CHAN_RADAR	    = 1<<3,
-	RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1<<4,
-	RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1<<5,
-};
-
-#define RTW_IEEE80211_CHAN_NO_HT40 \
-	  (RTW_IEEE80211_CHAN_NO_HT40PLUS | RTW_IEEE80211_CHAN_NO_HT40MINUS)
-
-/* Represent channel details, subset of ieee80211_channel */
-struct rtw_ieee80211_channel {
-	u16 hw_value;
-	u32 flags;
-};
-
 #define CHAN_FMT \
 	"hw_value:%u, " \
 	"flags:0x%08x" \
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6b6d560d7143..ee15f93a5477 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -187,7 +187,7 @@ struct sitesurvey_parm {
 	u8 ssid_num;
 	u8 ch_num;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
+	struct ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
 };
 
 /*
@@ -731,7 +731,7 @@ struct TDLSoption_param
 #define H2C_RESERVED		0x07
 
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
-		      int ssid_num, struct rtw_ieee80211_channel *ch,
+		      int ssid_num, struct ieee80211_channel *ch,
 		      int ch_num);
 u8 rtw_createbss_cmd(struct adapter  *padapter);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index dcf91e7894a5..fed8e77e512b 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -200,7 +200,7 @@ struct	ss_res {
 	u8 ssid_num;
 	u8 ch_num;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
+	struct ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
 };
 
 /* define AP_MODE				0x0C */
-- 
2.36.0

