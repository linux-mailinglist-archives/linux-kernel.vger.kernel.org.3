Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36948F217
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiANVnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbiANVnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642196613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
        b=R7S67hf8tcGNk03u8H4xDibZtHhRcUfnwtlbv0FaLLxpF0Z+PNqMoDpwmxHno4SpGl1AEC
        hCR1k33Kk8TCctht9GTsX3fLtJ5ui3eo+2R3Kw7w8C4njWHIhLVOJ3ooPrkgS7q5wek4Cc
        nPypzHAPP5IrI8q6wcyEPBAYZpcISzU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-MFEb3JWwN3OwKU56qgvwjQ-1; Fri, 14 Jan 2022 16:43:31 -0500
X-MC-Unique: MFEb3JWwN3OwKU56qgvwjQ-1
Received: by mail-ed1-f72.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so9268681edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
        b=A307Y/hXf1pnCsHeWN6NXAWj6yhhWDZEg2Vu821jvyB00UCUaZdYXh5xEkq/9vypYv
         FzgXmWbSkpUoBaR71BHmGMAAoblgL8Y3S+4c40OR0PcF7hIzX/XsDKhTHXSMIaXxp+NX
         +oV+1557ThlVDGpGeaX09Mwpk7beAUllNx7ZvewgLfl6vvFhNz1vQjE67k3Hv+ep1guH
         06cTeqLPYh9v0ZYhDCSO2Q5SfD8lgXtpY0qcRYTaw1WIybrfocCrOZmWuEDozTtQvM3Z
         1VdUi6OAeap7pfkZmdCTSDbVNvxEmoI2jNbmCN253/INn9W4uTce9n4JbGSzJad9zs+Q
         SzWw==
X-Gm-Message-State: AOAM530pDaHDgn6kkK0XayILbJlzsZ4ovb4st6eaUMXoUQx2yMVfbQvy
        DwLG8HTvbvwmt8f7FTeL3BDaozXvTp3UpiFFcLahYlodj1ZlCZevQ1HTNUDuUR0uzlWkuihukg8
        Pa+gjFkzSuOd1SSWradx4Tbu6uiT5OYzvrpEgS8iCwm2if6dDL44b3UM35hL9ze0ACGKBwA==
X-Received: by 2002:a05:6402:27d1:: with SMTP id c17mr10483759ede.128.1642196609916;
        Fri, 14 Jan 2022 13:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwX+X4YHjBMDl2PYMvPClJyagNr+C+tepnu7ca8BYRhvwykdVnYrSL9WI3b0URVZRj1HoAt8A==
X-Received: by 2002:a05:6402:27d1:: with SMTP id c17mr10483746ede.128.1642196609685;
        Fri, 14 Jan 2022 13:43:29 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id c19sm2755020ede.47.2022.01.14.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:43:29 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:43:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_mem: break device on remove
Message-ID: <20220114214324.239444-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common pattern for device reset is currently:
vdev->config->reset(vdev);
.. cleanup ..

reset prevents new interrupts from arriving and waits for interrupt
handlers to finish.

However if - as is common - the handler queues a work request which is
flushed during the cleanup stage, we have code adding buffers / trying
to get buffers while device is reset. Not good.

This was reproduced by running
	modprobe virtio_console
	modprobe -r virtio_console
in a loop, and this reasoning seems to apply to virtio mem though
I could not reproduce it there.

Fix this up by calling virtio_break_device + flush before reset.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 38becd8d578c..33b8a118a3ae 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 		virtio_mem_deinit_hotplug(vm);
 
 	/* reset the device and cleanup the queues */
+	virtio_break_device(vdev);
+	flush_work(&vm->wq);
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
-- 
MST

