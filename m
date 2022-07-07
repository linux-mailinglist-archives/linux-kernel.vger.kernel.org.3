Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477156AC31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiGGTtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiGGTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB0CE083
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657223355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/09duIaIEFfbOfOoFpBzJ/OHB5C+OhETNK1haqEKUI=;
        b=JssJj4Od/GVA/d2hi3cXTasM9SCztaB0WtIBuxDGQdQ2fnOrwy8kHEn7twFQhdQVhPThK3
        14dIbYqRpGXi314qZkMAA0KSrZ7A38iW4dVJuLHFN2HOfzFhNbLMxjJoMiditFoF7KifSE
        u0BVR04sYXs+Peap+MOo6m8woP/rNxI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-tVX5ULRyO8yPU7Pd4PZbiA-1; Thu, 07 Jul 2022 15:49:14 -0400
X-MC-Unique: tVX5ULRyO8yPU7Pd4PZbiA-1
Received: by mail-qt1-f200.google.com with SMTP id fw9-20020a05622a4a8900b0031e7a2ed350so11061379qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=b/09duIaIEFfbOfOoFpBzJ/OHB5C+OhETNK1haqEKUI=;
        b=NFnmQ1dzRaYAMsK3OPDyqEi9BuOnJfnMEhInBGCdrMz4ptUIJasgJVMZmGSItKlwTb
         fK8KR8CpDCoX2sRyOvxf9cdp/wn0MQ9Djg8k0ugqneUDx/elWt/FX2Jy1U9UnrGWVtZd
         tAnChXAxKAN1i6r26YYg7+LTRn0XwqAlAjAH7G0kEehW0/fltgdnPT032PZ9FRrbFwAi
         3a2Bd4CDsn5hEChuw4yhlWWIOqI45tYEnY+TU3N+pdrEMgtgqLU9YSaoo4UFn6tWuwsT
         ExVnc4y6yclZXZ50GVrVLF7jjVUChWFOqF+lBrC60HmWODEIWhFoG0IWMItRvQ0F3OUU
         H+8g==
X-Gm-Message-State: AJIora9iUQqGVTJ9bDuoL7RCgZIeWo4d1VKVl3cxr8jhw23adcL64LA5
        kG3hy+Nv6uivd3k+0r3z3qi7LNum62tGDLYn81tj5tKLLCA0eAjdGCRqsKBF3p4c95AJDGHVwLS
        TEA7Xl3GvhZsc1YisRYPkYExy
X-Received: by 2002:a05:6214:2027:b0:473:2d58:7ce9 with SMTP id 7-20020a056214202700b004732d587ce9mr4481194qvf.107.1657223353553;
        Thu, 07 Jul 2022 12:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v30p/B+gX/BnCMrUQB1lcXkKCSu9pY+vBctYwrmJAVo313ntD9v5GhZQ9NfuVfNRds55Wb4A==
X-Received: by 2002:a05:6214:2027:b0:473:2d58:7ce9 with SMTP id 7-20020a056214202700b004732d587ce9mr4481163qvf.107.1657223353007;
        Thu, 07 Jul 2022 12:49:13 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id dm15-20020a05620a1d4f00b006b555509398sm1582726qkb.136.2022.07.07.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:49:12 -0700 (PDT)
Message-ID: <a6e04ca0ff6134652f5ddf4bdbce1f1e90270e2e.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: fix a use-after-free in
 nouveau_gem_prime_import_sg_table()
From:   Lyude Paul <lyude@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, bskeggs@redhat.com,
        kherbst@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Jul 2022 15:49:11 -0400
In-Reply-To: <20220705132546.2247677-1-niejianglei2021@163.com>
References: <20220705132546.2247677-1-niejianglei2021@163.com>
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

Will push to the appropriate branch in a moment

On Tue, 2022-07-05 at 21:25 +0800, Jianglei Nie wrote:
> nouveau_bo_init() is backed by ttm_bo_init() and ferries its return code
> back to the caller. On failures, ttm will call nouveau_bo_del_ttm() and
> free the memory.Thus, when nouveau_bo_init() returns an error, the gem
> object has already been released. Then the call to nouveau_bo_ref() will
> use the freed "nvbo->bo" and lead to a use-after-free bug.
> 
> We should delete the call to nouveau_bo_ref() to avoid the use-after-free.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_prime.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c
> b/drivers/gpu/drm/nouveau/nouveau_prime.c
> index 347488685f74..9608121e49b7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
> @@ -71,7 +71,6 @@ struct drm_gem_object
> *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
>         ret = nouveau_bo_init(nvbo, size, align, NOUVEAU_GEM_DOMAIN_GART,
>                               sg, robj);
>         if (ret) {
> -               nouveau_bo_ref(NULL, &nvbo);
>                 obj = ERR_PTR(ret);
>                 goto unlock;
>         }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

