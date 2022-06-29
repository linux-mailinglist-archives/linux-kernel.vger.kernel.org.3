Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D855FA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiF2Ids (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiF2Idp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0E7134676
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656491623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2JQfeor2cSluhLc8gxrGHJypvB/NOwVYQaX5GcymEw=;
        b=cItQxl70+UzYrKLDyJQz8vZMvVKoR5dFYS8WOAAPu5cJYVTl0TF5dN4233ocn5I1XIGN5b
        p8nE2ysqyqFwpCHpiqPGAhL+p+XvX3qhODaSW/wFLrxh2UVDHuajZqfnRG5IO1F5uWl8d0
        II7ANhwJtVNSqmU+IgdaaT85e08vBrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-P2hclSg4OemOwd94iXry1g-1; Wed, 29 Jun 2022 04:33:41 -0400
X-MC-Unique: P2hclSg4OemOwd94iXry1g-1
Received: by mail-wr1-f69.google.com with SMTP id e5-20020adff345000000b0021b9f00e882so2167962wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2JQfeor2cSluhLc8gxrGHJypvB/NOwVYQaX5GcymEw=;
        b=A+LGXTl/rx4Dtz0OpzZp4DlsvDFyHMInvgjjgcic01YI6PYf626hlR9kNydtFWWEiD
         VpB5LGejDvT1D+FAHXIXRMrNGn2gi7shZLRUQUTZqzgSaMEztDPt8dYGT3tZgHOtCpxJ
         Lom4BIsrO6KKDes0WeYzw77OC9wQ9CQ9iu8nr1WU9GPj52eDvwbI8VajPZe2AKvUhuI7
         J/sIf8dV19e47hQG2TprxlULwyQliHSZnkgEcjyj9bSEyDC+kmxRLfhD7dH6/pCLIlym
         FTW34pRlg8dv6MuBiOPPltC/0XW+Ubg92g4wnBLQMTmEo+PbvBWVap72jRp7hV96HGpe
         qPhg==
X-Gm-Message-State: AJIora9WyFbyaP43kwJeabLDnhEn5hOgiK/KzHa1DDV1ROi7cUILUcQH
        jFVO6A1V5+f4FJOy8aTl7p0cSwV4sOM/IcftVi7CH2qAz4iTU1780+udy/yOk1dfgAAja5bu/N7
        dj8WpAcAwMmJ1Ig9o3S4XsEMq
X-Received: by 2002:adf:de02:0:b0:21b:953f:27da with SMTP id b2-20020adfde02000000b0021b953f27damr2001613wrm.376.1656491620636;
        Wed, 29 Jun 2022 01:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+PLxQJll7TtXInzKQuybrNIaNivTqMnP9VYX0DKTWMU6o2bHq58tFNp54PMJxN/DCg4HUhQ==
X-Received: by 2002:adf:de02:0:b0:21b:953f:27da with SMTP id b2-20020adfde02000000b0021b953f27damr2001587wrm.376.1656491620402;
        Wed, 29 Jun 2022 01:33:40 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b003973ea7e725sm3420476wmq.0.2022.06.29.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:33:39 -0700 (PDT)
Date:   Wed, 29 Jun 2022 04:33:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] vduse: Update api version to 1
Message-ID: <20220629042856-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-7-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629082541.118-7-xieyongji@bytedance.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:25:41PM +0800, Xie Yongji wrote:
> Let's update api version to 1 since we introduced
> some new ioctls to support registering userspace
> memory for IOTLB.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Adding new ioctls does not justify things like this.

Besides, adding UAPI then changing it is not nice
since it makes git bisect behave incorrectly.

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
>  include/uapi/linux/vduse.h         |  8 +++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 7b2ea7612da9..2795785ca6a2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1206,6 +1206,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_GET_INFO: {
>  		struct vduse_iotlb_info iotlb;
>  
> +		ret = -EPERM;


Almost for sure a wrong error code.

> +		if (dev->api_version < 1)
> +			break;
> +
>  		iotlb.bounce_iova = 0;
>  		iotlb.bounce_size = dev->domain->bounce_size;
>  


Wait a second. so you are intentionally breaking any userspace
that called VDUSE_SET_API_VERSION with version 0?

Please don't.


> @@ -1219,6 +1223,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_REG_UMEM: {
>  		struct vduse_iotlb_umem umem;
>  
> +		ret = -EPERM;
> +		if (dev->api_version < 1)
> +			break;
> +
>  		ret = -EFAULT;
>  		if (copy_from_user(&umem, argp, sizeof(umem)))
>  			break;
> @@ -1230,6 +1238,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_IOTLB_DEREG_UMEM: {
>  		struct vduse_iotlb_umem umem;
>  
> +		ret = -EPERM;
> +		if (dev->api_version < 1)
> +			break;
> +
>  		ret = -EFAULT;
>  		if (copy_from_user(&umem, argp, sizeof(umem)))
>  			break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 1b17391e228f..902ea19cd9e0 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -8,7 +8,13 @@
>  
>  /* The ioctls for control device (/dev/vduse/control) */
>  
> -#define VDUSE_API_VERSION	0
> +/*
> + * v0 -> v1:
> + *  - Introduce VDUSE_IOTLB_GET_INFO ioctl
> + *  - Introduce VDUSE_VDUSE_IOTLB_REG_UMEM ioctl
> + *  - Introduce VDUSE_IOTLB_DEREG_UMEM ioctl
> + */
> +#define VDUSE_API_VERSION	1
>  
>  /*
>   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
> -- 
> 2.20.1

