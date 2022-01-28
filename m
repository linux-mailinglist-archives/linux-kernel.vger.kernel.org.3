Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA554A0147
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbiA1T7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:59:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232875AbiA1T7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643399986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/RNAVREYoMWWmbXyD7JmCQPxXU0h1w7hHfP+VKDHWk=;
        b=NEYVWR3jmEfEYpocz++QJ1myCHqTKU6dnF8fooM6PzDBbKsLRLn1oWmsO5h44F7uEh+1Di
        sqoGWl5ZUOjGOtwm3KiIGevISkOIqm1HIBxTcOtKmSynPXvbFtJcSMrGj+pTkrMrtlImy3
        lrk0sV1uRpElc/pV2g5hflm0rGLoyZE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-5P-rWOVNMGim8psllq9Z0w-1; Fri, 28 Jan 2022 14:59:45 -0500
X-MC-Unique: 5P-rWOVNMGim8psllq9Z0w-1
Received: by mail-qt1-f198.google.com with SMTP id y1-20020ac87041000000b002c3db9c25f8so5389050qtm.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=H/RNAVREYoMWWmbXyD7JmCQPxXU0h1w7hHfP+VKDHWk=;
        b=u+M/ZdoqLB6Yl9k2wRptQRF/hDGbI81xsKdDqWq1muBD5ybSmra5XMI3hYJI9ox67E
         MyB4OBNZFOlkpkucI5xlSu0IbkA0hEQvut5ZilUVkdXvTFECIUhLFRC3BtnAZVLInTa1
         5eqF4boHfkiFy2LzfSLKQxHffSyNfQicg/usiFb5tiDvopEjPjt9R/UNRqPQ+jvsGsCE
         V2MNL5W1kdmyoB0ySX2AcrMTYZS7bPftNFtoUEqlLGUFoQ6cRPAXkeI3oppaGM5iD9o4
         nF80pVaWej/kdIQid4CeiwTyBw/jFDxUzgfAr7On8CVKs7Y6jGaP/bJD6W6AqF9pPAyh
         39Ag==
X-Gm-Message-State: AOAM532crraetqFiwOf045SvDbwg+oJiXx3YvV2nIwU9f9UF/6W2RVbs
        irhs0/wTcfV7YHNxcP2Xg82dD6gvXstGZ0yU3SsikCdrze/rzp1MIwdOc9nGpb6E8XG2dcCLgd2
        WfCMikYyyA0X+Kj4oVnY6GCG9
X-Received: by 2002:a05:620a:1a9e:: with SMTP id bl30mr4658852qkb.122.1643399984960;
        Fri, 28 Jan 2022 11:59:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMVL7Ee01ALwRBPd6MwzSYTHv1qXAtOUO9d/6kaeBi6vEJvalGNdFdHO2BgIzYtQiTAwBaxQ==
X-Received: by 2002:a05:620a:1a9e:: with SMTP id bl30mr4658847qkb.122.1643399984791;
        Fri, 28 Jan 2022 11:59:44 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net. [98.118.105.43])
        by smtp.gmail.com with ESMTPSA id m4sm3868731qkp.117.2022.01.28.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 11:59:44 -0800 (PST)
Message-ID: <8a01bf1d367a702cd41e6cb1281294e82a48f541.camel@redhat.com>
Subject: Re: [PATCH] Revert "drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()"
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhou Qingyang <zhou1615@umn.edu>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Jan 2022 14:59:42 -0500
In-Reply-To: <20220128192951.626532-1-lyude@redhat.com>
References: <20220128192951.626532-1-lyude@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on further reconsideration: Self-NAKing this. I don't see any issues with
those patches.

On Fri, 2022-01-28 at 14:29 -0500, Lyude Paul wrote:
> This reverts commit 2343bcdb4747d4f418a4daf2e898b94f86c24a59.
> 
> Unfortunately, as Greg pointed out I totally missed the fact that this
> patch came from a umn.edu patch. umn.edu is still banned from contributing
> to the Linux kernel, so let's revert this for the time being. I'll
> re-evaluate this fix myself later and send another fix if this ends up
> being valid.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> index a6ea89a5d51a..667fa016496e 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> @@ -142,12 +142,11 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const char
> *name, int ver,
>  
>         hsfw->imem_size = desc->code_size;
>         hsfw->imem_tag = desc->start_tag;
> -       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> GFP_KERNEL);
> +       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> +       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> +
>         nvkm_firmware_put(fw);
> -       if (!hsfw->imem)
> -               return -ENOMEM;
> -       else
> -               return 0;
> +       return 0;
>  }
>  
>  int

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

