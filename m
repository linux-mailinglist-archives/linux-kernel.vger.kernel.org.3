Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8646FCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhLJIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:24:57 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29115 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhLJIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:24:54 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J9P1F6qmPz1DKM9;
        Fri, 10 Dec 2021 16:18:25 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
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
Subject: [PATCH 3/3] amba: Move EXPORT_SYMBOL() closer to definition
Date:   Fri, 10 Dec 2021 16:31:30 +0800
Message-ID: <20211210083130.141784-4-wangkefeng.wang@huawei.com>
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

Some EXPORT_SYMBOL() is at the end of the function, but some is
at the end of file. For reader sanity and be consistent, move all
EXPORT_SYMBOL() declarations just after the end of the function.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index dd0ef65e5c3a..d3bd14aaabf6 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -370,6 +370,7 @@ int amba_driver_register(struct amba_driver *drv)
 
 	return driver_register(&drv->drv);
 }
+EXPORT_SYMBOL(amba_driver_register);
 
 /**
  *	amba_driver_unregister - remove an AMBA device driver
@@ -383,7 +384,7 @@ void amba_driver_unregister(struct amba_driver *drv)
 {
 	driver_unregister(&drv->drv);
 }
-
+EXPORT_SYMBOL(amba_driver_unregister);
 
 static void amba_device_release(struct device *dev)
 {
@@ -642,6 +643,7 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 
 	return amba_device_add(dev, parent);
 }
+EXPORT_SYMBOL(amba_device_register);
 
 /**
  *	amba_device_put - put an AMBA device
@@ -668,6 +670,7 @@ void amba_device_unregister(struct amba_device *dev)
 {
 	device_unregister(&dev->dev);
 }
+EXPORT_SYMBOL(amba_device_unregister);
 
 /**
  *	amba_request_regions - request all mem regions associated with device
@@ -689,6 +692,7 @@ int amba_request_regions(struct amba_device *dev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(amba_request_regions);
 
 /**
  *	amba_release_regions - release mem regions associated with device
@@ -703,10 +707,4 @@ void amba_release_regions(struct amba_device *dev)
 	size = resource_size(&dev->res);
 	release_mem_region(dev->res.start, size);
 }
-
-EXPORT_SYMBOL(amba_driver_register);
-EXPORT_SYMBOL(amba_driver_unregister);
-EXPORT_SYMBOL(amba_device_register);
-EXPORT_SYMBOL(amba_device_unregister);
-EXPORT_SYMBOL(amba_request_regions);
 EXPORT_SYMBOL(amba_release_regions);
-- 
2.26.2

