Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34805483789
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiACT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiACT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:27:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EEC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:27:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z9so69651953edm.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdGCU54c0X79jQu1NP89jndacfxYf5lufN7LSpFLLZY=;
        b=YKmEDMFjid2JEookZysauYsMUcZaGLZ2/fCRTBw6EOEA4ZQ4ACVqFqfUrRlNSo7Qis
         S5GyPIa2eCapJ76MAVb0mN8Mh81SNfNLubd6aOebU6lDZT1zOYH32njY8UHl4rIicduf
         GFFz9qfB/Y5J4fpAZVXOMDKl52SnKhkHVtylnGcT0N9dEAxYDD5evHsuioRy70xHSrPR
         72Xkiu5QEacUBEuTBX88JJs/l+KSWZzFhGF15jhNJ0Yx83QFwEUar7HHuFGESjq5q8HM
         2zXuNGEBpRMys7YN/nwSLcVfPZZGlWt+2lIXKfByUhCQycaC8EEI4prFRDdgiVkdI11J
         inDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdGCU54c0X79jQu1NP89jndacfxYf5lufN7LSpFLLZY=;
        b=fXtCLiMsX2NlIvmpjlmNm3w9IJpfvcNJM0nh+fY+v0f6eLsCSpxh6sQ6VB3C3fxMug
         AM6sH9vURC5NMtpcRpIvxyyHV4rJlu6EwH70c5DYmsEJKkgsfAa3tluLdprYlIhkUQnY
         /S1lEYbbJrX7SIuKEaeV2+NRzeHOdXtN1QvEnFOP0Gqz/cbufuFx23MLns1JfNHcSK/o
         +L06XXI0bjeWJN6VCXz++NN3sp8tFRj/iSYo34lns4iMG/IoEuEZx/4PvXKnMVwLdWqQ
         H4FUHRSpTrx/e/FRS13Yg1/P085JQxJFeisklKo7eywNMVG7r4OnDzKbvXp2R83g9z7K
         2RlQ==
X-Gm-Message-State: AOAM533/KUi7i09H4z1ZQC0GFqqcjFzcYpVXT80BGwviXWfcWUmFjxxe
        fMeBaU2H40dfW1h8kbUTRPY=
X-Google-Smtp-Source: ABdhPJx6PRfd1ooGv7qVI1mGjobcKbAYutZibdbolge0Ad8SHAADpGLeeN3o5bnDigu+A1oDnWKNag==
X-Received: by 2002:a17:907:6e11:: with SMTP id sd17mr38207223ejc.143.1641238022364;
        Mon, 03 Jan 2022 11:27:02 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:27:02 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/56] staging: r8188eu: rename camelcase GetMData to get_m_data
Date:   Mon,  3 Jan 2022 20:01:58 +0100
Message-Id: <20220103190326.363960-24-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetMData into get_m_data.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 844369531639..59560a3c87df 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1110,7 +1110,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	pattrib->pw_save = get_pwr_mgt(ptr);
 	pattrib->mfrag = get_m_frag(ptr);
-	pattrib->mdata = GetMData(ptr);
+	pattrib->mdata = get_m_data(ptr);
 	pattrib->privacy = GetPrivacy(ptr);
 	pattrib->order = GetOrder(ptr);
 
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 869a38ec9ba5..d42ed74c8469 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -193,7 +193,7 @@ enum WIFI_REG_DOMAIN {
 #define set_m_data(pbuf)	\
 	(*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_))
 
-#define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
+#define get_m_data(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
 
 #define ClearMData(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_))
-- 
2.25.1

