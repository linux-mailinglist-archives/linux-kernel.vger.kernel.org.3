Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D64837B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiACTth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiACTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:49:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1867EC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:49:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u25so18470234edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VlUnAdpZCxh+p4k3M8H06cBUwhFklxuHnBgx5rYHCfA=;
        b=nxG5yv12GZBGOv4v3ACa2CrerQjzvSm/Nh8O43gRWEp53WI8tSHY4IhEexJhnJfqs0
         V7gq/4vfix0M6gv9HB+Zawq7ydxr7jVJRhYDBICJTiVroUTF7WD6iPdWYyp9fKj4juR8
         V6dFvuWhOC75CSsRUuCZCv70+2qJ4IrKgPeWnwUGHLE34SnotvSPqTBPqj6LMPYNKqLf
         OxNINmHoZLnxHOCvV4DPY7xNLlX6vCYaumDj3ohiW3mquBAsA0RVd5Fz5TbuPLf19Bic
         hoDGMxzvYpNZ4oip3nBj3w5hDMnw9GOsQHtVr8EgXUxMewv/AWHf9MrszbP8rQzr98XD
         GP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VlUnAdpZCxh+p4k3M8H06cBUwhFklxuHnBgx5rYHCfA=;
        b=lZQOthYWshJ/KrLZ9DCWEv2oE7j70LdLUZAhL/qp9S93PuQxVY1FZmNB0xCCq038Ge
         mT0GTr7jeVNzgF0ddY4pdfKEzaYNbS9vTG9SYdRtdd8WOrm1WgOqH0OFCwrNG9sHIIOk
         rgXou5dsYrhKyTIKes9WJ0avu9Bui85/v7gIGhzL+59oO/+7J7B7wV1XR2YGPvHavH3q
         rztEhHavuTozZxOOxEP9fBHkQVm6LzEIAAJxaMQheVl/V6TtUh8XVm8EKiSlwYTsOnBg
         sXVv5PrXNVyJSjJZ82r6BcoIktYf3LZUaVxHoKeg//nURrY7ppNQALZUMjQxWVLPy2dy
         JqSQ==
X-Gm-Message-State: AOAM530svfgkSJSVqzsBf5ZauyfP3sc6Edt5fbIAoiZ8VSjT7YuoetVQ
        n5U1SvoYM4sYEW8Y0nWchAQ=
X-Google-Smtp-Source: ABdhPJxPXnGoyrGmVduRpZU2vZynEnj12nigymPYNTyICBWyUmrxMOksSE86HAPYL9g8T6p9fIt0gA==
X-Received: by 2002:a17:907:6d9c:: with SMTP id sb28mr36521799ejc.393.1641239374708;
        Mon, 03 Jan 2022 11:49:34 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:49:34 -0800 (PST)
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
Subject: [PATCH 47/56] staging: r8188eu: rename camelcase SetAckpolicy to set_ack_policy
Date:   Mon,  3 Jan 2022 20:02:22 +0100
Message-Id: <20220103190326.363960-48-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetAckpolicy into set_ack_policy

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c     | 2 +-
 drivers/staging/r8188eu/include/wifi.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 13f6831fb53b..6ec53f1039cc 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5532,7 +5532,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 
 	set_eosp(qc, pattrib->eosp);
 
-	SetAckpolicy(qc, pattrib->ack_policy);
+	set_ack_policy(qc, pattrib->ack_policy);
 
 	memcpy(pwlanhdr->addr1, da, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 1d22f6dc2cdc..eed9a2efa21b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -772,7 +772,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 			set_eosp(qc, pattrib->eosp);
 
-			SetAckpolicy(qc, pattrib->ack_policy);
+			set_ack_policy(qc, pattrib->ack_policy);
 		}
 
 		/* TODO: fill HT Control Field */
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 16acf7df0144..75b54ab0fe9c 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -241,7 +241,7 @@ enum WIFI_REG_DOMAIN {
 #define set_eosp(pbuf, eosp)	\
 		(*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4))
 
-#define SetAckpolicy(pbuf, ack)	\
+#define set_ack_policy(pbuf, ack)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5)
 
 #define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
-- 
2.25.1

