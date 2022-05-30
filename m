Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856C1538872
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbiE3VBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243259AbiE3VA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:00:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11854915AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u23so18503419lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yQqHGmllGTqv5b6W6sRDmvHNQ6gC3VDGqt+iST1GP4=;
        b=S9MQR0ujpwPcnAyQYtPOzs9RCcNptzk0O/ZMxmFkOJnlI6mtmjxlbztcN0YE14G+/O
         CACKu4Iom63FSxFErPfKqe3D8u1NBDzLCPW0bP4ReCA8eMTw2li9C6ziCtU4wpuuXFOv
         qt8hKg4Ch3uraBa6Tn2+BZTqz64LBuzU3H+Y3p7d156cESE/deH1HCsjxMQApA/hMabB
         SVd/urKJWwl1w0Od8Z4zjUY6waUfCEhfljhE6SeNVuuV96Jjyfsdnq6mtPjXwQC9I81N
         93RwoCNTdcACEhMhE6pcdd8EPkimavXlYSfpVDIUPItTBv+rAA4J2jKLCkS4egHb/581
         YKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yQqHGmllGTqv5b6W6sRDmvHNQ6gC3VDGqt+iST1GP4=;
        b=IHHZ8Nqp6UoWDfzWaVqpptrkVf74/blgICsdg6g7JJIR9CYG3wgamxjELzLcMoIVqF
         b4fKdMwFx//gKG5x/Julh9/hrdoyoNUk9RUOOoXKehGiociEUay16isesbba3reb32Z+
         p7QYbIZhJIFWnf3yYlAbz6A2UgogR60LvOJuS7AGuw6rvkQZzdpbqdArHj/aNDpcoDk6
         hL0HQn527SXt/mSUXcEnppP3QfcQ2nwF+plv3sojmzY1O9R3LKCGSAOEWcdON0K7XGTB
         EWKBdQZ3KURW9BHRhYt8gQauCRXcKWRnsz2HwjdC6j4byH426yFeAo45gCEQgH1t2FiF
         0BLA==
X-Gm-Message-State: AOAM533QO/8njLjf9oWF3Yv6TqrgzfC9zOziHC2Ohr+BgXF6E//cXC4I
        803KGyfRrftHbh+fHiwdBdM=
X-Google-Smtp-Source: ABdhPJxRI3M09HPtHmhTVLy5lEGHXzz2fTw91+bnwCJ2p93uOzuCHkjvEzV3hyRjrqV1bLRUpJbu/Q==
X-Received: by 2002:a05:6512:22c2:b0:478:3ed7:f0f7 with SMTP id g2-20020a05651222c200b004783ed7f0f7mr37717893lfu.112.1653944434440;
        Mon, 30 May 2022 14:00:34 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k21-20020a2ea275000000b0025550e2693asm581541ljm.38.2022.05.30.14.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 14:00:34 -0700 (PDT)
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
Subject: [PATCH V3 8/8] arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices
Date:   Tue, 31 May 2022 00:00:17 +0300
Message-Id: <1653944417-17168-9-git-send-email-olekstysh@gmail.com>
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

