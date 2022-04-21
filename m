Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9950AC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442886AbiDUX41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382034AbiDUX4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:56:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86912C647
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:53:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s14so7142759plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FvZqIly0MqhR6NzevS5ekyPjOQj5Xg3pXSl2WXGAog=;
        b=Ogg18t2rICAhRyRa+1/Ctr+uZB0ahi8Ixw+q8a+lWa56Jmo8mkR9D42AYlBMIVCuoC
         kHT2PiySv87HxkRxuKAy03xfE5y5bakuV0MKkVtqerf78IqnIr+7+ZLiR/YHwe3SKIhE
         B1Jhu+MlTA+oSZ7sBN56agL0d5dkNoyBop+ss8x5lWaqOBqPpkbW4f6qzzZT6Xs82cu2
         IfnpryhLlHIpS/fX607dwqAF6231mjdgZNBzBZzsF/SPvGENwbt3GP/CpIF6xxZek01p
         zKDsFkTweVo3RVxHqL/wU03987efQgDWQ0fY5LWpWYQalEeMHU3UqYrRbP+Ezd82jhwC
         P0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FvZqIly0MqhR6NzevS5ekyPjOQj5Xg3pXSl2WXGAog=;
        b=PWPtGDWOVGpJe/nfBui/i2iRTW5l7zh3/lR7IZs6WWM7iDIvkMHUw4u/Ip+jY2chYS
         ARaw9UcwJm4RPt2FxhwSEBnoEG+UPzlnGkKGlJkTVhQqhrdwAQHs+hRxOAl14dc7DSy6
         E12CdPPFt1nMlczbtyw2V0zqmzp7AUIsBsXGdhUnmm/tDKYclr+ZuLkh78fe2h4Qo+Yi
         /BZlhc1ybn1p0tb5r7f/MN7dllHB17x9rZ44BHMl6lCIRLa5mUPwUcKrKnTYeq9Zfntm
         EGgqq+QwSjnlgTk51mxcRTbso/sU9TBZexoOzJY4c6OMEmVhrdJm/huBGOw1cbSb5Qdr
         LVPg==
X-Gm-Message-State: AOAM531MZ6bLDTlrRZvJ++kkJgZl1aR0nWVkI9QwYZeUO6B8iwDtXCnT
        c/9Hze8cFyERGsEXt86IkrE=
X-Google-Smtp-Source: ABdhPJyC2FzBaOCosZX0rucADzwGysiHj3insxyptmDX1ZvMS6w2yTuqTvFqfGGbiHvKqXUzNBgpZA==
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id g3-20020a170902d5c300b00154c472de80mr1832018plh.87.1650585211355;
        Thu, 21 Apr 2022 16:53:31 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id w137-20020a62828f000000b0050adb63c6d5sm222972pfd.220.2022.04.21.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:53:30 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        dan.carpenter@oracle.com
Subject: [PATCH v2] staging: r8188eu: use in-kernel ieee channel
Date:   Fri, 22 Apr 2022 07:52:38 +0800
Message-Id: <20220421235237.4218-1-wjsota@gmail.com>
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

Use the in-kernel structure and flags instead of defining a separate
one. The rtw_ieee80211_channel structure and flags can be replaced by
the ieee80211_channel defined in include/net/cfg80211.h since the flags
serve the same purpose and the ieee80211_channel struct includes the
elements used in the rtw_ieee80211_channel struct.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
V1 -> V2: Rephrased the commit message to not mislead.
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

