Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B450D8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiDYFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiDYFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:31:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75566AE79
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:28:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so24613680plh.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qacab+tgoYimzhMxQiLLM2/31arXbTsbP05ybhAApac=;
        b=fxO+Xn2GHjWXtpVM2P7VIds4X/stcrjVBSbYlP0dOs5sBFAMDUd2lyNHXVq4aYCVV5
         qYdGPeXsY87U9jDDdbD98KAVMx6Yw7qbncFxGmt1PPP2EpAiGOEaFu1v0UWZUGcegcAU
         ycXCsC9dc7hN2b/Bi1iY1QMs6f2yyxa9SM97O07cj2T2STyALB0hbiLue+eEXir+N12k
         IoOoi92lpdLRX1v197l9S/pNazwiq2NEt3HuhEQihmeNhMd/sB3IaGR0LchT5tpkfBak
         SCN1ArmOttKUf1hgtgGZU4CXrMXKfivv8hDIZn5AoJyQL9ag7F5fgJqxAQ4r7LEiGb9H
         +9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qacab+tgoYimzhMxQiLLM2/31arXbTsbP05ybhAApac=;
        b=sGq4RoDUF7s8cPvt0R0xrbAez5E5DTtmnPnsdVm6MM2ykk2c+SKj6pzVjR7aoXOH5v
         e0+pLM1mJestmzE/dvq47BQPte0zU7HftnkkeIlpVFLxyZe83i89YL8l6GXAiAFuDMxi
         c9zxjLdRU2jK/PpbmVhbR6lfpdtIRjwNC77+6iEVSDip4bRg9E+13lz92xDQ/CR89myr
         LReAUG6VcPE9m1f9WqyTXpQxkwtzNKpBRMbhx3F51lTi0e7IGmj9E8rdVMx10kHup7ll
         MjCVj/4EGSl6K69UJx+JXjnGcJwd1xyqbF9UrfcvYXlRD3Bk1KfxwIVdMBYcSHLQ8K5i
         7cog==
X-Gm-Message-State: AOAM533LY4i4MvW4wvy1YPqROiRnOf1qblosHl8Cx4kb7G0iJA50WJgC
        pca4ft2mHAs8lO5WDmBgkZe8Wx7KYT7FnQ==
X-Google-Smtp-Source: ABdhPJyGbtlQkHeE1FR4ToXw4Tcgnj4XLNMNKBvALtEZtOCELT7ayJqBBhZ3scRTJwor7kY9PZq82Q==
X-Received: by 2002:a17:90a:94c2:b0:1d9:3fbd:bbe1 with SMTP id j2-20020a17090a94c200b001d93fbdbbe1mr9659700pjw.59.1650864510847;
        Sun, 24 Apr 2022 22:28:30 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id t1-20020a628101000000b0050d47199857sm547513pfd.73.2022.04.24.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:28:30 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com
Subject: [PATCH v3] Revert "staging: r8188eu: use in-kernel ieee channel"
Date:   Mon, 25 Apr 2022 13:28:03 +0800
Message-Id: <20220425052802.2419-1-wjsota@gmail.com>
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

This reverts commit 0afaa121813ed602bd203759c339cb639493f8c2 as changing
rtw_ieee80211_channel to ieee80211_channel causes a memcpy bug as reported
in
https://lore.kernel.org/linux-staging/67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com/
due to their size differences.

Reported-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
V2 -> V3: Add Reported-By tag
V1 -> V2: Fix spelling error in commit message.
---
 drivers/staging/r8188eu/core/rtw_cmd.c        |  6 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 18 +++++-----
 drivers/staging/r8188eu/include/ieee80211.h   | 34 ++++++++++++++++++-
 drivers/staging/r8188eu/include/rtw_cmd.h     |  4 +--
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 5 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ebe2479d1402..f036a980ec1a 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -320,7 +320,7 @@ int rtw_cmd_thread(void *context)
  *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
  */
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
-	struct ieee80211_channel *ch, int ch_num)
+	struct rtw_ieee80211_channel *ch, int ch_num)
 {
 	u8 res = _FAIL;
 	struct cmd_obj		*ph2c;
@@ -366,8 +366,8 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	if (ch) {
 		int i;
 		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
-			if (ch[i].hw_value && !(ch[i].flags & IEEE80211_CHAN_DISABLED)) {
-				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct ieee80211_channel));
+			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
+				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
 				psurveyPara->ch_num++;
 			}
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 7739a0bde1e0..839b0b85993e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5749,11 +5749,11 @@ void site_survey(struct adapter *padapter)
 		else
 			ScanType = SCAN_ACTIVE;
 	} else {
-		struct ieee80211_channel *ch;
+		struct rtw_ieee80211_channel *ch;
 		if (pmlmeext->sitesurvey_res.channel_idx < pmlmeext->sitesurvey_res.ch_num) {
 			ch = &pmlmeext->sitesurvey_res.ch[pmlmeext->sitesurvey_res.channel_idx];
 			survey_channel = ch->hw_value;
-			ScanType = (ch->flags & IEEE80211_CHAN_NO_IR) ? SCAN_PASSIVE : SCAN_ACTIVE;
+			ScanType = (ch->flags & RTW_IEEE80211_CHAN_PASSIVE_SCAN) ? SCAN_PASSIVE : SCAN_ACTIVE;
 		}
 	}
 
