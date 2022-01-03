Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69D8483760
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiACTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiACTHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:07:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F1C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:07:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q14so131602507edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jM4NyCG+Klkl1K7S7VYyfqpY34ENYAtSLpzEWHASd+M=;
        b=N7HTuu6Cox+eZeWfdx42tiN5bwB17QepQCcHWcxmmLYRhXp5vWBIqrPBF97/4s1nve
         PngsOPAh30YfQGRVzphP0lkSj1NHzihov0UNaksKaPMHT3mWZIVTzFpGsXwhY0QvVDXH
         saAfwdUXFGFJyVLpol1X5Mf/et7oTw7Z8XR1+/9jLeYCXTWL0sRcbmTJoJE5qx9RxnA0
         AAtoMszQXB75Wxt9KhohH1HMzqv6tmToWHL4lIMloi5Aa9+hFqaM1JBMm7dJEZWr/Jmo
         FgdYvCFpIfcg2iY2kpVhekJDz1T7gdW2spAm7zFftzsoI37Fg7CrlTrqehgpM3XmRVOE
         QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jM4NyCG+Klkl1K7S7VYyfqpY34ENYAtSLpzEWHASd+M=;
        b=h1IDzNbx2Wu8oy8YDNreS4/wB8ZdS4XlWF4ncoh6P0BWKIDbwu7l5Jyo/ITgdz72ZN
         qiPUHZgzfo6OrsRZkNA+hKF47tcgY1wcT9aYxey9vH2pLB0QC2q3WxbDnZdmSXjO4rfK
         qy8oEAb2/4UX/VPpN27oCEKcOn1A1M1AtTfr4zQUd6yQqQWn2keTSOWgp0dtA2o7w6yu
         5SxfmzqG7YAtetWyYSmT3isnKpqTgC6CCMUrnRnnqBIhbnM620byVJTfZODeOgEotoiC
         5XsIRHi/XvNHXkrVOYxZcjlE1JC5C91brqJV4PPVSTbiyuqFu7d5WRFKfcmh/B56in3U
         UCBg==
X-Gm-Message-State: AOAM532t6HiPMrcOPpRnsawG5l6n14tCG0s5yAZYypMP9We3dYhrx+xm
        OQF48Xjp+P2vX2rQScQJmvU=
X-Google-Smtp-Source: ABdhPJzVGH0TzQD9DSODD33MFlbou3zYOuDhhIBe9JnPA6WT3vUrlXVu5m1VD/1+8bwKCdI3lF2S5A==
X-Received: by 2002:a17:907:6d9c:: with SMTP id sb28mr36437148ejc.393.1641236863893;
        Mon, 03 Jan 2022 11:07:43 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:07:43 -0800 (PST)
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
Subject: [PATCH 03/56] staging: r8188eu: remove dead macro ClearToDs
Date:   Mon,  3 Jan 2022 20:01:38 +0100
Message-Id: <20220103190326.363960-4-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro ClearToDs.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index c556cf378c8a..487a4b7eafd6 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -168,9 +168,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
 
-#define ClearToDs(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_TO_DS_))
-
 #define SetFrDs(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_)
 
-- 
2.25.1

