Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E564837A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiACTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiACTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:40:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98FC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:40:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f5so139705711edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KeBS7T+z3+RFfIW5vzlPf8GNtNuS/+GT4QZbada5eqM=;
        b=j2JW1HaTairBLqiT7eFzSqGa5+3RHmml3yC0s+mBeDO9SZvxNB0FntkrB9ssFzF5vw
         561sjHwJTMzdzzoqEZWbwSPwDhTTc4q5sFgUG6kbWccCIrwDFImxzigET2WLowM5ZEkl
         EsJRuqHLcD5vCnZwPBfv7LGxVrGCWBlRv96T41ALjGi51RcmoX8cGhYQpvYHkzO8BALs
         atEd82tpUx6db83SXDr+bmKRs7/zCDOQaHgy8SWmJYplk32yfECJT1b7CfOHUxz5Wqeu
         XKHWAUC8yOwdMcGq8S3oVljeuMv5XabmtyMWhwANMaTpBvjdLrd/BUr7sl4Gjci/VFlW
         vBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeBS7T+z3+RFfIW5vzlPf8GNtNuS/+GT4QZbada5eqM=;
        b=M/3xRmkCM2hsS3O4W0tVtp1PgqaD3bjfeFQo8HASYBQwuF9X/uQDOWbSZu3rsFMYGU
         gqCG9IjU4Zqt26zXxEyou2qy/LeRrVKi1+2bMz24xsuWMS4Pfr/5/EXZ+bkDHg/FrYMU
         mWNwDUhGDYRrODDWN9xwTj/DDuDYFX1SnEElH8X8Z/C6+bBtEh47l8rAhw7o376l8Nbj
         rsdmG56I6MIq7jYS4vVPBOPxMhetJdGIaYhqTIih+ALnpX6RWHD39M3au1RlNt91Occ1
         zk90+ZXuSvnOE70ez7GCJcFcfRGM/kMp5gPU50kXhWIxQpATRmCy2Cgvs0HXabSdSDBD
         UpvQ==
X-Gm-Message-State: AOAM533qgiS4F5ELV9CADOKX5UzzfcIpKT8FU/ePxifYODMzSwrtJjGf
        +bC08bPllZjO81mr4s32v8pYf2ZFra0=
X-Google-Smtp-Source: ABdhPJxcvm9zELUx8UpELVzNDSMsWyYXdYW7kwbDp+QuQpSBC1NmEGNRh1WfI7tbPhPhkdM6crO86A==
X-Received: by 2002:a17:907:9694:: with SMTP id hd20mr35891559ejc.360.1641238812749;
        Mon, 03 Jan 2022 11:40:12 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:40:12 -0800 (PST)
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
Subject: [PATCH 37/56] staging: r8188eu: remove dead macro SetFragNum
Date:   Mon,  3 Jan 2022 20:02:12 +0100
Message-Id: <20220103190326.363960-38-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro SetFragNum.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 652a31da0556..4b5dd73c391e 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -223,14 +223,6 @@ enum WIFI_REG_DOMAIN {
 #define get_frag_num(pbuf)			\
 	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) & 0x0f)
 
-#define SetFragNum(pbuf, num) \
-	do {    \
-		*(unsigned short *)((size_t)(pbuf) + 22) = \
-			((*(unsigned short *)((size_t)(pbuf) + 22)) &	\
-			le16_to_cpu(~(0x000f))) | \
-			cpu_to_le16(0x0f & (num));     \
-	} while (0)
-
 #define SetSeqNum(pbuf, num) \
 	do {    \
 		*(__le16 *)((size_t)(pbuf) + 22) = \
-- 
2.25.1