@@ -7280,26 +7280,26 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	return	H2C_SUCCESS;
 }
 
-static int rtw_scan_ch_decision(struct adapter *padapter, struct ieee80211_channel *out,
-	u32 out_num, struct ieee80211_channel *in, u32 in_num)
+static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_channel *out,
+	u32 out_num, struct rtw_ieee80211_channel *in, u32 in_num)
 {
 	int i, j;
 	int set_idx;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 
 	/* clear out first */
-	memset(out, 0, sizeof(struct ieee80211_channel) * out_num);
+	memset(out, 0, sizeof(struct rtw_ieee80211_channel) * out_num);
 
 	/* acquire channels from in */
 	j = 0;
 	for (i = 0; i < in_num; i++) {
 		set_idx = rtw_ch_set_search_ch(pmlmeext->channel_set, in[i].hw_value);
-		if (in[i].hw_value && !(in[i].flags & IEEE80211_CHAN_DISABLED) &&
+		if (in[i].hw_value && !(in[i].flags & RTW_IEEE80211_CHAN_DISABLED) &&
 		    set_idx >= 0) {
-			memcpy(&out[j], &in[i], sizeof(struct ieee80211_channel));
+			memcpy(&out[j], &in[i], sizeof(struct rtw_ieee80211_channel));
 
 			if (pmlmeext->channel_set[set_idx].ScanType == SCAN_PASSIVE)
-				out[j].flags &= IEEE80211_CHAN_NO_IR;
+				out[j].flags &= RTW_IEEE80211_CHAN_PASSIVE_SCAN;
 
 			j++;
 		}
@@ -7313,7 +7313,7 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct ieee80211_chann
 			out[i].hw_value = pmlmeext->channel_set[i].ChannelNum;
 
 			if (pmlmeext->channel_set[i].ScanType == SCAN_PASSIVE)
-				out[i].flags &= IEEE80211_CHAN_NO_IR;
+				out[i].flags &= RTW_IEEE80211_CHAN_PASSIVE_SCAN;
 
 			j++;
 		}
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 788c9873d7b6..fe2dc2a0a802 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -8,7 +8,6 @@
 #include "drv_types.h"
 #include "wifi.h"
 #include <linux/wireless.h>
-#include <net/cfg80211.h>
 
 #define MGMT_QUEUE_NUM 5
 
@@ -666,6 +665,39 @@ enum rtw_ieee80211_back_actioncode {
 
 #define VENDOR_HT_CAPAB_OUI_TYPE 0x33 /* 00-90-4c:0x33 */
 
+/**
+ * enum rtw_ieee80211_channel_flags - channel flags
+ *
+ * Channel flags set by the regulatory control code.
+ *
+ * @RTW_IEEE80211_CHAN_DISABLED: This channel is disabled.
+ * @RTW_IEEE80211_CHAN_PASSIVE_SCAN: Only passive scanning is permitted
+ *      on this channel.
+ * @RTW_IEEE80211_CHAN_NO_IBSS: IBSS is not allowed on this channel.
+ * @RTW_IEEE80211_CHAN_RADAR: Radar detection is required on this channel.
+ * @RTW_IEEE80211_CHAN_NO_HT40PLUS: extension channel above this channel
+ *      is not permitted.
+ * @RTW_IEEE80211_CHAN_NO_HT40MINUS: extension channel below this channel
+ *      is not permitted.
+ */
+enum rtw_ieee80211_channel_flags {
+	RTW_IEEE80211_CHAN_DISABLED	 = 1<<0,
+	RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1<<1,
+	RTW_IEEE80211_CHAN_NO_IBSS	  = 1<<2,
+	RTW_IEEE80211_CHAN_RADAR	    = 1<<3,
+	RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1<<4,
+	RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1<<5,
+};
+
+#define RTW_IEEE80211_CHAN_NO_HT40 \
+	  (RTW_IEEE80211_CHAN_NO_HT40PLUS | RTW_IEEE80211_CHAN_NO_HT40MINUS)
+
+/* Represent channel details, subset of ieee80211_channel */
+struct rtw_ieee80211_channel {
+	u16 hw_value;
+	u32 flags;
+};
+
 #define CHAN_FMT \
 	"hw_value:%u, " \
 	"flags:0x%08x" \
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index ee15f93a5477..6b6d560d7143 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -187,7 +187,7 @@ struct sitesurvey_parm {
 	u8 ssid_num;
 	u8 ch_num;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	struct ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
+	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
 };
 
 /*
@@ -731,7 +731,7 @@ struct TDLSoption_param
 #define H2C_RESERVED		0x07
 
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
-		      int ssid_num, struct ieee80211_channel *ch,
+		      int ssid_num, struct rtw_ieee80211_channel *ch,
 		      int ch_num);
 u8 rtw_createbss_cmd(struct adapter  *padapter);
 u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index fed8e77e512b..dcf91e7894a5 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -200,7 +200,7 @@ struct	ss_res {
 	u8 ssid_num;
 	u8 ch_num;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-	struct ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
+	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
 };
 
 /* define AP_MODE				0x0C */
-- 
2.36.0

