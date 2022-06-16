Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19DC54ED59
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378992AbiFPWbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378814AbiFPWbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0792B5677E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655418688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bU0VsK2JDaFAXshvmhSgHStyrksxJWmjq/aibJfxfwc=;
        b=OjkApXPrrrDpc+/tNXVH9NnBqJwf0bS7U7/OFZZHGVip1rRI9Nf3C/sYLv6cleYEH66Rt1
        Ff6p0xxMiidMreeKdrEJCvmASlDFe61TK8iIJVkZGuY5e83kHcncqNVld+mqycW2oUVnJL
        OWWr0dFwSEYheKcy9FUH6ueKsFg+TRM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-Qus0afRyN-q887XyB_Agsg-1; Thu, 16 Jun 2022 18:31:25 -0400
X-MC-Unique: Qus0afRyN-q887XyB_Agsg-1
Received: by mail-qk1-f197.google.com with SMTP id bq34-20020a05620a46a200b006a9793b0cd3so3096264qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=bU0VsK2JDaFAXshvmhSgHStyrksxJWmjq/aibJfxfwc=;
        b=Syo9LhjMhcP41TuQEkohAxY6KNdb/J1apst5p2MkifL4q+WLneqiAfMItaotn4mFyB
         VxEnYcjiAxBdAAMUXhqx2Hy+quEqtwel8Ei3CHjRNxJJXBRfk0H0PBTMxCEUu/lt9ZZQ
         3inYbQhv9dz6lcWwJ5DB6wKf3dpR5aWEKc2E8u8kydsW4uUZdyXJ3/yZW5ZL6Y2W5qzb
         1DDCVdTZ1C8lK+3JzLBK4iw4UNjV9PJ+4S6OK8b8kxfktuZVM1UvzOrRDoCp+HcGch+H
         6+ThEpOseK9M4vBkG5pOcWw29K10v0+ykkY26+wRyQv2id8pv7fBIg3hwU2wdExXMSAB
         Bjjg==
X-Gm-Message-State: AJIora8PXOyuFl73+PGP5RO2zkksHHHN+OS+pQmnssP08Ys1wP9yC9sm
        uMnBjJoGzJTL4FTXLM9LPFSHX62sc9LOufmlAXjuC4bnWDJLtAobynL1dmeYB/MqN952cDRflpv
        aBQAuiN+RmJs/3ZlOWdwyXhrS
X-Received: by 2002:a05:6214:5197:b0:469:dbf0:899b with SMTP id kl23-20020a056214519700b00469dbf0899bmr6016648qvb.59.1655418684728;
        Thu, 16 Jun 2022 15:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQ2+VNUkNyYDOT0uSnFzlvw62r4UWrTVGLjfnocSOM/wpgLfLveTzqDllaP17TXrkYMGFUDA==
X-Received: by 2002:a05:6214:5197:b0:469:dbf0:899b with SMTP id kl23-20020a056214519700b00469dbf0899bmr6016637qvb.59.1655418684489;
        Thu, 16 Jun 2022 15:31:24 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85d88000000b00304edcfa109sm2965995qtx.33.2022.06.16.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 15:31:22 -0700 (PDT)
Message-ID: <8f78441d81e4f867cbf4c16751f9a307f225ce9d.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix spelling typo in comments
From:   Lyude Paul <lyude@redhat.com>
To:     1064094935@qq.com
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Date:   Thu, 16 Jun 2022 18:31:20 -0400
In-Reply-To: <tencent_C15AFFD9BBB862C56280A415C336F94C3909@qq.com>
References: <tencent_C15AFFD9BBB862C56280A415C336F94C3909@qq.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2022-06-16 at 15:01 +0800, 1064094935@qq.com wrote:
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

