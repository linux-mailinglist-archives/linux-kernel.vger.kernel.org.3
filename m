Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A203490BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiAQPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiAQPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:42:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:42:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n8so8444644plc.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtOfUVwTLdIOXT8a0g5ckSpi7c+ofEftPzF8DVvjq7w=;
        b=DSj3EgDScSimidVnItWhtOJzPUaZYBJzmUix6/8XulxD9eh7oQ92ArhOGtIA+dm+Ii
         W1jMtwbG1VSSajJDNgj0TX7eeprVE6JObDSFVX+T2cFloG0XgLYVOVbbi0iNrWsJcWpg
         FDj83SQW5k1fff003y6ytsL6Zlqfv0aj/yq4g1aS5iSfx5R4RYxNInCcqfO/3vJuzhsX
         eVMHbV97c2I/CQmrbKnE5FnALpzl/VxqKR+2Kacp2IYF3WxIv0uikbYRoMqeHR6XHjyD
         1K/VrhxKdBY0QjB/kacXlJwBsgX+v4zVz21wU+hQV74M63c/d+TjlBxdWrP08+4DNELS
         uB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtOfUVwTLdIOXT8a0g5ckSpi7c+ofEftPzF8DVvjq7w=;
        b=NWb5/KW6gAhDc6SC3aL7AMMGjw57JxsqOWDiudX4iJ4uEYAiEcmVQGWcgkCNuTUEty
         PhL66CZt/scHmVfJo/adIXraKDwLC5P18fhEFR6nZLGa4HC5+SbgRKLiIDbFjKECcaAG
         pqqec0DBOu60cl6OFKdH01gGOKYidTYWPPwV+jlj6beCfGPkHuFk8DGwXwHe+HvpgEgQ
         3WcoQb5N+7SlZ82r8HivXwV4lMFxms6IRIggA8YCBqxlydDDq1ihfMJPFgkez+Nw1p8a
         c9tNOrQs1yaSlqyIZVUd+VBGvpWZIIPQ38kdSgozyembZfcuuHsk/hB67uUPNJ6sWBNl
         pvjA==
X-Gm-Message-State: AOAM532UVJvb7NZ4erMArrZcjjeI3kGfc9VbQePTMV6mvZ8sgodkWK4E
        9S7kdu2ASynJShhfkOcxCzU=
X-Google-Smtp-Source: ABdhPJz5G1+u67lsrh8eLZfD2KUC2fJ5ASHhWSnK4O/r6glXQvoCoXYTisCmW19QxJfNIyNqGIK3+w==
X-Received: by 2002:a17:902:9a42:b0:14a:baa1:c7ee with SMTP id x2-20020a1709029a4200b0014abaa1c7eemr5657642plv.58.1642434151549;
        Mon, 17 Jan 2022 07:42:31 -0800 (PST)
Received: from localhost.localdomain (211-75-30-246.hinet-ip.hinet.net. [211.75.30.246])
        by smtp.gmail.com with ESMTPSA id q22sm15582949pfu.153.2022.01.17.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:42:30 -0800 (PST)
From:   Zhiming Liu <lzmlzmhh@gmail.com>
To:     narmstrong@baylibre.com, robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhiming Liu <lzmlzmhh@gmail.com>
Subject: [PATCH v3] drm/bridge: Remove extra device acquisition method of i2c client in lt9611 driver
Date:   Mon, 17 Jan 2022 23:41:50 +0800
Message-Id: <20220117154150.5145-1-lzmlzmhh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm/bridge: Remove extra device acquisition method of i2c client in lt9611 driver.

We have got the device of i2c client in probe function.So we should remove extra
device acquisition method of i2c client.

Signed-off-by: Zhiming Liu <lzmlzmhh@gmail.com>
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

