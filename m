Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE03A56AEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiGGWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGGWrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:47:32 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2814D171
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:47:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b125so14513253qkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KJPuKpEjQXLdW7YDv+FAq8BJmKxZ0ZAJ/Vjmx076GPE=;
        b=NXTKvfpQo9YtjO+WWJo7RPpPLreD5XBgNPbiFVpJiRI7D3IyCKD1IIv3mOZmDPMteb
         yoD5xWsaxCuQOylmooEmDPUmxr3KSDyEspkAlP1W4HYOqx3XIL8CSUxwGip7TfcakgLx
         2+Xf8rPms12mGQDMnUTqyUF+hKc6BOvV9bmhW6Jj5MHllCxRFf9RvpkLu+81nuL72/Ws
         OHhcgsmMvNnevjRtqlZWUIq4VgGPZ7jjXQxUQnFaCFQz0z3HEna6HJmDxjYQrV9ZIFjn
         GZNP9VIAcZA/tyb+3mOaI76lf5C7QCNX/R/mfYdjftBcFW6sw10Rj2DZOEp1jrpZV8AU
         Z8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KJPuKpEjQXLdW7YDv+FAq8BJmKxZ0ZAJ/Vjmx076GPE=;
        b=QkBow25oZfILEfN7RsSb2TInc0764MoKtNZP+nlQnghSmEQ8GvzzMWfPTuIn3JsGtR
         60v8avaedf8DQ9mTCnJbaJ2DgInAsILYH1roFVeUb7qBDZSC82t1J75JHsYoGfHS6F5O
         Kt34N8S799FvhHDlPJUDMucIer9QH9im58d1ruo4vZByaYHn6ErNTS+PCiSUD7iACezL
         5ttIlxwWis4riO/CgetMR2T+QILyIGOt4g//YyPH6Bo6rfb8VcIc6z6Sp2rt9DqhGDKG
         HtlRvSeBBrC2m8PJHWKh/Y00hAwtNi2yu+T0kIlPS5N6NsHTRACTZ1tllWkz7hcTtx1C
         UPVA==
X-Gm-Message-State: AJIora9U4qu6J7hA/qZ1QiFrgup2pitNI/Pa9thL9o6DGMIH3ceeKaWQ
        yfyAbVKysCF3x01dqQCiSOjz6BO4qas91A==
X-Google-Smtp-Source: AGRyM1vsttQreuTcSAT2EYt76DVQbofg7HhdDTFDkt/D09XX2cBW7SQdQFsRYeU+V+uIJo6rUSE7qA==
X-Received: by 2002:a05:620a:4587:b0:6b2:527f:2059 with SMTP id bp7-20020a05620a458700b006b2527f2059mr245603qkb.694.1657234050870;
        Thu, 07 Jul 2022 15:47:30 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id v26-20020ac873da000000b00304dec6452csm26939767qtp.78.2022.07.07.15.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:47:30 -0700 (PDT)
Date:   Thu, 7 Jul 2022 15:47:29 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: Make length parameter `len` unsigned
Message-ID: <YsdigTF3YM+Yehaa@yury-laptop>
References: <20220707215051.5664-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707215051.5664-1-pmenzel@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 11:50:52PM +0200, Paul Menzel wrote:
> The length is non-negative, so make it unsigned, and adapt while
> condition accordingly.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied, thanks!

> ---
>  lib/bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index b18e31ea6e66..0746beb336df 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -348,14 +348,14 @@ int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
>  }
>  EXPORT_SYMBOL(__bitmap_weight);
>  
> -void __bitmap_set(unsigned long *map, unsigned int start, int len)
> +void __bitmap_set(unsigned long *map, unsigned int start, unsigned int len)
>  {
>  	unsigned long *p = map + BIT_WORD(start);
>  	const unsigned int size = start + len;
>  	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>  	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> -	while (len - bits_to_set >= 0) {
> +	while (len >= bits_to_set) {
>  		*p |= mask_to_set;
>  		len -= bits_to_set;
>  		bits_to_set = BITS_PER_LONG;
> -- 
> 2.36.1
