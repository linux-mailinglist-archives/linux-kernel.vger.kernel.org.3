Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA30492BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiARRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236454AbiARRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642525427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xeHoR1Km3Ot/QwwgnNEtsDvDGwANoK5Acc9epKDxSQU=;
        b=Xpijj9Fn5Fr4+2bNwTB8g315xzQZG21M3KKrF3BAl0DVvR5vliAT9eMangZMF1CxW/mEhn
        dC2meVhuDo7OXwcB0W7QUg6genoVCYpo21lQ7k+D6YpH+4WErtqhRG167gRCyKGSdyOvsg
        C2nkwsNjXUmA28cspAryht5K3lG8JwA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-9vX1mWFnPD6rZNjjZsnxUQ-1; Tue, 18 Jan 2022 12:03:44 -0500
X-MC-Unique: 9vX1mWFnPD6rZNjjZsnxUQ-1
Received: by mail-ed1-f69.google.com with SMTP id t5-20020aa7db05000000b00402670daeb9so6660531eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xeHoR1Km3Ot/QwwgnNEtsDvDGwANoK5Acc9epKDxSQU=;
        b=U0vRTDh5KXAtFEOv2VmVGmwdlP2zA+Dk1iHoHxSObt9gqgY9s0zGEdhab1eJx47Y9U
         3dIwCQ6+6sz+yyHYgk6uQmQhjVW/nJ49IciBl5HVqlDKKTKXOozjETosGfhVIgOexwtg
         zEHmkMx+SAvJsNxQotL7EauKkCwQtXU30r4oJqs8xXBQ45RONlozZBcur293LklfdOJi
         yb1EWTjQ6378fFduRZI+AT/FROs/zLm95wxHqnHZPtJs7gta03LU3WjE0r7C/+I32/0y
         OGMN4wN4rnnsWn6H/Na781cieTW4KlcCl/NKKZFZ4IBvdP6xZJM9JjZ8GnY3jb/Kwh+A
         CJVQ==
X-Gm-Message-State: AOAM531fSgfTjLt/Nvg21OBzKFEeISzX6pOpGzbbi25ZzD/pBhPYWWkd
        IP3HLiG+AfQHrvtwOZfnxen4EssXOGejPbBYbURaBsKxkFg/R6Or5lzgtfNy6ybalR59K7b2qQm
        VkPO2Sj1za20JCcVScZ13qrH6adJA1k/826IbFDDtvBp3dubwir030QO60e5VUwBmwVNE2A==
X-Received: by 2002:a05:6402:399:: with SMTP id o25mr25929996edv.70.1642525421662;
        Tue, 18 Jan 2022 09:03:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysFKMueDijbw2+fxPnfDwyfRixXRfg11cODmIZFCXfCeIojgPJErkMskMdbICWuCYRvZZVkg==
X-Received: by 2002:a05:6402:399:: with SMTP id o25mr25929978edv.70.1642525421403;
        Tue, 18 Jan 2022 09:03:41 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id i22sm5559325ejw.75.2022.01.18.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:03:38 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:03:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] virtio: unexport virtio_finalize_features
Message-ID: <20220118170225.30620-1-mst@redhat.com>
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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

