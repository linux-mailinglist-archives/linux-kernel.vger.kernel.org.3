Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34D4AB6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiBGI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbiBGI5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:57:38 -0500
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:57:36 PST
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2B9C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:57:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644223341; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gG+FJQvKaASjk7IlHHZqKuO6suD3jNIio+39iUtRbjAmL3QwM6ZnNwY8hARonSZRzP0nhacGy7OCCgt7LMHCp7RB0F891FzGqOMQCo1NGNWcs/olBq/Dj6GLgwVN4fHZmOJmzYOqqaua3ExaeBzowQzZL/9EbSctunN+XDB/LD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644223341; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bHWu6qaqTeCTl3byxsc78TYWz+sAfdD4ZfBE7NU3VlM=; 
        b=gaEap2VAJsSLGxepaHAXG0MC/2ia1+jJQfse6Y078FzdhNc7caBJYCjUiIZ2Dk15gMmKUowPPYtiFd858JSqdBd8N3nhmkW2BqcjXTS8lu/PSiE9oCOEumVQ4Is03DgI8H3xjvyGAnT0J3N5tAxfojVOniFofZ4QuHTAWAo7OX8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644223341;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=bHWu6qaqTeCTl3byxsc78TYWz+sAfdD4ZfBE7NU3VlM=;
        b=CaVOp4/R1VNenkGLpNbbL2UumqzZ0aW1mFecCXUShg8hnYT1YJreHSkgCSTPKPvg
        FpShMoui1flHbAaAVDOn4pnmX4hGJaN1Ajz/4NNR9bFPSDb1g6mbH3zr1dXKMQ0TmU9
        qlOeuBOiet1GmOWMjfPfWG+7LnJNl9Tw9vwtc8to=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1644223339907434.297028008398; Mon, 7 Feb 2022 00:42:19 -0800 (PST)
Received: from  [45.80.185.188] by mail.zoho.com
        with HTTP;Mon, 7 Feb 2022 00:42:19 -0800 (PST)
Date:   Mon, 07 Feb 2022 03:42:19 -0500
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17ed3591d61.e124844b50297.8578687506451219143@zohomail.com>
In-Reply-To: <YfGN69H64acLNbtS@kroah.com>
References: <17e76f86155.1222b3923123229.7199263965880267375@zohomail.com>
 <17e7787698b.fb1a6d971174.8745566338649911775@zohomail.com> <YfGN69H64acLNbtS@kroah.com>
Subject: [PATCH V5] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>
Date: Thu, 20 Jan 2022 15:40:43 +0800
Subject: [PATCH v5] misc: pci_endpoint_test: simplify endpoint test read and
 write operations

Introduce pci_endpoint_epf_transfer_data to simplify
read and write operations.

Also tabify this file.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changes in V2:
fix WARNING: line length of 108 exceeds 100 columns
#128: FILE: drivers/misc/pci_endpoint_test.c:243:
Changes in V3:
This patch context doesn't change but resend with my Zoho mail account in that previous
company mail will contain un-removeable proprietary messages.
Changes in V4:
Add "From:" to the first line of the message body. 
Changes in V5:
tabify file
replace enum EPF_WRITE/EPF_READ with WRITE/READ from linux/kernel.h
get_random_bytes only when WRITE.

 drivers/misc/pci_endpoint_test.c | 310 ++++++++++++-------------------
 1 file changed, 118 insertions(+), 192 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2ed7e3aaff3a8..080239ae9601d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -84,7 +85,7 @@
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
-					    miscdev)
+						miscdev)
 
 static bool no_msi;
 module_param(no_msi, bool, 0444);
@@ -132,16 +133,119 @@ static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
 }
 
 static inline void pci_endpoint_test_writel(struct pci_endpoint_test *test,
-					    u32 offset, u32 value)
+						u32 offset, u32 value)
 {
 	writel(value, test->base + offset);
 }
 
 static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
-					      int bar, int offset)
+						  int bar, int offset)
 {
 	return readl(test->bar[bar] + offset);
 }
+static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
+				unsigned long arg, const int operation)
+{
+	struct pci_endpoint_test_xfer_param param;
+	bool ret = false;
+	u32 flags = 0;
+	bool use_dma;
+	void *addr;
+	dma_addr_t phys_addr;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	void *orig_addr;
+	dma_addr_t orig_phys_addr;
+	size_t offset;
+	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
+	size_t size;
+	int err;
+
+	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
+	if (err != 0) {
+		dev_err(dev, "Failed to get transfer param\n");
+		return false;
+	}
+
+	size = param.size;
+	if (size > SIZE_MAX - alignment)
+		goto err;
+
+	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
+	if (use_dma)
+		flags |= FLAG_USE_DMA;
+
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		goto err;
+	}
+
+	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
+	if (!orig_addr)
+		goto err;
+
+	if (operation == WRITE)
+		get_random_bytes(orig_addr, size + alignment);
+
+	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+					operation == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, orig_phys_addr)) {
+		dev_err(dev, "failed to map source buffer address\n");
+		goto err_phys_addr;
+	}
+
+	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
+		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
+		offset = phys_addr - orig_phys_addr;
+		addr = orig_addr + offset;
+	} else {
+		phys_addr = orig_phys_addr;
+		addr = orig_addr;
+	}
+
+	if (operation == WRITE) {
+
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
+				 crc32_le(~0, addr, size));
+
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
+								lower_32_bits(phys_addr));
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
+								upper_32_bits(phys_addr));
+	} else {
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
+								lower_32_bits(phys_addr));
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
+								upper_32_bits(phys_addr));
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	// if we ask rc to write to ep, then ep should do read operation, and vice versa.
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 operation == WRITE ? COMMAND_READ : COMMAND_WRITE);
+
+	wait_for_completion(&test->irq_raised);
+
+	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+					 operation == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	if (operation == WRITE)
+		ret = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS) & STATUS_READ_SUCCESS;
+	else
+		ret = crc32_le(~0, addr, size) ==
+			pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
+
+err_phys_addr:
+	kfree(orig_addr);
+
+err:
+	return ret;
+}
 
 static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
 						int bar, u32 offset, u32 value)
