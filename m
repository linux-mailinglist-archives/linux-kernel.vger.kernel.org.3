Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555B6490408
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiAQIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238267AbiAQIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642408849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLjuH51cFkRJWVNi3hBO0xfpEwddo5qConrJZzRzMjU=;
        b=YYAkVJ1EXyYfqpOiRL0Mi3bDGt/XakGREToGcVVw0Hp6vWpcNEK/pUJ4O3zPFVSPyZHi7y
        Bhi0+qLEsUMxmuop2iQoxzpY400ta/I3QIaxKENb2oZM4u7s2HqV5y1HVMznjPkt8W4CAV
        ku2Ty7npTcLxOi6J0CZ3COpzZN1iV8g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-n_hVKZt9OkylqGt8uNiyxw-1; Mon, 17 Jan 2022 03:40:47 -0500
X-MC-Unique: n_hVKZt9OkylqGt8uNiyxw-1
Received: by mail-wm1-f69.google.com with SMTP id l20-20020a05600c1d1400b0034c29cad547so3055151wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BLjuH51cFkRJWVNi3hBO0xfpEwddo5qConrJZzRzMjU=;
        b=ITALkTDGlrTSRx5CBt60jxVtdY7nINYFN205xgEDriI00feiUuhI2duosfqe0F9o0N
         uSHZ+QCW4Px1jN/5DIwbohBckV3++pQxfFPhwNCJ+gJPEMbke+h9c7QyEcJA+eLIHuTu
         dK58Z1VULXn1ubqXHY1rpABkZ07AWZ+uwx5IIrzakUDEdTV0D/7XICK4MXxXoYUr10CI
         9cYxmBMgB5QHRQPe5XbY8rueDE51YAnA3FbphcmuNXxilwEW3pcryN6nYLNQ9MBKYhjP
         8WPR/z2qZCeXGUh3m3Ucy/xJjQLAae1bL3D9SlJ6oC/x96prlGn0E41BJoeA5kmb6lb0
         rpVw==
X-Gm-Message-State: AOAM530vzyJbBN48iGchJR3OH7I722r17iWXitZ7Eeye2VwpnJeNJe73
        8Qt3JvEsfl5TlgLaybIQRPuzjnZZl5sRb3bSl5jDNJoXNfh8TbXHay8BifEVqbkqtQR1N+QWB65
        7/JDGuGqkYzx9jIacbkCgGK7N
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr17796698wrp.90.1642408846442;
        Mon, 17 Jan 2022 00:40:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXvnwrS6Hhqbeb42pM4DaQ5d43/2YR56/T2526aA/yVtEqYoPRUrehv7UyFOqn/AS4Ix3E9w==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr17796672wrp.90.1642408846176;
        Mon, 17 Jan 2022 00:40:46 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id y9sm5950678wrm.94.2022.01.17.00.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:40:45 -0800 (PST)
Date:   Mon, 17 Jan 2022 03:40:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_mem: break device on remove
Message-ID: <20220117033644-mutt-send-email-mst@kernel.org>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
 <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 09:31:56AM +0100, David Hildenbrand wrote:
> On 17.01.22 08:55, Michael S. Tsirkin wrote:
> > On Mon, Jan 17, 2022 at 02:40:11PM +0800, Jason Wang wrote:
> >>
> >> 在 2022/1/15 上午5:43, Michael S. Tsirkin 写道:
> >>> A common pattern for device reset is currently:
> >>> vdev->config->reset(vdev);
> >>> .. cleanup ..
> >>>
> >>> reset prevents new interrupts from arriving and waits for interrupt
> >>> handlers to finish.
> >>>
> >>> However if - as is common - the handler queues a work request which is
> >>> flushed during the cleanup stage, we have code adding buffers / trying
> >>> to get buffers while device is reset. Not good.
> >>>
> >>> This was reproduced by running
> >>> 	modprobe virtio_console
> >>> 	modprobe -r virtio_console
> >>> in a loop, and this reasoning seems to apply to virtio mem though
> >>> I could not reproduce it there.
> >>>
> >>> Fix this up by calling virtio_break_device + flush before reset.
> >>>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>>   drivers/virtio/virtio_mem.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> >>> index 38becd8d578c..33b8a118a3ae 100644
> >>> --- a/drivers/virtio/virtio_mem.c
> >>> +++ b/drivers/virtio/virtio_mem.c
> >>> @@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> >>>   		virtio_mem_deinit_hotplug(vm);
> >>>   	/* reset the device and cleanup the queues */
> >>> +	virtio_break_device(vdev);
> >>> +	flush_work(&vm->wq);
> >>
> >>
> >> We set vm->removing to true and call cancel_work_sync() in
> >> virtio_mem_deinit_hotplug(). Isn't is sufficient?
> >>
> >> Thanks
> > 
> > 
> > Hmm I think you are right. David, I will drop this for now.
> > Up to you to consider whether some central capability will be
> > helpful as a replacement for the virtio-mem specific "removing" flag.
> 
> It's all a bit tricky because we also have to handle pending timers and
> pending memory onlining/offlining operations in a controlled way. Maybe
> we could convert to virtio_break_device() and use the
> &dev->vqs_list_lock as a replacement for the removal_lock. However, I'm
> not 100% sure if it's nice to use that lock from
> drivers/virtio/virtio_mem.c directly.

We could add an API if you like. Or maybe it makes sense to add a
separate one that lets you find out that removal started. Need to figure
out how to handle suspend too then ...
Generally we have these checks that device is not going away
sprinkled over all drivers and I don't like it, but
it's not easy to build a sane API to handle it, especially
for high speed things when we can't take locks because performance.

> -- 
> Thanks,
> 
> David / dhildenb

