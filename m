Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C824C4E6087
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiCXImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348995AbiCXImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAA409D04A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648111233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YVN3Z4ALPsJ831T0Et8KXdlyQO9D/giSRlpYVR7Ufo=;
        b=Rk7S50ebwQrn4s6Ul/6C3KhIG5zX6KWzQ+VmGhA2jnApzCxXWiWI7vm9y1dZkynI4xPNDJ
        crPyhXZff2Lp1aDKalUtE084gXDpCOgSWkl3jafL7Y7brHmF77QDJmWzTyIQMjY/HXESJ0
        6QOkjwbecTnIpMoaLpV154Pt/zatr9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-tBTYbpZIPi615OveNkuBxg-1; Thu, 24 Mar 2022 04:40:30 -0400
X-MC-Unique: tBTYbpZIPi615OveNkuBxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF5D9857A83;
        Thu, 24 Mar 2022 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com [10.72.13.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A322C40CF8ED;
        Thu, 24 Mar 2022 08:40:25 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com, keirf@google.com
Subject: [PATCH 1/3] virtio: use virtio_device_ready() in virtio_device_restore()
Date:   Thu, 24 Mar 2022 16:40:02 +0800
Message-Id: <20220324084004.14349-2-jasowang@redhat.com>
In-Reply-To: <20220324084004.14349-1-jasowang@redhat.com>
References: <20220324084004.14349-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

This avoids setting DRIVER_OK twice for those drivers that call
virtio_device_ready() in the .restore and it will allows us to do
extension on virtio_device_ready() without duplicating codes.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 22f15f444f75..75c8d560bbd3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
 			goto err;
 	}
 
-	/* Finally, tell the device we're all set */
-	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
 
 	virtio_config_enable(dev);
 
-- 
2.25.1

