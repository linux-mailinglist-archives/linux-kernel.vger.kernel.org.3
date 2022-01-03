Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACAB48375E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiACTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiACTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:06:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ADAC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:06:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so139343852edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1i///cnKfTZkbq/DWiJzY5k7VFjzMonQidtSe6VC6Q=;
        b=YSdEuaxQAZZpHrNeVdFuwOF2hsPOpINoK5GkjuOeTKDhl9wO7L8NM5N12qpAc2Sqm0
         vYqvJolZ8lPesKTazfN53sdWTTby+AbqgAeNTi1XhyuuTwmVdHi5Iaqofem4OY8awSh/
         NPiG9WrkdOMW0bQd8m00CZm7eYfnARDtKI7pGxv4SSAJYkpEaRiw219mHiSobB5T9sf1
         1te9TMHpfDUKEuWrrw2yAx4igGfemCqaNZDX7UXZo9oq0rccQr+Bo03SNEzbmJ47hF2c
         2xYay1CoY6RrW2I6618ieEzzMS3GCfaNsqO8xm6Z+o/Mt1r731hDBYzCtZ5Toji0/A31
         10hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1i///cnKfTZkbq/DWiJzY5k7VFjzMonQidtSe6VC6Q=;
        b=SY38h52OVviD09ibKXRPOssB+9eH2w6O1cRcl5/EQ1Z6RYbnhpx1aQZgexFa9kT9eD
         0uQd5SfPC4C9nkkdIldWF5g08xLb9f7ja1k+2l7UQFg1Y68uUIOLMTEM0QrerMwoi3oj
         Qum4yLqJetfaeL+v0pVx31wfO7+TFR/kaJbxAPbDgvipiPB8/ZCmJaFLSnnwiSxrNmuV
         UblKcK8Pg4Bb7jjFmw80TCndVkBcLVedDivND5qC4HBJWHV4hEAw/66wXDqR7/g0XX0F
         6GRSyVByzvPNhyy7MtxvgtiMbL9Ouav6JMR99oXj49mDXkjG/rIhrd0H1eZv+KLYZdDI
         DWAg==
X-Gm-Message-State: AOAM530awUVVBfoTsFPOQqYIc4cUSwp260GDUP/xVp/dVJe3O/9O1oJh
        QcDUbItu6bY85SKwoCvuuNA=
X-Google-Smtp-Source: ABdhPJwd5azRAS9V60QFKJFbmgzEdJyfPv0l31p1pSZTK/6jM+b9sRVGTKg+g/3zDRojsLze27FexQ==
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr32976825ejc.552.1641236795124;
        Mon, 03 Jan 2022 11:06:35 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:06:34 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/56] staging: r8188eu: rename camelcase SetToDs to set_to_ds
Date:   Mon,  3 Jan 2022 20:01:37 +0100
Message-Id: <20220103190326.363960-3-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetToDs into set_to_ds.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 drivers/staging/r8188eu/core/rtw_xmit.c     | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 2 +-
 drivers/staging/r8188eu/include/wifi.h      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 0aa958f20cd6..6c784134d957 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5409,7 +5409,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		SetFrDs(fctrl);
 	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
-		SetToDs(fctrl);
+		set_to_ds(fctrl);
 
 	if (power_mode)
 		SetPwrMgt(fctrl);
@@ -5524,7 +5524,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
 		SetFrDs(fctrl);
 	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
-		SetToDs(fctrl);
+		set_to_ds(fctrl);
 
 	qc = (unsigned short *)(pframe + pattrib->hdrlen - 2);
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 8503059edc46..b528729cad76 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -729,7 +729,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 			/* to_ds = 1, fr_ds = 0; */
 			/* Data transfer to AP */
-			SetToDs(fctrl);
+			set_to_ds(fctrl);
 			memcpy(pwlanhdr->addr1, get_bssid(pmlmepriv), ETH_ALEN);
 			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, pattrib->dst, ETH_ALEN);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index ca24e17c369d..e452b257ccae 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -345,7 +345,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 
 	switch (cur_network->network.InfrastructureMode) {
 	case Ndis802_11Infrastructure:
-		SetToDs(fctrl);
+		set_to_ds(fctrl);
 		memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 		memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
 		memcpy(pwlanhdr->addr3, StaAddr, ETH_ALEN);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index f16e9f44babe..c556cf378c8a 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -163,7 +163,7 @@ enum WIFI_REG_DOMAIN {
 #define _PRIVACY_	BIT(14)
 #define _ORDER_		BIT(15)
 
-#define SetToDs(pbuf)	\
+#define set_to_ds(pbuf)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_))
 
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
-- 
2.25.1

