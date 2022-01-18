Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27997491303
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiARAvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiARAvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:51:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 16:51:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18so24040295wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eET614Qfg6W9qpxZ166TZNilIJMW9NHi2y7kBYgTJ/g=;
        b=KHECiTd/tpQ4q9K685cfKAMx/fo5xI4sNk8CYXhlXOLs+htyfujCbzYphrC2jTyP3i
         9ONwxf8DZ4mOKNad0FMNYLVCodDuG+fImCKiCEakI+Ei8uFfDDI6RMP5qhEfLhXWJiIe
         NBIGV+IX4am8kSc7HAIvf6ERbAb11bzdDIeSlG9D9icnAd8xVeFl24VD7EgMMiEM32VV
         8pHPdHf1YRvuRsY0rc4iQMRBGT0kHubn2yQIgy7y8bABzEH2YVQ0vN31X4RVuiWodXUt
         m6tRtJ5yj0h/Gg+GRA3A2Z7Ex7kNvOsQXFElXgib1A5Vi7IsAMiBuLVWQfkEDkTBeX/S
         tzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eET614Qfg6W9qpxZ166TZNilIJMW9NHi2y7kBYgTJ/g=;
        b=X2GHdBIQfem3MtEKHNlkrPVC+jjZ7Z2j8P6WkJj1frJFhOFMHMdfnlwPoUa3KJooj1
         zGPgGXB9z5zA06U2b8mhdbLAxQ+UGe5NFtaBpNJb5Y1wQikZYuEIpzPkpobIWmqJogQO
         63zAOwRaHnjqUomkJyY1Ydm9A1bLIdnSZiVpUK+4Xn1NVEL7XQrPqYyQOyP/A7J7JJI5
         gLnyxl//C6ehuUYK11Q0+LIt7dyIWULskmbenOcg9/kpqTm2hUE8KeXAUGipBiCwpTam
         iS1MrYSz7qlE9DwgwCjkadCHy5hqh2zD4ih+GY2qANDhHfAbP7DSnunPoZhCbs8L+jkl
         PkOg==
X-Gm-Message-State: AOAM530hVrhr7eKYqLOE5dw1mpSUa2djhl5rM+h5aQ+4zHo4PAUuZe69
        9LYTG6BeIVKCvf5rufz2dmq2Z3x+7b7JwxHF
X-Google-Smtp-Source: ABdhPJxsbmXqH2Tc8aB/dQ0VVIuGmoi5xH4cWG6TQYXhSnzF55fKapL06QP/D/eiTwZfs8WA1NW80A==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr21816849wrt.379.1642467101701;
        Mon, 17 Jan 2022 16:51:41 -0800 (PST)
Received: from pswork.fritz.box (i577BCEE6.versanet.de. [87.123.206.230])
        by smtp.gmail.com with ESMTPSA id l8sm832572wme.5.2022.01.17.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 16:51:41 -0800 (PST)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     linux-kernel@vger.kernel.org, mripard@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     emma@anholt.net, treasure4paddy@gmail.com,
        linux-rpi-kernel@lists.infradead.org
Subject: [PATCH] drm/vc4: Fix deadlock on DSI device attach error
Date:   Tue, 18 Jan 2022 01:51:26 +0100
Message-Id: <20220118005127.29015-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI device attach to DSI host will be done with host device's lock
held.

Un-registering host in "device attach" error path (ex: probe retry)
will result in deadlock with below call trace and non operational
DSI display.

