Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8662E4837B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiACTsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiACTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:48:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B60C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:48:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bm14so139798492edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJrc6JPPLLoAv5ayNdMrXg0ETocomX7tZsuSWyXHNy4=;
        b=Tdu7hMZRPWOS63ywzBk+qj1MtQLch/RYYtMI4+hUygsAO01g/edWOmXYD0fI9GhbGp
         VIpQJY9UFX6ovvfVpxWN/xRvDZusQb9fkE8qwWox6e6ZIZgM0vWxIq7F8wPF4Bye2ZQz
         yMk6DognAQtYRAktPnwML51ERG5lkyED+ZS4fkFfjw5nhva8PvBVbWF55gZxb2TzCy5B
         0yHGPWlzORFvtk2MSxA6N4LkeLDis0u3wgV+1gQs7NDBlp73ZjBtgZckTD7nvtL4kIgN
         zzY6hoFh5NYmxiGY5PVvyt8WxxRP2AcBtPFMOhkgqGFxhlaQMRt8BBX2ZB+vNWx90K/0
         fuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJrc6JPPLLoAv5ayNdMrXg0ETocomX7tZsuSWyXHNy4=;
        b=TjJ/x97Ngg88Tn4suyKBma0m5JjZm32Mgt9iC7Zxo5TnSw9X7B8As89f2xP4R68642
         g8ndmtDUKwXtez81t7dZ0vPp+tam/On9B//P9uQpwPwE0VfAbj/HBIEUgMT6tAw3If7a
         g7M/XlZR1E5xBIqPL3i+hJ8bqLrVBvtbiLBgPC35Sy9D3ROE8PPL8CoTi9/PJRMQU1Nu
         BvVXqcfZyS3duLk435rjHYUUyksqBkojM10AmaNV6WduxtN7aCr+vXKi3fIrvWVDL/M/
         qqx19E4ljXw8Qunh0SiqgfXXcWFbJFbxsZdbA8UBcEU07HOKHHNn3bPZx4eWpQAEAcPA
         Jnhw==
X-Gm-Message-State: AOAM530k1/dvxTqvDdv9bRUxfhhmRanUHmPVPVr1nwZyHOLx+KaJehzb
        NXKruw6fCgl04QtP9Yz5D+4=
X-Google-Smtp-Source: ABdhPJw1cZT9VhXDODjLU2l/kuUEtENA1ktE4AN8sFm0tEZoZkEhVb6uhPoE4o/SP+DsSHLDZe3gIQ==
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr36877291ejc.29.1641239318233;
        Mon, 03 Jan 2022 11:48:38 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:48:37 -0800 (PST)
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
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 46/56] staging: r8188eu: remove dead macro GetTid
Date:   Mon,  3 Jan 2022 20:02:21 +0100
Message-Id: <20220103190326.363960-47-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro GetTid

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 8364b16dfd36..16acf7df0144 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -253,10 +253,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 2)) & 0x3fff)
 
-#define GetTid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) +	\
-			(((get_to_ds(pbuf)<<1) | get_fr_ds(pbuf)) == 3 ?	\
-			30 : 24))) & 0x000f)
-
 #define GetAddr1Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
 
 #define GetAddr2Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
-- 
2.25.1

