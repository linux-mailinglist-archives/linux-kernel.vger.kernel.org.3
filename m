Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794E0464381
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbhK3XiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241388AbhK3XiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638315298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GdpNBT7tOVqqTmqVJ8xdgf1nbTSEx6kcMW8RvUyDwUQ=;
        b=X4SwTL5jZvKKrF1kMjDFV2RVhf0S0b4Msu3UoU/xf87iwz3DrcVWGLSkEEXcsr7i7x7BG4
        ALLvuEJ3aH8xd6gCkbKWaRsvJB06Q38n2mgREm8+leKwp89sTtncTx+iWWI1vSWpNf4Dc5
        S8QIBrPTZtNlfgajYQ5WY26c1REMFy4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-XuZCKD5aMgeFCRkfQYmPoQ-1; Tue, 30 Nov 2021 18:34:57 -0500
X-MC-Unique: XuZCKD5aMgeFCRkfQYmPoQ-1
Received: by mail-ed1-f71.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so18414607edx.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdpNBT7tOVqqTmqVJ8xdgf1nbTSEx6kcMW8RvUyDwUQ=;
        b=UhkTZNGEn0K6sfYDwGeAb1VG4vSKznDzZtYqrBBPGRhhtKVeI4NiS9DcFRUz13KzcX
         w66gGBAViMDcoCCo7aO6uBJzbmFy5u6RLKqR/EhUcxBMIA0tiyX8ybgPxnSfs+RCnM0J
         OnQWaepd9KfYXcvGjqWo/CUDTFsK+9aXEqE8iNkSre5rKkiai9Y2ixV/8/6RD0fbzFJH
         QB4AF+TKf457+FSKdcIaGxe9taVFwMs4UVysevaWpqxD2Aq2LJD+noAVkcA5+sG+nxY4
         P4e4B10vS2BC4sefQuYR01HI3dR9+3l3PUigljqUE+eYpdRRaVLXD5k4wBRoUqBKfI3/
         Y3dQ==
X-Gm-Message-State: AOAM530KG+tmI9ge0cLNnqm0IUYz+qB+b3x/eKAFSriTrgXe0VSdAbuI
        /+SbUWD0uSIEMIM/jgJsTf4JX9FTxoYi1aHEMej5UlhiHjrkU2oC+NDtYhRyt0meLVu7Bs6CDS2
        ABfrutueeMRuoQG5JwEOl9/ey
X-Received: by 2002:a17:906:4e42:: with SMTP id g2mr2642866ejw.230.1638315296070;
        Tue, 30 Nov 2021 15:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyf8H+HN0kOqlHFT43UIstlOhAvrRhtSbI9tcJcD/y7tQP4Qind2uTR2BwAPdeqaxhjTGu6Bw==
X-Received: by 2002:a17:906:4e42:: with SMTP id g2mr2642852ejw.230.1638315295943;
        Tue, 30 Nov 2021 15:34:55 -0800 (PST)
Received: from redhat.com ([2.53.15.215])
        by smtp.gmail.com with ESMTPSA id e1sm12182243edc.27.2021.11.30.15.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:34:55 -0800 (PST)
Date:   Tue, 30 Nov 2021 18:34:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Parav Pandit <parav@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        edumazet@google.com, kbuild-all@lists.01.org, lkp@intel.com,
        linux-kernel@vger.kernel.org, kbuild@lists.01.org, elic@nvidia.com,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v1] vdpa: Consider device id larger than 31
Message-ID: <20211130183432-mutt-send-email-mst@kernel.org>
References: <20211130042949.88958-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130042949.88958-1-parav@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:29:49AM +0200, Parav Pandit wrote:
> virtio device id value can be more than 31. Hence, use BIT_ULL in
> assignment.
> 
> Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> changelog:
> v0->v1:
>  - supporting device id up to 63
> ---
>  drivers/vdpa/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..09bbe53c3ac4 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -404,7 +404,8 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>  		goto msg_err;
>  
>  	while (mdev->id_table[i].device) {
> -		supported_classes |= BIT(mdev->id_table[i].device);
> +		if (mdev->id_table[i].device <= 63)
> +			supported_classes |= BIT_ULL(mdev->id_table[i].device);
>  		i++;
>  	}


Not for this release, but a for loop will be cleaner here.

> -- 
> 2.26.2

