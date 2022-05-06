Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7FF51D9B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441954AbiEFOGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349347AbiEFOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:06:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37B541AC
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27532B835D5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB84C385A9;
        Fri,  6 May 2022 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651845751;
        bh=ufq3bjZ09clzli8bz1S9ydGwiX1f3vkPaLVKdGK2X38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIjyiK3LJEYMh9u5riG/w+6W71FZWhm9GwiLzD/PqHGj7+n4YWf2Zt2LwxlR7nZrZ
         dJyKt4cp0+BXZX7LnpYIEYoEUm6BZYuoUwla82J0ffo08XoLcyln0C8TSgu+p3Uhlf
         NNIHVq9JXan2diQ7g4s2arh2usiYD2k0RZIAF92U=
Date:   Fri, 6 May 2022 16:02:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, andriy.shevchenko@linux.intel.com,
        geert@linux-m68k.org, linux@roeck-us.net, adobriyan@gmail.com
Subject: Re: [PATCH] kobject: Refactor kobject_set_name_vargs()
Message-ID: <YnUqdBuxy7MofDoR@kroah.com>
References: <20220506133309.36794-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506133309.36794-1-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 07:03:09PM +0530, Jagdish Gediya wrote:
> Setting name as per the format is not only useful for kobjects.
> It can also be used to set name for other things for e.g. setting
> the name of the struct attribute when multiple same kind of attributes
> need to be created with some identifier in name, instead of managing
> memory for names at such places case by case, it would be good if
> something like current kobject_set_name_vargs() can be utilized.
> 
> Refactor kobject_set_name_vargs(), Create a new generic function
> set_name_vargs() which can be used for kobjects as well as at
> other places.
> 
> This patch doesn't introduce any functionality change.
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
>  include/linux/string.h |  1 +
>  lib/kobject.c          | 30 +-----------------------------
>  mm/util.c              | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b6572aeca2f5..f329962e5ae9 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -9,6 +9,7 @@
>  #include <linux/stdarg.h>
>  #include <uapi/linux/string.h>
>  
> +int set_name_vargs(const char **name, const char *fmt, va_list vargs);
>  extern char *strndup_user(const char __user *, long);
>  extern void *memdup_user(const void __user *, size_t);
>  extern void *vmemdup_user(const void __user *, size_t);
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 5f0e71ab292c..870d05971e3a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -249,35 +249,7 @@ static int kobject_add_internal(struct kobject *kobj)
>  int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
>  				  va_list vargs)
>  {
> -	const char *s;
> -
> -	if (kobj->name && !fmt)
> -		return 0;
> -
> -	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
> -	if (!s)
> -		return -ENOMEM;
> -
> -	/*
> -	 * ewww... some of these buggers have '/' in the name ... If
> -	 * that's the case, we need to make sure we have an actual
> -	 * allocated copy to modify, since kvasprintf_const may have
> -	 * returned something from .rodata.
> -	 */
> -	if (strchr(s, '/')) {
> -		char *t;
> -
> -		t = kstrdup(s, GFP_KERNEL);
> -		kfree_const(s);
> -		if (!t)
> -			return -ENOMEM;
> -		strreplace(t, '/', '!');
> -		s = t;
> -	}
> -	kfree_const(kobj->name);
> -	kobj->name = s;
> -
> -	return 0;
> +	return set_name_vargs(&kobj->name, fmt, vargs);
>  }
>  
>  /**
> diff --git a/mm/util.c b/mm/util.c
> index 54e5e761a9a9..808d29b17ea7 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -112,6 +112,46 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
>  }
>  EXPORT_SYMBOL(kstrndup);
>  
> +/**
> + * set_name_vargs() - Set the name as per format
> + * @name: pointer to point to the name as per format
> + * @fmt: format string used to build the name
> + * @vargs: vargs to format the string.
> + */
> +int set_name_vargs(const char **name, const char *fmt, va_list vargs)

Why is this a mm/ thing and not a lib/ thing?

And who else will be needing to use this?  Why the churn for no
actual users?

> +{
> +	const char *s;
> +
> +	if (*name && !fmt)
> +		return 0;
> +
> +	s = kvasprintf_const(GFP_KERNEL, fmt, vargs);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	/*
> +	 * ewww... some of these buggers have '/' in the name ... If
> +	 * that's the case, we need to make sure we have an actual
> +	 * allocated copy to modify, since kvasprintf_const may have
> +	 * returned something from .rodata.
> +	 */
> +	if (strchr(s, '/')) {
> +		char *t;
> +
> +		t = kstrdup(s, GFP_KERNEL);
> +		kfree_const(s);
> +		if (!t)
> +			return -ENOMEM;
> +		strreplace(t, '/', '!');
> +		s = t;
> +	}
> +	kfree_const(*name);
> +	*name = s;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(set_name_vargs);

No need to export this as there are no users in modules.

And if there was, shouldn't it be EXPORT_SYMBOL_GPL() as that's what the
kobject functions are exported as (most of them at least.)

But again, why is this needed at all?

thanks,

greg k-h
