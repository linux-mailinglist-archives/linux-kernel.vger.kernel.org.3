Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC2538871
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiE3VBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiE3VBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:01:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E1915AA
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 1so12721576ljp.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQ1JH7AWAJHsRRYFQY27acyYSyJWPZ/cZSwuKE03m9M=;
        b=F3Dp/1RfYd/CNOWtpufTjQ5KG1C/SjG2GTXBdmAnmkIZmIISp6swxVs8EtEn+CBphf
         bJoFFuN+PnP5FTSwKK7r/G8qOeglHY3GL5o10B5kKyNI3lbYT2QRFbJMxi4Am+JQI3ZN
         ehlzziC+FS40xWH5CO/plPfSgnEkPRbzN/ZpEuxVsyac3aY0NmGhhav6DE7ZZk3YYLiZ
         NIBnVA7VpoQLIsLbKcRgByxkCjJh6t4jRaz3uUTAJF0JG+Zo5N5/KlXzqzM6ILBj7ile
         v0bUG3G8bfZR3IgtGMst1ql3DwP8EUrB62vK7C0on5gaI+gMR/yHkjGBuGFC74oT++mK
         ISEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQ1JH7AWAJHsRRYFQY27acyYSyJWPZ/cZSwuKE03m9M=;
        b=7oiycXuoU/QTkkxNXDqwjvEFi9hZHgFylelN+BkKrtY3CDBGigDFW2t5vth8z8fKKR
         D1HipESFzr54gpyucdb9MCLq0oDFiGRdL4e0A0cEF7oul+YjAiXUdeMsa+TmoiXfkjwH
         KrY6GzY2CwnveIRCDG++dYyXSPBj95z7IEojOjwV0vj3jLO6A3Goku/wW17oBVfJnZlG
         h342UCFUWIlhpeNNvPERmF8e7Egh6Yj2BhuTBWGCeZWbn5ZV65UBxiAoiAC90+E0SWP7
         5gp+qlITfv8n9V0PupZXihP1MtpGtZtEthxTWBrJ++tqZFhb6H7CV+FGUr3Z8wpFoJxE
         I9Vw==
X-Gm-Message-State: AOAM5337W0gvj2oJ/W7rvbbsa0CdzslQVZAdNaoeXubN5TuP65RemBhI
        KNvDaFo+qMXAv0S3d1uR9UA=
X-Google-Smtp-Source: ABdhPJwO1sx6nXB3yQvX6BxgfoZrQPM9WyfnZcUaKJhUw7Qhdh1gVI5p09PHodbZD/CPwbZDBCk3cg==
X-Received: by 2002:a2e:b88d:0:b0:253:ee2a:6b70 with SMTP id r13-20020a2eb88d000000b00253ee2a6b70mr22917522ljp.247.1653944433394;
        Mon, 30 May 2022 14:00:33 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0025550e2693asm581541ljm.38.2022.05.30.14.00.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 14:00:33 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 7/8] xen/grant-dma-ops: Retrieve the ID of backend's domain for DT devices
Date:   Tue, 31 May 2022 00:00:16 +0300
Message-Id: <1653944417-17168-8-git-send-email-olekstysh@gmail.com>
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

Use the presence of "iommus" property pointed to the IOMMU node with
recently introduced "xen,grant-dma" compatible as a clear indicator
of enabling Xen grant mappings scheme for that device and read the ID
of Xen domain where the corresponding backend is running. The domid
(domain ID) is used as an argument to the Xen grant mapping APIs.

To avoid the deferred probe timeout which takes place after reusing
generic IOMMU device tree bindings (because the IOMMU device never
becomes available) enable recently introduced stub IOMMU driver by
selecting XEN_GRANT_DMA_IOMMU.

Also introduce xen_is_grant_dma_device() to check whether xen-grant
DMA ops need to be set for a passed device.

Remove the hardcoded domid 0 in xen_grant_setup_dma_ops().

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V1:
   - new patch, split required changes from commit:
    "[PATCH 4/6] virtio: Various updates to xen-virtio DMA ops layer"
   - update checks in xen_virtio_setup_dma_ops() to only support
     DT devices for now
   - remove the "virtio,mmio" check from xen_is_virtio_device()
   - remane everything according to the new naming scheme:
     s/virtio/grant_dma

