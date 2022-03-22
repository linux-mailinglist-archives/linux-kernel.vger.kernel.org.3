Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D94E3FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiCVNhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiCVNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A93B87B565
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647956183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yEfbx3KDPFlRi9NsR3t9OxuLawKBXpgCccFQfHQvcxA=;
        b=hOMF84L0Qf6VgOuo7cNxmFaGHspaucI2gKe/ogCOZjL+bPhHa+rTSy6+vxS1aJa4ZlWcyS
        lCh7t3bS/lU/goUPvrocblc9sLZtAxx2z9k/HdUNtIztCGLYmnigInyXLdQGM4d3FErSma
        wGOKB4pdcOQ5IjaioXN75uMSZpojZ6E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-PkPyBdYXPKu3z_xY8ZzdBA-1; Tue, 22 Mar 2022 09:36:20 -0400
X-MC-Unique: PkPyBdYXPKu3z_xY8ZzdBA-1
Received: by mail-wm1-f72.google.com with SMTP id i6-20020a1c5406000000b0038c97ed0db5so3197440wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yEfbx3KDPFlRi9NsR3t9OxuLawKBXpgCccFQfHQvcxA=;
        b=tdiy/7L0UtfG5hbPmdDhsZfIAZZOJngu/i7tXNOZl919H+fkqlme/TKhWqa8+LrbwZ
         57J+Tz4zCQAjqoHTa9Qa7dwl+zFF/KnsP6Gy73OSJ0bjVBBOaq5C+tD682lEgWaWp0Vc
         xMuLXQ9MUXiE/AmVmwDH2EtR8zjl8oTu1DcREIcuuEM0L7gj111Px0JKFT0emtpTeur5
         O/kuxINRiwAVXxRxvUqPY4vh/lzlVbArQTTbPY5PZlzHwt+kC7f0M+XvCHK5WM2cFfxG
         oajHkyCBElh78/3Q3E414WJ15kHbx/88HK3oY3OdBskAeaQ/ACf9lPiaBR4Uprhq8+Cs
         d+Gg==
X-Gm-Message-State: AOAM530bmPLlRYrtOpV0NadSBz7SdD1GyZhwvNqSIul769ysa1cF24Q2
        snkBKcpVH+6hQsf9invGjDfuB6b39XFPFI4hYuFOCwL5/mBZ40wCNNY/OSU5MO4uOObgxqeoxhV
        M6sFA3vYKaVd/AuXJYE/YXxJL
X-Received: by 2002:a5d:5982:0:b0:204:1b19:40da with SMTP id n2-20020a5d5982000000b002041b1940damr6150034wri.23.1647956179337;
        Tue, 22 Mar 2022 06:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt2WiiDuMgW7o4aI8TTeUozv/0SKfKOVFu6npOXGitY0mPpGVzP8XK+kXs7cco7hBpouXLOw==
X-Received: by 2002:a5d:5982:0:b0:204:1b19:40da with SMTP id n2-20020a5d5982000000b002041b1940damr6150004wri.23.1647956179070;
        Tue, 22 Mar 2022 06:36:19 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm1910031wmq.46.2022.03.22.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:36:18 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:36:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Asias He <asias@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: enable VQs early on probe
Message-ID: <20220322092723-mutt-send-email-mst@kernel.org>
References: <20220322103823.83411-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322103823.83411-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:38:23AM +0100, Stefano Garzarella wrote:
> virtio spec requires drivers to set DRIVER_OK before using VQs.
> This is set automatically after probe returns, but virtio-vsock
> driver uses VQs in the probe function to fill rx and event VQs
> with new buffers.


So this is a spec violation. absolutely.

> Let's fix this, calling virtio_device_ready() before using VQs
> in the probe function.
> 
> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 5afc194a58bb..b1962f8cd502 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
>  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
>  
> +	virtio_device_ready(vdev);
> +
>  	mutex_lock(&vsock->tx_lock);
>  	vsock->tx_run = true;
>  	mutex_unlock(&vsock->tx_lock);

Here's the whole code snippet:


        mutex_lock(&vsock->tx_lock);
        vsock->tx_run = true;
        mutex_unlock(&vsock->tx_lock);

        mutex_lock(&vsock->rx_lock);
        virtio_vsock_rx_fill(vsock);
        vsock->rx_run = true;
        mutex_unlock(&vsock->rx_lock);

        mutex_lock(&vsock->event_lock);
        virtio_vsock_event_fill(vsock);
        vsock->event_run = true;
        mutex_unlock(&vsock->event_lock);

        if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
                vsock->seqpacket_allow = true;

        vdev->priv = vsock;
        rcu_assign_pointer(the_virtio_vsock, vsock);

        mutex_unlock(&the_virtio_vsock_mutex);


I worry that this is not the only problem here:
seqpacket_allow and setting of vdev->priv at least after
device is active look suspicious.
E.g.:

static void virtio_vsock_event_done(struct virtqueue *vq)
{
        struct virtio_vsock *vsock = vq->vdev->priv;

        if (!vsock)
                return;
        queue_work(virtio_vsock_workqueue, &vsock->event_work);
}

looks like it will miss events now they will be reported earlier.
One might say that since vq has been kicked it might send
interrupts earlier too so not a new problem, but
there's a chance device actually waits until DRIVER_OK
to start operating.


> -- 
> 2.35.1

