Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478BA48F230
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiANV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbiANV5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642197455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
        b=SeSurwWyHP9c/HCum+/op3Sorzkx4GjZUQiUrzlR3sPxULSeNG7VbcVou0l6dqYYd5pVEf
        /o4hRGh/2CHvqUu54h6AtsMmWvuAukd/bETeu4DqLEGsHETf6kHCHRX50bqwq8UYtXnpsj
        GxvFaJnOIkFGWd1hmWLTIWc8/l6wdX4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-EVS3s5H1PHOGJ-DqQtEShQ-1; Fri, 14 Jan 2022 16:57:34 -0500
X-MC-Unique: EVS3s5H1PHOGJ-DqQtEShQ-1
Received: by mail-ed1-f69.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso9264217edd.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H65UNYpk1YgIkr6+F7jbPWFp6tYbCp821iY0zXAi0/8=;
        b=lU1+EHiTBg+Z4puZQCi7mqm56ZHUEx+UboIAb3Ep9kxuVbSmB+BdYVdKlqBnDXGW/m
         +dXiWuRZNenR4I+5I8F2LNQIUw0H1u3nDHhGgT590Ka+Xx1fem1+2QtcacJTKUD5htbZ
         te6i/KNoiOLYmI8dIBkvwrk47F+mxqNBwptJJehCJlRqprNAFZbo00XvOGpvK0YgNw7S
         Epfw0dnjksHxi0UeLuCuNUxnzaptpEhwOI3r3tzd1jhuNZ9dLovWy+jiIHwlOHr7ZmY2
         tKSavIjbHbCpHd0bkiRk4Sfbpx84wZwiQ8LChT6k0l+Ydf3fGuVnBmEgLcCExuXpvYJe
         XpHQ==
X-Gm-Message-State: AOAM532VmCR4jDXuHe9aqTNuDsaZDlLCzymBuXdDslnEVXlLzdgA0QD1
        qF1T2TB4sNNLrpE+v76ZOo855jXWyS83l2RiICqBf98rR7aAY7/0wJQQmGEQp2QXC6INTq939sR
        HBdX4g96kf89eqRDDqMdQswUV0TNg62CWxmCP/NT9SbXIWJYupHkniHBT7EnfvFlMqrLK7w==
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr8651759ejc.228.1642197452489;
        Fri, 14 Jan 2022 13:57:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsTiLtSAGxhk+CZk+P/jiuyGZo11tboZXauUuIvMgtr2CQW2woyxWUOXD9q5He4VsWBSjrIg==
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr8651746ejc.228.1642197452229;
        Fri, 14 Jan 2022 13:57:32 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id c15sm2779480edv.77.2022.01.14.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:57:31 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:57:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/3] virtio_mem: break device on remove
Message-ID: <20220114215641.239984-4-mst@redhat.com>
References: <20220114215641.239984-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114215641.239984-1-mst@redhat.com>
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

