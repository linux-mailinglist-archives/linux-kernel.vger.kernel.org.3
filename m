Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9548F22F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiANV5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbiANV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642197452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wOvJxanjv8dJh5us8ooGzpb/lM+VsWX3ZsU7uSOCqY=;
        b=BbbzC1QWvLFkLm0przHgaiEssyvFXWbObc/7qcWgMpRtKwL7z8YJYZjaPN0xyx3qjnBuoI
        ELFfrMGl2Gr0GP/u9oGi9IX/mFnK7r+/ZELRJvPvQMh+rPxWLMe16xRDV+BlF4VfqaHmwB
        rwX/fAalxBh1gEGJ0pZbDmtAAov2tcQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-44Pu1O30N3KqjY7B0gl_Fg-1; Fri, 14 Jan 2022 16:57:31 -0500
X-MC-Unique: 44Pu1O30N3KqjY7B0gl_Fg-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020a056402124a00b0040186fbe40dso717157edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wOvJxanjv8dJh5us8ooGzpb/lM+VsWX3ZsU7uSOCqY=;
        b=FL0wExhWXZtsFUnn+JBSu+8cZ/9B3BPUGHozkDHU25Z2LFSN4quw19z5Tq1JsVtsTG
         2tMtRiKedyxVWAIv81qZntMT6P7BNwtXfgOPj/rmIS9M2BpSITyj9Us+e/asa1FF24A2
         vizxVZ2caHUKgBWZ+hap/Th/ZB9vjSsUD75tUgDGYWOgVea9qbY4sAM++nJvc/JONXC9
         kOwoW+QiPAu4zKLvYcxWTxAaMFF0EViGnLsDRUrhiQe2TN2qvI/7hftOLPF7AC9bE8AC
         BAGtoGv9/ewqAt6nXCG8cqD5ZCClH+AeXZm9RXjFMUDjW4MDJH5AujABOSlwH66ag+3P
         TNgA==
X-Gm-Message-State: AOAM531XbjuOY+FdFW7MeaYCGm6v82TwHeF1j68M2wUxyN4gzH0k6dHd
        k9reVwPqYrCWHrRQsldbcYuWzl9oXTmFs5v7e+a7Q/QAhCXsZjMUC03mjpUedRoK0lAZ9XcIj4t
        MDTEqnnX6XWyWTMN8pRoy3Ic6hMrw3cgt1zN13uIMWXqh/vBR/h7jUoC/ctzbPxwGzRzB8A==
X-Received: by 2002:aa7:db41:: with SMTP id n1mr10643172edt.307.1642197449930;
        Fri, 14 Jan 2022 13:57:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPcMkPHRedToYHc/SYw7TuOGuXM5aNzWoT0JmhpwS9rK3yCFyfEvKXtgc7v8dDKX/rq3pNmQ==
X-Received: by 2002:aa7:db41:: with SMTP id n1mr10643153edt.307.1642197449573;
        Fri, 14 Jan 2022 13:57:29 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id hd16sm2084204ejc.62.2022.01.14.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:57:29 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:57:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/3] virtio_console: break out of buf poll on remove
Message-ID: <20220114215641.239984-3-mst@redhat.com>
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
in a loop.

Fix this up by calling virtio_break_device + flush before reset.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2359889a35a0..e3c430539a17 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1957,6 +1957,13 @@ static void virtcons_remove(struct virtio_device *vdev)
 	list_del(&portdev->list);
 	spin_unlock_irq(&pdrvdata_lock);
 
+	/* Device is going away, exit any polling for buffers */
+	virtio_break_device(vdev);
+	if (use_multiport(portdev))
+		flush_work(&portdev->control_work);
+	else
+		flush_work(&portdev->config_work);
+
 	/* Disable interrupts for vqs */
 	virtio_reset_device(vdev);
 	/* Finish up work that's lined up */
-- 
MST

