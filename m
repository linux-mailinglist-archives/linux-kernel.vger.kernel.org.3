Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77E46FCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhLJIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:25:16 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15719 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhLJIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:25:15 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9P1f3ccdzZgH3;
        Fri, 10 Dec 2021 16:18:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:21:18 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:21:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] amba: kill amba_find_match()
Date:   Fri, 10 Dec 2021 16:31:29 +0800
Message-ID: <20211210083130.141784-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211210083130.141784-1-wangkefeng.wang@huawei.com>
References: <20211210083130.141784-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no one use amba_find_match(), kill it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c       | 61 ----------------------------------------
 include/linux/amba/bus.h |  1 -
 2 files changed, 62 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e1a5eca3ae3c..dd0ef65e5c3a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -669,66 +669,6 @@ void amba_device_unregister(struct amba_device *dev)
 	device_unregister(&dev->dev);
 }
 
-
-struct find_data {
-	struct amba_device *dev;
-	struct device *parent;
-	const char *busid;
-	unsigned int id;
-	unsigned int mask;
-};
-
-static int amba_find_match(struct device *dev, void *data)
-{
-	struct find_data *d = data;
-	struct amba_device *pcdev = to_amba_device(dev);
-	int r;
-
-	r = (pcdev->periphid & d->mask) == d->id;
-	if (d->parent)
-		r &= d->parent == dev->parent;
-	if (d->busid)
-		r &= strcmp(dev_name(dev), d->busid) == 0;
-
-	if (r) {
-		get_device(dev);
-		d->dev = pcdev;
-	}
-
-	return r;
-}
-
-/**
- *	amba_find_device - locate an AMBA device given a bus id
- *	@busid: bus id for device (or NULL)
- *	@parent: parent device (or NULL)
- *	@id: peripheral ID (or 0)
- *	@mask: peripheral ID mask (or 0)
- *
- *	Return the AMBA device corresponding to the supplied parameters.
- *	If no device matches, returns NULL.
- *
- *	NOTE: When a valid device is found, its refcount is
- *	incremented, and must be decremented before the returned
- *	reference.
- */
-struct amba_device *
-amba_find_device(const char *busid, struct device *parent, unsigned int id,
-		 unsigned int mask)
-{
-	struct find_data data;
-
-	data.dev = NULL;
-	data.parent = parent;
-	data.busid = busid;
-	data.id = id;
-	data.mask = mask;
-
-	bus_for_each_dev(&amba_bustype, NULL, &data, amba_find_match);
-
-	return data.dev;
-}
-
 /**
  *	amba_request_regions - request all mem regions associated with device
  *	@dev: amba_device structure for device
@@ -768,6 +708,5 @@ EXPORT_SYMBOL(amba_driver_register);
 EXPORT_SYMBOL(amba_driver_unregister);
 EXPORT_SYMBOL(amba_device_register);
 EXPORT_SYMBOL(amba_device_unregister);
-EXPORT_SYMBOL(amba_find_device);
 EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 609ee31760ed..7f5e8be62487 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -123,7 +123,6 @@ void amba_device_put(struct amba_device *);
 int amba_device_add(struct amba_device *, struct resource *);
 int amba_device_register(struct amba_device *, struct resource *);
 void amba_device_unregister(struct amba_device *);
-struct amba_device *amba_find_device(const char *, struct device *, unsigned int, unsigned int);
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
-- 
2.26.2

