Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8E46421F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhK3XOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhK3XNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:13:39 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC46C06174A;
        Tue, 30 Nov 2021 15:10:19 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id m12so6077569ljj.6;
        Tue, 30 Nov 2021 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERM173rnlxHrezuLhERWO1z/gEqXVXV1BN/+rag/gH0=;
        b=fT7ZcuoDV9WZYGw/uHvsPnUTdpRNLBvlyuoM8XwVN1CCP+NCv0cA+DMi5jZQ9+ipNx
         1S0oCwCpgen+11NSKf2JTa1Gg7pRz62pb2DU1AeLY6buLkpmWHl2hp3g8ItGyz7tEfZ4
         b+/iyIRZTqapPQUjrBe8/kr5+3lletoqNdk6YFV+E4a2qXjy3ChVfecrvduYkeOeSk6i
         heVrII1NQy537z8DpVMrimIjsqFdPRv1UBo1c0cRpUuh/DttCoTHoLMvK+ncfVC4+2F2
         WySy03FD82cZwTYLMPL2sNOeO5Dvg3ZrDL0o8DoIJJB6HVwPT+g9m+sRHsJwKcpye/op
         vf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERM173rnlxHrezuLhERWO1z/gEqXVXV1BN/+rag/gH0=;
        b=oD/Nhpjaaf3N4mvUxPhIGkCa6felPd+N5LEo0JUA847x1Y0+m1sw7LO2+FGHsL6GoF
         LybW3SyUEIv5/4ZjGOecmthU7msjuVXo7fOv5cQz3XI0f6bc4THqappSyrELdhHvXK/5
         psdprmy8ixqxT0RU9S78PNjhu0bK0fUcITY2eL2B7y3j/4v6ecvtY0EDK6HB3SkBul91
         LBLPahkJItHmBNY98bjzHCbO/cCkXbhSj4ZgPKS2XTb29Z87Lxej09euwVwskwiwcQjQ
         GqRcKWCnswV1d5ll3mndbyjnXXz89tsjrZ8NJuddqK5DWJ6jIxl9UsAbsXqpIVfdgFvR
         eEVQ==
X-Gm-Message-State: AOAM5302bagf7MQeoaZFSHHXP8Wpln9Av58ogtNvBpUXnofWBRgo/z3f
        wc6+79WKUqRaFvqkVSInCJA=
X-Google-Smtp-Source: ABdhPJy8OrwAMk/4qysO8j03czL6bhwBqxpZq7ekWf8/+UlGsG4xsttvr4RZlRJiCp7oHHxgfgLsIg==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr1957933lji.36.1638313817379;
        Tue, 30 Nov 2021 15:10:17 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id k14sm2099846lfu.210.2021.11.30.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:10:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/tegra: Create DRM device early
Date:   Wed,  1 Dec 2021 02:09:55 +0300
Message-Id: <20211130230957.30213-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130230957.30213-1-digetx@gmail.com>
References: <20211130230957.30213-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM sub-drivers need to access DRM device early during first stage of
drivers' probing. Use new host1x init/deinit callbacks to create DRM
device early and destroy late.

Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/drm.c | 46 ++++++++++++++++++++++++++-----------
 drivers/gpu/drm/tegra/drm.h |  2 ++
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index e9de91a4e7e8..e9cbcaf6e017 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1133,21 +1133,42 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
 	return domain != NULL;
 }
 
-static int host1x_drm_probe(struct host1x_device *dev)
+static struct drm_device *terga_drm_dev;
+
+struct drm_device *tegra_drm_device(void)
 {
-	struct tegra_drm *tegra;
-	struct drm_device *drm;
-	int err;
+	return terga_drm_dev;
+}
 
-	drm = drm_dev_alloc(&tegra_drm_driver, &dev->dev);
+static int host1x_drm_dev_init(struct host1x_device *dev)
+{
+	struct drm_device *drm = drm_dev_alloc(&tegra_drm_driver, &dev->dev);
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
 
+	dev_set_drvdata(&dev->dev, drm);
+	terga_drm_dev = drm;
+
+	return 0;
+}
+
+static void host1x_drm_dev_deinit(struct host1x_device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(&dev->dev);
+
+	terga_drm_dev = NULL;
+	drm_dev_put(drm);
+}
+
+static int host1x_drm_probe(struct host1x_device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(&dev->dev);
+	struct tegra_drm *tegra;
+	int err;
+
 	tegra = kzalloc(sizeof(*tegra), GFP_KERNEL);
-	if (!tegra) {
-		err = -ENOMEM;
-		goto put;
-	}
+	if (!tegra)
+		return -ENOMEM;
 
 	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
 		tegra->domain = iommu_domain_alloc(&platform_bus_type);
@@ -1164,7 +1185,6 @@ static int host1x_drm_probe(struct host1x_device *dev)
 	mutex_init(&tegra->clients_lock);
 	INIT_LIST_HEAD(&tegra->clients);
 
-	dev_set_drvdata(&dev->dev, drm);
 	drm->dev_private = tegra;
 	tegra->drm = drm;
 
@@ -1285,8 +1305,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
 		iommu_domain_free(tegra->domain);
 free:
 	kfree(tegra);
-put:
-	drm_dev_put(drm);
+
 	return err;
 }
 
@@ -1319,7 +1338,6 @@ static int host1x_drm_remove(struct host1x_device *dev)
 	}
 
 	kfree(tegra);
-	drm_dev_put(drm);
 
 	return 0;
 }
@@ -1391,6 +1409,8 @@ static struct host1x_driver host1x_drm_driver = {
 	.probe = host1x_drm_probe,
 	.remove = host1x_drm_remove,
 	.subdevs = host1x_drm_subdevs,
+	.init = host1x_drm_dev_init,
+	.deinit = host1x_drm_dev_deinit,
 };
 
 static struct platform_driver * const drivers[] = {
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index fc0a19554eac..8b7c9508070f 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -121,6 +121,8 @@ int tegra_drm_unregister_client(struct tegra_drm *tegra,
 int host1x_client_iommu_attach(struct host1x_client *client);
 void host1x_client_iommu_detach(struct host1x_client *client);
 
+struct drm_device *tegra_drm_device(void);
+
 int tegra_drm_init(struct tegra_drm *tegra, struct drm_device *drm);
 int tegra_drm_exit(struct tegra_drm *tegra);
 
-- 
2.33.1

