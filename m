Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F214719D1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhLLLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhLLLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639309105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enZ9wtju2weTaLCliJwjtIvdjIiIKEzWJXF4kl1QYYg=;
        b=IVvPqLxEE3Gfxpm9pmkTj98YIQNXNN/qiVHunXoETx0kUGSbSfqPdFjLdJW2R59dUGmZQa
        Twb+R1ZqST6kCTNdRFFoGvWWE/XAO2UnZ/0SYhnbtUiW1pVp3Jg2EcAk9/sduhgxjlyYLD
        ITX+0a/7llOD7HRaEDMMN79ydaLLink=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-9nc2ceiiN_CW9m-HlUWJmw-1; Sun, 12 Dec 2021 06:38:23 -0500
X-MC-Unique: 9nc2ceiiN_CW9m-HlUWJmw-1
Received: by mail-ed1-f69.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so11614928edq.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 03:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=enZ9wtju2weTaLCliJwjtIvdjIiIKEzWJXF4kl1QYYg=;
        b=5+6OenBrmlmL02Jc4p0CaJTkpVJVV9LyEkIHab7xEscvJsrLN8dnUN3bCP89ENLr/H
         j+hTM6ryGGgD/yo+1piZiE1fml900wI/BhbJTHb1ToppSfA4zAUJZ3Uy6cFDWGHmrbgU
         1npUszJnvCO+DjVG4NQLwdfLNXMAkJOg1icVqCnc516sRpFnbX5s21MplhMG3Yk3s9it
         /vzXu5g0t/Hng7NW6oU2/X4NVP2k+BaIvdfYp3b5AuNe7lcqyam4AvteLSAP+IXsxJ6o
         ZgHNgfr/2EUgQFtd+vUJypubZJ0Feo1M9KPqMeYsjCb9LH1EXln7Zn0PKIdrNx4r4QGC
         msnA==
X-Gm-Message-State: AOAM530EjH8O73YtcjfmXjqXB7AhqR8T6FzKV0Ub0G908UW1BqDm0TCR
        KdYRrPo9u9PWvD9Pn7LhKmZKIMpz7bk9EOpVQ1rBe5wX2q5lPOOs9wh5DGNAh5j+j7kgfj6IPlS
        67G769bQmc4wFFJiRaixCK18/
X-Received: by 2002:a17:906:d54c:: with SMTP id cr12mr35915080ejc.56.1639309102154;
        Sun, 12 Dec 2021 03:38:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW9vaJuFcH2IwdHdxLGm0JdPJEr8oNOfr6SlYZ1y82jRAzo0ZkyuchOniriaZlKdGyAKu2Zg==
X-Received: by 2002:a17:906:d54c:: with SMTP id cr12mr35915063ejc.56.1639309101900;
        Sun, 12 Dec 2021 03:38:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s18sm4738692edd.15.2021.12.12.03.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 03:38:21 -0800 (PST)
Message-ID: <76ac4a54-4913-66f7-5de8-9e70c14bde80@redhat.com>
Date:   Sun, 12 Dec 2021 12:38:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] lib/genalloc: Fix NULL vs IS_ERR() checking
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211211144957.31381-1-linmq006@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211211144957.31381-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/11/21 15:49, Miaoqian Lin wrote:
> The devm_gen_pool_create() function does not return NULL. It
> returns error pointers.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

This is already fixed in linux-next, see:

https://cgit.freedesktop.org/drm-misc/commit/drivers/gpu/drm/vboxvideo/vbox_main.c?id=cebbb5c46d0cb0615fd0c62dea9b44273d0a9780

Regards,

Hans


> ---
>  drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
> index f28779715ccd..c9e8b3a63c62 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_main.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
> @@ -127,8 +127,8 @@ int vbox_hw_init(struct vbox_private *vbox)
>  	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
>  	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
>  						"vboxvideo-accel");
> -	if (!vbox->guest_pool)
> -		return -ENOMEM;
> +	if (IS_ERR(vbox->guest_pool))
> +		return PTR_ERR(vbox->guest_pool);
>  
>  	ret = gen_pool_add_virt(vbox->guest_pool,
>  				(unsigned long)vbox->guest_heap,
> 

