Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F47510563
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiDZR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiDZR3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FEE91ADBE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650993988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIDKi1Fbqi03mYjNDUZNSZko/5hz16GhkjeizzJX6xo=;
        b=eRfWVOIre4i/K579Qc25dJvkQWJG/ae4Vq3boTMAZqphm05OUeDpfJz5raxfgbTqBPK9aD
        cMhzci1cnQvn7pdFUVn4IxHKYdaWSNrlRbLwIAnn9yUYnU005SNLnkFs9cYy56KKZBnFNL
        Hrs2VQUr2pnlFZc4PrHFG9UQlLclO9M=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-uymoa9HKObqZdTDEP46LVQ-1; Tue, 26 Apr 2022 13:26:27 -0400
X-MC-Unique: uymoa9HKObqZdTDEP46LVQ-1
Received: by mail-vk1-f199.google.com with SMTP id g63-20020a1f5242000000b0033f4c7f7561so1903058vkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=lIDKi1Fbqi03mYjNDUZNSZko/5hz16GhkjeizzJX6xo=;
        b=iOqkDcbbCK3SqvGHtor9wdqmXKAgQHSrujeiRyqHKfG8Pd8REAawOeE7pfGG1MPx9F
         d3Xv97r7yUsV2i4noFhzsZNd7VgaNMhRI+a0Z9tTWt9xb25c9sTZsmq3rk+vQluTPflb
         kNYeBcrrMXdeLllYo7NtzkSq2aUhYYMIo6dCfOCZfbLYe3UCB6StlV8/OYPBJWMdcdiq
         7Nhi02S9Wgn7cdOrA9FR6ZIZBubOCi14K4vYHu8BZaNNaDK6zmx8jlqWqPxbSQ9Jgzen
         Tlf8KSlJ6vK8ZATQ844bSWLjVdSJ3w69qv6WM0mmrd6GP/l62ABFpC2RpoANVurWXCf2
         a5Cg==
X-Gm-Message-State: AOAM533EVVyxl/0zAEsoBr+g4wg8od16DhKcc+yBPIzTgcD1d/kOdZ2e
        AP7fPo1T1Fd5k3svUqG9Q0bQihJQu4fPdVRR1lH6AGXgEbHWu0+3k1Je+gT0AZYoWuUP/qC4D/L
        jpj9zPo4yg/Drkr4Wvov7U8ih
X-Received: by 2002:a67:e9d1:0:b0:32c:eb44:efd6 with SMTP id q17-20020a67e9d1000000b0032ceb44efd6mr911039vso.16.1650993986730;
        Tue, 26 Apr 2022 10:26:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpFGyTlNOnTHUlqHT3HOBW9kR28MQd1k1z2LvC85IOws5IevLAC/JD+KnrsGzp3VspUMHE+w==
X-Received: by 2002:a67:e9d1:0:b0:32c:eb44:efd6 with SMTP id q17-20020a67e9d1000000b0032ceb44efd6mr911031vso.16.1650993986543;
        Tue, 26 Apr 2022 10:26:26 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id b206-20020a1f34d7000000b003452c5cc13csm1672864vka.41.2022.04.26.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 10:26:25 -0700 (PDT)
Message-ID: <a46595078332c8e0ad801f3f8eb03ca9c11db8dc.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/kms/gv100: use static for
 gv100_disp_core_mthd_[base|sor]
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 13:26:24 -0400
In-Reply-To: <20220422185132.3163248-1-trix@redhat.com>
References: <20220422185132.3163248-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a bit

On Fri, 2022-04-22 at 14:51 -0400, Tom Rix wrote:
> Sparse reports these issues
> coregv100.c:27:1: warning: symbol 'gv100_disp_core_mthd_base' was not
> declared. Should it be static?
> coregv100.c:43:1: warning: symbol 'gv100_disp_core_mthd_sor' was not
> declared. Should it be static?
> 
> These variables are only used in coregv100.c.  Single file use
> variables should be static, so add static to their storage-class specifier.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
> index 448a515057c7..1d333c484a49 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
> @@ -23,7 +23,7 @@
>  
>  #include <subdev/timer.h>
>  
> -const struct nv50_disp_mthd_list
> +static const struct nv50_disp_mthd_list
>  gv100_disp_core_mthd_base = {
>         .mthd = 0x0000,
>         .addr = 0x000000,
> @@ -39,7 +39,7 @@ gv100_disp_core_mthd_base = {
>         }
>  };
>  
> -const struct nv50_disp_mthd_list
> +static const struct nv50_disp_mthd_list
>  gv100_disp_core_mthd_sor = {
>         .mthd = 0x0020,
>         .addr = 0x000020,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

