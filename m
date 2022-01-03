Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA6483787
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiACTZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiACTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:25:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0986C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:25:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so139504970edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLWybMvTvQjm0rsshKSfFK61DNO55meHI6XQkolunpE=;
        b=Bm54eHOwffGHan56tt/RMkzNx3SwpWHZYE2GmgNbelXC/oR+hPOD+pfH+wWFhLMpFd
         VhumWEoxLIXBb/yyQWFFgjivvDtHGskz9MsTj3zf0qnT56s3figP/c8QuTB+TP1DcBYv
         gT5iHRr9cJuZ3QHrTAm0LK4JrmMO/cKPDBDqhKE4dWgU6S8/doOAQ2pI8NTAA4YvD32T
         OO9UWVi18t+LeymU1oLf0SSMDpOQCI5fLXngNrnEtiDB14A5fzPiFXV/+dF8IC4Yg/Oi
         xVCtTNx29Imb40P6QeFW32ZvSHGG/0HxbJQqXHZdZkJ6iMcROgAXt0+WSO6VxD/4DMmp
         M7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLWybMvTvQjm0rsshKSfFK61DNO55meHI6XQkolunpE=;
        b=GeTYHbqK8OKU7L9w38DYbAYbIQhl8BMqOR8X4n6ec50QalNPuZvXXn5NVdJk+eO20D
         TxV37fEH6Wz/4HfbZ7dH4TL2m4NWgLzRDOE7WNrAk8pVji9y3cY9Y7IRKUc87BNzbBAG
         8ihhk2e1ZIEjMXxpUk523z90XcXQhkeUNbHZK8nloma0oQEJQEwyNq8roWHFpA0DYy8B
         1mQPzRMg60LlTRGRKw6JuYiQUfPs7N9l2j/oyGpKZsI3x3koiB3IbVdoDc952LAP/Z04
         IVcznqS77eYSpx14bHLTRVRRtXX3CTX6+mXYYzpksyby2Xj2t7xzuaOXdK+t0fWXWxqz
         ZKHw==
X-Gm-Message-State: AOAM533fVxAbtCgn2N8MdkImrWfp7TssmmDkxJpYrBpiT9OO5yssgw9y
        dOFARvG2Y/uY7Id8GpJL2Ex71rO7kQw=
X-Google-Smtp-Source: ABdhPJwd8Tqhh468L+uUUcEWilXC9sGh18M9p2I3NVVdZvkBOV4zG5Id8q6S38KsR+LMmFVxOX2ZLA==
X-Received: by 2002:aa7:da8a:: with SMTP id q10mr46052994eds.302.1641237909530;
        Mon, 03 Jan 2022 11:25:09 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:25:09 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/56] staging: r8188eu: rename camelcase SetMData to set_m_data
Date:   Mon,  3 Jan 2022 20:01:56 +0100
Message-Id: <20220103190326.363960-22-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro SetMData into set_m_data.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 0deba46d3a23..3a28c02da7c8 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -759,7 +759,7 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 		}
 
 		if (pattrib->mdata)
-			SetMData(fctrl);
+			set_m_data(fctrl);
 
 		if (pattrib->encrypt)
 			SetPrivacy(fctrl);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index c6b9cd37219a..7a87fac66e43 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -190,7 +190,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_pwr_mgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
 
-#define SetMData(pbuf)	\
+#define set_m_data(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_)
 
 #define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
-- 
2.25.1

