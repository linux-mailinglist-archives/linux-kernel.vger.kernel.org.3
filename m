Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D35512A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiFTIZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFTIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20A97105
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655713485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6ksPPnyGgOYO6quOjNZEzWgaMag0zFdWZyTCSpNBko=;
        b=Gwke25D+AhuWklw9TJA7JooY6+2vzHcDY87Uz2INEqHegE29rr6ktN22z7vOAFqNYm/r/7
        mGwmHyQKvOGti77737Y832Kd9ZRJr76YogZxAZgFVATvcl7+2ZUjVi7nWPk/pk6uP72/US
        ns84C5qn5B+RWuo+Kb+saZlz990wilY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-67wBrxcaNO2M5cuzvYCjtg-1; Mon, 20 Jun 2022 04:24:36 -0400
X-MC-Unique: 67wBrxcaNO2M5cuzvYCjtg-1
Received: by mail-ej1-f69.google.com with SMTP id fp4-20020a1709069e0400b00711911cecf9so3133298ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6ksPPnyGgOYO6quOjNZEzWgaMag0zFdWZyTCSpNBko=;
        b=EEtQazgthVRnMMG6xsJVFi46RjRTxP9jIIqJtYZvXGZGlg73K+AkaOm0hpymwkRBsJ
         BeYlNonjD6DZ9TsnALAxoahAKzR6eu/OqEAHdVZ0KLfIUPEjR4T0AH02+Sxitb20lCS8
         VZvujVsXS8X2uGx7LSpfzbBsrACh5HdLr2fCQApftxNFJfKK0d2Ng+9YwtAi/fllyRaH
         nz5oU7qP6pQg6TOPpaGKJ3JHbCaIQvr8EuaM0wHx8az16iDlekR+ehd20ZS07eZyAyyR
         7r8Tul7s51vThCiVGR+9a5+vJfsWXBBcCCnZQAPKCsw35H1xhhPiIrwR1lRm/4/DKUTY
         kaMg==
X-Gm-Message-State: AJIora8N8rA8jBdIZiOh7zul76mFaSRMQjvzSpzig1bbeMJe7HUzXsRT
        iVIwNRPyHDaJVOsFAOv5EyXtvG8crU6HbsgZFGTItd0tko/yTVZQ8lG6XkRIJ/kHJlrQPM5Jh0H
        C96FXreBiHO796xMwVIcV36y+
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id b14-20020a056402350e00b0042fb2c19393mr28239620edd.11.1655713474777;
        Mon, 20 Jun 2022 01:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZJFz4jypDP9bnqRJi3iDgujFYlZ8/dhQlpRBA4gnyiHbIdX6gXU3ScDQzxUS9zbdSyqyZfQ==
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id b14-20020a056402350e00b0042fb2c19393mr28239603edd.11.1655713474518;
        Mon, 20 Jun 2022 01:24:34 -0700 (PDT)
Received: from redhat.com ([2.52.146.221])
        by smtp.gmail.com with ESMTPSA id c25-20020aa7d619000000b0043574d27ddasm4114501edr.16.2022.06.20.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:24:33 -0700 (PDT)
Date:   Mon, 20 Jun 2022 04:24:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: Optimize duplicate judgment codes for
 virtqueue_add_split
Message-ID: <20220620042221-mutt-send-email-mst@kernel.org>
References: <20220620080656.1559-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620080656.1559-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:06:56AM -0400, Deming Wang wrote:
> We combine repeated judgments about indirect in one place
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>


Point being? The patch makes the code kind of confusing.
What do we gain in return?

> ---
>  drivers/virtio/virtio_ring.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..331fa3cf5be7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -582,23 +582,19 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  					 total_sg * sizeof(struct vring_desc),
>  					 VRING_DESC_F_INDIRECT,
>  					 false);
> +		vq->free_head = vq->split.desc_extra[head].next;
> +		vq->split.desc_state[head].indir_desc = desc;
> +	} else {
> +		/* Update free pointer */
> +		vq->free_head = i;
> +		vq->split.desc_state[head].indir_desc = ctx;
>  	}
>  
>  	/* We're using some buffers from the free list. */
>  	vq->vq.num_free -= descs_used;
>  
> -	/* Update free pointer */
> -	if (indirect)
> -		vq->free_head = vq->split.desc_extra[head].next;
> -	else
> -		vq->free_head = i;
> -
>  	/* Store token and indirect buffer state. */
>  	vq->split.desc_state[head].data = data;
> -	if (indirect)
> -		vq->split.desc_state[head].indir_desc = desc;
> -	else
> -		vq->split.desc_state[head].indir_desc = ctx;
>  
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
> -- 
> 2.27.0

