Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802A651E52A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445990AbiEGHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446027AbiEGHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FFC66160E
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651908064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OrDhR3xrTuYjXDb+dW3SHAfSccXogpE1Lj4O6Dtyns=;
        b=g77F7I9fzveDaLuFWXFZpqRO7VeEzjMJWcK/ykoPWyz6VPRriz5qk+l2yUdzQD8qvQ1yAt
        GWqDNyFu06tNw3sQtt4c3tHJNXbjMn7MeR/tyZ9X3lq7MAl9aErxDsJOFuOtu0OEzYWVzh
        bx5tLUXO1jJgtoLemkr0i7wxz9rg8YU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-rT-x5dtrOwyDQc22EMAw_g-1; Sat, 07 May 2022 03:21:03 -0400
X-MC-Unique: rT-x5dtrOwyDQc22EMAw_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77C283810D3F;
        Sat,  7 May 2022 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-216.pek2.redhat.com [10.72.13.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E954C40D2971;
        Sat,  7 May 2022 07:20:56 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH V4 9/9] virtio: use WARN_ON() to warning illegal status value
Date:   Sat,  7 May 2022 15:19:54 +0800
Message-Id: <20220507071954.14455-10-jasowang@redhat.com>
In-Reply-To: <20220507071954.14455-1-jasowang@redhat.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to use BUG_ON() in virtio_device_ready() to detect illegal
status value, this seems sub-optimal since the value is under the
control of the device. Switch to use WARN_ON() instead.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 23f1694cdbd5..5d539f39f7ee 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -255,7 +255,7 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
-	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 
 	/*
 	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
-- 
2.25.1

