Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9650BD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449934AbiDVQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449870AbiDVQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:54:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241215F8DF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y32so15294301lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FWaKUpxpKzKjbtSZ6ZKtWz+3C1vj9orKjhUr2xwY4lM=;
        b=hZs3izeCtmtt43a0UNm5IqmPSa6o2CTFdv4hT95HlTt8sq4U8H2GVbe8LO7gpfIx9P
         nUCA0BIFr8bWe4R+3Vx5F5V5bZlcVUxVU6cfKnoKPtW9fYpu4rM0I3NA6A9jDYVP/9eT
         5v6R6JbVvZdOMWrOceZlrUlagLbrTSPHZ85X9eWLHsTTCGbqBvoaWLAPWUgbs6Idby5s
         4LtwH2Lnu3gjEMNKSbuabCyQMifLdMh/r+T6OpIX4rBGG1FX/6XuNg2Nq2vJTPVMJqWK
         NdOH6K0tTIKQxd1NLk5+6LC7bTT/3ZCxi4f0143G79Y5OyjlhU1DkqwMqAELZuYMQgwV
         5rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FWaKUpxpKzKjbtSZ6ZKtWz+3C1vj9orKjhUr2xwY4lM=;
        b=LlqKv4YHT8o3XFKHlJw8awYPwkVEElwEpTgG1jgwsHnaUdZnTT8+MFhi5NOsX3Sii2
         pkyd0ulXWsMoi6FCfWwOC1v1ZtEjJv+msihAWorazt60nAAktsLxOgB6CaZk30DBBfhG
         dPawn/gOYWQDI3AbzSOboIczgoUjXunIY/pENtcQhme/pv2xriZQhCWoGZ2lYHWHPm+z
         ZPSKFCtvQ3jaWhGm8qJjhn0iX2cD45gxmVFEj7kh7QHZ/5EyCe6IejZnGW+zZ45Ek/xM
         rc+uIauPzkBEhAEt8uT5QCEbmEsfthfitNnfIQ+JG2VkL8PGAYM0xAX5/IIzRdi20cMB
         KEKQ==
X-Gm-Message-State: AOAM532nu7VRITAYC3h+pq7eV1yS+gRWhlqwgCfnbHHnUkcnIE8PGV2f
        3GICMm/duG89SAwVarFsDhE=
X-Google-Smtp-Source: ABdhPJw7+T0P6Ouxeu7dgpNbQZDF5EXBC/YTqVl/e4VxLwsPs+mJYBXNMvJhS0HMKIGJGQ32Omz2oQ==
X-Received: by 2002:a05:6512:3d14:b0:46b:81d9:b9ee with SMTP id d20-20020a0565123d1400b0046b81d9b9eemr3709015lfv.109.1650646286428;
        Fri, 22 Apr 2022 09:51:26 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n2-20020a056512310200b0046e2f507a3asm279742lfb.167.2022.04.22.09.51.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:51:26 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V1 6/6] arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices
Date:   Fri, 22 Apr 2022 19:51:03 +0300
Message-Id: <1650646263-22047-7-git-send-email-olekstysh@gmail.com>
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

As the main (and single at the moment) purpose of xen-grant
DMA devices is to enable using virtio devices in Xen guests
in a safe manner, assign xen-grant DMA ops only if restricted
access to the guest memory is enabled.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V1:
   - update commit subject/description
   - remove #ifdef CONFIG_XEN_VIRTIO
   - re-organize the check taking into the account that
     swiotlb and virtio cases are mutually exclusive
   - update according to the new naming scheme:
     s/virtio/grant_dma
---
 include/xen/arm/xen-ops.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
index 288deb1..26954e5 100644
--- a/include/xen/arm/xen-ops.h
+++ b/include/xen/arm/xen-ops.h
@@ -2,12 +2,17 @@
 #ifndef _ASM_ARM_XEN_OPS_H
 #define _ASM_ARM_XEN_OPS_H
 
+#include <linux/virtio_config.h>
 #include <xen/swiotlb-xen.h>
+#include <xen/xen-ops.h>
 
 static inline void xen_setup_dma_ops(struct device *dev)
 {
 #ifdef CONFIG_XEN
-	if (xen_swiotlb_detect())
+	if (arch_has_restricted_virtio_memory_access() &&
+			xen_is_grant_dma_device(dev))
+		xen_grant_setup_dma_ops(dev);
+	else if (xen_swiotlb_detect())
 		dev->dma_ops = &xen_swiotlb_dma_ops;
 #endif
 }
-- 
2.7.4

