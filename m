Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544F1594E82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiHPCJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbiHPCJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CF5822F1EA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660601095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lyQQM+55ZldD7H6umrPU2pn/Ul/3O7z+T5LMRSIVXr0=;
        b=SxpFIraaZIZckWZ9w7a9QR/f9X6As3Bo3ElBmSJDQfz5IOrnOCrpSXPIjEpRAWBQJEXvRd
        ZYBfufRh5WSH/1Aayx+GG7FbTRVDd3gME1NuknSS6R+4sEk1q6GotjVoaZ+xYwyIo4ZoZS
        BGsZRM6O72ep02Mu/OoyKOV1jeKrug0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-XZicoZ8eNgSUZlnl1zfhMA-1; Mon, 15 Aug 2022 18:04:53 -0400
X-MC-Unique: XZicoZ8eNgSUZlnl1zfhMA-1
Received: by mail-wm1-f70.google.com with SMTP id 133-20020a1c028b000000b003a5f307844bso1311481wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=lyQQM+55ZldD7H6umrPU2pn/Ul/3O7z+T5LMRSIVXr0=;
        b=rLmzTC0xsAH0Tst4dVCz61qTjCpqnGVVAX8dzaP1/bxlwP1sxRY/FrJkPbEzqK8NNh
         ArQbfhU9czZKZgVyB8jz1Sw/o52tYgPoB4IWYbHHwlfuMp/VweiWFzl5iVbTiZDZ8osB
         qOg96KkMXqk++u+VISXPo+K9GlRbN2NMTFPPWiR8sTIJiO5EjBZ5T9DXoxtpJnk6WR9f
         cV46+1WJNtI4XzQzw7eV9ubtnqMAiN075808mHLHMSAhsFvnsynEC21I78ZDN3ImHI36
         TF5FH3E3fn5iEcyV37lnV2FE5rFNQwlWVWmhqzb4WUQyHdKq+lMaVbzeKBrz3AW+fBRr
         KlWg==
X-Gm-Message-State: ACgBeo0MfbUI34eYm5WE46AU2h8ip34CSJr53mxUmZ7wIVDo3x/Ha6Im
        WlRGT5jBy2y1AjJ4aDo/S3lJ+SbnEwfrCXF9FJTI6y/O19h6Hsc7PmUhnHdm3L5a8c+jhPrKnWy
        NcoJHa7jgY96wq0ItNjJfj2XJV72hXA/0xc4Fke5KT5KpPwSeUAkQ4N+8oEHtVq20fOtCTg==
X-Received: by 2002:a05:600c:5107:b0:3a6:72a:e63a with SMTP id o7-20020a05600c510700b003a6072ae63amr194374wms.204.1660601092548;
        Mon, 15 Aug 2022 15:04:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6PUhV7WZdq3IgqAnAv21g/kOlOq56EKtk/N9dRgjydoQVgIDJVhN0tVySUIn3OBVrOOkFoZg==
X-Received: by 2002:a05:600c:5107:b0:3a6:72a:e63a with SMTP id o7-20020a05600c510700b003a6072ae63amr194361wms.204.1660601092225;
        Mon, 15 Aug 2022 15:04:52 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0021b970a68f9sm8189495wrp.26.2022.08.15.15.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:04:51 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:04:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: drop vp_legacy_set_queue_size
Message-ID: <20220815220447.155860-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's actually no way to set queue size on legacy virtio pci.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_pci_legacy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/virtio_pci_legacy.h b/include/linux/virtio_pci_legacy.h
index e5d665faf00e..a8dc757d0367 100644
--- a/include/linux/virtio_pci_legacy.h
+++ b/include/linux/virtio_pci_legacy.h
@@ -32,8 +32,6 @@ void vp_legacy_set_queue_address(struct virtio_pci_legacy_device *ldev,
 			     u16 index, u32 queue_pfn);
 bool vp_legacy_get_queue_enable(struct virtio_pci_legacy_device *ldev,
 				u16 idx);
-void vp_legacy_set_queue_size(struct virtio_pci_legacy_device *ldev,
-			      u16 idx, u16 size);
 u16 vp_legacy_get_queue_size(struct virtio_pci_legacy_device *ldev,
 			     u16 idx);
 int vp_legacy_probe(struct virtio_pci_legacy_device *ldev);
-- 
MST

