Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78C50BDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377191AbiDVRH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355052AbiDVRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE90175E6E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650647084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QQiY2IuiN4KN2jf63+soXn8T3SQzl/mtR86RllPdFw=;
        b=Oe39dZiOroQsQYgcRu7XtmFmPDzak1+DgJy03Xqw/ild/qpp5WYrAC7jb+uEih3gqGW9a0
        nmzPMroqcGnco+3W1IDemlbqpTSWollGxiuU859t7onLGCq/CwgyuDv5txqdGh2b+IZTdl
        dNA1PhXSUTLhLx1hDvSbyVxT4Y+5tUw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-PwKuZRmlOqeugu8gR63Kzg-1; Fri, 22 Apr 2022 13:04:43 -0400
X-MC-Unique: PwKuZRmlOqeugu8gR63Kzg-1
Received: by mail-qv1-f72.google.com with SMTP id gf14-20020a056214250e00b0045048ab18a7so3040848qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6QQiY2IuiN4KN2jf63+soXn8T3SQzl/mtR86RllPdFw=;
        b=59Ebj9AVFpJTfZm/4e3RkKu8wvkwzjOldOb4kDLaGAB2ENX/e2zVRgmM+X4s6yJa6g
         a/lx2M3U3u69HrWkhaEK0dZVlR9DoOyx29M9hzbrlQF43GU3KSGgAK/gP+AcKRjoqSNt
         08WgdNSfQh8gBl/BHUdm1B2bNp3SVvc57s3NKfmSUTXwG8wb0q9Ub8tWdxxyfDM9FV5W
         M9MS+1tRI1yvsQPEEMAxKwJ21JRgMU04y34OAvhy6PjclNSyPZkR1c7RD8Kf5LhRcSON
         XHnjnvWOEL5KQhysJpi6Fo5Ooj+Zo77EmQOSbdnVlSoWxU5VPVprjGLEZFwD5YSQVT+x
         G1nA==
X-Gm-Message-State: AOAM530RhHSjHKBrnRLDx0INF6E2lBE10HjkKJn8lsx6y+zn1LNGhVsn
        NkXRrdL82eI9B4spUGXXPt1wIctujYTHcPCE8Hc5O5E03DZSaJcZ91MEEaBOg0alpl9wIkeV8lt
        nbxXkrevD0f/cvIF42MMxHURe
X-Received: by 2002:ad4:576b:0:b0:453:cc2c:e6f8 with SMTP id r11-20020ad4576b000000b00453cc2ce6f8mr2063747qvx.127.1650647082456;
        Fri, 22 Apr 2022 10:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrAx69KALPbKbVyDjA5XRoT5dp0gFMLLP0r0F4OF9bZ5kqdwOdUE0ru7J+zpV9RKzoq/K22w==
X-Received: by 2002:ad4:576b:0:b0:453:cc2c:e6f8 with SMTP id r11-20020ad4576b000000b00453cc2ce6f8mr2063725qvx.127.1650647082234;
        Fri, 22 Apr 2022 10:04:42 -0700 (PDT)
Received: from [192.168.8.138] (pool-71-126-244-162.bstnma.fios.verizon.net. [71.126.244.162])
        by smtp.gmail.com with ESMTPSA id t67-20020ae9df46000000b006809a144ac1sm1137490qkf.99.2022.04.22.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:04:41 -0700 (PDT)
Message-ID: <647ec060ec96fd8055344fcc466d890ed3bb147a.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/gsp: change gv100_gsp from global to static
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Apr 2022 13:04:40 -0400
In-Reply-To: <20220421133028.724954-1-trix@redhat.com>
References: <20220421133028.724954-1-trix@redhat.com>
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

Will push upstream in a moment

On Thu, 2022-04-21 at 09:30 -0400, Tom Rix wrote:
> Smatch reports this issue
> gv100.c:46:1: warning: symbol 'gv100_gsp' was not declared. Should it be
> static?
> 
> gv100_gsp is only used in gv100.c so change its
> storage-class specifier to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
> index 2ac7fc934c09..6c4ef62a746a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
> @@ -42,7 +42,7 @@ gv100_gsp_nofw(struct nvkm_gsp *gsp, int ver, const struct
> nvkm_gsp_fwif *fwif)
>         return 0;
>  }
>  
> -struct nvkm_gsp_fwif
> +static struct nvkm_gsp_fwif
>  gv100_gsp[] = {
>         { -1, gv100_gsp_nofw, &gv100_gsp_flcn },
>         {}

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

