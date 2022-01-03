Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E124837B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiACTpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiACTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:45:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:45:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w16so139829858edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gXPAyB7bp53CagxNwAMOzhqdhAe1RGHeinSxyk9f7E=;
        b=XeG7MZAaIrx1W4pvPLO6geVQaoIIspZ0+XcFG24TMXqLa2VZ2pHbG1wzUkwhVk/EhW
         VafPkJKW66+QXdA/gib4p+TotO8UjMokE9e8UnO+54KpM0fEutz/xUp9Ae74/6QjQPbI
         QQmGlnF6W5zd3GQrmefh+ZqNhsFiDT84qbcOgsD7RlVbAMZ1Op/KGlU4sAcObCczXGsk
         e/7RqR53H2aPwFhdAVxbsvwSHbB4LvCi5Z0hI/7lOltxpOBPNTWoemt0/U5p5IktTofu
         6w2VH2tLfBRFvrRa1orX9PB1gFDLyQkvNYe6ES5sK1AZFGw/Zz05ZDinHbl3Iz/Zcs4R
         mgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gXPAyB7bp53CagxNwAMOzhqdhAe1RGHeinSxyk9f7E=;
        b=hcCrNSOBT/UV5/g6G5DZkf0MXY3hWgIpVFXfMIgQ5D2hKKIG8rB7EANbSfv0TgaPlh
         crJnFZiTXgwWMtpKV90AuZc4Jcq/WQYVzXEGLhg/VR52tHI+QYjfQfb7tJgwss4wF81g
         SZ6hi7Ra3dB4+8U3ciwUiMD5WXX9YAFTKHQV766T3GRxtBroKuap68KsDkJjzQbU8RM7
         lgy13F1aOTS6Bq4Ez5xjhXLN6H8gpS+HWu1z6YMeVFjHdn7V0KtSLtCo8SC4NCUXc6Yw
         2sFehEHR8Sq6e2pvKvF6Pc8BB32h2zL8pzC6dZDFg3AGhRIbVmXBznJBObUeutuRFzgG
         hT0Q==
X-Gm-Message-State: AOAM532xGKrwLavE9Uv78LPvknQeI0tQbWuyuOFcVZbdt62UNvRYC+n7
        g80aRRuvu8or2GjJAF/41WE=
X-Google-Smtp-Source: ABdhPJy/1cuHbNh/I8Qg7S8YKuwG6Hk5cqGL8T7Ugso/FpIYiuPIe17wSwvZmjpxBjO/nYN8VwojQw==
X-Received: by 2002:a17:907:6093:: with SMTP id ht19mr38052895ejc.286.1641239149985;
        Mon, 03 Jan 2022 11:45:49 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:45:49 -0800 (PST)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 43/56] staging: r8188eu: rename camelcase GetPriority to get_priority
Date:   Mon,  3 Jan 2022 20:02:18 +0100
Message-Id: <20220103190326.363960-44-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetPriority into get_priority.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 8bda34f87849..d187bb73f539 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1035,7 +1035,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	pattrib->ack_policy = 0;
 	/* parsing QC field */
 	if (pattrib->qos == 1) {
-		pattrib->priority = GetPriority((ptr + 24));
+		pattrib->priority = get_priority((ptr + 24));
 		pattrib->ack_policy = GetAckpolicy((ptr + 24));
 		pattrib->amsdu = GetAMsdu((ptr + 24));
 		pattrib->hdrlen = pattrib->to_fr_ds == 3 ? 32 : 26;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index f6323767d659..6c5ca5b409d2 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -236,7 +236,7 @@ enum WIFI_REG_DOMAIN {
 #define set_priority(pbuf, tid)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf))
 
-#define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
+#define get_priority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
 
 #define SetEOSP(pbuf, eosp)	\
 		*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4)
-- 
2.25.1

