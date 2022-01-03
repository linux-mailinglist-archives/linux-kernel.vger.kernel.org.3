Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA048377F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiACTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:20:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302FC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:20:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y22so139594062edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnLMiq8Mm2ARPQsexbrW9egBTCgyloKoB1Bo0S3MfQc=;
        b=AOY97vn0ni7cV9yW+M+6M+jY/FPaZ9J7gv58MWx8ojvRG5LiYNF3EcHoXWIdu8Y8Er
         hwaVlCvZ2R/DxxLX3oFNZOU+HavfwgHEPheCNqAuGwyaG/jHdiT0nTImc9oPHUgGAZmn
         1oeO+5q0lBVaDWuxG9yXmw9EgK6Cz3oa9M8dYQvjO15saVrTYekxOLgbGjAjYyzMF/04
         UK720mfVxItFQ4l6JlpGN6dS6HrYd7UFWr4K8mYmm+FHaH5atGAQGAnJ3jGF1IqTwDqB
         /EN1P4KqkxVYhbMlNjljJLWQfUFBCP+LGA7fSiaIgkdUOlfDbEKQW/UoJvbiHFfnIQC6
         PMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnLMiq8Mm2ARPQsexbrW9egBTCgyloKoB1Bo0S3MfQc=;
        b=TZIaKuNvuJL45NvWLhRxVyDe0LhSnyIXqYPpL0P6Cq07RoIotDtgG3wD5dfTsBNx1E
         k8XyyL4YDHbkbD9JL0pbAzfqqGyAE4QhZ9CFWRUwbKNKn+XHLEKhQ0mtzFP4uRg+BTLa
         NfRvTxMKK5lT4aXXMTmKHvKDLlKj3KLJl0kR4Lh04nDk6ezbpGvs+BP+PjAZyxaz3E6U
         ElMIyNJ1nm8t6vglmVYPoJBzqdpAlenrv4bW3/IlryT9Ay0bRBXXQEuEeCkgnPBy3g+L
         2yYi/6jAmzZXjvjvxXjcwHJGy2BVQiK6k00b7jsvs2BGLgJKOufpRnYdk/OAhIFEvwpB
         xSzw==
X-Gm-Message-State: AOAM530Zsj7AFDV8FBbh2ZRUobSfK6hsmrOmzn6D5h0LlKLUV1BKO6xE
        HwzDSUo87LNSwwsc3T2ZU78=
X-Google-Smtp-Source: ABdhPJyW8VwR2Fmp7fAb1CmReVpCcLPh55im4PGVyWUpDRm/ZDT9PGtpcMkoleB6v/45hUzlJIudqQ==
X-Received: by 2002:a17:906:2f97:: with SMTP id w23mr35780885eji.739.1641237626372;
        Mon, 03 Jan 2022 11:20:26 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:20:26 -0800 (PST)
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
Subject: [PATCH 16/56] staging: r8188eu: remove dead macro ClearRetry
Date:   Mon,  3 Jan 2022 20:01:51 +0100
Message-Id: <20220103190326.363960-17-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro ClearRetry.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 20a70cde2272..ab8ed3ce89f4 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -185,9 +185,6 @@ enum WIFI_REG_DOMAIN {
 
 #define get_retry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
-#define ClearRetry(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_))
-
 #define SetPwrMgt(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
 
-- 
2.25.1

