Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720735365F7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353999AbiE0Q1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiE0Q1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E6E5340DE
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653668841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCQWiLeW5qUsRPrZU5r1fc6h36nurC5ojFEAsj8ddWE=;
        b=dZe+12grPakHrpmXzOMMj9Ar4/0vv1EJbVm0ZkxiUl9Na4V/ldeQ6KLaYnZVIC04tJf8qQ
        yffBLlVUaYGJPvCyw+CtYQPtJPEWOBXT9x1gjogqOnOiDh68ukT13ZFFV1m0RMXdRs0V+c
        B1UsNoMKoIa6PQ7wUQkKykILnicKc8s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-UIpH9tJeMKaTLfb6y7llNg-1; Fri, 27 May 2022 12:27:20 -0400
X-MC-Unique: UIpH9tJeMKaTLfb6y7llNg-1
Received: by mail-qt1-f198.google.com with SMTP id t25-20020a05622a181900b002f3b32a6e30so4826007qtc.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=hCQWiLeW5qUsRPrZU5r1fc6h36nurC5ojFEAsj8ddWE=;
        b=aBLhXdSa6s33LDjTH6nT01KBjoJTMhUWgow5uZomKtfekSGJh7PDZxPKYwzy/Ot/GX
         gDnZhgmFYcI26pTHzRsG8hLflp3d2fudWnvkkm4acyo23wEKcfCGV3dwqut/cWKntflh
         ASe1dk/VD2LVAzG37rXMnLM+Bc9bzLy384MICZbrxy2KLCBdKSTMxOxoI8OFQd7mztyK
         RGbMUdXasCSjgumryCbSOdfLvxw7q5KzhhqKDhTq1foD4qB9KoACnIUB58syKyiyBnaT
         E+S9WwMkOd9YJkNhZ+EpuXMXU1m4XD9+0N/47SX+Lz5yl5RX8lLP+3rb13RUQ4/lYtvT
         WTEA==
X-Gm-Message-State: AOAM530mXFcv6KDL/6XYke14CM4/8g56sB41483eyvG/X6MUBbQIcCuE
        RAgFKBOTtqWW/U38+cktbZxPL8USTNBBDUA3YzYpS/YNbCuHoVsWOkcLEheePRASE0rZPkJzU6E
        +Q69HSkMKOHozie337iiUqvd/
X-Received: by 2002:a05:622a:8c:b0:2fb:4df4:3421 with SMTP id o12-20020a05622a008c00b002fb4df43421mr10819796qtw.144.1653668839655;
        Fri, 27 May 2022 09:27:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiVpHPTtun+A+ekQ9OvBfz2OZyj/VWxMpfPUOhnLBH21qzgnM33CVE7ErnqS3tvCVpXeyueA==
X-Received: by 2002:a05:622a:8c:b0:2fb:4df4:3421 with SMTP id o12-20020a05622a008c00b002fb4df43421mr10819780qtw.144.1653668839419;
        Fri, 27 May 2022 09:27:19 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id f13-20020a05622a1a0d00b002f39b99f695sm2899986qtb.47.2022.05.27.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 09:27:18 -0700 (PDT)
Message-ID: <d8a12051e71ec322f489beed252576e16802a172.camel@redhat.com>
Subject: Re: [PATCH 5/5] drm/nouveau: Fix spelling typo in comments
From:   Lyude Paul <lyude@redhat.com>
To:     1064094935@qq.com, Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Date:   Fri, 27 May 2022 12:27:17 -0400
In-Reply-To: <tencent_655C23622640268A069B49A6A5ADDEECB508@qq.com>
References: <tencent_655C23622640268A069B49A6A5ADDEECB508@qq.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Do you need me to push this to drm-misc? Or will this be pushed as one series?

On Fri, 2022-05-27 at 12:22 +0800, 1064094935@qq.com wrote:
> From: pengfuyuan <pengfuyuan@kylinos.cn>
> 
> Fix spelling typo in comments.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>  drivers/gpu/drm/nouveau/include/nvhw/drf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/include/nvhw/drf.h
> b/drivers/gpu/drm/nouveau/include/nvhw/drf.h
> index bd0fc41446e2..d6969c0e2f29 100644
> --- a/drivers/gpu/drm/nouveau/include/nvhw/drf.h
> +++ b/drivers/gpu/drm/nouveau/include/nvhw/drf.h
> @@ -190,7 +190,7 @@
>  #define DRF_MD_(X,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,IMPL,...) IMPL
>  #define DRF_MD(A...) DRF_MD_(X, ##A, DRF_MD_I, DRF_MD_N)(X, ##A)
>  
> -/* Helper for testing against field value in aribtrary object */
> +/* Helper for testing against field value in arbitrary object */
>  #define DRF_TV_N(X,e,p,o,d,r, 
> f,cmp,v)                                          \
>         NVVAL_TEST_X(DRF_RD_X(e, (p), (o), d##_##r   ), d##_##r##_##f, cmp,
> (v))
>  #define
> DRF_TV_I(X,e,p,o,d,r,i,f,cmp,v)                                          \
> @@ -198,7 +198,7 @@
>  #define DRF_TV_(X,_1,_2,_3,_4,_5,_6,_7,_8,_9,IMPL,...) IMPL
>  #define DRF_TV(A...) DRF_TV_(X, ##A, DRF_TV_I, DRF_TV_N)(X, ##A)
>  
> -/* Helper for testing against field definition in aribtrary object */
> +/* Helper for testing against field definition in arbitrary object */
>  #define DRF_TD_N(X,e,p,o,d,r, 
> f,cmp,v)                                                          \
>         NVVAL_TEST_X(DRF_RD_X(e, (p), (o), d##_##r   ), d##_##r##_##f, cmp,
> d##_##r##_##f##_##v)
>  #define
> DRF_TD_I(X,e,p,o,d,r,i,f,cmp,v)                                             
>              \

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

