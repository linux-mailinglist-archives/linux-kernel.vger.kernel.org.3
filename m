Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D25549D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiFVMPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358341AbiFVMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47855340C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655900120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQ0/S4hTGe/CYe8u/0j1fhgzO/f/h03uTX6vN/h92Tk=;
        b=bMYnECgmd86SOKnLOzS/7vDaZLYXsKGssjQEpxQ20rBwl3wY+li/C3D7rIJFv0sno8ARfg
        SbSnbKmoUCdekLhL+GB8VZrA4hsFzmsQ+6+juFlR/HPRVyww4UoV+Eshg6DWoK53S8iql9
        kfXdwZjagPXB9rt9hwncReviXJuOx/g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-Q_msMRW9Pe2umA16aVfbNg-1; Wed, 22 Jun 2022 08:15:17 -0400
X-MC-Unique: Q_msMRW9Pe2umA16aVfbNg-1
Received: by mail-wr1-f69.google.com with SMTP id y18-20020adfdf12000000b0021b94ba4c37so1647623wrl.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQ0/S4hTGe/CYe8u/0j1fhgzO/f/h03uTX6vN/h92Tk=;
        b=mvraAc+Vtr+7zjrsOhmx7jhphcXwbnY0lZYm9agfCnmLeaB42k5mIQOsB8e8jtdnto
         X73sQh7HKKGuH0C6s5zx8rBrPY0pg8BCxp72IS4eXv5WjTqQeThceB5OiHb9rSEOnIkd
         UH5PaMhn//Zw0bBLQUf/AKF7+aTsdcV8UDfbUHgpAXVDsPrRYSV7ixczxNPa2SYenODI
         H8ydDnTGhw3pXGo69FoqGCaJvj37d81ADJIeDoGwSDcYKQ0wWjWKKoHM6iplQEoZIRIQ
         4WQ2UgXqxeY9a5p1HjxIldHXAS4xmh6t4kgm31u9tn8GNUy46jzRa6CGq+vYne0QbUti
         Xv9w==
X-Gm-Message-State: AJIora+yA7RcK5EXRn1rmpuFg5lQJCcVoDMhNbD6cWQhJ+qACyzcuidU
        MGpwQfQwABnqVxGnDxCKOrdK3/hWthYacUvD14VGb+3JLHSsoy38kmc/7C6b6CvLN6bBzTftLsL
        BH9qGKk4kAseqZGuNi6cxmQ6U
X-Received: by 2002:adf:f7c7:0:b0:21b:9452:e8fe with SMTP id a7-20020adff7c7000000b0021b9452e8femr3211545wrq.640.1655900115861;
        Wed, 22 Jun 2022 05:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uw/M5KspGlqskc/kFQvcJ3XkxHAQCDS3r8X8uIM7gfQdn0B5UzoYAktVnD2Jx/JTdYhXLqyA==
X-Received: by 2002:adf:f7c7:0:b0:21b:9452:e8fe with SMTP id a7-20020adff7c7000000b0021b9452e8femr3211525wrq.640.1655900115574;
        Wed, 22 Jun 2022 05:15:15 -0700 (PDT)
Received: from redhat.com ([147.235.217.93])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c2ccf00b003974a00697esm26140287wmc.38.2022.06.22.05.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 05:15:14 -0700 (PDT)
Date:   Wed, 22 Jun 2022 08:15:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call in
 virtqueue_disable_cb_packed
Message-ID: <20220622081411-mutt-send-email-mst@kernel.org>
References: <20220622075052.1560-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622075052.1560-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:50:52AM -0400, Deming Wang wrote:
> It passes '_vq' to virtqueue_use_indirect(), which still calls
> to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq in hot path.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

I do not see the point of any of these patches. Sorry.
If this is supposed to be an optimization, post some numbers pls.


> ---
>  drivers/virtio/virtio_ring.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..af2b7785ed77 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1475,10 +1475,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	return ret;
>  }
>  
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
>  		vq->packed.vring.driver->flags =
> @@ -2007,7 +2005,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  		return;
>  
>  	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(_vq);
> +		virtqueue_disable_cb_packed(vq);
>  	else
>  		virtqueue_disable_cb_split(_vq);
>  }
> -- 
> 2.27.0

