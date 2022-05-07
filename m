Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A951E92B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446853AbiEGSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446805AbiEGSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:23:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF123054E
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 11:19:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so6133150wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i20ZoV0Dy7aIhximSqwDLxqvQZkpduCzRqaqQhDs+Gw=;
        b=kaeAxv8eQCkCyM/YsKefnviDP9GsVHb7/51955hWaPMeqjaXkbK/uyVclInXeCIUdE
         X8IXEo2iLyaRQragIBliJUttM3m9nzwxKVQiWuRmtv46zoTAxr+TSDhNPCDeGLBzpq1X
         49JcoOjn13VevVWcxYzJrKiK6peJgDk6R4HwUT1NR3m/lvWnFhUk8bsPpDQ1f9I7QBD2
         33LCxLFmevZNmxrucdGWpD9GNkaUtqTcfGH95is2ZEuijHlLJi2xWq6+Rv3EOoL7eK2c
         Wfthv4gIYltKPDkuCDjm9ROaxIFniVwE1HfbHBVyoPo58rw1q35dbgiELmS1saNmOgEZ
         oWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i20ZoV0Dy7aIhximSqwDLxqvQZkpduCzRqaqQhDs+Gw=;
        b=YjcRH+Shy5zWfrZf1cEz9JOPZVDUobPrbxTRkC6O0w0nmIPsgU5uIQSGSHSXaqkSrj
         BMLxbbIlvZtR1IvM+KEpVLm1lqlAVEl88xLZH2+R+Dq+wSFuvVB2ElSQZxbejGua1Bdf
         ZosAlIfZwbGLXM+Jd+b1ZCSFdkGYRbBVauSltkqaayhL5f2nHlbWqODMcUk/J+J3VIwO
         jTudt3v1DdQYHKf/YqQaw9UPVwUT0k0t6q7uKpNadlUTDIX4SBHJNml4VyuAmw85YNlT
         FdDAv1kQer5G6G0Lpi4WUxN1cfBgCAW5jD5sVvj7TWe09Zp4YHW4MJoZZnEXilmoVnqY
         jKJg==
X-Gm-Message-State: AOAM532uUCjUEyRI192imb72+EdxK4QC+OPDFa7ic+ylaTdJRK85kP2w
        R6UQyArAMEEWTieQH9foz+A=
X-Google-Smtp-Source: ABdhPJwPA0kb7aWDicLsLDhgAaPwApIyoCaRdYZ+eHdlC/fExsCO5IbDdRUI+wRMk84GSOATJZsaLQ==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id n2-20020a7bcbc2000000b00388faec2036mr9020942wmi.190.1651947568572;
        Sat, 07 May 2022 11:19:28 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0020c5253d8f3sm8198457wru.63.2022.05.07.11.19.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 11:19:27 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2 6/7] xen/grant-dma-ops: Retrieve the ID of backend's domain for DT devices
Date:   Sat,  7 May 2022 21:19:07 +0300
Message-Id: <1651947548-4055-7-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
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

Changes V1 -> V2:
   - remove dev_is_pci() check in xen_grant_setup_dma_ops()
   - remove EXPORT_SYMBOL_GPL(xen_is_grant_dma_device);
---
 drivers/xen/grant-dma-ops.c | 24 +++++++++++++++++-------
 include/xen/xen-ops.h       |  5 +++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 29ad7bf..8924178 100644
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
@@ -275,6 +270,15 @@ static const struct dma_map_ops xen_grant_dma_ops = {
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
+
 void xen_grant_setup_dma_ops(struct device *dev)
 {
 	struct xen_grant_dma_data *data;
@@ -286,8 +290,14 @@ void xen_grant_setup_dma_ops(struct device *dev)
 		return;
 	}
 
-	/* XXX The dom0 is hardcoded as the backend domain for now */
-	dev_domid = 0;
+	/* XXX ACPI device unsupported for now */
+	if (!dev->of_node)
+		goto err;
+
+	if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
+		dev_err(dev, "xen,dev-domid property is not present\n");
+		goto err;
+	}
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
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

