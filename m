Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904650BD9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449899AbiDVQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449881AbiDVQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:54:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C85F8E6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w1so15284325lfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhuPWU8Ck/Zqwd8QYGNbplUi9vy17AnQZagSCJ37QGk=;
        b=NOb0zaTNkpTy3DsQIPg0dlh0OMrNEZEmtlKznw8XqFpcusEUdvVM6zMbTVNhxDwSXb
         9s37u6+satXYoHdp9aa7oR59besAWm0FyfFiy6XEjvSmmpgqVORyHmPjGB9ycHQDJJWY
         NhBHK5PmSgHWKDXsrY1o7I3msHW/lE2r8fRLPkm+huQTPVs0JPTel+isPlp+aKY9PECA
         TgXI2IbEGgOzT7qwLsqu/TyulQid0mXcPa7j9ZtTDusbzC4o3xYvxYVruqLq6WimAnlD
         NuIvwpd8kt/kRI2bBQnCc3VInK9vHaSdv0v4tgUnpJpgPie2NhI61zNXsHV+nBAVrH8s
         y7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KhuPWU8Ck/Zqwd8QYGNbplUi9vy17AnQZagSCJ37QGk=;
        b=hxUz2Fax+Gs4jzDr4mQTcN05Tyxg68Dkrnq1f5JpAIEdVrPuaS23LVpuqCK3u0dfTg
         D2vu46L1cGCZ35yY27RFh06Pd9DZ59L/s2E8UoEx8kp62EhZ/n/FaM2m839fcw9Wj3GC
         Pldm1/vxfhdT2zTz4oaDr27gUUyK15T/7ZpqBeF/VJmBb2NwNZxFdOvCI9ZRmC5DOvPt
         3veGEt1ua3DjbE45L7HcQW+1aQ5sO//hutSZCa9Qpm7LNF6TaF3Gl8mHkqhkyNi53aJb
         tGMExckg3B2C5HbAlmWqPmLGYE18TlrHXhADGWaA2SXfO5U3bKUIlXh5MRm4dRNeo/9a
         DzlA==
X-Gm-Message-State: AOAM5309vJjET6ibWAfb8f44gO+14Y3ZhIQHFOoSppW12WJGwsNaq6Gn
        GVuF5dnPi/VTYs0SFo4H4r7lFzB69yo=
X-Google-Smtp-Source: ABdhPJwYOQYW+DLtmEipeBoU8JAOfR2j+jhgl2CJGFYZXuwNwDTvK1p0Ec2CwRYofuAFV0Wcslpcwg==
X-Received: by 2002:ac2:4e95:0:b0:471:ee3b:6534 with SMTP id o21-20020ac24e95000000b00471ee3b6534mr808665lfr.291.1650646285373;
        Fri, 22 Apr 2022 09:51:25 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n2-20020a056512310200b0046e2f507a3asm279742lfb.167.2022.04.22.09.51.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:51:24 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V1 5/6] xen/grant-dma-ops: Retrieve the ID of backend's domain for DT devices
Date:   Fri, 22 Apr 2022 19:51:02 +0300
Message-Id: <1650646263-22047-6-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Use the presence of recently introduced "xen,dev-domid" property
in the device node as a clear indicator of enabling Xen grant
mappings scheme for that device and read the ID of Xen domain where
the corresponding backend resides. The ID (domid) is used as
an argument to the Xen grant mapping APIs.

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
---
 drivers/xen/grant-dma-ops.c | 25 ++++++++++++++++++-------
 include/xen/xen-ops.h       |  5 +++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 0e69aa8..70d5d77 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -66,11 +66,6 @@ static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
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
@@ -277,6 +272,16 @@ static const struct dma_map_ops xen_grant_dma_ops = {
 	.dma_supported = xen_grant_dma_supported,
 };
 
+bool xen_is_grant_dma_device(struct device *dev)
+{
+	/* XXX Handle only DT devices for now */
+	if (!dev->of_node)
+		return false;
+
+	return of_property_read_bool(dev->of_node, "xen,dev-domid");
+}
+EXPORT_SYMBOL_GPL(xen_is_grant_dma_device);
+
 void xen_grant_setup_dma_ops(struct device *dev)
 {
 	struct xen_grant_dma_data *data;
@@ -288,8 +293,14 @@ void xen_grant_setup_dma_ops(struct device *dev)
 		return;
 	}
 
-	/* XXX The dom0 is hardcoded as the backend domain for now */
-	dev_domid = 0;
+	/* XXX ACPI and PCI devices unsupported for now */
+	if (dev_is_pci(dev) || !dev->of_node)
+		goto err;
+
+	if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
+		dev_err(dev, "xen,dev-domid property is not present\n");
+		goto err;
+	}
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
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

