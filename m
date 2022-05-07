Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6D51E92F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446885AbiEGSXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446819AbiEGSXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:23:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97630F43
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 11:19:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so6139776wmz.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQ4/wPcUQ3XIBwyiOH+85aEeFtvLk17ZXfaTMabSQhQ=;
        b=M0nL9AqbUiqgoGeBXuGJocL7BzhM9dpf6lZVm6z1MjjHA7Ksx3fAI6nsxT0Nt1TL05
         V9n3RuTkUTnoTUTcWzbDZzYyXq+nDqhodBqF5QWBpLz3KG7WkLCJw+dMLaWXpmXERYF1
         Z/ciVWktZyebFps/o8q2Oq5Yq41Pu3hxh+stWpNbBkwcaCkgIOQ5WYEwn7lV+jJsEdSh
         +HhxY/jdkwpoWo5uCgqY6+fdKmpb5rQY+LpZDKBI6NpE+HUIsQOlFS0+S/WN3zq9WuIL
         TiiJg4uvRYrYvsi0W51dYzG/nuX5J3xAnuGzn1LhIo6s+ydhszeik8BNC8Hg3Kloj1TO
         zwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQ4/wPcUQ3XIBwyiOH+85aEeFtvLk17ZXfaTMabSQhQ=;
        b=HlmFV/R/Ea6819rQM6MBm5LVA6y4OrYdNPvYMTbNLS9IWZikBTUaCI9IOasquBKtJp
         WOl/ye8oGXVxPBMVCI/7sZ/UUH348+EUqL2lJtbmF7uOSGWcbsuVyW0e2NfP/huzHzOE
         g0MCuzmSg0BwyY/iBYWEZNIO6avmabOZV+deWPPuaV5yVQGy+/+PUrZP+pa6zimluFUi
         5QJ8ipjHPRznWjyrbIks0z3G7Or7u69pHPZvJmy6okMF/X2Tykg6MBoArMSqCYsgQrDN
         Gr3wTAL4t9unqAw1NSaweffEk4+U3qeO302Vp57Nak03WPeWraCVxl/xpRMqSCdVuDQZ
         8Jgw==
X-Gm-Message-State: AOAM531XAxmS7V+hkqxDT4BWT6APNv5oz6dsVF8OrQgzGzcMCcBS1k2D
        LyiTuEAVAlt/sT++BUGaKLY=
X-Google-Smtp-Source: ABdhPJx4KKTzPkd6Pb55J8tu0qaETBwCwPrhXqxi1bGV5Mve7UPIQCUHgzJRC6duNfUV/2m203EIIQ==
X-Received: by 2002:a1c:3b54:0:b0:394:3910:3c7b with SMTP id i81-20020a1c3b54000000b0039439103c7bmr8718493wma.3.1651947570262;
        Sat, 07 May 2022 11:19:30 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0020c5253d8f3sm8198457wru.63.2022.05.07.11.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 11:19:29 -0700 (PDT)
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
Subject: [PATCH V2 7/7] arm/xen: Assign xen-grant DMA ops for xen-grant DMA devices
Date:   Sat,  7 May 2022 21:19:08 +0300
Message-Id: <1651947548-4055-8-git-send-email-olekstysh@gmail.com>
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