Startup Call trace:
[   35.043036]  rt_mutex_slowlock.constprop.21+0x184/0x1b8
[   35.043048]  mutex_lock_nested+0x7c/0xc8
[   35.043060]  device_del+0x4c/0x3e8
[   35.043075]  device_unregister+0x20/0x40
[   35.043082]  mipi_dsi_remove_device_fn+0x18/0x28
[   35.043093]  device_for_each_child+0x68/0xb0
[   35.043105]  mipi_dsi_host_unregister+0x40/0x90
[   35.043115]  vc4_dsi_host_attach+0xf0/0x120 [vc4]
[   35.043199]  mipi_dsi_attach+0x30/0x48
[   35.043209]  tc358762_probe+0x128/0x164 [tc358762]
[   35.043225]  mipi_dsi_drv_probe+0x28/0x38
[   35.043234]  really_probe+0xc0/0x318
[   35.043244]  __driver_probe_device+0x80/0xe8
[   35.043254]  driver_probe_device+0xb8/0x118
[   35.043263]  __device_attach_driver+0x98/0xe8
[   35.043273]  bus_for_each_drv+0x84/0xd8
[   35.043281]  __device_attach+0xf0/0x150
[   35.043290]  device_initial_probe+0x1c/0x28
[   35.043300]  bus_probe_device+0xa4/0xb0
[   35.043308]  deferred_probe_work_func+0xa0/0xe0
[   35.043318]  process_one_work+0x254/0x700
[   35.043330]  worker_thread+0x4c/0x448
[   35.043339]  kthread+0x19c/0x1a8
[   35.043348]  ret_from_fork+0x10/0x20

Shutdown Call trace:
[  365.565417] Call trace:
[  365.565423]  __switch_to+0x148/0x200
[  365.565452]  __schedule+0x340/0x9c8
[  365.565467]  schedule+0x48/0x110
[  365.565479]  schedule_timeout+0x3b0/0x448
[  365.565496]  wait_for_completion+0xac/0x138
[  365.565509]  __flush_work+0x218/0x4e0
[  365.565523]  flush_work+0x1c/0x28
[  365.565536]  wait_for_device_probe+0x68/0x158
[  365.565550]  device_shutdown+0x24/0x348
[  365.565561]  kernel_restart_prepare+0x40/0x50
[  365.565578]  kernel_restart+0x20/0x70
[  365.565591]  __do_sys_reboot+0x10c/0x220
[  365.565605]  __arm64_sys_reboot+0x2c/0x38
[  365.565619]  invoke_syscall+0x4c/0x110
[  365.565634]  el0_svc_common.constprop.3+0xfc/0x120
[  365.565648]  do_el0_svc+0x2c/0x90
[  365.565661]  el0_svc+0x4c/0xf0
[  365.565671]  el0t_64_sync_handler+0x90/0xb8
[  365.565682]  el0t_64_sync+0x180/0x184

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index a229da58962a..9300d3354c51 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1262,7 +1262,6 @@ static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
 			       struct mipi_dsi_device *device)
 {
 	struct vc4_dsi *dsi = host_to_dsi(host);
-	int ret;
 
 	dsi->lanes = device->lanes;
 	dsi->channel = device->channel;
@@ -1297,18 +1296,15 @@ static int vc4_dsi_host_attach(struct mipi_dsi_host *host,
 		return 0;
 	}
 
-	ret = component_add(&dsi->pdev->dev, &vc4_dsi_ops);
-	if (ret) {
-		mipi_dsi_host_unregister(&dsi->dsi_host);
-		return ret;
-	}
-
-	return 0;
+	return component_add(&dsi->pdev->dev, &vc4_dsi_ops);
 }
 
 static int vc4_dsi_host_detach(struct mipi_dsi_host *host,
 			       struct mipi_dsi_device *device)
 {
+	struct vc4_dsi *dsi = host_to_dsi(host);
+
+	component_del(&dsi->pdev->dev, &vc4_dsi_ops);
 	return 0;
 }
 
@@ -1686,9 +1682,7 @@ static int vc4_dsi_dev_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct vc4_dsi *dsi = dev_get_drvdata(dev);
 
-	component_del(&pdev->dev, &vc4_dsi_ops);
 	mipi_dsi_host_unregister(&dsi->dsi_host);
-
 	return 0;
 }
 
-- 
2.17.1

