Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA94901E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiAQGQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:16:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234410AbiAQGQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642400212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ngjqbhd+I2RAGqYA3unyWdhIXjaBf9jaTXyUpAmiTbU=;
        b=F6JrHBsPzvrUXz1vjQQK5AOqQpKPkbN3cVHp101O4DNAsxCB3dvd8VcjgYF7ugkK1mJ+EB
        r82tOqUztqVEW7jeHCDTF6JgmskzrSVbrwtaD5B0gFJWacI87pWKgQ9ypXwSNBV51vItVn
        oxOL73hEfGYhUctN0SUYSvz+yxYoNzA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-pgVuh_4uMvCEmzRFBkVKPA-1; Mon, 17 Jan 2022 01:16:51 -0500
X-MC-Unique: pgVuh_4uMvCEmzRFBkVKPA-1
Received: by mail-pj1-f72.google.com with SMTP id d11-20020a17090a498b00b001b3fb4f070bso13727382pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ngjqbhd+I2RAGqYA3unyWdhIXjaBf9jaTXyUpAmiTbU=;
        b=2wUwij6vW4EkFwq8h1g3c6mQ1XeAdbzAJKpJh4XwlelEGpo3pL9dw0jNXV2DsqvLBb
         M9te24TJdfEGptLiYIMYyucCArODkKMlrgXrWvmTH92Pa5ZJ5ighUBV/MCITgIDJfTrI
         vp4xGSoW5055uo1YSq8RfQGZ0u81PNnvOUDd4jI760jsvuWe5uWkHLu4HHwQuEgMnnHW
         qCL0oYaIcdJsCX7Fu6YBaeygiEBu0WkhC7oMS7ZPhs+8Hfe+Du4RaLKfcucBrAxh9fkj
         YSZgZoZ2Qp2GYdRZdHRrDkN53b0rILYK0wGnd82qp9d5ARJV55wzcEufeig/Hb7YF9/f
         u5yQ==
X-Gm-Message-State: AOAM533S7QznK5lvXtYb6KH3G4penRByNsALNY4VCjGepZjWMAWS/rNF
        qEQbPrID1pnOhnf621WjZTMt5sS9sDISJlA6F/etTQChf7abKkW+Yb2dcSWcJKnVIt9b/lNqQf2
        5qzIuY9fJqW/W6UsmFMLAfR3X
X-Received: by 2002:a05:6a00:b55:b0:4c1:3512:d20b with SMTP id p21-20020a056a000b5500b004c13512d20bmr19592221pfo.12.1642400210189;
        Sun, 16 Jan 2022 22:16:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9G9qBf4rYS6kgY8uT90Aj62EDgIo/NWwD9KxTg6NfDLQx/bIGbYRqAoyJm5TbKzMGA/QZdQ==
X-Received: by 2002:a05:6a00:b55:b0:4c1:3512:d20b with SMTP id p21-20020a056a000b5500b004c13512d20bmr19592208pfo.12.1642400209949;
        Sun, 16 Jan 2022 22:16:49 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k13sm13113600pfc.60.2022.01.16.22.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 22:16:49 -0800 (PST)
Message-ID: <7b292868-f875-f225-ab56-b6f140a6373a@redhat.com>
Date:   Mon, 17 Jan 2022 14:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio: unexport virtio_finalize_features
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org
References: <20220114195710.149933-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220114195710.149933-1-mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/15 上午3:57, Michael S. Tsirkin 写道:
> virtio_finalize_features is only used internally within virtio.
> No reason to export it.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio.c | 3 +--
>   include/linux/virtio.h  | 1 -
>   2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 00ac9db792a4..d891b0a354b0 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -166,7 +166,7 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>   }
>   EXPORT_SYMBOL_GPL(virtio_add_status);
>   
> -int virtio_finalize_features(struct virtio_device *dev)
> +static int virtio_finalize_features(struct virtio_device *dev)
>   {
>   	int ret = dev->config->finalize_features(dev);
>   	unsigned status;
> @@ -202,7 +202,6 @@ int virtio_finalize_features(struct virtio_device *dev)
>   	}
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(virtio_finalize_features);
>   
>   void virtio_reset_device(struct virtio_device *dev)
>   {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 72292a62cd90..5464f398912a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -133,7 +133,6 @@ bool is_virtio_device(struct device *dev);
>   void virtio_break_device(struct virtio_device *dev);
>   
>   void virtio_config_changed(struct virtio_device *dev);
> -int virtio_finalize_features(struct virtio_device *dev);
>   #ifdef CONFIG_PM_SLEEP
>   int virtio_device_freeze(struct virtio_device *dev);
>   int virtio_device_restore(struct virtio_device *dev);

