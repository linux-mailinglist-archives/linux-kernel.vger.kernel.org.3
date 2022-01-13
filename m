Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8550048D83D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiAMMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiAMMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:52:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D45C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:52:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h1so9612966pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swVaXzBx+PrfXmAvvghZ6HgBvKOJ7/EddkA4pJ4xeEI=;
        b=TuiWl8Oz+foIhj0GKYCXsYw7/LOB74AzRk0AVyxvHDwjucLVBvmxatrq9l5GOniEHu
         D1NRALEoW8UGcqLlffH0hW3xTegREfsqqwBMMTC3Clh4Ue7l0yhzkFZ+EcswgGgSVH4J
         ri4Q6Vlsr5Ww7S6jCz1q1L+sU66m4+Wg0ZkhIT6D3PMuAbRrmkI0gqtmu54GhpirQp8j
         N52ujwYK4q6VnoC0TrauHF3sNxhS2M/SbeLXAtrxfKolM7CFOZJavgBSsIHs064ISdtY
         lTXQFZwc92PJEuIMEPdGOiiWouK5fod0HnsOkQDc/UINixC5N0WdmEC2ScxPAj/f5Lzl
         Rd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swVaXzBx+PrfXmAvvghZ6HgBvKOJ7/EddkA4pJ4xeEI=;
        b=RfFf0yi2V7WJaG2gM7gk/nknSUxYwkMpsw6GzmyYeRiO+FxAc5Y9MlTAqTNw7atiOK
         M6faG9FNQVKJpjY1g+OcNYOCdzXRE+ANrWEjx7tvxWLunWHodgxDaPtVUDQ12we2NOIB
         vJLh1QkGg2GeK3YTbHTBfDELZrg856qi4IuODkYTLxcBVkS3U4zABYpeuTdy5zTXFRMN
         7miwWLgPxB0KYg3Z78UbiLsboHYegyQ5ejo37A9ABRAvxh6xxLbKaTvg40jJVE+3864y
         5DcLobC9LRPhW6RkgMvWGsy+wA8G0P+f420YyYB6D9XEQgO5bPlM61fApYapMP8fml4R
         BOzw==
X-Gm-Message-State: AOAM532/qVRCyDrUqi1C/w+J6GJS0+G6s9RHY0LVvFeaxwoybMBFMOqE
        c2MuvlAgKLbutzde3VYlHVA=
X-Google-Smtp-Source: ABdhPJzaqVUc5iwgSTLDxoA1+5ZByWOicwSgsG6MgN2setHwniTm0Jy8BKkS+NCGatVoAAyt2otLbw==
X-Received: by 2002:a63:700c:: with SMTP id l12mr3682836pgc.559.1642078336413;
        Thu, 13 Jan 2022 04:52:16 -0800 (PST)
Received: from localhost.localdomain ([103.144.149.199])
        by smtp.gmail.com with ESMTPSA id g6sm2311406pgk.37.2022.01.13.04.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 04:52:15 -0800 (PST)
From:   Zhiming Liu <lzmlzmhh@gmail.com>
To:     narmstrong@baylibre.com, robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhiming Liu <lzmlzmhh@gmail.com>
Subject: [PATCH v2] Remove extra device acquisition method of i2c client in lt9611 driver
Date:   Thu, 13 Jan 2022 20:52:01 +0800
Message-Id: <20220113125201.22544-1-lzmlzmhh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zhiming Liu <lzmlzmhh@gmail.com>

bridge : drm : Remove extra device acquisition method of i2c client in lt9611 driver.

We have get the device of i2c client in probe function.So we should
remove extra device acquisition method of i2c client.
---
 drivers/gpu/drm/bridge/lontium-lt9611.c    | 4 ++--
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index dafb1b47c15f..feb128a4557d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1090,7 +1090,7 @@ static int lt9611_probe(struct i2c_client *client,
 	if (!lt9611)
 		return -ENOMEM;
 
-	lt9611->dev = &client->dev;
+	lt9611->dev = dev;
 	lt9611->client = client;
 	lt9611->sleep = false;
 
@@ -1100,7 +1100,7 @@ static int lt9611_probe(struct i2c_client *client,
 		return PTR_ERR(lt9611->regmap);
 	}
 
-	ret = lt9611_parse_dt(&client->dev, lt9611);
+	ret = lt9611_parse_dt(dev, lt9611);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree\n");
 		return ret;
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 33f9716da0ee..3d62e6bf6892 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -860,7 +860,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
 	if (!lt9611uxc)
 		return -ENOMEM;
 
-	lt9611uxc->dev = &client->dev;
+	lt9611uxc->dev = dev;
 	lt9611uxc->client = client;
 	mutex_init(&lt9611uxc->ocm_lock);
 
@@ -870,7 +870,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
 		return PTR_ERR(lt9611uxc->regmap);
 	}
 
-	ret = lt9611uxc_parse_dt(&client->dev, lt9611uxc);
+	ret = lt9611uxc_parse_dt(dev, lt9611uxc);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree\n");
 		return ret;
-- 
2.25.1

