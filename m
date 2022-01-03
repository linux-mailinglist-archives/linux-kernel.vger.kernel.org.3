Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403E84837BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiACTwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiACTwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:52:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07709C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:52:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u25so18494512edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ByAqSVB2B3ep+zd7HSU1TmysX0Jx7A5in4U6nSnvgc=;
        b=dMy2H4U9+w1PP3Ry9CRyrNp4dio4xBSHGn2UY/conmG+lHPoAq9hnpLwdOB81r7p8B
         5pYwJe4pOOIEnu+pUrHNKC8vC5uaGcHM9/kF3f+sb1cMEpf09oqXQvz70BnO1sdSvOOh
         stCZi5T6qxV0T0XrYzCyT/uSExAIrtubkUBKrkE8InsxbPWa8D0BZwcV7LZnlQ2jbS5W
         rNNXXh8GB3+eVUdxuAVOAQ9I/3KGy5J/J3k2CDB/to5ELqM8+2z+lQfRzobsAw9cSQF8
         sdFrfotPY1YvjH7WEGD2oi3gq3gvHaaekb6SQJrdZvzodWuJhJWIO7Iw4BqCUgdpGuo5
         Ecvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ByAqSVB2B3ep+zd7HSU1TmysX0Jx7A5in4U6nSnvgc=;
        b=TClS7m9wVk71Vi7a6ZQ+Jzv7Rp1n405JNKkahBm2OaSwCCGyheMHzypD72dF2MM0XE
         CA+F9oxfSYYA68DyEu7y3La+Lg4d1N4OCYQ5VRrdS/qRsIvYIkcFXVFmfBUvpnE68lpH
         1QyAcBTBpMSJU7PMloE0zsX4qnCDahrIeaXvhxceRpnQbtbuODZZYQXMSsKh3/uzWAOt
         hNskdPyysW7eOoEuuQ8xxLzOYFuXKYcuaRNXRWooJm/yWY/nsVWE3QlrLtOgEMmwk5PR
         I9kDOCb7niOj6N5P6n4Ds0Qroa9lZK1aAYp76zYKqqOqzvnNRQYhCoAcjlU1zpmGyMWP
         Og7Q==
X-Gm-Message-State: AOAM533MLr8o5yVssmp1objiK43KWAAwcRJT7FPTRILRn70KWha3qq0v
        rf2wwwDA/nPh3CxUB9SOlig=
X-Google-Smtp-Source: ABdhPJw5AW4b0KIQnsnsLl8cvI51gNhi/VHTXTUk15QVc9jBjrHQZ9XNcAJnxlthXk7w3fg9w16sPw==
X-Received: by 2002:a17:907:1703:: with SMTP id le3mr35788097ejc.344.1641239542622;
        Mon, 03 Jan 2022 11:52:22 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:52:22 -0800 (PST)
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
Subject: [PATCH 50/56] staging: r8188eu: rename camelcase GetAMsdu to get_a_msdu
Date:   Mon,  3 Jan 2022 20:02:25 +0100
Message-Id: <20220103190326.363960-51-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetAMsdu into get_a_msdu

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 4aa295ad4a27..81dcb482ff22 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1037,7 +1037,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	if (pattrib->qos == 1) {
 		pattrib->priority = get_priority((ptr + 24));
 		pattrib->ack_policy = get_ack_policy((ptr + 24));
-		pattrib->amsdu = GetAMsdu((ptr + 24));
+		pattrib->amsdu = get_a_msdu((ptr + 24));
 		pattrib->hdrlen = pattrib->to_fr_ds == 3 ? 32 : 26;
 
 		if (pattrib->priority != 0 && pattrib->priority != 3)
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 2de7addd1fbf..7a42031ebc15 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -246,7 +246,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_ack_policy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
 
-#define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
+#define get_a_msdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
 #define SetAMsdu(pbuf, amsdu)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16((amsdu & 1) << 7)
-- 
2.25.1

