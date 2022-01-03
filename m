Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3C4837C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiACTyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiACTyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:54:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF85C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:54:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j6so139692478edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J729v2YTPLSMP7LVTWvLHEzUt9xmZs65s4uXAGemIX4=;
        b=HglwB6ouSl894iyJ6P+NA61EGF0kA17qpR8jFk4Brsg6fRq1SCN0FWKWtcgXv6NMU4
         VNjEDuQa9qP5vxbDDyeYpbfk8tSN8R1n9Y00hXJ2EvgX/eizoYbmsUfO+cLB+JRizMNO
         HM7OVjWKcG9HuyKhSB1pP8H84vPI0v9A1wPoI3Pb9800kRsX1WSZMUWd1hfFQPJ/VoyP
         sGKG+v+eDj9inLyD6L1Guo5JwNbJtNbti88yaqo7Uq06V6yEAfLET+vScx7pxj+7vULS
         LDJGc8e2vyS5695aO5uSAQ8dEpPcpqS8qnrvhKY6LzggtrK80lOjxtELIMTXYXciMqoB
         e/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J729v2YTPLSMP7LVTWvLHEzUt9xmZs65s4uXAGemIX4=;
        b=HybqVpcy5TruEzzQWiKQLi9IhHKwg9a4yn1NKv9wRxy1MLbQR8L12zupePZmBtfnNZ
         wgd/ldZolbUtBWOMgrjCK0fPq7y++G+x1HcxymSqh8IWcgR6G5Axk6W5bLl4E5oZmmyQ
         FlUmB/5XHXPEveRjkbiV2AYtWfTXD0x54cH8jh1a2YedCQlp/8pRmd452D4v29xkLExp
         iG9IkU0GdgZtLcqUS3Zqqfwo9hVun7dfyssj6W0MfN1ZsamzBjnXyKuqv1H841KuQxR1
         Tkg1yubNmF28E4iAHsDuOQhIGP0kWUnHbXz1Fh3zYxeHE2t37kQh8XRtjlztgawYX2Nd
         dPFQ==
X-Gm-Message-State: AOAM533A+VDyswkdibHUk+IuA/vcRKv7mHBj7OgjqnhfF5X6McVt5E6A
        jppoPW0MLIPRwSRjJprFI6U=
X-Google-Smtp-Source: ABdhPJw/2B1BSahBvseSt+FMdhyn53n9c0J3gBrXahp2xMWgky2PkzOpzvt1uElI1RzdXazFOAtTHQ==
X-Received: by 2002:a50:fb03:: with SMTP id d3mr44638458edq.123.1641239654528;
        Mon, 03 Jan 2022 11:54:14 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:54:14 -0800 (PST)
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
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 52/56] staging: r8188eu: rename camelcase GetAid to get_aid
Date:   Mon,  3 Jan 2022 20:02:27 +0100
Message-Id: <20220103190326.363960-53-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetAid into get_aid

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 81dcb482ff22..32e0bcce65a0 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -832,7 +832,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		u8 wmmps_ac = 0;
 		struct sta_info *psta = NULL;
 
-		aid = GetAid(pframe);
+		aid = get_aid(pframe);
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
 		if (!psta || psta->aid != aid)
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 63f1b0a974f4..061d1aa18eed 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -248,7 +248,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_a_msdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
-#define GetAid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 2)) & 0x3fff)
+#define get_aid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 2)) & 0x3fff)
 
 #define GetAddr1Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
 
-- 
2.25.1

