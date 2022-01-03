Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2130E4837D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiACT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiACT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:58:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F37C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:58:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y22so139913013edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jypa2KZz1jaCb25AkvRox++XG9Sod4bM8BJSXTd2gt4=;
        b=Oaq22mGxBm00uR2oC81gkGJ0DLrNl2TZrquOp+DsHSh7dA8mGJMGtbWtLQaZTA4G4i
         9D+sgF6DZ5dK8JSVpt0aMlPamrOJ9vQjzzLpMZKnZOTRE+l9/IPcUp8uis0zfwv6TqQP
         PVRl2g2jDDaIxhU6AC6vK+ZHaVY8ER10DQJRg+UoM6OfHIMxJ9dsmlGsdOvyH4oHqoGV
         yp0enqqAQOxR5ZRPDAqfYnVFV5xMv2lodMWlRGQnTMWTpZN0/CGkRpQql73bbJd/7jEM
         fYtOBxjyYFruI5k4o0aVeaqqJMDguL+Zk2MeJa37uT79EZYE+3DqAQEv+OcMDHlnA2Eu
         3UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jypa2KZz1jaCb25AkvRox++XG9Sod4bM8BJSXTd2gt4=;
        b=CF/We6hUH1z8LKJc/HI/lz0HFOnk2MSZP9rUMsp1RIVSwUI2NIEUn+YEj7OoA/S6Hw
         bD7VqwriOwBe2BFRPKWl1UmDHZKt0AhPWs1jUnY13CotPHCGvlorGV80k/ZlpDGGg4vd
         5pZfMp43fGonKaLlRVsM9qwC0rGLnBeBUAldDtqPkPtjIU/wZ5+fegHwF7vQtP6ekDxv
         yLqId3CqCZ73YhvwiYmdjY8jpPPZ9zWTZadW1j84MZJ38LHvyvQqVrOBpJB2sIF+SSEh
         JMliXzIO+QwOdigGxNLfHpH3kJ/2iF9ntgBJClEgvkPYp2l6WSOlmpTUioP7vJnPKWDm
         uWQw==
X-Gm-Message-State: AOAM531wYxM01Me1OkAW6R8LthR6zMJCzxXs2W+l8vAqaQPX9thM1v3K
        8HdRotiDlq07AeNxPPOjBhQ=
X-Google-Smtp-Source: ABdhPJyl1esHZl2UmsYjnpJRxX5wQd9/tTBMpv0aGaUVT/aoDg14dnCKuBGYf9i3mVHNP16V+luJKA==
X-Received: by 2002:a17:906:4556:: with SMTP id s22mr37079990ejq.321.1641239879000;
        Mon, 03 Jan 2022 11:57:59 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:57:58 -0800 (PST)
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
Subject: [PATCH 56/56] staging: r8188eu: rename camelcase GetAddr4Ptr to get_addr_4_ptr
Date:   Mon,  3 Jan 2022 20:02:31 +0100
Message-Id: <20220103190326.363960-57-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetAddr4Ptr into get_addr_4_ptr

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 9d8d69cc562a..d464938a12b6 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -256,7 +256,7 @@ enum WIFI_REG_DOMAIN {
 
 #define get_addr_3_ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 16))
 
-#define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
+#define get_addr_4_ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
 static inline int IS_MCAST(unsigned char *da)
 {
@@ -304,7 +304,7 @@ static inline unsigned char *get_sa(unsigned char *pframe)
 		sa = get_addr_2_ptr(pframe);
 		break;
 	default:	/*  ToDs=1, FromDs=1 */
-		sa = GetAddr4Ptr(pframe);
+		sa = get_addr_4_ptr(pframe);
 		break;
 	}
 	return sa;
-- 
2.25.1

