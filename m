Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE04348A68F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347288AbiAKDlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbiAKDlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:41:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658CC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:41:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z3so15150023plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hwEPMvp3DjRSN3d2/dcUVuC6b+oG9XWyIp1x6JZBMCU=;
        b=qJhKfppSoaHQ9x0M8JS4CHsfoRvskXcYBqGE4k4UL6E+OoAQKy2x7Otjnmm8kZQNw+
         /UvnyzUkKPNrLviF+AolXpjg0PyWfhBMbFKnmU1EJ7chVluv25O9Kd6ejQQAzooFq6Xy
         UghEqYyYCePb/o/FymIosocn9kD64P+dQxZFPbGKNYbPsP4zRgvOtjqPORktn40TrZD8
         5llCBJ/kJ1NFJW/8uLAUuVxPOJp6u03URdM/aJ/nNVy0SmMuOPQHrADGB8lVPAaRt4Gb
         zgTiu2xVGWzlfPUHYXX8fS5UOxOnIJH6afERIGngrRzb0y6bMSOmf4P0sXg2cvY97raU
         ZbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hwEPMvp3DjRSN3d2/dcUVuC6b+oG9XWyIp1x6JZBMCU=;
        b=2AFM4DNF2aooRO9EIAG/fPFTXNnLDFuQ/eWSRTCuuN6IY+asGyelHD8i+KPBypKGDz
         cDcLYOYZpTz4R0Z7w7Z5HJcgEmcPRjRo3eiara+Shtj1F5J60q1H+AWjSrzCWXPKFmwr
         aUegVLXhS3+sUztSQaQpsq/y4z9bg5fArZ5xPjtc2jvsTjVkkX+zCdTWS2e8pgQrDv69
         0NJusLXKddDCP6dlPzS6H/DYvcmxSdra70RgcGtoKFAltjzphEUEilTEev7kaodT2koI
         oieRNg7c2xv5ZAjpaBGaz7/A8uTx3AYP6J+37s8fewi5MG+JM5+/QksvC/511t5mmIGh
         WnCQ==
X-Gm-Message-State: AOAM530eEmDCiKwOQ4Nuv8aCh5FVIENscJnjip68i9A1/xmXGJSOxpbG
        YEDP8Uay3/tKkywpqaecMZCyve30OlVFkbSEWKo=
X-Google-Smtp-Source: ABdhPJxYXhrJc/EjC0Np8wZ+dKkfFxXVsLMmeCHIPTToDcc2z7QjHEg9hxy20KkyS4ABVthGKzR+tg==
X-Received: by 2002:a17:902:6b03:b0:149:7cf7:a17f with SMTP id o3-20020a1709026b0300b001497cf7a17fmr2664825plk.173.1641872468280;
        Mon, 10 Jan 2022 19:41:08 -0800 (PST)
Received: from localhost.localdomain ([103.144.149.199])
        by smtp.gmail.com with ESMTPSA id y14sm6871315pgo.87.2022.01.10.19.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:41:07 -0800 (PST)
From:   lzmlzm <lzmlzmhh@gmail.com>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lzmlzm <lzmlzmhh@gmail.com>
Subject: [PATCH] Remove extra device acquisition method of i2c client in lt9611 driver
Date:   Tue, 11 Jan 2022 11:40:51 +0800
Message-Id: <20220111034051.28913-1-lzmlzmhh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: lzmlzm <lzmlzmhh@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index dafb1b47c15f..e0feb4fd9780 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1090,7 +1090,7 @@ static int lt9611_probe(struct i2c_client *client,
 	if (!lt9611)
 		return -ENOMEM;
 
-	lt9611->dev = &client->dev;
+	lt9611->dev = dev;
 	lt9611->client = client;
 	lt9611->sleep = false;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 33f9716da0ee..e50e42312e82 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -860,7 +860,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
 	if (!lt9611uxc)
 		return -ENOMEM;
 
-	lt9611uxc->dev = &client->dev;
+	lt9611uxc->dev = dev;
 	lt9611uxc->client = client;
 	mutex_init(&lt9611uxc->ocm_lock);
 
-- 
2.25.1

