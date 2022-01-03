Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260EF48378A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiACT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiACT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:27:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2EC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:27:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j21so139473348edt.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MdYEcgXd4B1apWzHzTGq7elyU9Ldr6jcgJyInqhbm8=;
        b=DWll5Tdbp8H5HRUrHGSm2RDLZ+O3CAcVRf/QUtYeRiv8aO2Tiv3g4EJR8x6y97+7Rh
         0JSldGS2DfA1tpC+b8BSjpu53nJwDd752qu1IQk6MmcnatK/UIOco0HoEErqutRbfOGP
         CEll1IZ2Z2e0vIKN8yCQ0FyUV8kipVHiK07x962qDUN2JbeRD96Y8vwta4so89lr1P59
         2lxogeA3Tw1JZnmO7wYpftu4QIGhz3X5LIxFKlylVY8GWxUoJd+Lk1YTWHyEXukjfyt1
         XwWyf9qjSQQTlfAPZi2y29plywdseuD6yRZGVMExFFcvu7BnKskoz6ZLZ2taIlzcH8C+
         gStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MdYEcgXd4B1apWzHzTGq7elyU9Ldr6jcgJyInqhbm8=;
        b=FxwlRXHNpwqMsRAXqiIzz5gFKPd5aIpvB5zYj4kWDlMd4CfM7EOH4QuGOueP3Y+pK4
         53fE+CupMQ1Rh09Iez8zcH1r11Qp6OOCATXluvHW93pv6W25s7JCLaSNLD8avpFnemJZ
         BDRGkc3XNX7f2Stu9vbK7fC3+AxNK68ApRfEav+WOgkV18OHR87b3XNU9ma1PbAD+4Ju
         h53k1aXADV0aBhEL8Ygxq13uO9i6uJr0ilHrmcJ2a04vCTSnxdtDkUBA7OHRORPn2jr5
         LYLT9Y5cfOAGjZZdkft3Lig2+r6m7lXE4qD9VlwbV7x1PiRUgT0+8Sws2vJEDXCsnNLJ
         tO3A==
X-Gm-Message-State: AOAM533Kh8CPt9OB6oAFTL4/ydj5c5SDkTFhUGNebV5yXWKIXoGRdBf6
        qqHyvrOcORP9hdF9xslcQ3lvqZRhXPg=
X-Google-Smtp-Source: ABdhPJz1XH1JWQwa5gvjsuWNQYom2EFo3T6mQfWaLCBfrDBrR2gCSXf738rRV1O0zBiO/IEDg1dIXQ==
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr36836605ejc.29.1641238078164;
        Mon, 03 Jan 2022 11:27:58 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:27:57 -0800 (PST)
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
Subject: [PATCH 24/56] staging: r8188eu: remove dead macro ClearMData
Date:   Mon,  3 Jan 2022 20:01:59 +0100
Message-Id: <20220103190326.363960-25-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro ClearMData

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index d42ed74c8469..73465becf1e4 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -195,9 +195,6 @@ enum WIFI_REG_DOMAIN {
 
 #define get_m_data(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
 
-#define ClearMData(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_))
-
 #define SetPrivacy(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
 
-- 
2.25.1

