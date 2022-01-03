Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D915D483770
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiACTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiACTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:11:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50554C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:11:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o6so139502090edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LpbJ40RMtGdL7dvHZ4+rXlOz+sMuPTGwqmKmFyNXJk=;
        b=gzruZNCqvf+NZH4xW1qDIXaQKtspAUmzfbOYOr5VgwPSfY6qb/Qlzm5KXEQpL65bQ1
         ySjCIy00tCVD5rAsLxLymFpCYctUXKQnJkEjHWmR7R8K+Hn7voYWARmCJB0K5Wxa5Yle
         QNj/ymRmuW8sWJgtadS8hT7+3OzuWuLmU3XhhZm1iQawVJrDi4XJv5SZJ8TBfueXTzPA
         H5i7Zi0E3H6SA+cc8GBk8IeLNL2+Aoc/k9Zq20IR0IX1JAX9DEx1Lp4+FUiLNmfE+859
         0RebFYSsWNR90CN1vFoKx9ZCvs8dv5+kkNHebhKgGSfcwbD92iiCoGtlEKemkz1t/WT+
         z48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LpbJ40RMtGdL7dvHZ4+rXlOz+sMuPTGwqmKmFyNXJk=;
        b=7/kQBiQ1N8g7AaLzG+lZfCWxeQl2baFTI0r2qhZypmN4o/jStbpe+11Inmu2E/5eLH
         ALLyoj7gkiFVudduCVt6lcv2ES5WQXBDt3Xf/dk+HvoC2KsvRNvqN2WJM7H9HTZTQYbK
         rcruIEUQyqnsNsoeOQ5gnwvUPtMxLV/AJ9kUsuQ3hrgIPyys5lofLC5esfUsldpGIvcH
         atWflw6a9ZkP8yfh4Pi6wtF4Pmf+b5oLQ0P0VMzQSCAlSF0eJQkVCsTABTvPPRC2O/4m
         NUcNlxEASZHAa6nO27CYRo2Xyg/VK7BVuRntipcJxoKQgSFXhjqcWmsNNqeRa7lN+kjW
         rykQ==
X-Gm-Message-State: AOAM530WR7Dv2vLCD3T/dVjMjtP1T9ShIyjbOySvCKK/ve7SOB4VBuHb
        19WEYUtVPVlnxJw97nXyJPo=
X-Google-Smtp-Source: ABdhPJz8ii42Fhw8J3V8PDp9kVvGCo7GA3FfPxfVQ4KKnG6JfenvWXwpbYNjzNISPUSkh5DfZelrjA==
X-Received: by 2002:a17:906:7d96:: with SMTP id v22mr7613314ejo.538.1641237106997;
        Mon, 03 Jan 2022 11:11:46 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:11:46 -0800 (PST)
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
Subject: [PATCH 07/56] staging: r8188eu: add parenthesis to macro SetMFrag
Date:   Mon,  3 Jan 2022 20:01:42 +0100
Message-Id: <20220103190326.363960-8-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro SetMFrag

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 1d24d798c5f9..6e39a72e49db 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -176,7 +176,7 @@ enum WIFI_REG_DOMAIN {
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
 
 #define SetMFrag(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_))
 
 #define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
 
-- 
2.25.1

