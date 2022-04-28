Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223D5134FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbiD1N0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbiD1N0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D67AAC927
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651152173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a14xq4pv5r/FkYeXeUtrnJ56gM2JRtUzYDAyxUxKyXw=;
        b=Tt248EhYFzQ1e2QqfYV5aGSPG/ngkVC8YQdIZJkjiYuiU0HMOA35v1TbBI5pgu7/G6rBlr
        dW2xXHL3i07Uv3uPefDHVDRtj69desMiwMf12uvzCGskizj59OJJ+bRf6qjf/B0SVdOkt1
        GBi7drlRIjEF0iM4bHMMWyTrh7qGsJ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-lYfuRa2JPnaHhPowZP6EOw-1; Thu, 28 Apr 2022 09:22:49 -0400
X-MC-Unique: lYfuRa2JPnaHhPowZP6EOw-1
Received: by mail-wm1-f69.google.com with SMTP id k41-20020a05600c1ca900b0039415d40dbbso517405wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a14xq4pv5r/FkYeXeUtrnJ56gM2JRtUzYDAyxUxKyXw=;
        b=rechXkeQkYfBANUsV275z486wqBUIY0BKcLDeIL2rhjWjfAM/jnOZPjxlIPVDvPV8W
         poMTw8L4b9aFQImnGT4Vq1SNn2G12OLC4hG+bIqhkLut73GYrbdWIneyJghvC3NloffH
         c3THNDuYI33sD48QE+uBfYqisrDg+gjBOvJX59LznZI5uDfzMe+p7s/4slrv35tUGUnp
         /QgPp5GgXXfrNKwSj66uV012UpYWuLSTQJFsXVM2hcpuKqpI2UZ8ZO19t4ct6XG0r4HF
         NSrxYmx5rg4paXrmrwoc0yaINQ7HU3Seq5/GwUCH83Ax7dhv51G24jXQW/ev7eG74I9p
         BLqA==
X-Gm-Message-State: AOAM531MV0nz6s4Dzqn3nAsR9LEMbYxq1tWDU3iacG0HX50jADJLv6E9
        rKpcZVOWe9BDiqH38UYUsbArl8vwM9iPjDuab4lNHMWi0FP4uv4YPMEiM5ptURsE/yGhdukHvF3
        a498DqBDTaSnENjON5JP2uOsW
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr31169266wmr.15.1651152168729;
        Thu, 28 Apr 2022 06:22:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQVnCQJ38EwfNhzDeSYDCstkye3h+BWbMt9XxC8erbs+iXajlC/fBdW5XhbJa/npUVsWgZzw==
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr31169254wmr.15.1651152168532;
        Thu, 28 Apr 2022 06:22:48 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-234.retail.telecomitalia.it. [87.11.6.234])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm4680978wmq.41.2022.04.28.06.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:22:47 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Vilas R K <vilas.r.k@intel.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next 2/2] vsock/virtio: add support for device suspend/resume
Date:   Thu, 28 Apr 2022 15:22:41 +0200
Message-Id: <20220428132241.152679-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428132241.152679-1-sgarzare@redhat.com>
References: <20220428132241.152679-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement .freeze and .restore callbacks of struct virtio_driver
to support device suspend/resume.

During suspension all connected sockets are reset and VQs deleted.
During resume the VQs are re-initialized.

Reported by: Vilas R K <vilas.r.k@intel.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 31f4f6f40614..ad64f403536a 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -743,6 +743,49 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	kfree(vsock);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_vsock_freeze(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	rcu_assign_pointer(the_virtio_vsock, NULL);
+	synchronize_rcu();
+
+	virtio_vsock_vqs_del(vsock);
+
+	mutex_unlock(&the_virtio_vsock_mutex);
+
+	return 0;
+}
+
+static int virtio_vsock_restore(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+	int ret;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	/* Only one virtio-vsock device per guest is supported */
+	if (rcu_dereference_protected(the_virtio_vsock,
+				lockdep_is_held(&the_virtio_vsock_mutex))) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = virtio_vsock_vqs_init(vsock);
+	if (ret < 0)
+		goto out;
+
+	rcu_assign_pointer(the_virtio_vsock, vsock);
+
+out:
+	mutex_unlock(&the_virtio_vsock_mutex);
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_VSOCK, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -760,6 +803,10 @@ static struct virtio_driver virtio_vsock_driver = {
 	.id_table = id_table,
 	.probe = virtio_vsock_probe,
 	.remove = virtio_vsock_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_vsock_freeze,
+	.restore = virtio_vsock_restore,
+#endif
 };
 
 static int __init virtio_vsock_init(void)
-- 
2.35.1

