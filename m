Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B84A00C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbiA1TRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbiA1TRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643397434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eO1UXFuFc6XDm59y7eIl2dtM6a/z0pBy0qGOEAiugBI=;
        b=c8iWQcuZvRTLEwe5kXcTTna0eo+znPw+8ex8obIRugEgFvsdAlWmHf/ePulVbWZFvvc0+6
        tuN3AjXQEgVu4bjPPIiZTOWQhYyJkVmqM5L0cQARR+JBYpAQgF2ZfJUxxPsDSaZQxLOSkg
        bc0F09HwyoxIpiG7L0lxTG8N4EwJSPw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-8M8jPdoQNPCt2Dy9I01I8w-1; Fri, 28 Jan 2022 14:17:13 -0500
X-MC-Unique: 8M8jPdoQNPCt2Dy9I01I8w-1
Received: by mail-qk1-f198.google.com with SMTP id u17-20020a05620a431100b004765c0dc33cso5553448qko.14
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=eO1UXFuFc6XDm59y7eIl2dtM6a/z0pBy0qGOEAiugBI=;
        b=FDdfC64VbQHiKvULiIwV9qpbmkVo7MgGgSDh8vQLKMkgqe6/1wSu+Ok2B/7I6w7hYt
         3jmIaGuICf0MhAifSr0RpsGWRh4fKSVH8khhhj8IcSG88mLE9VTzQONuexd2yC7E+xzQ
         WGshDD3OUKDTTLLpFNS51UaNFsM78KROmeFuEsQIGPZnrkvRcoSbMkPkzETHoYwOYR+B
         N+mgN/Ny+CyW2Yz1L0NhIH4DTeL7vhM5yy/bnSL0449zshm/jPu/EICoan3Tga7nHRlw
         X28mAq9w/pLSQIYtIfk4FOywiDXvqaLzNkmxaKDQ8sgvEnHTfox6PsY6MGGg7+br7kzW
         TQug==
X-Gm-Message-State: AOAM532UrBhaV2as1dc+0LXpVCTyK2fd07qzCQn0pXH5Lm5Ap9YUlFtn
        MDbFQAcZdAjrYp8Wupb8v9+n4ZJ1MGblLh+EARr/SjKa4OUGaIPD2h/2b4nWCVPS9+wCaDPTddH
        kvkWaavfqbrvUc3jLubE3MdgW
X-Received: by 2002:a05:622a:ca:: with SMTP id p10mr2002420qtw.123.1643397432669;
        Fri, 28 Jan 2022 11:17:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYaAdUDE5W566fq77+INMNx47zILwdtqN04KYzsDT/UoGpKgB0OvZw6qO3zCtXnbY/NcpCYg==
X-Received: by 2002:a05:622a:ca:: with SMTP id p10mr2002408qtw.123.1643397432443;
        Fri, 28 Jan 2022 11:17:12 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net. [98.118.105.43])
        by smtp.gmail.com with ESMTPSA id u17sm3548025qkj.44.2022.01.28.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 11:17:11 -0800 (PST)
Message-ID: <67747024d7b3e1904d639e5877a580a0af32d855.camel@redhat.com>
Subject: Re: [PATCH 09/14] drm/nouveau: Replace dma-buf-map with iosys-map
From:   Lyude Paul <lyude@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        linux-media@vger.kernel.org, nouveau@lists.freedesktop.org
Date:   Fri, 28 Jan 2022 14:17:09 -0500
In-Reply-To: <20220128083626.3012259-10-lucas.demarchi@intel.com>
References: <20220128083626.3012259-1-lucas.demarchi@intel.com>
         <20220128083626.3012259-10-lucas.demarchi@intel.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this patch:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2022-01-28 at 00:36 -0800, Lucas De Marchi wrote:
> iosys-map is the new name for dma-buf-map and will gain new
> capabitilities. Replace with the new API in nouveau.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c
> b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 9416bee92141..ad0527bdaadf 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -24,6 +24,8 @@
>   *
>   */
>  
> +#include <linux/iosys-map.h>
> +
>  #include <drm/drm_gem_ttm_helper.h>
>  
>  #include "nouveau_drv.h"

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

