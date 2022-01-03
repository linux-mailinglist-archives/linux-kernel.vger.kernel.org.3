Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48E64837B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiACTqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiACTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:46:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85229C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:46:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u25so18446794edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUcYul9v18yAoVmolWArOf2DBnyclj+ggzFU2OVJJAg=;
        b=hiax1oMlj9H/vUQPvrRHXPP6hhJy05e6mvmCS3qaRR6Ev0ZyyFV2py98WgbYGNlu7Z
         0vK/kDkT52A91JVj7EY9Hl4jZDErbVqIeKDD9a1RR0ok2t9MseONteDRs2yhcKyRvf7s
         GZPhLuG2kRtFsO55T4dP1n26jcoyVjkiLKB9e73cYWlGcJg1VXHkmTU0zlYc7gD/EXn7
         mzJf5xw5KyK/CMDXwfQhUpJAxTfpZJv4JjO78Lwn4EILR3XLWh7mMI+h/jw0Ol4JKtIj
         /I46D4/mfv+1zAQtlWICcNmaohS2elK9Ca05k7UIiX67QjExlhrrSniiHWxJSSutbxSL
         LPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUcYul9v18yAoVmolWArOf2DBnyclj+ggzFU2OVJJAg=;
        b=iXQISvyCXZjzPhvJYv6K8bQI5vGjZL28CEQafCTs3BVPW+/u0R0eWpWdXnykE2rVkD
         0ZnZopfK4rxrTE2zSfwdGdGEICjSiRjKQKGe2Aq3h2OIpGRB+x8i0goB+oQKB5Z1p/uB
         L4BtOKuDou61AqpAVUNOiidYCC/xNzMOg2+uhWhPVU7G9b1mFppwbaka1YXGUP1Hkcom
         hirHQtl6dHuqbcYjLFtN2YS6zWHzzeeFFLRhq4hUXzTjgKLQWYQo7aBbTAXYKuZzffIs
         cGdouEVTi47QgpFVyQ/RRzjmJVz/gFKARymS+HxVe3yYR4pruNS3HPHladOcBq1O747F
         33QA==
X-Gm-Message-State: AOAM530NGcYdvrbb1Q6OrvP/Xzhcd4Q7JgvxZ0Ff1wkZ310rIUPR50iR
        8EMk+XjziAU4KC1ae3dSdBI=
X-Google-Smtp-Source: ABdhPJxW3M0Gf06UJFW9efJsc7PGZPR4M/g4hgGb0p/STrrkd/L+AYIpQietAOnyH7YrTSE2JIwp9Q==
X-Received: by 2002:a17:906:9756:: with SMTP id o22mr36763074ejy.324.1641239206131;
        Mon, 03 Jan 2022 11:46:46 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:46:45 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 44/56] staging: r8188eu: rename camelcase SetEOSP to set_eosp
Date:   Mon,  3 Jan 2022 20:02:19 +0100
Message-Id: <20220103190326.363960-45-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetEOSP into set_eosp

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c     | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 2 +-
 drivers/staging/r8188eu/include/wifi.h      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 29075d7516ec..13f6831fb53b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5530,7 +5530,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 
 	set_priority(qc, tid);
 
-	SetEOSP(qc, pattrib->eosp);
+	set_eosp(qc, pattrib->eosp);
 
 	SetAckpolicy(qc, pattrib->ack_policy);
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index a13ef82b41f1..1d22f6dc2cdc 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -770,7 +770,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			if (pattrib->priority)
 				set_priority(qc, pattrib->priority);
 
-			SetEOSP(qc, pattrib->eosp);
+			set_eosp(qc, pattrib->eosp);
 
 			SetAckpolicy(qc, pattrib->ack_policy);
 		}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index e4f5b877c559..60b80ce144df 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -373,7 +373,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 
 		pwlanqoshdr = (struct rtw_ieee80211_hdr_3addr_qos *)pframe;
 		set_priority(&pwlanqoshdr->qc, AC);
-		SetEOSP(&pwlanqoshdr->qc, bEosp);
+		set_eosp(&pwlanqoshdr->qc, bEosp);
 
 		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr_qos);
 	} else {
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 6c5ca5b409d2..45774d7a6429 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -238,7 +238,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_priority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
 
-#define SetEOSP(pbuf, eosp)	\
+#define set_eosp(pbuf, eosp)	\
 		*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4)
 
 #define SetAckpolicy(pbuf, ack)	\
-- 
2.25.1

