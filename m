Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4564253BEC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiFBTYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiFBTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:24:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9AB2DCD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:24:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id q1so11817780ejz.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1vkkmAPV7KLk5lLiYTidlJE/79j9EHin+NPAEwFGGPw=;
        b=jmz6IGbzJezrRiTA2mBa10TijR6VR0Wsv+zWCJK861wll6nY+yQF0eqIKkBS5xRnY3
         06uO1Xxv/f6WxMrF7ZyLzMMJpLL7T61a9BflqTJ5BPHI2FF2yaJJHfW/bvUVTWX/bfjV
         TROS8lfNzLEEAzJE9nYscufoMwjo6IO6XfMO3atpb5xGlgWq24wpMqelyhVadYrVknNw
         V4Dfqy8uPCBCPMqt8EIVIXfDHx1hVqeQ4NxiznFjv2NBcgYhlvr/UPQpIcO2wVH5JkM0
         oetd2/yrhmoOzPa4PebgUEMktci6Q0lz4PC7beZD+tIq3arTBN3tTXxehvdl7SduyR5Q
         8frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1vkkmAPV7KLk5lLiYTidlJE/79j9EHin+NPAEwFGGPw=;
        b=FgNBZ97dYaxOQpqO1UaclcsljLfk3N3rn+BgCk8gRMXgflzPbmzarcBSFny+2e14KX
         3XtzFfVChYIRORkD8ovfmfEQet91g4B5Qez8siSzBXtIsBG5Bw/2nFQ1PNinGDhbJvi/
         ceI7y8CCqATnrX1XQjlDwNQj9DOBWNJC0tL/kAsI99TU8cu4MIJ3922Z0EACVgfcQPuc
         0ouk+tHfVNEeeZ61lgu8trqQuAmstJCNmerYj1hTueVs5TEgiSv1PDNXRv7cF/3Pii0x
         GTsqurBxI+Y+pIPVmjovj1fJTDDygLTck0pOniH6/SJHLKU5efLtj+ysSQQ8uhugPCwx
         4eAw==
X-Gm-Message-State: AOAM531il5F9sg46BwX5ZS/noPQbFz8f0ipz9mPbRZU183uxuTbn0ZWr
        q8RCtr44QYl6wX13050qx8c=
X-Google-Smtp-Source: ABdhPJzV8VoTn9s996wPN+vTdvWiSQPgr/k13Tl/xR8W22maSDMF8OZr0DW6z0mMDrujt2w9yOf1MQ==
X-Received: by 2002:a17:907:7f20:b0:6fe:f0c8:8e6f with SMTP id qf32-20020a1709077f2000b006fef0c88e6fmr5510662ejc.453.1654197865496;
        Thu, 02 Jun 2022 12:24:25 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm2938301edb.13.2022.06.02.12.24.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:24:25 -0700 (PDT)
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
Subject: [PATCH V4 8/8] arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices
Date:   Thu,  2 Jun 2022 22:23:53 +0300
Message-Id: <1654197833-25362-9-git-send-email-olekstysh@gmail.com>
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

By assigning xen-grant DMA ops we will restrict memory access for
passed device using Xen grant mappings. This is needed for using any
virtualized device (e.g. virtio) in Xen guests in a safe manner.

Please note, for the virtio devices the XEN_VIRTIO config should
be enabled (it forces ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS).

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
Changes RFC -> V1:
   - update commit subject/description
   - remove #ifdef CONFIG_XEN_VIRTIO
   - re-organize the check taking into the account that
     swiotlb and virtio cases are mutually exclusive
   - update according to the new naming scheme:
     s/virtio/grant_dma

Changes V1 -> V2:
   - add Stefano's R-b
   - remove arch_has_restricted_virtio_memory_access() check
   - update commit description
   - remove the inclusion of virtio_config.h

Changes V2 -> V3:
   - no changes

Changes V3 -> V4:
   - no changes
---
 include/xen/arm/xen-ops.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
index 288deb1..b0766a6 100644
--- a/include/xen/arm/xen-ops.h
+++ b/include/xen/arm/xen-ops.h
@@ -3,11 +3,14 @@
 #define _ASM_ARM_XEN_OPS_H
 
 #include <xen/swiotlb-xen.h>
+#include <xen/xen-ops.h>
 
 static inline void xen_setup_dma_ops(struct device *dev)
 {
 #ifdef CONFIG_XEN
-	if (xen_swiotlb_detect())
+	if (xen_is_grant_dma_device(dev))
+		xen_grant_setup_dma_ops(dev);
+	else if (xen_swiotlb_detect())
 		dev->dma_ops = &xen_swiotlb_dma_ops;
 #endif
 }
-- 
2.7.4

