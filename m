Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A84953E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiATSOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiATSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:14:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EACDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:14:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u130so2041581pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sOK8Ok1ZQTzg6dPQtib4q7TePacA51amgY3BF4r2O1o=;
        b=Y4sbbhTqE7AAD2RzVTue6vc5Z6vuYgXfQ1sPlZPXPMTjobl3QwI28uzhtYvZlf/wAG
         vZKG6DebmDBeofQ+VuovAIymHF6dDrzvPWOimZluxaJD74HTS2r42u5lFcCvQMwrcHhY
         SbtxPMjtWY/8+S5xKGp+Socd73ZR4wOZAYbW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sOK8Ok1ZQTzg6dPQtib4q7TePacA51amgY3BF4r2O1o=;
        b=mGF3Iym3tZ53anG8PAbxSdI0FF9EPcYDJonB/LLmtoNzBBY7ucZDph1w8Q55+osIC1
         arGgusqYoY5rm2q2Zo5h1XehwCG4o3d7qfe0jSdqYlU9SKzO02lXzCYeVOTwf8dV0mtV
         EETx4/DBFP2ywmw3uHdeHl36Le/JCEOWxhbE63rLq1uMH5xfjcYjHf4+MoxxFwQnw0Pf
         ajs4LJBKn44hWF0Qx1sRHZ1JH3dWGY7wWyVj38VzYXAxL2LxTnYJ5g84oy0Z3kM/i+Lf
         AQcdxWJBvFtncXkQEnWYXpOFS+npouJPGozeb6aJ2caCdMGt/x4SNNeiqnjNLgZqTEzW
         SZqA==
X-Gm-Message-State: AOAM533hLgxKDokCy/cppdAzX/qLUO6feGrPx+OuR2F6nAhhZnT4xZ1k
        9DJpuuMHvN59Kq4QCfF1O8+h+w==
X-Google-Smtp-Source: ABdhPJwmT5hMY53u7eLodFYspiBUE96qUrOhvQcgxNnwWIXi+G/UmDp2ceTPJ825tLGKRM3b9yk4Yg==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr1059324pgd.135.1642702449716;
        Thu, 20 Jan 2022 10:14:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z17sm4386180pfe.10.2022.01.20.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:14:09 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:14:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lkdtm/bugs: Check for the NULL pointer after calling
 kmalloc
Message-ID: <202201201013.0079B1D@keescook>
References: <20220120092936.1874264-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120092936.1874264-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 05:29:36PM +0800, Jiasheng Jiang wrote:
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
> 
> v2 -> v3
> 
> * Change 1. Add pr_err if fails.
> 
> v3 -> v4
> 
> * Change 1. Revert to v2 that remove the pr_err.
> ---
>  drivers/misc/lkdtm/bugs.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Kees Cook <keescook@chromium.org>

> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 4282b625200f..072e3b742edf 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -248,6 +248,11 @@ void lkdtm_ARRAY_BOUNDS(void)
>  
>  	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
>  	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
> +	if (!not_checked || !checked) {
> +		kfree(not_checked);
> +		kfree(checked);
> +		return;
> +	}
>  
>  	pr_info("Array access within bounds ...\n");
>  	/* For both, touch all bytes in the actual member size. */
> -- 
> 2.25.1
> 

-- 
Kees Cook
