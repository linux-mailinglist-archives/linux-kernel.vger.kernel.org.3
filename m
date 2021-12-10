Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59B46FCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhLJIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:24:55 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32905 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhLJIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:24:53 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9P4J2ZHrzcdHC;
        Fri, 10 Dec 2021 16:21:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:21:18 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:21:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] amba: Cleanup amba pclk operation
Date:   Fri, 10 Dec 2021 16:31:28 +0800
Message-ID: <20211210083130.141784-2-wangkefeng.wang@huawei.com>
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

There is no user about amba_pclk_[un]prepare() besides pl330.c,
directly use clk_[un]prepare(). After this, all the function about
amba pclk operation, enable, disable, [un]prepare could be killed.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/dma/pl330.c      |  4 ++--
 include/linux/amba/bus.h | 20 --------------------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 110de8a60058..858400e42ec0 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2968,7 +2968,7 @@ static int __maybe_unused pl330_suspend(struct device *dev)
 	struct amba_device *pcdev = to_amba_device(dev);
 
 	pm_runtime_force_suspend(dev);
-	amba_pclk_unprepare(pcdev);
+	clk_unprepare(pcdev->pclk);
 
 	return 0;
 }
@@ -2978,7 +2978,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	struct amba_device *pcdev = to_amba_device(dev);
 	int ret;
 
-	ret = amba_pclk_prepare(pcdev);
+	ret = clk_prepare(pcdev->pclk);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index edfcf7a14dcd..609ee31760ed 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -127,26 +127,6 @@ struct amba_device *amba_find_device(const char *, struct device *, unsigned int
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
-static inline int amba_pclk_enable(struct amba_device *dev)
-{
-	return clk_enable(dev->pclk);
-}
-
-static inline void amba_pclk_disable(struct amba_device *dev)
-{
-	clk_disable(dev->pclk);
-}
-
-static inline int amba_pclk_prepare(struct amba_device *dev)
-{
-	return clk_prepare(dev->pclk);
-}
-
-static inline void amba_pclk_unprepare(struct amba_device *dev)
-{
-	clk_unprepare(dev->pclk);
-}
-
 /* Some drivers don't use the struct amba_device */
 #define AMBA_CONFIG_BITS(a) (((a) >> 24) & 0xff)
 #define AMBA_REV_BITS(a) (((a) >> 20) & 0x0f)
-- 
2.26.2

