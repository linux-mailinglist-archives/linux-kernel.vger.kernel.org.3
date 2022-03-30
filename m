Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7764EBAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbiC3G0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiC3GZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70828517EC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648621425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5XfMGd9jclB7Y89wnX07DRxpXe9qfoOyLMTpktP1Go=;
        b=Gi8K4WCETdl8pIDajVVRy6au5cgbiiuqf28czJGBHarStW2BUa0uAWmD3xYxEtEzpQsWl6
        ly2j/Mg8cxwFGZESnj/4ClHNpyK5i33YLhuGgahRLRJOrXMusBquD5H2fGm7kGixwqCZ6T
        QB0EYQiCUDEP7Pp/4SF10/04k08Y994=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-3VHKqq7qPiWWoF-SBseq0A-1; Wed, 30 Mar 2022 02:23:34 -0400
X-MC-Unique: 3VHKqq7qPiWWoF-SBseq0A-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a05600c214200b0038c7c02deceso2167275wml.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N5XfMGd9jclB7Y89wnX07DRxpXe9qfoOyLMTpktP1Go=;
        b=r3wGNwMJWLN2KdMzHZW5QzIYpcvOq+DzycultjRnmeVxj5J8oBGNw5jf1KhbY02En3
         IgBD0plKjyW/8mgQb0Cf8g29RTLncYxZLbD0Mcfs3XT/z8U/Lod1r4s761IBC16+PY08
         S9TBsPSHOfhODkJ0fTYJektpt53QudCAw2x/W0WgsydHm92rVUhqlwZR/IMYkpQ1DrYk
         J5ePcior1u93oPWkzA/gUY0e4S5WRfw1PglaT4lbCmuYlYBla68X7TZT3NRq84w5ZiDh
         TyFA2xRojNBAxIiT5KN2etjuoF2f4kty+nPWS+ocgYzQd5h1GQLvDTgzpA4zyIL0/a6t
         VdPQ==
X-Gm-Message-State: AOAM533Hjnzjo5uqXo19gyw3Vfl1UWuGB6jJR4BfU2oFQ0S2uj7ckW/y
        IKhjqg3hwTX/wFgTUZUP+X7VDjR2WukYCX3qUgY1jHADSD3gms3tnC6zAvONyrJtIDMhfosnWqh
        XUu1g3ZmNhubevclDOIUvXoyrr5T2EpSIE6lzhw23kceqtWh9VJId4NqORrSv6C73KnWkNA==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id u14-20020a056000038e00b00204101ab2bfmr35760768wrf.308.1648621413163;
        Tue, 29 Mar 2022 23:23:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISs0u26955cnW/k6f0wGfHnfWVmb1Bxl8fBIKYFV5DYAcUY7i7AIUsaUgjsvbX0suwvm3DA==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id u14-20020a056000038e00b00204101ab2bfmr35760748wrf.308.1648621412840;
        Tue, 29 Mar 2022 23:23:32 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d66c5000000b00203fd25f4ecsm15756665wrw.16.2022.03.29.23.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 23:23:32 -0700 (PDT)
Date:   Wed, 30 Mar 2022 02:23:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] Revert "virtio_config: introduce a new .enable_cbs
 method"
Message-ID: <20220330062315.125924-2-mst@redhat.com>
References: <20220330062315.125924-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330062315.125924-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d50497eb4e554e1f0351e1836ee7241c059592e6.

The new callback ended up not being used, and it's asymmetrical:
just enable, no disable.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index dafdc7f48c01..b341dd62aa4d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -23,8 +23,6 @@ struct virtio_shm_region {
  *       any of @get/@set, @get_status/@set_status, or @get_features/
  *       @finalize_features are NOT safe to be called from an atomic
  *       context.
- * @enable_cbs: enable the callbacks
- *      vdev: the virtio_device
  * @get: read the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
@@ -78,7 +76,6 @@ struct virtio_shm_region {
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
-	void (*enable_cbs)(struct virtio_device *vdev);
 	void (*get)(struct virtio_device *vdev, unsigned offset,
 		    void *buf, unsigned len);
 	void (*set)(struct virtio_device *vdev, unsigned offset,
@@ -233,9 +230,6 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
-	if (dev->config->enable_cbs)
-                  dev->config->enable_cbs(dev);
-
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
-- 
MST

