Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824FB4864D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiAFNA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239262AbiAFNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641474053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nwzCKRlarcXm1RHufaPsJW9CI1uQM/UHS6c0Nx6knro=;
        b=Fucu49jY671i6KGsWAFJ/4EIgggWgDSXbRacLghyVJ4EvarqtyfjPdhtqpt022b6pFJIhI
        SGEBMqpnoVSAFQXOzFUARmWMLFPkr77+DVmYLYbVkwyYvzCmXeUIZeI0RL1dwArimMxkoZ
        XMsHcrhRnaoPaw0GfDNBge8Jolusf/o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-GPcRkzHRNLGJSmux_JF8wA-1; Thu, 06 Jan 2022 08:00:52 -0500
X-MC-Unique: GPcRkzHRNLGJSmux_JF8wA-1
Received: by mail-wm1-f70.google.com with SMTP id n3-20020a05600c3b8300b00345c3fc40b0so3042325wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 05:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nwzCKRlarcXm1RHufaPsJW9CI1uQM/UHS6c0Nx6knro=;
        b=FHA64VeOwZGKeHFxN/4oK9AS8PGGrXT5O3f0o89UBGhwhGwzOl4q9TNj89S1CQ8RJd
         heFNHKRQdqiPENNn0fgnAEv/kRE6ngDzCi9Lau/WFPxde2itoxTWRER4OfggGY1tN+Ut
         YKdIz20n0R/814o7kaJmojFaKT2xYpFv3229AeER94TIWMZUXoCmqbrIz4ce49SplKK8
         DVBA8ZA/wVBskIxy6pXS8oHL/P8Ft8m8p9UZCFN8dX2wLMBZwcrLVdUWGrDxRXf0Zi/p
         wUkfxSGPc4PpWJfVZ6583SjkXWGKDlsmdWqm2RcKI/4N1/vZQ+VGkyzj2zwm+NKhL7Kl
         mnWg==
X-Gm-Message-State: AOAM531SOILq5ueNPIsmYgFBkqBEovOUxcKZs0+bIM5K+mTLXPClVLip
        nXvMsHdwa9fn+HmxGE9uG7T32qQvz7qZqMJt40c/ULB6H0sW+yx/iTpTaKcFhlZCltbWD54BfRt
        RNkI0Z+PJl7wh94amyaL5UHYE5ZCSM9upCgZ2eU8sBPrONwmwARDVoWvjx0cev0QLE7nxDw==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr50571969wrc.29.1641474051023;
        Thu, 06 Jan 2022 05:00:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8sjEET+CFZdglHMPDN4E8uNhAyHPhpS/seTRaepk7Pmro3HZna6jkZjGbwE/mzv/D/1wVFg==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr50571942wrc.29.1641474050718;
        Thu, 06 Jan 2022 05:00:50 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
        by smtp.gmail.com with ESMTPSA id o8sm2436559wry.20.2022.01.06.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:50 -0800 (PST)
Date:   Thu, 6 Jan 2022 08:00:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_ring: mark ring unused on error
Message-ID: <20220106130046.422417-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recently added error path does not mark ring unused when exiting on
OOM, which will lead to BUG on the next entry in debug builds.

TODO: refactor code so we have START_USE and END_USE in the same function.

Fixes: fc6d70f40b3d ("virtio_ring: check desc == NULL when using indirect with packed")
Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 028b05d44546..962f1477b1fa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1197,8 +1197,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	if (virtqueue_use_indirect(_vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
 						    in_sgs, data, gfp);
-		if (err != -ENOMEM)
+		if (err != -ENOMEM) {
+			END_USE(vq);
 			return err;
+		}
 
 		/* fall back on direct */
 	}
-- 
MST

