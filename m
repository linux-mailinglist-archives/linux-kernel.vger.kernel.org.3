Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE757030D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiGKMoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiGKMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:54 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B76302
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657542513; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BWLMC3it4BtPyJWYDoPgYKmbLqEhQRxv8s3RJ9kVzUq4qSI3Se1FWX6GzIcNcUQyYwPw5MwzLU3Lt+4A2Y2KLof2kHNvZ/TaGNRptdXyiv5OSs4IFQDxHO0zHG4xT5fEMhVDp2U5LmP3sF3Ah0dgo8POju7SL3GZBzVm0DwnP8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657542513; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/45RwWvpZQ8gxiW9JTrbUVV5LljPR1ktHOujlwlnKxQ=; 
        b=mr/8H1PKbsemg6iuOktY9uH9bIO4L2xoejQBtu3J6xBCmTUVVqm5akq2/PUJNfCZEdPPquqMTLk9LYIt6L/G3ctrpuk+kNmRJ8OmO6t7fBxwWhOcKMvKK6/MSdeGJipFvolMPDc0J1iFF9SnR0/lfyKp6QllbiaiCSWF0C3OqD4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657542513;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=/45RwWvpZQ8gxiW9JTrbUVV5LljPR1ktHOujlwlnKxQ=;
        b=NN43XqsWrzBzau+jKqb4vYqFipSvenjZhL4yn+DPsre33ZTgav2bIdy0QYA6N8rU
        oNotCfkx7vY9ndsfCNxE+pgGJfoOkxJSqJ34oRF3MWJuTQ2HBYanF+XR0SiEGj69Yg5
        N3UGyfNPfQFxA+OJGzZH4WcxXRB28kWFRk+MtFWc=
Received: from sh-lchen.ambarella.net (180.169.129.130 [180.169.129.130]) by mx.zohomail.com
        with SMTPS id 1657542511621198.9230621815609; Mon, 11 Jul 2022 05:28:31 -0700 (PDT)
From:   Li Chen <me@linux.beauty>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct page and dio support to no-map rmem
Date:   Mon, 11 Jul 2022 20:24:54 +0800
Message-Id: <20220711122459.13773-5-me@linux.beauty>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711122459.13773-1-me@linux.beauty>
References: <20220711122459.13773-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

This sample driver shows how to build struct pages support to no-map rmem.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: Ie78494fa86fda40ceb73eab3b8ba505d0ad851a1
---
 samples/Kconfig                 |   7 ++
 samples/Makefile                |   1 +
 samples/reserved_mem/Makefile   |   2 +
 samples/reserved_mem/rmem_dio.c | 116 ++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100755 samples/reserved_mem/Makefile
 create mode 100755 samples/reserved_mem/rmem_dio.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b0503ef058d3..d83ba02ec215 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -6,6 +6,13 @@ menuconfig SAMPLES
 
 if SAMPLES
 
+config RESERVED_MEM_DIO
+	tristate "Build example reserved mem dio support"
+	depends on OF_RESERVED_MEM_DIO_SUPPORT
+	help
+	   Build kernel space sample module to show how to add struct
+		 page and dio support to reserved memory.
+
 config SAMPLE_AUXDISPLAY
 	bool "auxdisplay sample"
 	depends on CC_CAN_LINK
diff --git a/samples/Makefile b/samples/Makefile
index 087e0988ccc5..106a386869eb 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux samples code
 
+obj-$(CONFIG_RESERVED_MEM_DIO)		+= reserved_mem/
 subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
diff --git a/samples/reserved_mem/Makefile b/samples/reserved_mem/Makefile
new file mode 100755
index 000000000000..a4f5c8bc08dc
--- /dev/null
+++ b/samples/reserved_mem/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_RESERVED_MEM_DIO) += rmem_dio.o
diff --git a/samples/reserved_mem/rmem_dio.c b/samples/reserved_mem/rmem_dio.c
new file mode 100755
index 000000000000..ffb3395de63c
--- /dev/null
+++ b/samples/reserved_mem/rmem_dio.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sample driver for reserved memory with struct page and dio support.
+ *
+ * wsps is abbr for with struct page support
+ *
+ * Copyright (C) 2022 Li Chen <lchen@ambarella.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/cdev.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+
+/*
+ * dts example
+ * rmem: rmem@1 {
+ *			compatible = "shared-dma-pool";
+ *			no-map;
+ *			size = <0x0 0x20000000>;
+ *		};
+ * perf {
+ *		compatible = "example,rmem";
+ *		memory-region = <&rmem>;
+ *	};
+ */
+
+static struct reserved_mem *rmem;
+
+static int rmem_wsps_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int rmem_wsps_release(struct inode *inode,
+					  struct file *filp)
+{
+	return 0;
+}
+
+static int rmem_wsps_mmap(struct file *file,
+					     struct vm_area_struct *vma)
+{
+	return reserved_mem_dio_mmap(file, vma, rmem);
+}
+
+static const struct file_operations rmem_wsps_remap_ops = {
+	.owner = THIS_MODULE,
+	.open = rmem_wsps_open,
+	.release = rmem_wsps_release,
+	.mmap = rmem_wsps_mmap,
+};
+
+static struct miscdevice rmem_wsps_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "rmem_wsps",
+	.fops = &rmem_wsps_remap_ops,
+};
+
+static int rmem_wsps_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void *vaddr;
+	int ret;
+
+	ret = misc_register(&rmem_wsps_miscdev);
+	if (ret) {
+		dev_err(dev, "%s: misc_register failed, %d\n", __func__, ret);
+		return -ENODEV;
+	}
+
+	rmem = get_reserved_mem_from_dev(dev);
+	if (!rmem) {
+		dev_err(dev, "%s: failed to find reserved\n", __func__);
+		return -ENODEV;
+	}
+
+	vaddr = reserved_mem_memremap_pages(dev, rmem);
+	if (IS_ERR_OR_NULL(vaddr))
+		return PTR_ERR(vaddr);
+
+	return 0;
+}
+
+static const struct of_device_id rmem_dio_match[] = {
+	{
+		.compatible = "example,rmem",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rmem_dio_match);
+
+static struct platform_driver rmem_wsps_driver = {
+	.probe = rmem_wsps_probe,
+	.driver = {
+		.name = "rmem_wsps",
+		.of_match_table = rmem_dio_match,
+	},
+};
+
+static int __init rmem_wsps_init(void)
+{
+	return platform_driver_register(&rmem_wsps_driver);
+}
+
+module_init(rmem_wsps_init);
+MODULE_LICENSE("GPL");
-- 
2.25.1

