Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705135691DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiGFScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiGFScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:32:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44BE6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:31:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ef5380669cso148625657b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqBcZVmZY62+uZaaDsEVHApvk4BPtabj2ze/xYSIKPM=;
        b=dEPL46gwLY9Xnxeq7C4mX9Slt3nXB1pC1jn5H0CL9VX9G2i8J6+ylsbX1Mgg2ERRjp
         vlPsgCqXtBs1XZnGQqilXjd5GePb2UO5C6pmc+JN1fk6Wqr+Ol6n1+ETMDRdz1MbpBtX
         se7qXtyj0/MrUfsRscQXaxQREgk3/B/JhYx7GEriklH1gVdocFajhWPIjV+pRV1sOL1M
         55HKrnvRjLHyI7UjeoWg73/+uxDsaFlG8k/XgUulVf0AGvgOOL2cjp6zctn+FPub2yuT
         6Sa9SruHspQVXX5hrICktogXVFwx0I513/4Z7w3NV8jfaVdf3t2TkUdWgnHZFmwAAFKa
         XZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqBcZVmZY62+uZaaDsEVHApvk4BPtabj2ze/xYSIKPM=;
        b=POW9/jsQuAA/Eihs54LJoiV7iEbV/Dw7xjW4b7s3Ya3gbtlNNOXAMw7OOO4J0M4SWw
         ylvYAFOsvErDfpQxRTCS/MP2vzuOO3LfMMcvggqHymktSOHurkq+nMWWz4e6e4XrQ8s5
         lnwEYq7ZQpwq9uQHOxb8spnOeNLfG2m2HZtBbvXsOa+ycBgJrQZ67lUOtdbkaQ66av3x
         APoHnAH8EA15vLe+8mHz0/Tu8MADsKkdwvzrGrW0ulrlG/kzArqEmOccjNjgf1BL1Io0
         bQWTfAPYbBQgBcla4qPZbLfUCvHhNTb79IFkQNF1evfxdGgz9SmHiA6LchFiLcBs2h3q
         TW4Q==
X-Gm-Message-State: AJIora9ti0HhuI84Uj889MzrhB9zUARrKdG719FAX2cuHAIvMFkcELZF
        qgc8dmv7Zi9iUW+orhs4JzZg2ZVb3NeCj7+mgVW7/w==
X-Google-Smtp-Source: AGRyM1vStpSFCTvQoOkYY9pCw67PR2KX2//2Tg5M4w73NRNk7nScyntoWxARzbefU6wlbYJu8sZsAQDLLqSTcibHrBs=
X-Received: by 2002:a81:4f95:0:b0:31c:9817:90e5 with SMTP id
 d143-20020a814f95000000b0031c981790e5mr20142591ywb.280.1657132318960; Wed, 06
 Jul 2022 11:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182924.2563058-1-tjmercier@google.com>
In-Reply-To: <20220706182924.2563058-1-tjmercier@google.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 6 Jul 2022 11:31:48 -0700
Message-ID: <CABdmKX2vtT04iPp-BZHRu0DAyXQpLvrtSc4eahNgUVxx+K4Tqg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Remove duplicate call to drm_gem_free_mmap_offset
To:     "T.J. Mercier" <tjmercier@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 11:29 AM T.J. Mercier <tjmercier@google.com> wrote:
>
> The docs explicitly say the drm_gem_object_release function already calls this,
> and this does not appear to be a prerequisite for the call to
> etnaviv_gem_ops.release.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index cc386f8a7116..ecb828e4e156 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -504,7 +504,6 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
>                 kfree(mapping);
>         }
>
> -       drm_gem_free_mmap_offset(obj);
>         etnaviv_obj->ops->release(etnaviv_obj);
>         drm_gem_object_release(obj);
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>

I don't have a device to test this with, but I believe this is correct
based on inspecting the code and the drm_gem_free_mmap_offset function
docs.