Changes V1 -> V2:
   - remove dev_is_pci() check in xen_grant_setup_dma_ops()
   - remove EXPORT_SYMBOL_GPL(xen_is_grant_dma_device);

Changes V2 -> V3:
   - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
   - update commit description
   - reuse generic IOMMU device tree bindings, select XEN_GRANT_DMA_IOMMU
     to avoid the deferred probe timeout
---
 drivers/xen/Kconfig         |  1 +
 drivers/xen/grant-dma-ops.c | 48 ++++++++++++++++++++++++++++++++++++++-------
 include/xen/xen-ops.h       |  5 +++++
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 35d20d9..bfd5f4f 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -347,6 +347,7 @@ config XEN_VIRTIO
 	bool "Xen virtio support"
 	depends on VIRTIO
 	select XEN_GRANT_DMA_OPS
+	select XEN_GRANT_DMA_IOMMU if OF
 	help
 	  Enable virtio support for running as Xen guest. Depending on the
 	  guest type this will require special support on the backend side
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 44659f4..6586152 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -55,11 +55,6 @@ static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
  * Such a DMA address is formed by using the grant reference as a frame
  * number and setting the highest address bit (this bit is for the backend
  * to be able to distinguish it from e.g. a mmio address).
- *
- * Note that for now we hard wire dom0 to be the backend domain. In order
- * to support any domain as backend we'd need to add a way to communicate
- * the domid of this backend, e.g. via Xenstore, via the PCI-device's
- * config space or DT/ACPI.
  */
 static void *xen_grant_dma_alloc(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
@@ -275,9 +270,26 @@ static const struct dma_map_ops xen_grant_dma_ops = {
 	.dma_supported = xen_grant_dma_supported,
 };
 
+bool xen_is_grant_dma_device(struct device *dev)
+{
+	struct device_node *iommu_np;
+	bool has_iommu;
+
+	/* XXX Handle only DT devices for now */
+	if (!dev->of_node)
+		return false;
+
+	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
+	has_iommu = iommu_np && of_device_is_compatible(iommu_np, "xen,grant-dma");
+	of_node_put(iommu_np);
+
+	return has_iommu;
+}
+
 void xen_grant_setup_dma_ops(struct device *dev)
 {
 	struct xen_grant_dma_data *data;
+	struct of_phandle_args iommu_spec;
 
 	data = find_xen_grant_dma_data(dev);
 	if (data) {
@@ -285,12 +297,34 @@ void xen_grant_setup_dma_ops(struct device *dev)
 		return;
 	}
 
+	/* XXX ACPI device unsupported for now */
+	if (!dev->of_node)
+		goto err;
+
+	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
+			0, &iommu_spec)) {
+		dev_err(dev, "Cannot parse iommus property\n");
+		goto err;
+	}
+
+	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
+			iommu_spec.args_count != 1) {
+		dev_err(dev, "Incompatible IOMMU node\n");
+		of_node_put(iommu_spec.np);
+		goto err;
+	}
+
+	of_node_put(iommu_spec.np);
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		goto err;
 
-	/* XXX The dom0 is hardcoded as the backend domain for now */
-	data->backend_domid = 0;
+	/*
+	 * The endpoint ID here means the ID of the domain where the corresponding
+	 * backend is running
+	 */
+	data->backend_domid = iommu_spec.args[0];
 
 	if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
 			GFP_KERNEL))) {
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 4f9fad5..62be9dc 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -223,10 +223,15 @@ static inline void xen_preemptible_hcall_end(void) { }
 
 #ifdef CONFIG_XEN_GRANT_DMA_OPS
 void xen_grant_setup_dma_ops(struct device *dev);
+bool xen_is_grant_dma_device(struct device *dev);
 #else
 static inline void xen_grant_setup_dma_ops(struct device *dev)
 {
 }
+static inline bool xen_is_grant_dma_device(struct device *dev)
+{
+	return false;
+}
 #endif /* CONFIG_XEN_GRANT_DMA_OPS */
 
 #endif /* INCLUDE_XEN_OPS_H */
-- 
2.7.4

