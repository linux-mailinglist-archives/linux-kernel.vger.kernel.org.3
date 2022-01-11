Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780E648AD08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiAKLwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239293AbiAKLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641901943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E31hZYFQcW+4o6U46docQzadWaoFYJuACIqYHgH7CS0=;
        b=Lzm4NFA30KF4eJmNuBdJswnH1k92PYXkmlewX4pd7CmCr4D+82MsD3txX6TLPhEnWueetj
        GX3/s6Ja9IdCy3R648ZP3gYP9o1ymy/Q9j9TT56XbwKHpzoyDuR3SBjC5R4N7QcLtZwzd8
        Z4EjfE88LrkWFtDzqjTgQ2w61oLUoXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-kJXp6rjJOPW6nuRfQVzRfA-1; Tue, 11 Jan 2022 06:52:22 -0500
X-MC-Unique: kJXp6rjJOPW6nuRfQVzRfA-1
Received: by mail-wm1-f72.google.com with SMTP id n14-20020a7bcbce000000b003488820f0d9so1673839wmi.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E31hZYFQcW+4o6U46docQzadWaoFYJuACIqYHgH7CS0=;
        b=O9/ayAWNeCLyFPpxvpPmvhJAs4bM6IxkbqGiq/UB9POyfqzCN8ZTEDy5bBCHXqmoAc
         fprg7F7jBz38xVuu8C4pAVnKiKC8G2MFliI/jss9xKW/sKimgFcsmZBsdXbS466izsts
         f8NxMM7Ex1M7HG7j5d07HhjfcXowBG8nMeh6x0Nby1JehIVGpGOjNd+c02UZOvyim2Mm
         pwnngynpULDmVfdi5jzR0FSr3extCU6gA8S8Jkn1HigcaFfqrMZl5ammWVJaC6NAe8kC
         8CkUlvyis702FIV6wVR2Gq/lfr0Q2HhQpqZ4GLaXJz+p9U911Jrwa15t2kGTbVdEc5k6
         ntvg==
X-Gm-Message-State: AOAM531RfhiYUKJ42u0MaO4wco2j4+dRbLBkPB+XGRN/cSDtbbvlFcuv
        lAhxRptAVnTRfO3yeUWcXHSQaHYolhdZNK4GLxNptwdjyusZHaz6CYR64/4ftPkytoEujKmEPvW
        smlKLH0kW/5Xp61zzd09YHK31
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr2213613wmj.56.1641901941338;
        Tue, 11 Jan 2022 03:52:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8n6FfOAwkWyYM7OljIHJJOBJHfRQiGCE6/GSFcIYglr5BcpFEwtehF5B/LALF7+cSmwk+Ig==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr2213593wmj.56.1641901941092;
        Tue, 11 Jan 2022 03:52:21 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
        by smtp.gmail.com with ESMTPSA id o15sm9550668wro.70.2022.01.11.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:52:20 -0800 (PST)
Date:   Tue, 11 Jan 2022 06:52:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>
Cc:     jasowang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220111065033-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7A45E1E967F13AE14B061269@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:36:42AM +0800, 李东升 wrote:
> When virtio vdpa device removed, the abnormal damage of the device cannot be
> perceived normally, which will cause problems similar to:
> 
> 43bb40c5b926


Should include the subject of the patch too.

> Hence, add the ability to abort the command on surprise removal
> 
> Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>

When removing gracefully,
I am not sure we should break device unconditionally like this
before giving drivers a chance to clean up.
Should we just do it for surprise removal?

> ---
>  drivers/virtio/virtio_vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 4a9ddb44b2a7..fd930409d190 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -374,6 +374,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
>  {
>   struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
> 
> + virtio_break_device(vd_dev->vdev);
>   unregister_virtio_device(&vd_dev->vdev);
>  }
> 
> --
> 2.17.1

