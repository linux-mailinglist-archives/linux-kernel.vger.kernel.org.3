Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A66D52B118
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiEREIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEREI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9A3614A24F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652846641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUK1Bi2BjYFDmK4YfFux7VS/n2JCtPpq0idhojywc4U=;
        b=gnWBvINpjELl/ozXLdmp7JrgixGk0B51U++vYsqQbcT9DiQjOXb/GySeOxTLMDbIWcaNQy
        QetaIykfSkMtierI8P+hAV6I4XJYdZZ/+zj2L9jN1hz00zMAMKY0Es9X19OQSVFee3nBBw
        jdk63lpySYhpf2lwFEXRvxhTrJXKAtk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-0_V0qlocPo6L2n4opOPfIQ-1; Wed, 18 May 2022 00:00:17 -0400
X-MC-Unique: 0_V0qlocPo6L2n4opOPfIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7597E804197;
        Wed, 18 May 2022 04:00:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-14-27.pek2.redhat.com [10.72.14.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7091121314;
        Wed, 18 May 2022 04:00:09 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH V5 1/9] virtio: use virtio_device_ready() in virtio_device_restore()
Date:   Wed, 18 May 2022 11:59:43 +0800
Message-Id: <20220518035951.94220-2-jasowang@redhat.com>
In-Reply-To: <20220518035951.94220-1-jasowang@redhat.com>
References: <20220518035951.94220-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

It will allow us to do extension on virtio_device_ready() without
duplicating code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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

