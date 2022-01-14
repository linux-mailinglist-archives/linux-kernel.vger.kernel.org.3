Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4648F0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiANT51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:57:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbiANT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642190242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jBT/nNeSa+Ii/P6rldCEBEg5crRoFIcXmmoQTy71T4A=;
        b=EwvQNmFefyXVQYIA2J7yXYTKBlrVAw5ZV5QnLcc7RxuAGs586S3JtAHNv0BvYCB5IeODJ2
        ato4lWW/ETcQSivKn+RCtyfbZiYIVZRRHRkt3lUHViv/Q6Vs77qomjTX3WUi42RDZb6L9T
        T9he2cv0+qmswMgGh/K9dCaRrnu5dPk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-HplV8BGPNLeCQRLYnYTkDQ-1; Fri, 14 Jan 2022 14:57:21 -0500
X-MC-Unique: HplV8BGPNLeCQRLYnYTkDQ-1
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso9070622ede.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jBT/nNeSa+Ii/P6rldCEBEg5crRoFIcXmmoQTy71T4A=;
        b=VZ9OzzHln4BPcwjq7t77z7LFHdr+0Drj7JHn2vSwDUaCXskTJg7wC54KXVRmI9T28C
         Hl3+RdUKviijtap3kDY0yHUq1ipcmZN/okHBP0yZ6L61pHvTjxk6ckg+3eaL7MEoXRWi
         XoqIjDY9TbNN5dfsjFzmIp4mNs2/1LgYFA4FIZ6/ZNKcsW98rx7C53n/2xAs+swvFvnx
         0VB741ZKUjUX+d9b9rFteDruw+y6w8P58kGHYeBNszSa6NOwyEs4opWn3bOIb7NFS9j6
         y/pOHLPZutTGmwN5O5esNSzRfGYZJsXldJRS/2QuGYeaMaoUKQWeC95ZUq4CfAa0tNFa
         n5Xw==
X-Gm-Message-State: AOAM5327w68PScvnuYQUy5u50ZTLahT7OqxFcnfuxhXvs8ehNJOE90+u
        ekZ2mb0HoQlhwNwC5KHoL/NNkw8yY4lBEOhyLNL1Jm2TQJICDhJa1JDUgmaFGvqIOMjj5Rvm5s3
        VsUu9AXGAe8qQdUvj4Vm5T16vztY3pNMgqb6gnmMGrA+nAo1rVDRnJO+Upb5EoVNWsaJgAQ==
X-Received: by 2002:a05:6402:27d1:: with SMTP id c17mr10169362ede.128.1642190240134;
        Fri, 14 Jan 2022 11:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkD8j7cTwK4rTOGXJcnDS2Znn/r1A0C96Nzycv1PW0gtcGx4Q/58wmzs1emQigbpUXzSB24w==
X-Received: by 2002:a05:6402:27d1:: with SMTP id c17mr10169348ede.128.1642190239850;
        Fri, 14 Jan 2022 11:57:19 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id c19sm2688490ede.47.2022.01.14.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:57:19 -0800 (PST)
Date:   Fri, 14 Jan 2022 14:57:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: unexport virtio_finalize_features
Message-ID: <20220114195710.149933-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_finalize_features is only used internally within virtio.
No reason to export it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 3 +--
 include/linux/virtio.h  | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 00ac9db792a4..d891b0a354b0 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,7 +166,7 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
-int virtio_finalize_features(struct virtio_device *dev)
+static int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
 	unsigned status;
@@ -202,7 +202,6 @@ int virtio_finalize_features(struct virtio_device *dev)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(virtio_finalize_features);
 
 void virtio_reset_device(struct virtio_device *dev)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..5464f398912a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -133,7 +133,6 @@ bool is_virtio_device(struct device *dev);
 void virtio_break_device(struct virtio_device *dev);
 
 void virtio_config_changed(struct virtio_device *dev);
-int virtio_finalize_features(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
MST

