Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABB46421E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbhK3XN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbhK3XNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:13:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8737C061748;
        Tue, 30 Nov 2021 15:10:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e11so44130380ljo.13;
        Tue, 30 Nov 2021 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PcErViLP1DIDDwbIDFXfn/iX9vhUyjqBs/0AKd7oEBs=;
        b=nhfNyeS2KxZtzLCKXh7Q/mC5AhcCIjlwjki3oBaz5iVnRc1B2PKCa+0/mur1FTkK7R
         6BvsXjoeXbAdnfBfSuT6j4qhWZNTUm/YyzLNZCVIGac7LJiUfrpFY4oVh36jJ1MxHqdC
         FQ6J0MhQudWhBG5wyyewx5eAmO0QD0KFo6nlV9FMHXh21tOmj2u3Lr6DqRvDk0GctoUC
         gJhAMEfg96EHRzIwKCXy24+jMQv9jFTZ9VifomI+/hnefTsTR6WEO2nJ8J1uSDdDGW1P
         RU8HxlK9INAPCYcC4r5FlUnJw+nP8tvKoIVYzBY1mgD+G2dEGz5vMcaMs18SQs9yF4v/
         p6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcErViLP1DIDDwbIDFXfn/iX9vhUyjqBs/0AKd7oEBs=;
        b=NL571BOy9llgZnFnNZ4SPGp6zCwLYDSvc2vJc3HE2HIBEbAxcQMSg6AInqQi0vxNM1
         iyHkrz8r9DWNuYjmeioaNtEuwRhzxXckX3wHorcTlTZKOwXWyMXw2roIUefrRH9liDrO
         uTjTrSJON152IPRMiWC2VDEvAMplCCodzslhy7eWq5Gu+Iqe6cSR78BgmeJCFB0+bTFc
         tkphsP21noNZnAsimmEW4CZt6i1+XU+K/RUHBJBE9dJ8hLTB9ngrYdWHFHnOE3m+UriV
         +jCNnrmEviQ4nMouYArxRGv7+IfBGqZDIyzUdjZmYw1K2SIw+JXsset7jqH9AISYoqiI
         8j4A==
X-Gm-Message-State: AOAM5336nPycZRrM7QVuHN7TQdP+CXLCydaZ91hbt/GDhN7cln8ooOY3
        EzzEL9+CKhfYiyupgiQNwJA=
X-Google-Smtp-Source: ABdhPJxHJi9jFiUY61AH0tju8mnlgPmv2hvOnwCogGTzZpToN7zk2nX5gUAlriEvo+wsCbYon5Vsxg==
X-Received: by 2002:a2e:908b:: with SMTP id l11mr1929554ljg.208.1638313816612;
        Tue, 30 Nov 2021 15:10:16 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id k14sm2099846lfu.210.2021.11.30.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:10:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] gpu/host1x: Add init/deinit callbacks to host1x driver framework
Date:   Wed,  1 Dec 2021 02:09:54 +0300
Message-Id: <20211130230957.30213-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130230957.30213-1-digetx@gmail.com>
References: <20211130230957.30213-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add init/deinit callbacks to host1x driver framework which allow to
perform early pre-initialization required by Tegra DRM driver.

Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/bus.c | 15 +++++++++++++++
 include/linux/host1x.h   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 0d81eede1217..25d688e5c742 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -479,8 +479,18 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
+	if (driver->init) {
+		err = driver->init(device);
+		if (err < 0) {
+			kfree(device);
+			return err;
+		}
+	}
+
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
+		if (driver->deinit)
+			driver->deinit(device);
 		kfree(device);
 		return err;
 	}
@@ -512,11 +522,16 @@ static int host1x_device_add(struct host1x *host1x,
 static void host1x_device_del(struct host1x *host1x,
 			      struct host1x_device *device)
 {
+	struct host1x_driver *driver = device->driver;
+
 	if (device->registered) {
 		device->registered = false;
 		device_del(&device->dev);
 	}
 
+	if (driver->deinit)
+		driver->deinit(device);
+
 	put_device(&device->dev);
 }
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e8dc5bc41f79..5e5ba33af4ae 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -346,6 +346,8 @@ struct host1x_device;
  * @driver: core driver
  * @subdevs: table of OF device IDs matching subdevices for this driver
  * @list: list node for the driver
+ * @init: called when the host1x logical driver is registered
+ * @deinit: called when the host1x logical driver is unregistered
  * @probe: called when the host1x logical device is probed
  * @remove: called when the host1x logical device is removed
  * @shutdown: called when the host1x logical device is shut down
@@ -356,6 +358,8 @@ struct host1x_driver {
 	const struct of_device_id *subdevs;
 	struct list_head list;
 
+	int (*init)(struct host1x_device *device);
+	void (*deinit)(struct host1x_device *device);
 	int (*probe)(struct host1x_device *device);
 	int (*remove)(struct host1x_device *device);
 	void (*shutdown)(struct host1x_device *device);
-- 
2.33.1

