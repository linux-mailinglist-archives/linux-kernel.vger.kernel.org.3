Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C495B538876
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbiE3VBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbiE3VAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:00:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873991587
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id l13so18380314lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQkUP6MgBXfhQ5VQQiDmITT3o08NX2ApOUY4yVu0jYM=;
        b=WLuL7ZtX5S8Xv18ibuMJgTR4erb8ZpBPwNgQjlFbayW2zb7WwwtgSMG27xiOGDSuJU
         t3lH3KrC8K70XpuiQssk+JCUs7nV1C8qMvmu8GlbQCB3xSYoXmR1M9Nc9ufsXuvW3mt8
         DcY1/w/Hb6/YJG9Pju/b6NXDE8mDx7CA1G34ytNlbfUOCgdrkPf5e4eXIlWwv3Xot55x
         DKst6rZ2pt6JGpbxpAvA0SSPeOxYJ+q8Sa5fJiNmTLPUU6dn+b6+knXi3gy13ShQJKIl
         L9fiy2/l6/vfejfMGqzPvpcOzOJB79MdCDHNA8coqTK66MvgzAEG1v1LjKcoQX2Km6to
         8aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQkUP6MgBXfhQ5VQQiDmITT3o08NX2ApOUY4yVu0jYM=;
        b=ox+bosfZTtSt5qWycvfeD0LNe4wWtf0/wiL23OkbDXtAnMQuk4G7Py63I7WclLIQvH
         ob4/zAMJ5UdObH+VJjHbZrKdmI3/dpU29n3Y64ApiKr1ZMgN1flKIkh2IoILI7XvgGNw
         +yAumAwfXm/SsZJXr2/tmJN+TXgRrm3biMCKuq/MCL7MbTxNIjDNBsaI87j6rSZv+tiY
         qGYJb23a52jhQQgYtZHiKWbBS3/a4+kMNwTbaYnGYCu3KSwvkqoEGI/RuUKA1HisS4st
         qvbFlGWMx/XuDxqOwAE4xO9XMPr+oGrLNXp4jiOSfJXBOJGMS6udhXQlo2FdaI/HvLDO
         ouNA==
X-Gm-Message-State: AOAM533Qu/TaE1rgBL4Ksb7umiVPYtFI6XpEFSob2rpDoA/N4XV5L9Vu
        ce1simM/rYKybKM0ZJXNOX0=
X-Google-Smtp-Source: ABdhPJyrEsxXy8rP0N5pXydrCG2JHswyhigBj0VPDBjmiPYCC6mscekUcRxdjLumVRMb+YbKh8/HBA==
X-Received: by 2002:a05:6512:108a:b0:478:68e8:adce with SMTP id j10-20020a056512108a00b0047868e8adcemr31174023lfg.617.1653944432306;
        Mon, 30 May 2022 14:00:32 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0025550e2693asm581541ljm.38.2022.05.30.14.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 14:00:31 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 6/8] xen/grant-dma-iommu: Introduce stub IOMMU driver
Date:   Tue, 31 May 2022 00:00:15 +0300
Message-Id: <1653944417-17168-7-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
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
---
According to the discussion at:
https://lore.kernel.org/xen-devel/c0f78aab-e723-fe00-a310-9fe52ec75e48@gmail.com/

Change V2 -> V3:
   - new patch
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

