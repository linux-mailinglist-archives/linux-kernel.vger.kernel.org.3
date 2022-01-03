Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DEE48379B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiACTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiACTeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:34:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF1CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:34:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n30so27530850eda.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Avpk6X8zfZczt2UJ5zUjfIT38ypp5ssS7y9M/r39eaM=;
        b=GAsXYEAkzhLODQVTeKJ8a0xoGWNSVmUm5TR+x3GYyEtrNe+TW19/Bzp5+1MqjPx4Jk
         o45uBFAsmR3wEt2VantWWEbgg4QRPji6zDhtbTj8s1u7pi8b298DnnAGu5ZD5XwTJcsd
         lZGaojkt06WtsrQ01N+BB4sAiahBGsZbFQ5Q1BrlCVLNl8P52dL1S3SDyToCoHWJ4DwK
         n8wu6U5TqwVphaLa6gmqXcP0e31rcoxUlzFaYKqarL8Sj8TgsJZDosmpP54rxeZopd5d
         Z4ijDl6c5z8TpY8HFw23xIrNd+H4EDgHHulW5gobDAEicaypI19NbjpRtiF/HdvPh0NI
         sSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Avpk6X8zfZczt2UJ5zUjfIT38ypp5ssS7y9M/r39eaM=;
        b=IGbB7O+2szMkGgKHscy5YpfkyW8c+Ve8H7po9nUXN8wjVPBTgXG9h2ka2J7bs3n8AE
         88jQzV3w3dWpHOD6QIMTJQmN7HZdgnTHvon1aHaU4QLQ63FJs4WuDToZKKlo61nX/7ij
         G4LjDLaRo4DA6k5NAZnjFglbFvtdv8TnnN977D6ul7YVd/wq35EWuRqA1bdeczzbioxi
         pglVv/OIx8RJYeYvIueAK5veeCPYQEFG6nV8whBTJ481YQ+niEpKdg0y4i4ewLZ1yphC
         HAuMmwmvHgN/pYHLjBjO+u8QKIU9/5SyNyUGDZxzmZEBtw/bRLJ/IccrF9gyAZb5eMnC
         77sQ==
X-Gm-Message-State: AOAM533/eXmZggULp1I+qXE+UIiVGMTfrpkJIRl3LPFg1/zQXd7eIRkY
        UiXByhqcG0c57VyHTiXfzS8=
X-Google-Smtp-Source: ABdhPJzdpuZ/C3M1dzZBk7YF/hyDuHI0LdmF1cIg1dhC3VurKZMbyiY7N9ElzguLByTUcMUf8Yu7ng==
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr37613196ejc.1.1641238474725;
        Mon, 03 Jan 2022 11:34:34 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:34:34 -0800 (PST)
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
Subject: [PATCH 31/56] staging: r8188eu: remove dead macro SetFrameType
Date:   Mon,  3 Jan 2022 20:02:06 +0100
Message-Id: <20220103190326.363960-32-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead macro SetFrameType.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index bd22f74e425b..7053185667a5 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -207,12 +207,6 @@ enum WIFI_REG_DOMAIN {
 #define get_frame_type(pbuf)				\
 	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
 
-#define SetFrameType(pbuf, type)	\
-	do {	\
-		*(unsigned short *)(pbuf) &= __constant_cpu_to_le16(~(BIT(3) | BIT(2))); \
-		*(unsigned short *)(pbuf) |= __constant_cpu_to_le16(type); \
-	} while (0)
-
 #define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
 	 BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2)))
 
-- 
2.25.1

