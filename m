Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE5483781
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiACTV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiACTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:21:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:21:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j6so139408774edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1Blw+/+IapJAwwma/5viAfpA+NmnRSXvCOl9KgWYPg=;
        b=m/Uba719A6RRJcMgOgPsw6dQ5TNUf3nrb0kDD/Tnkcj3Pc5u/eRfBth5uG0DxjaZTq
         YfrGo6Siq13O8zwhGfqopOP57iOe956uPv3C0oPVQIXveHIVRuqvWA33B5h8VK5luBR7
         7U825J24ASULsH/dSpnEHr7pslDHL6GQaoGCpvsKftNL2OxMttTOibUmO5xfmnbloP0B
         TAeWqwcuTELUvTVAY1r8DDd8d/mG0j+WLnK9m7QOgCCAh+nPt9TSMEMKPhXoUpNdK92L
         2UMMrMGde816DlSggo2SVHxXHV94P4SP/X/6i/QyyXlJ70A8QsbMSJDg5hTx3hACloBe
         0Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1Blw+/+IapJAwwma/5viAfpA+NmnRSXvCOl9KgWYPg=;
        b=2d0DDN7GJW5pw2xAlGSr5cA5wB2m55TlqhgVmqU3KaZVCqonIvmlmgFxyfyN2KAvSc
         HSTwdkvXIxgN0OCJugUWtv4YFEkStcRj/iA5GHg2qvV2PinCO6CLald6ed6HhomUoHX7
         V3qXlmrYxqgdqueOhmwH1xK5V32PwkiMGQxiRtau2gTpka+h79hvQ+Y4cHgvWegNCIlP
         M2uGgLgfw9J0O/J+HWdbKTNFanP9rO2NTKIsxBcmG1HHqVowMpXFJ2k9aF0jqgpWVorn
         /WGUQ+yhCH43/v+/5Xv0XfwN81ugK7mwjPRnH2wfeMt/Wn+xXBKIdmEmSOKg4Y2pRVeH
         q7JA==
X-Gm-Message-State: AOAM531axxduzPUi2rVd2Y/DRmBahfxqkjIzEHy1g7kFvwVP/uN5CFKi
        RFouUl+gSou5SqQGC7N3aU0=
X-Google-Smtp-Source: ABdhPJz0DXJv0uHyJZPwcD3PLKMkhZpEVEMX11DoVOF2zNS3OxRUSn34Y3Wfy84MzT0oorII2z0UXg==
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr39570554ejc.15.1641237684928;
        Mon, 03 Jan 2022 11:21:24 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:21:24 -0800 (PST)
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
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/56] staging: r8188eu: rename camelcase SetPwrMgt to set_pwr_mgt
Date:   Mon,  3 Jan 2022 20:01:52 +0100
Message-Id: <20220103190326.363960-18-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetPwrMgt into set_pwr_mgt.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 4 ++--
 drivers/staging/r8188eu/include/wifi.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 885a6412738b..63e16f9deff4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5412,7 +5412,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 		set_to_ds(fctrl);
 
 	if (power_mode)
-		SetPwrMgt(fctrl);
+		set_pwr_mgt(fctrl);
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index b7385ec7ce93..8fb4789d9e65 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -305,7 +305,7 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	/*  Frame control. */
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
-	SetPwrMgt(fctrl);
+	set_pwr_mgt(fctrl);
 	SetFrameSubType(pframe, WIFI_PSPOLL);
 
 	/*  AID. */
@@ -341,7 +341,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 	if (bForcePowerSave)
-		SetPwrMgt(fctrl);
+		set_pwr_mgt(fctrl);
 
 	switch (cur_network->network.InfrastructureMode) {
 	case Ndis802_11Infrastructure:
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index ab8ed3ce89f4..3f16e9b9c342 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -185,7 +185,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_retry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
-#define SetPwrMgt(pbuf)	\
+#define set_pwr_mgt(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
 
 #define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
-- 
2.25.1

