Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA84E620E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbiCXLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiCXLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC5D15BD0E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648119857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QzKBoZ1rRX3VzCL9ZTZ74cnxlXwhmkLuajM8brTFu9o=;
        b=dIUpmJ4EFc2Anj1E8/l9oJo/6SZZUgKNnGoaQbh1c6ZoqO3cYwpgfiichw0Z4LxU2LmpbE
        jcGfS+D5BckbdXcduU1m8i/gC41Hp7ZT1RFeJPoYLe+fytnUaBDKSQ0LTcsbeZUaWA/Qax
        1dnPqlewLXLM4xnmZTYZQPEos3GtN+s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-c-6Bzi45NqOqP5hFmWNDeQ-1; Thu, 24 Mar 2022 07:04:16 -0400
X-MC-Unique: c-6Bzi45NqOqP5hFmWNDeQ-1
Received: by mail-qv1-f71.google.com with SMTP id h18-20020a05621402f200b00440cedaa9a2so3324438qvu.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzKBoZ1rRX3VzCL9ZTZ74cnxlXwhmkLuajM8brTFu9o=;
        b=Gt9bPGHdhJC846xSKp7/sSMPRLd7Qcr0YLXNERV/p7Q1sL9G37y1MATx0dm6uwcksV
         3YHYOr+cUwTLlHSiNYWusVV/hKiHVMhSoqPCh9hj+yr6xxfdlujelbuiXqwYBzcqntgx
         nbEI8HCcOJJKRPSgidwxY6EUXwcsUIWcyYSp20H2YZgOpj0VIVseVkmDdcB04UcanejR
         rWO6wJ5+YMXlTqvQFoBOdSG2iAy/5buxY799A4pelobVG9YvQP4re+2rugHZ3Bn14owW
         LwQQYnSyDxS7FieaSKARwEHggYtT2A8VtWLQzq4tMivc17Bg8HhFmm78Ke/uTDKUQPSX
         QjtA==
X-Gm-Message-State: AOAM530+YPeAcY1S25CUfWrAJAQ1GF6mM92xFjESF0OGzJaFRYJ0e+4a
        Ik7+0Q4Cb+NUAWc2CFcRlJDXqtBGRT21f7CKvTTYxrpxAFKjuPfEGoXI1NdZjUvkoaRsybVWcqz
        b0+Oo6d/0DCk3uBELCGUizdzS
X-Received: by 2002:a05:622a:1491:b0:2e2:2faa:dd47 with SMTP id t17-20020a05622a149100b002e22faadd47mr3827498qtx.142.1648119855068;
        Thu, 24 Mar 2022 04:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/wQU8MsdSrsLRUuClD5GYcuKTmcmliL/h8xBYtLUnGZZtN/JCvCQVu4EX161cOJ6FTBdng==
X-Received: by 2002:a05:622a:1491:b0:2e2:2faa:dd47 with SMTP id t17-20020a05622a149100b002e22faadd47mr3827473qtx.142.1648119854871;
        Thu, 24 Mar 2022 04:04:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8068e000000b002dd1bc00eadsm2010781qth.93.2022.03.24.04.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:04:14 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:04:09 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keirf@google.com
Subject: Re: [PATCH 2/3] virtio: use virtio_reset_device() when possible
Message-ID: <20220324110409.d3s4cgbomuaezv6h@sgarzare-redhat>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220324084004.14349-3-jasowang@redhat.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:40:03PM +0800, Jason Wang wrote:
>This allows us to do common extension without duplicating codes.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/virtio/virtio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index 75c8d560bbd3..8dde44ea044a 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
>
> 	/* We always start by resetting the device, in case a previous
> 	 * driver messed it up.  This also tests that code path a little. */
>-	dev->config->reset(dev);
>+	virtio_reset_device(dev);
>
> 	/* Acknowledge that we've seen the device. */
> 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>@@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
>
> 	/* We always start by resetting the device, in case a previous
> 	 * driver messed it up. */
>-	dev->config->reset(dev);
>+	virtio_reset_device(dev);
>
> 	/* Acknowledge that we've seen the device. */
> 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

