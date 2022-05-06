Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312FD51DB07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442414AbiEFOuh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiEFOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:50:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C3D013D51
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:46:51 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-274-gs3rWkflMKGWx7a-ge22aQ-1; Fri, 06 May 2022 15:46:49 +0100
X-MC-Unique: gs3rWkflMKGWx7a-ge22aQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 6 May 2022 15:46:47 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 6 May 2022 15:46:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jagdish Gediya' <jvgediya@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
Subject: RE: [PATCH] kobject: Refactor kobject_set_name_vargs()
Thread-Topic: [PATCH] kobject: Refactor kobject_set_name_vargs()
Thread-Index: AQHYYU3qLELCyca9fE2SaEK1v39Vvq0R6/5w
Date:   Fri, 6 May 2022 14:46:47 +0000
Message-ID: <5902e26ef400451b966be2dd0fbd1575@AcuMS.aculab.com>
References: <20220506133309.36794-1-jvgediya@linux.ibm.com>
In-Reply-To: <20220506133309.36794-1-jvgediya@linux.ibm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya
> Sent: 06 May 2022 14:33
> 
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
...
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

There is a kstrdup_const() that will DTRT here.

> +		strreplace(t, '/', '!');
> +		s = t;
> +	}
> +	kfree_const(*name);
> +	*name = s;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(set_name_vargs);

Are you sure this can ever work from a module?
This all relies on:

static inline bool is_kernel_rodata(unsigned long addr)
{
	return addr >= (unsigned long)__start_rodata &&
	       addr < (unsigned long)__end_rodata;
}

which isn't going to do anything sane given an "xxx" inside a module.

Indeed can kobject_set_name_vargs() end up with a constant string
inside a module?
Seems horribly fragile.

	David

> +
>  /**
>   * kmemdup - duplicate region of memory
>   *
> --
> 2.35.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

