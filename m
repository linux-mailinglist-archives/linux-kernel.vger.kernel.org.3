Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD457973F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiGSKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiGSKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:03:43 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247CB3F303
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:03:02 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id h1-20020adfa4c1000000b0021e43452547so137249wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2+lXQGbE+buo/8gvrJD/wB7UlZqElDrslAcOEAzV6bU=;
        b=IjL0xFtCCH0yUMSKPvsupNsNo1jFdAKM4jmd3W/HRCTGXVVzwK3i06L30Woic4TNOR
         fbOkS38vVyh7LVlXsADVVDXkth9VHi080ItZA2PW3sJie1UPoTj3b9xfFCg+N6Lfz31Y
         b2Fnw8/D7ew40+ZRZ6JTo8Np4/5zrazpJXUbTBqQa2uJdGO9Z8g7gn9az4kdhM9rUY8X
         Y2SL6S6IVw34ITaEkY/s8mgpkDqy5/UDCTKRj6enqZ5x5CjoI6+4W5sBRj1k5aXSMgt7
         sUB0eL0Yv/eChQHo4AINpQ1qbnt1VV6qoSCXD3v4wEdQjgH2okkwFSM9sPf8U1jZlfmi
         tbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2+lXQGbE+buo/8gvrJD/wB7UlZqElDrslAcOEAzV6bU=;
        b=elSC0HJAjlYZ/sDOvP6LV0GiuwTIxwQyiVTLFPHYu2vAj1UEjXJ7+aS/1zKgtxu7s3
         anfo256NB4v8kNJKYXUjwVRAlqoBOyRt1jd8XlLIHO2+ayiw71uGTyShQihNAr+dYLR9
         bxGew1teIge4ldFcvtamcCW3lVRfSRumb1gwqVsexOxFrEsJ2IyXm+ouAkILkI6f6z0c
         5fNkTVBHoF3w1uznnjqDsVerQ42MuZBu32g1QoGzVVCc+JxNSXPVXrMBQpdDFtGY7P3D
         fQmh/qiyXeRLZdILvB+VztRsp0cX4lc8RG8Kec1QWH77baSLcZoOCx35S4zsjF3NX1cQ
         nNtA==
X-Gm-Message-State: AJIora9fAgg6mJACmvkoyZBLsbktIeeiUaiV03+yOoOnojNe1x0jCytb
        G/1ZqsgWyffayNhxzR3F7AeOEDh3pw==
X-Google-Smtp-Source: AGRyM1sgGnAqIIcgX+y+EisPfzlYd9ddFBqArnedVXkgRFaJ2kqhqwEHwZrtyeoSZN5pUkWKKnu7sIJm7A==
X-Received: from keirf.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:29e7])
 (user=keirf job=sendgmr) by 2002:a05:600c:3512:b0:3a3:f39:5735 with SMTP id
 h18-20020a05600c351200b003a30f395735mr18602416wmq.165.1658224979874; Tue, 19
 Jul 2022 03:02:59 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:02:56 +0000
Message-Id: <20220719100256.419780-1-keirf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] virtio: Force DMA restricted devices through DMA API
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel-team@android.com, Keir Fraser <keirf@google.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If virtio devices are tagged for "restricted-dma-pool", then that
pool should be used for virtio ring setup, via the DMA API.

In particular, this fixes virtio_balloon for ARM PKVM, where the usual
workaround of setting VIRTIO_F_ACCESS_PLATFORM in the virtio device
doesn't work because the virtio_balloon driver clears the flag. This
seems a more robust fix than fiddling the flag again.

Signed-off-by: Keir Fraser <keirf@google.com>
---
 drivers/virtio/virtio_ring.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a5ec724c01d8..12be2607c648 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -12,6 +12,7 @@
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/swiotlb.h>
 #include <xen/xen.h>
 
 #ifdef DEBUG
@@ -248,6 +249,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	if (!virtio_has_dma_quirk(vdev))
 		return true;
 
+	/* If the device is configured to use a DMA restricted pool,
+	 * we had better use it.
+	 */
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
+	    is_swiotlb_for_alloc(vdev->dev.parent))
+		return true;
+
 	/* Otherwise, we are left to guess. */
 	/*
 	 * In theory, it's possible to have a buggy QEMU-supposed
-- 
2.37.0.170.g444d1eabd0-goog

