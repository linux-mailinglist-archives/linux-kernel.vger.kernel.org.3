Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1944538AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbiEaFma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiEaFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0C7E81486
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653975744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXZqQ2bmpu17MD3xsKbd7SyCjtmA473Yqjdy/U/0t2k=;
        b=Q+ESFjkk7m67tcs3eGghVr3qD5RwVpm9yvbyTb8XS+O+oj3Ru2ALWHH9ujqszcjOEPa2w9
        jPvzDduVzGAjc+J7JE7ve6YpsmmgsdrIFfSKuqZjmFZ1Kl81b7atRzE6pLiMHX8ot6rKLg
        KxPkTOMfEt10P5I2vdV2LUqxP1l0f4U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-zo7QDF_NPR-TPctBnDYWUA-1; Tue, 31 May 2022 01:42:15 -0400
X-MC-Unique: zo7QDF_NPR-TPctBnDYWUA-1
Received: by mail-wr1-f70.google.com with SMTP id h2-20020adfe982000000b002102da95c71so708324wrm.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lXZqQ2bmpu17MD3xsKbd7SyCjtmA473Yqjdy/U/0t2k=;
        b=T2Euw71qeFjZnjHAgXIvTOaS+D1FFR4l6OXWd/XBA7KIGlrwFPz4RFWmWCGGlCHBQK
         o/sIc/az9tQQEauP8CuziQjxY5YgaEDpZyEoQRtq+1jR14AbrHTb1m02/fJilf0AIKlW
         4Kl9ZTC4lyXVNuq2+Y0y5CHH/BjE0pfow1Tv49RrVPomPxjBC6hZYgtOh/16Yv526KpI
         vheV5Zem3vBGMNVPl6akhSGP75lm6/OGQt0+fdIU5KWdDuld8bA+K+AZufRx+69QXnFY
         0xDkJ9EwNpKuEmixJnwTQo1R1D0f4ypcjjm0tWyFLSaA8C2QAMlCF7MKUu8P514a2c/o
         3SFQ==
X-Gm-Message-State: AOAM531UaBw0IuamlI7Q1YTLgfgR7zvgWvazkkcnhufNEbRHsVQcIbXL
        GO/BUTVodH5KCFOK6ZADu8HFcWAjowdRQ9NMC/SbbMur+hVC8tQ+4frcVHOgMo8lPw7IySlBQT/
        aqwMvXLrp+mgELmGhJ+ZhZQp5
X-Received: by 2002:a5d:5984:0:b0:20f:f3a1:fc56 with SMTP id n4-20020a5d5984000000b0020ff3a1fc56mr26938590wri.718.1653975734740;
        Mon, 30 May 2022 22:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdE+qW9FBh7CyCXbLKMzMHLR0yj20nkiIZGrztEDmjYsCEbIiQpOmR1K3n4oHtOPy/6V+v4A==
X-Received: by 2002:a5d:5984:0:b0:20f:f3a1:fc56 with SMTP id n4-20020a5d5984000000b0020ff3a1fc56mr26938567wri.718.1653975734469;
        Mon, 30 May 2022 22:42:14 -0700 (PDT)
Received: from redhat.com ([2.52.157.68])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5949000000b002103136623esm5160877wri.85.2022.05.30.22.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 22:42:13 -0700 (PDT)
Date:   Tue, 31 May 2022 01:42:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org, martinh@xilinx.com,
        Stefano Garzarella <sgarzare@redhat.com>, martinpo@xilinx.com,
        lvivier@redhat.com, pabloc@xilinx.com,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhang Min <zhang.min9@zte.com.cn>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>, lulu@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>, Piotr.Uminski@intel.com,
        Si-Wei Liu <si-wei.liu@oracle.com>, ecree.xilinx@gmail.com,
        gautam.dawar@amd.com, habetsm.xilinx@gmail.com,
        tanuj.kamde@amd.com, hanand@xilinx.com, dinang@xilinx.com,
        Longpeng <longpeng2@huawei.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Message-ID: <20220531014108-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220526124338.36247-1-eperezma@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 02:43:34PM +0200, Eugenio Pérez wrote:
> Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively stop the device.
> 
> This is a must before get virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them. There are
> individual ways to perform that action for some devices
> (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> way to perform it for any vhost device (and, in particular, vhost-vdpa).
> 
> After the return of ioctl with stop != 0, the device MUST finish any
> pending operations like in flight requests. It must also preserve all
> the necessary state (the virtqueue vring base plus the possible device
> specific states) that is required for restoring in the future. The
> device must not change its configuration after that point.
> 
> After the return of ioctl with stop == 0, the device can continue
> processing buffers as long as typical conditions are met (vq is enabled,
> DRIVER_OK status bit is enabled, etc).
> 
> In the future, we will provide features similar to VHOST_USER_GET_INFLIGHT_FD
> so the device can save pending operations.
> 
> Comments are welcome.


So given this is just for simulator and affects UAPI I think it's fine
to make it wait for the next merge window, until there's a consensus.
Right?

> v4:
> * Replace VHOST_STOP to VHOST_VDPA_STOP in vhost ioctl switch case too.
> 
> v3:
> * s/VHOST_STOP/VHOST_VDPA_STOP/
> * Add documentation and requirements of the ioctl above its definition.
> 
> v2:
> * Replace raw _F_STOP with BIT_ULL(_F_STOP).
> * Fix obtaining of stop ioctl arg (it was not obtained but written).
> * Add stop to vdpa_sim_blk.
> 
> Eugenio Pérez (4):
>   vdpa: Add stop operation
>   vhost-vdpa: introduce STOP backend feature bit
>   vhost-vdpa: uAPI to stop the device
>   vdpa_sim: Implement stop vdpa op
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
>  drivers/vhost/vdpa.c                 | 34 +++++++++++++++++++++++++++-
>  include/linux/vdpa.h                 |  6 +++++
>  include/uapi/linux/vhost.h           | 14 ++++++++++++
>  include/uapi/linux/vhost_types.h     |  2 ++
>  8 files changed, 83 insertions(+), 1 deletion(-)
> 
> -- 
> 2.31.1
> 

