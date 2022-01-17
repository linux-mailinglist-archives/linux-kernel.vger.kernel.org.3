Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF349033A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiAQHzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235240AbiAQHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642406150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S794o1+gxZiFBik2xQJ/yYRJWwEkmKRwWvfOGmOlz/A=;
        b=OmSMV8pShftMaQZhRb+huTuVALWaJ9N2ay9nsy9hnArSbInPVMiEWgACcChS3rQxXeFD9J
        0QYgitWEUvr/liB+B7D2iJUU08dMrfuFlgyEIgCXVCV352NJVRR/7xCOPhHVUg6TC4QIJm
        F/vmvy/i2fHaE7BUQF/2GZei6vwUZJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-uSH-nGMgO_SDnLn1dqk1ww-1; Mon, 17 Jan 2022 02:55:47 -0500
X-MC-Unique: uSH-nGMgO_SDnLn1dqk1ww-1
Received: by mail-wm1-f71.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so13344287wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S794o1+gxZiFBik2xQJ/yYRJWwEkmKRwWvfOGmOlz/A=;
        b=cORyE1XfWZzV4XRYR8o7nWbr1CtelKCUFyZM+hAb/9JZWbaqfdQcl4EUen5wWZhhh+
         XGKDPGAs7NfygAuaJaFyn4V4lwRYCjMS8U8pXKMM5H1YrEvNcJ+XQSTmpLDK5EPPcKRm
         uiZTpzXlkbvAEqHxq2HN0sPh/b2BrGK+H2/OV1zo7UF9PgUto+Irzl7MU3aITJ9QbdCg
         5cER+ulWQxo86BiV5hDrl1brPeDt/6Z63DDc/pLGRfuuO+TVO+2u6+53djE6dCvJBudv
         C1xv4+EIVKUSaJzIcwclJTyd7HxozXWV0OwswVJ8ftGou6Z8aWKQ7Hhm7Q3YSVO8PnWJ
         cAFA==
X-Gm-Message-State: AOAM532C6mYhW5YWTdfCleZR1ebYzrguAKN3vp1OQkLYRfWlas6Jp0xP
        p8qsDhFhIjhEGgvS3k/KfDKjbeKljWhrfsnfSPhnR95GXnhh+V3fg9tVR8XNQNJ4km3W0pg39dW
        3XGEtstOfbkMv/u4ffPSX5Exw
X-Received: by 2002:a5d:6251:: with SMTP id m17mr10886823wrv.49.1642406146785;
        Sun, 16 Jan 2022 23:55:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyppKFvTpSnYReosIo+xIkvfCskoqdMVLvEKl0f9W0+ccEUUAvaX0prC3KjSPi1+jccsmbe7w==
X-Received: by 2002:a5d:6251:: with SMTP id m17mr10886814wrv.49.1642406146588;
        Sun, 16 Jan 2022 23:55:46 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id t15sm12611807wrz.82.2022.01.16.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 23:55:46 -0800 (PST)
Date:   Mon, 17 Jan 2022 02:55:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_mem: break device on remove
Message-ID: <20220117025341-mutt-send-email-mst@kernel.org>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 02:40:11PM +0800, Jason Wang wrote:
> 
> 在 2022/1/15 上午5:43, Michael S. Tsirkin 写道:
> > A common pattern for device reset is currently:
> > vdev->config->reset(vdev);
> > .. cleanup ..
> > 
> > reset prevents new interrupts from arriving and waits for interrupt
> > handlers to finish.
> > 
> > However if - as is common - the handler queues a work request which is
> > flushed during the cleanup stage, we have code adding buffers / trying
> > to get buffers while device is reset. Not good.
> > 
> > This was reproduced by running
> > 	modprobe virtio_console
> > 	modprobe -r virtio_console
> > in a loop, and this reasoning seems to apply to virtio mem though
> > I could not reproduce it there.
> > 
> > Fix this up by calling virtio_break_device + flush before reset.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/virtio/virtio_mem.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> > index 38becd8d578c..33b8a118a3ae 100644
> > --- a/drivers/virtio/virtio_mem.c
> > +++ b/drivers/virtio/virtio_mem.c
> > @@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> >   		virtio_mem_deinit_hotplug(vm);
> >   	/* reset the device and cleanup the queues */
> > +	virtio_break_device(vdev);
> > +	flush_work(&vm->wq);
> 
> 
> We set vm->removing to true and call cancel_work_sync() in
> virtio_mem_deinit_hotplug(). Isn't is sufficient?
> 
> Thanks


Hmm I think you are right. David, I will drop this for now.
Up to you to consider whether some central capability will be
helpful as a replacement for the virtio-mem specific "removing" flag.

> 
> >   	virtio_reset_device(vdev);
> >   	vdev->config->del_vqs(vdev);

