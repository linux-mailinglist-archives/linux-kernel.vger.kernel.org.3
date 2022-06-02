Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778253BEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiFBTYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiFBTY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:24:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74BA260F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:24:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rq11so11849481ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNk74UaWLtQZL938Xxs3lBfmlvnA9FseeUHkafxECOY=;
        b=l5kSUmTyGQGXi74E515dldlWlFe3o08m4WJUZfONrAYROcSF48RNd1TEGdK3LNFW+s
         tHjQHCQNYLmJh9wphr3xZq+NVXxnGx3cH+ocoirkpGeSZ869Kup4B5xOfIsyusPe34JW
         fimV2t9ST7TGBac/fuJaEnuwygaZgZ26gqFiCY1muNWsRbEzGytMUMQZC+PpYHUU7H29
         PVza1L+tH2IrywKG2WMwfvahBQ9yUpDBlpQqq+UjuysWSRqg/fQRnKtJgG0s+bfA05tE
         a1K1tERwgCp1gamFt3ZSwmgs8FxhO+ttN+3bbIuzaXgPzMAYhqlnluJoFMc+67kQwS3r
         9Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iNk74UaWLtQZL938Xxs3lBfmlvnA9FseeUHkafxECOY=;
        b=vCA+zkOxYkhxrVteqxHhXRxtCsZNQpNxWFwBeUj+rnSulJVmnfxBgGOu6WZ8Xy37f+
         XE9H2BGyf63yHOR/JImDMsYUSJ/5hpmuZWXw9FlG5YgzydhZVHuzh7oJMi8W9rSUY1TM
         JiXH4ut8bojq4W999n/9MxPpN7shsEgjLv6iRHEpViI5oTlAGPY1GdcreVGnZdY3VsTk
         obApEeJH32Cfh6uI0cAz6E9SzKVz5pfaeq5MP5wuBRu1tWE6tiUX2ZolmVQoojEej+44
         9UffaN8WGPkZhlGY8qatnJ5g7W5NKph6t+5/gKMcoMGHVjrRhMMvFKRv8+4CxzTvmre7
         27dA==
X-Gm-Message-State: AOAM532moIy4uX6eiURu1w45GZlD0BItznQpLcp8vj+12LM1zr/MXkNK
        I3Mm1USNTGS6iF7NL43BBw0=
X-Google-Smtp-Source: ABdhPJwzZQbzIbCIFf3Pkn1ya1TGT8EEvSTk8i6RqQF4X2KAXdSL8hILlCy1w1gJmVJ7oRgwQh7H8w==
X-Received: by 2002:a17:906:d1cc:b0:709:567f:3506 with SMTP id bs12-20020a170906d1cc00b00709567f3506mr5538761ejb.363.1654197863445;
        Thu, 02 Jun 2022 12:24:23 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm2938301edb.13.2022.06.02.12.24.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:24:23 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V4 6/8] xen/grant-dma-iommu: Introduce stub IOMMU driver
Date:   Thu,  2 Jun 2022 22:23:51 +0300
Message-Id: <1654197833-25362-7-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

In order to reuse generic IOMMU device tree bindings by Xen grant
DMA-mapping layer we need to add this stub driver from a fw_devlink
perspective (grant-dma-ops cannot be converted into the proper
IOMMU driver).

Otherwise, just reusing IOMMU bindings (without having a corresponding
driver) leads to the deferred probe timeout afterwards, because
the IOMMU device never becomes available.

This stub driver does nothing except registering empty iommu_ops,
the upper layer "of_iommu" will treat this as NO_IOMMU condition
and won't return -EPROBE_DEFER.

As this driver is quite different from the most hardware IOMMU
implementations and only needed in Xen guests, place it in drivers/xen
directory. The subsequent commit will make use of it.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
According to the discussion at:
https://lore.kernel.org/xen-devel/c0f78aab-e723-fe00-a310-9fe52ec75e48@gmail.com/

Change V2 -> V3:
   - new patch

Changes V3 -> V4:
   - add Stefano's R-b
---
 drivers/xen/Kconfig           |  4 +++
 drivers/xen/Makefile          |  1 +
 drivers/xen/grant-dma-iommu.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 drivers/xen/grant-dma-iommu.c

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index a7bd8ce..35d20d9 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -335,6 +335,10 @@ config XEN_UNPOPULATED_ALLOC
 	  having to balloon out RAM regions in order to obtain physical memory
 	  space to create such mappings.
 
+config XEN_GRANT_DMA_IOMMU
+	bool
+	select IOMMU_API
+
 config XEN_GRANT_DMA_OPS
 	bool
 	select DMA_OPS
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 1a23cb0..c0503f1 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -40,3 +40,4 @@ xen-privcmd-y				:= privcmd.o privcmd-buf.o
 obj-$(CONFIG_XEN_FRONT_PGDIR_SHBUF)	+= xen-front-pgdir-shbuf.o
 obj-$(CONFIG_XEN_UNPOPULATED_ALLOC)	+= unpopulated-alloc.o
 obj-$(CONFIG_XEN_GRANT_DMA_OPS)		+= grant-dma-ops.o
+obj-$(CONFIG_XEN_GRANT_DMA_IOMMU)	+= grant-dma-iommu.o
diff --git a/drivers/xen/grant-dma-iommu.c b/drivers/xen/grant-dma-iommu.c
new file mode 100644
index 00000000..16b8bc0
--- /dev/null
+++ b/drivers/xen/grant-dma-iommu.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Stub IOMMU driver which does nothing.
+ * The main purpose of it being present is to reuse generic IOMMU device tree
+ * bindings by Xen grant DMA-mapping layer.
+ *
+ * Copyright (C) 2022 EPAM Systems Inc.
+ */
+
+#include <linux/iommu.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+struct grant_dma_iommu_device {
+	struct device *dev;
+	struct iommu_device iommu;
+};
+
+/* Nothing is really needed here */
+static const struct iommu_ops grant_dma_iommu_ops;
+
+static const struct of_device_id grant_dma_iommu_of_match[] = {
+	{ .compatible = "xen,grant-dma" },
+	{ },
+};
+
+static int grant_dma_iommu_probe(struct platform_device *pdev)
+{
+	struct grant_dma_iommu_device *mmu;
+	int ret;
+
+	mmu = devm_kzalloc(&pdev->dev, sizeof(*mmu), GFP_KERNEL);
+	if (!mmu)
+		return -ENOMEM;
+
+	mmu->dev = &pdev->dev;
+
+	ret = iommu_device_register(&mmu->iommu, &grant_dma_iommu_ops, &pdev->dev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, mmu);
+
+	return 0;
+}
+
+static int grant_dma_iommu_remove(struct platform_device *pdev)
+{
+	struct grant_dma_iommu_device *mmu = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	iommu_device_unregister(&mmu->iommu);
+
+	return 0;
+}
+
+static struct platform_driver grant_dma_iommu_driver = {
+	.driver = {
+		.name = "grant-dma-iommu",
+		.of_match_table = grant_dma_iommu_of_match,
+	},
+	.probe = grant_dma_iommu_probe,
+	.remove = grant_dma_iommu_remove,
+};
+
+static int __init grant_dma_iommu_init(void)
+{
+	struct device_node *iommu_np;
+
+	iommu_np = of_find_matching_node(NULL, grant_dma_iommu_of_match);
+	if (!iommu_np)
+		return 0;
+
+	of_node_put(iommu_np);
+
+	return platform_driver_register(&grant_dma_iommu_driver);
+}
+subsys_initcall(grant_dma_iommu_init);
-- 
2.7.4

