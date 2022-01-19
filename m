Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A206494020
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350117AbiASSpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbiASSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:45:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE1DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:45:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w204so3093479pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1aEqQ/nyIMaBlpDHfQKw2cwOT/MTa3zHEsU16u3B0U=;
        b=kv+M5ciyFpRf2P3r0za6IWJYO1Ra/ayGXj29Z4QCLl6N3v73IdECniDsIDkNoHmYUr
         9s0GnNcyeR3bmle1TPhCVtPv8/hLuGA3Q6QpoSAYlp+dNE+EWUm2hL7CIZaOjMRepKJd
         UCsvLqRXpJhrTNE3plBjsQVVmGHzAKyCA3n8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1aEqQ/nyIMaBlpDHfQKw2cwOT/MTa3zHEsU16u3B0U=;
        b=uBLQamWY9OjtkKlJG6Iwzcd4htjN5WIIHTERscf6CluZlrP69mPnbNjsl1/uUzJArE
         9AjmqCCnH8oA6wttgPAa7FYDPpqwYg68c3ft/hoPgmPVVhx6HtunMco4bOdAQqNW60C2
         YBLx2iFrEtz8a/YAZEHXRJSkLhvFayv+QVEv8+9J513/IGrnX4sI09J0F/GnKbfpPRjQ
         sZKmhLK7uPvuWvtgBKr1lvuGB7+aVhwsumKVIJp/RqEBvhT8gCVZYYO42TgFotwzn5xi
         4iTBgrEEHUwYFcMMOfAI6m1zO5mytfF0dkiCiU4AWc+eFR+aSTm8hzOerNjObVRLninU
         a2KA==
X-Gm-Message-State: AOAM533+ZppW5CH/G/CVwqKqxYEGLEVooYxk9rJZdpTJKdGc+MyFeQwv
        Fvc8I5wJfagZVwQGmiiN3LlsIQ==
X-Google-Smtp-Source: ABdhPJy9Me6bktIP7Dl5TEMY3sYxSNtiMSBjOt4qGk730MjENECqxtZq5cOSvzJrRWZuKX/dZb7J6Q==
X-Received: by 2002:a62:c186:0:b0:4c1:232c:819d with SMTP id i128-20020a62c186000000b004c1232c819dmr32039467pfg.28.1642617933942;
        Wed, 19 Jan 2022 10:45:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm349560pfi.149.2022.01.19.10.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:45:33 -0800 (PST)
Date:   Wed, 19 Jan 2022 10:45:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dan.carpenter@oracle.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm/bugs: Check for the NULL pointer after calling
 kmalloc
Message-ID: <202201191044.69872866B@keescook>
References: <20220119122055.1826561-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119122055.1826561-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:20:55PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the kmalloc(), the not_checked and checked
> could be NULL pointer.
> Therefore, it should be better to check it in order to avoid the
> dereference of the NULL pointer.
> Also, we need to kfree the 'not_checked' and 'checked' to avoid
> the memory leak if fails.
> And since it is just a test, it may directly return without error
> number.
> 
> Fixes: ae2e1aad3e48 ("drivers/misc/lkdtm/bugs.c: add arithmetic overflow and array bounds checks")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v1 -> v2
> 
> * Change 1. Add the kfree if fails.
> ---
>  drivers/misc/lkdtm/bugs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index f4cb94a9aa9c..c35ea54824ac 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -325,6 +325,11 @@ void lkdtm_ARRAY_BOUNDS(void)
>  
>  	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
>  	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
> +	if (!not_checked || !checked) {
> +		kfree(not_checked);
> +		kfree(checked);
> +		return;
> +	}

This should explicitly yell about the memory failure. See the other
error cases for examples. I'd expect something like this before the
return:

		pr_err("FAIL: could not allocate required buffers\n");

-Kees

>  
>  	pr_info("Array access within bounds ...\n");
>  	/* For both, touch all bytes in the actual member size. */
> -- 
> 2.25.1
> 

-- 
Kees Cook
