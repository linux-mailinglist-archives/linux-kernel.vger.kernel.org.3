Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6852C464
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiERUZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiERUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:25:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F590939E0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:25:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so3151517pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0RUFEAAb0EUvAvgjmVhvNXqgIl2634hQPp6NyaB/BE=;
        b=L6sJM823YSYGCEu5Vx6kyBcGRMkDtvbRk1g3zMveNTQGmV1rJUbhpDm7tL9Sx53GdH
         9BrG2SjuHMe2C+hS937ohWm4LWCp73Kyg7h/TnDUfPe5ubtQDzsM0mbu8ovx+iAubhfz
         4oTampAzdwVEv+3BeGvkjx4CzH4EErl0TPsPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0RUFEAAb0EUvAvgjmVhvNXqgIl2634hQPp6NyaB/BE=;
        b=JLPrPGb2/AH2fA39EaFgfyllPOdXuLdHeDk1Xh9B3CcUv34D/GRyEt+uMY099vDvbn
         kiXwRtrZh84tIjkjTdedNdv8/GlvqmpEMWQvg39rmQM/PztpYOlRWEGN5W4YEcgT8bUT
         luwd0FfHyi0Hn4uQG6jNto0E+VQ+XniPy8BdQ9KiEI+RnitFk0ERXuO5liIlptdqcFcv
         qLEAeMGZAZ8DzTcckcrYaqPgxIymdjYtt3u9nWlbUW18Z81XImw90Yw6RynHZA7L6WBZ
         oBW1T0z+g09o4mu3lxyPav0yETGTT0N+EkcKXQqyWkkTxvAESjx9+CopIS1kqVZuc69B
         j9Nw==
X-Gm-Message-State: AOAM531AB3DREU8DRS+9h3dwTj/ncg2YcoIlDein9jpw8QJH3AbgvawA
        viK13sogDTa6WFxSWAUDJfzPWQ==
X-Google-Smtp-Source: ABdhPJwFG8w1ZTkhJXaj8JxUZLxZnFHlyBsxl5a7UPCmYkYRpDDj0B2yfmzhsYf7Q7TqK6uD1CEWqw==
X-Received: by 2002:a63:e40c:0:b0:3f2:5729:eace with SMTP id a12-20020a63e40c000000b003f25729eacemr998455pgi.384.1652905530072;
        Wed, 18 May 2022 13:25:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ji15-20020a170903324f00b001616e13fccdsm2114121plb.221.2022.05.18.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:25:29 -0700 (PDT)
Date:   Wed, 18 May 2022 13:25:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH] security: keys: add __randomize_layout to
 keyring_search_context
Message-ID: <202205181325.0D772A54@keescook>
References: <20220518091841.141441-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518091841.141441-1-gongruiqi1@huawei.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:18:41AM +0000, GONG, Ruiqi wrote:
> Struct keyring_search_context contains a pointer to `struct cred`, which
> is a security-critical structure and whose layout is randomized already.
> Apply __randomize_layout to struct keyring_search_context as well, as
> suggested in [1].
> 
> [1]: https://github.com/KSPP/linux/issues/188
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Seems reasonable to me; it's an entirely internal structure.

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  security/keys/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9b9cf3b6fcbb..3e3def5fbaa4 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -136,7 +136,7 @@ struct keyring_search_context {
>  	bool			possessed;
>  	key_ref_t		result;
>  	time64_t		now;
> -};
> +} __randomize_layout;
>  
>  extern bool key_default_cmp(const struct key *key,
>  			    const struct key_match_data *match_data);
> -- 
> 2.17.1
> 

-- 
Kees Cook
