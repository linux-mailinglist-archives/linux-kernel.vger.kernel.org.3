Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548B956AC44
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiGGTz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiGGTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 940F55C9CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657223752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Mo3Zl8VhFZlmNu+vKliCf9PrnP4k8cuE7bMp/19zYQ=;
        b=OzN/Xhf1hf+AanqN1tXztTnyitNhJGBIcK6suPyLwcza+4LpQQYdXCccXWnJ5eJTAvl/tI
        79BH0lu9o4lfduoudoiaZTU2nvhwpUb1BakwbL3fxvXOjFX3SM84bjIRBt+MEpehNfu72m
        wjCD+9ahC8I6/zqKqhPG133a/SIoFuM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-evkr0Y9jPJqbklOO5xXjOQ-1; Thu, 07 Jul 2022 15:55:48 -0400
X-MC-Unique: evkr0Y9jPJqbklOO5xXjOQ-1
Received: by mail-qk1-f200.google.com with SMTP id z9-20020a376509000000b006af1048e0caso18904986qkb.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4Mo3Zl8VhFZlmNu+vKliCf9PrnP4k8cuE7bMp/19zYQ=;
        b=R/N+EytWN5FmEa8aiihV8y9UvwX2tHTM0Wx/l3RVb/jHw/rhdrBTqeX7sT0Z0ekgQG
         3lSYD0k0M3xbvZ4CR0LcEZMcwwr0MLlLQwCwtVB7mONhORdL9VIZYU4wUl4ji2/5uEZ6
         wOu2jj6YIPXNfmBhI2F/VuGoV65Alrm5rnGbsv5h27EPJZLMdOAPRpLgw4HOncaBqjQx
         cvYCHUZgwfwSAmcZ8wDF4cACgU0AGiH0/r5C07EZP16zW+a9TvrdpeeSzBgswhEnRPh0
         UBqIf3AcAD1Bkqw+TfIZtVbkJaayBW8NHrrB7wxDbGOgxkQjwvYUx61Ba9YzlIE8Opmt
         cuPw==
X-Gm-Message-State: AJIora+v5x5b4xXpwFJma0BGCm0d+Kn2y4fhuTV2hIvqM57xW7wHH5ki
        rjDHGbtoS09rP0sMK5WC6XhHYDc8gA5nq05tHKWVkEh9sOzTzkj2g6CDZg7UOOSkCOtm0+Kv9Kl
        2eV9jepiuDpxD0UQsacseBJyQ
X-Received: by 2002:a05:620a:a97:b0:6af:1394:1966 with SMTP id v23-20020a05620a0a9700b006af13941966mr31924311qkg.348.1657223748324;
        Thu, 07 Jul 2022 12:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uL/JdDYPTjD7D3BFa0hLHVO+5vqO0/kmBCEI+jlAypJGlcReJaqO0oDq49OegV/weSeVsAqg==
X-Received: by 2002:a05:620a:a97:b0:6af:1394:1966 with SMTP id v23-20020a05620a0a9700b006af13941966mr31924302qkg.348.1657223748010;
        Thu, 07 Jul 2022 12:55:48 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006afd667535asm23648140qkp.83.2022.07.07.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:55:47 -0700 (PDT)
Message-ID: <62827a27253727d92d6bfcf833a9ec4d3f7c7cd3.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/nouveau_bo: fix potential memory leak in
 nouveau_bo_alloc()
From:   Lyude Paul <lyude@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, bskeggs@redhat.com,
        kherbst@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     ri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Jul 2022 15:55:46 -0400
In-Reply-To: <20220705094306.2244103-1-niejianglei2021@163.com>
References: <20220705094306.2244103-1-niejianglei2021@163.com>
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

Will push

On Tue, 2022-07-05 at 17:43 +0800, Jianglei Nie wrote:
> nouveau_bo_alloc() allocates a memory chunk for "nvbo" with kzalloc().
> When some error occurs, "nvbo" should be released. But when
> WARN_ON(pi < 0)) equals true, the function return ERR_PTR without
> releasing the "nvbo", which will lead to a memory leak.
> 
> We should release the "nvbo" with kfree() if WARN_ON(pi < 0)) equals true.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_bo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c
> b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 05076e530e7d..d0887438b07e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -281,8 +281,10 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size,
> int *align, u32 domain,
>                         break;
>         }
>  
> -       if (WARN_ON(pi < 0))
> +       if (WARN_ON(pi < 0)) {
> +               kfree(nvbo);
>                 return ERR_PTR(-EINVAL);
> +       }
>  
>         /* Disable compression if suitable settings couldn't be found. */
>         if (nvbo->comp && !vmm->page[pi].comp) {

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

