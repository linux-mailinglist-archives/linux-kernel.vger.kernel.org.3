Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DD4DD227
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiCRBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCRBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:00:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13129C949
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:59:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o13so3947394pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWkUKKUfs4VYn5pehhvDhFVAi6lfMmcxFwsgAeoQ1uQ=;
        b=HyYvAk3qp0AznsZ1/9IYiiHU6O8Np8bhXI3+eVmt18FxaLdD7bLohl48k7Qru/UY7D
         sl5gMT1frvug45Dxe+py3+45R70xch08b8twcO5T+qIyvJdbBykNDQZ47jJMOtvswfba
         Dk/XUwhO5HRDrzSrogn+ieZfo5rU0wtyWW/VFf2CZtrYt7jaDPdgBfFWg6WLGZBU9zvo
         LpiXzT8mlIWid/bOuzePITPbq+GxdLOJy/qBievflfFiJ1mb3oI6xv5qqficut6FfKBj
         RGOidAeM1rhnAGsxcc/TdMu/PvsJWBbRt/tfkZ3MV3HzTBGMj6K6Zr7voXO5s7/VGfvO
         3TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWkUKKUfs4VYn5pehhvDhFVAi6lfMmcxFwsgAeoQ1uQ=;
        b=vCaT5Jm01hmjQIDhSb3cLeFi2/xB6Y6HrOPNSykHSHIg2R5YinFmGp0OWV8Nryc/pI
         4i2qBVzekqY/B+W9oE3osWrE6XqedCqAsrHhGGESBb6/UEzx/eM9yVl/NTl/UYMNly3F
         rdkWM958of2TkbWC8+q1UEGrs4Xa3jmm1QOCicGHgJiRl9TKMxYXEo0+iOgwiIWmwK1K
         T4dYZacy2lWUnJD/DpuaYNyGQ7hXK276QtxX0CwpYU6shic+4HDEIZKuh2VsU+Ir6e6c
         pbOO11FVsaIDXHZzqpCSjwQF1fuWUWUe6Q74Bqpexyy30g+7Rr19P/PWwsAOgmtcPiOo
         Zhpw==
X-Gm-Message-State: AOAM53019Id4S746W3Ma0Is5LQ5QfS8f3TLE8WWfbad5ACB/RjjkshHK
        5OwS7G9AineNvvDBVdgIqrE=
X-Google-Smtp-Source: ABdhPJwNaMiQ05re71GC2MP+JezQKbqshGdZOGhfnKMpQT+6Q9lj3LnxhBazPqKYdQcktOZsdbtZgA==
X-Received: by 2002:a63:a1a:0:b0:34d:a4a9:a8b9 with SMTP id 26-20020a630a1a000000b0034da4a9a8b9mr5854426pgk.176.1647565147035;
        Thu, 17 Mar 2022 17:59:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a0008ce00b004f66dcd4f1csm8734514pfu.32.2022.03.17.17.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:59:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] virito-pci-modern: Remove useless DMA-32 fallback configuration
Date:   Fri, 18 Mar 2022 00:58:58 +0000
Message-Id: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/virtio/virtio_pci_modern_dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e8b3ff2b9fbc..dff0b15a239d 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -255,9 +255,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	}
 
 	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
-	if (err)
-		err = dma_set_mask_and_coherent(&pci_dev->dev,
-						DMA_BIT_MASK(32));
 	if (err)
 		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
 
-- 
2.25.1

