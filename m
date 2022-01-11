Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F30748AD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiAKMMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239449AbiAKMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641903168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D+JwBXKLH4NzNFAnwckZER2iqQBL9AvK/6BgEkjCf/E=;
        b=Rd1hraMQ+OOqHrWXZYapoWerlK+d8t8K1iRsMXMSvKr/Af884RlDlzSRlHuNM749rSdLYa
        KM26x9Ssn8+wdn2pd0DKvbBk4MsjJP4Y/EpmA5wDHNB5PHWgdeBBsx+ew3pPIfTr9/fP6I
        2hhA7S0xfkuNHgmq/9FteilThPb5c+k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-8faDvv4wOkKYENpg2kzG4w-1; Tue, 11 Jan 2022 07:12:46 -0500
X-MC-Unique: 8faDvv4wOkKYENpg2kzG4w-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso13112370edd.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+JwBXKLH4NzNFAnwckZER2iqQBL9AvK/6BgEkjCf/E=;
        b=uaa3eOA8fLkypAjjmhUY7Qldw6ZMW6sKhQ3gC8uLfobnyKZq1lb2J5NCPukA/JDaT4
         0RbSe5uCLz4nprEJc6EQlFen5ZkhHMJFcL9PjWWQnhxCcBEy1XdppSEqob0OWHMYYaDl
         zMZQ6rE1CXnN1u1oC1//rdQnS3blKdKCP6a4px/817h6ck/RdJGY05DzKo7GN7pgeDrn
         Ok2VeY2SkkQBvPgLKnaCbtyXMCbVeCHq/6Cl+FV4KIHOTKYF2xFIBYZnrK7YPx11baQF
         T77I/d/iocgvNbsu0KgLpXB5TjzYWgNLoDh1pKZ5Mu76mCQJwBENQjAL2szVFZv1dQaO
         jTbA==
X-Gm-Message-State: AOAM532BLNiC6K4cjAtFpxuOMp+/R0hs2E0SEDYh+qvXa3bOioioL4nq
        +WJnklOLA4SvQs0zLH9eFHe/4vxQnOYbxdKimdLMaLdTmgcpdnwqfey266NyZQnBS/9tvUFyZ0g
        tZB6JG90tLOvFFOU5Ezlg3PUP
X-Received: by 2002:a17:907:a42a:: with SMTP id sg42mr3410700ejc.413.1641903165298;
        Tue, 11 Jan 2022 04:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn+HBSWzRmwPfwdKn9MBTiJv8kC1oPBnrcd2espINtsRmbDSRkTPnikgecszuaERMFk7gBQg==
X-Received: by 2002:a17:907:a42a:: with SMTP id sg42mr3410681ejc.413.1641903165088;
        Tue, 11 Jan 2022 04:12:45 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
        by smtp.gmail.com with ESMTPSA id kv5sm3525931ejc.113.2022.01.11.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 04:12:44 -0800 (PST)
Date:   Tue, 11 Jan 2022 07:12:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     dongsheng li <lidongsheng@dayudpu.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wangwei@dayudpu.com
Subject: Re: [PATCH v2] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220111071135-mutt-send-email-mst@kernel.org>
References: <20220111065527.1160-1-lidongsheng@dayudpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111065527.1160-1-lidongsheng@dayudpu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:55:27PM +0800, dongsheng li wrote:
> When virtio vdpa device removed, the abnormal damage of the device cannot be
> perceived normally, which will cause problems similar to:
> 
> Commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
> virtio pci device")
> Hence, add the ability to abort the command on surprise removal
> 
> Signed-off-by: dongsheng li <lidongsheng@dayudpu.com>

If you don't mkae changes you can carry forward acks.

> ---
>  drivers/virtio/virtio_vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f85f860bc10b..a5cebad09320 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -396,6 +396,7 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
>  {
>  	struct virtio_vdpa_device *vd_dev = vdpa_get_drvdata(vdpa);
>  
> +	virtio_break_device(&vd_dev->vdev);

My comment on graceful removal stands. E.g. a storage device
will want to flush out writes if possible not drop them.

>  	unregister_virtio_device(&vd_dev->vdev);
>  }
>  
> -- 
> 2.17.1