@@ -234,8 +338,8 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 
 	for (i = 0; i < test->num_irqs; i++) {
 		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
-				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, test->name, test);
+					   pci_endpoint_test_irqhandler,
+					   IRQF_SHARED, test->name, test);
 		if (err)
 			goto fail;
 	}
@@ -309,7 +413,7 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
 }
 
 static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
-				       u16 msi_num, bool msix)
+					   u16 msi_num, bool msix)
 {
 	u32 val;
 	struct pci_dev *pdev = test->pdev;
@@ -385,7 +489,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 	get_random_bytes(orig_src_addr, size + alignment);
 	orig_src_phys_addr = dma_map_single(dev, orig_src_addr,
-					    size + alignment, DMA_TO_DEVICE);
+						size + alignment, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, orig_src_phys_addr)) {
 		dev_err(dev, "failed to map source buffer address\n");
 		ret = false;
@@ -417,7 +521,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	}
 
 	orig_dst_phys_addr = dma_map_single(dev, orig_dst_addr,
-					    size + alignment, DMA_FROM_DEVICE);
+						size + alignment, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, orig_dst_phys_addr)) {
 		dev_err(dev, "failed to map destination buffer address\n");
 		ret = false;
@@ -471,193 +575,15 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 }
 
 static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
-				    unsigned long arg)
+					unsigned long arg)
 {
-	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
-	u32 flags = 0;
-	bool use_dma;
-	u32 reg;
-	void *addr;
-	dma_addr_t phys_addr;
-	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
-	void *orig_addr;
-	dma_addr_t orig_phys_addr;
-	size_t offset;
-	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
-	size_t size;
-	u32 crc32;
-	int err;
-
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err != 0) {
-		dev_err(dev, "Failed to get transfer param\n");
-		return false;
-	}
-
-	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
-
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
-		flags |= FLAG_USE_DMA;
-
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
-	if (!orig_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		ret = false;
-		goto err;
-	}
-
-	get_random_bytes(orig_addr, size + alignment);
-
-	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
-					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
-		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
-		goto err_phys_addr;
-	}
-
-	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
-		phys_addr =  PTR_ALIGN(orig_phys_addr, alignment);
-		offset = phys_addr - orig_phys_addr;
-		addr = orig_addr + offset;
-	} else {
-		phys_addr = orig_phys_addr;
-		addr = orig_addr;
-	}
-
-	crc32 = crc32_le(~0, addr, size);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
-				 crc32);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
-				 lower_32_bits(phys_addr));
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
-				 upper_32_bits(phys_addr));
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_READ);
-
-	wait_for_completion(&test->irq_raised);
-
-	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (reg & STATUS_READ_SUCCESS)
-		ret = true;
-
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
-			 DMA_TO_DEVICE);
-
-err_phys_addr:
-	kfree(orig_addr);
-
-err:
-	return ret;
+	return pci_endpoint_test_transfer_data(test, arg, WRITE);
 }
 
 static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
-	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
-	u32 flags = 0;
-	bool use_dma;
-	size_t size;
-	void *addr;
-	dma_addr_t phys_addr;
-	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
-	void *orig_addr;
-	dma_addr_t orig_phys_addr;
-	size_t offset;
-	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
-	u32 crc32;
-	int err;
-
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err) {
-		dev_err(dev, "Failed to get transfer param\n");
-		return false;
-	}
-
-	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
-
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
-		flags |= FLAG_USE_DMA;
-
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
-	if (!orig_addr) {
-		dev_err(dev, "Failed to allocate destination address\n");
-		ret = false;
-		goto err;
-	}
-
-	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
-					DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
-		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
-		goto err_phys_addr;
-	}
-
-	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
-		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
-		offset = phys_addr - orig_phys_addr;
-		addr = orig_addr + offset;
-	} else {
-		phys_addr = orig_phys_addr;
-		addr = orig_addr;
-	}
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
-				 lower_32_bits(phys_addr));
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
-				 upper_32_bits(phys_addr));
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_WRITE);
-
-	wait_for_completion(&test->irq_raised);
-
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
-			 DMA_FROM_DEVICE);
-
-	crc32 = crc32_le(~0, addr, size);
-	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
-		ret = true;
-
-err_phys_addr:
-	kfree(orig_addr);
-err:
-	return ret;
+	return pci_endpoint_test_transfer_data(test, arg, READ);
 }
 
 static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
@@ -668,7 +594,7 @@ static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
 }
 
 static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
-				      int req_irq_type)
+					  int req_irq_type)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
@@ -698,7 +624,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 }
 
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
-				    unsigned long arg)
+					unsigned long arg)
 {
 	int ret = -EINVAL;
 	enum pci_barno bar;
@@ -793,7 +719,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	mutex_init(&test->mutex);
 
 	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
 		dev_err(dev, "Cannot set DMA mask\n");
 		return -EINVAL;
 	}
-- 
2.34.1


