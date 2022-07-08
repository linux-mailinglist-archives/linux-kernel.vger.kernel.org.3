Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF41156C44E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiGHTFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiGHTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:05:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82D25E94;
        Fri,  8 Jul 2022 12:05:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so26962048ljb.5;
        Fri, 08 Jul 2022 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlzZcoQi6N5H04cLMBPt4y2hPNxixoZVDelp6FruGTQ=;
        b=Yy9dxNDW6VCVo0JeJAUXbcpMXJU3WNA8x8Eurlve66sY8Labx20UJt7Y8lU8yJga+O
         XqyZb0YsikufpwjcPouvWIsRKbokRQixp9MejCu/LiovWBcemrZBI9Ac9uyVhMJH8AhC
         vjzItyuuAlEJNxJU/pSgizH/ZaMaapghYVNuz/g6GsDVWU72D7n+lX50dhodYKKQoFFz
         IBlhQfcjFQoeWxOOGsSnPs1V4FxIdPNiFPiX0UKKu1bzRmzEetHALvGnJoJI+MNm2W+5
         KGz+e0LwvyqaZoTEl98mEpYOVQ5VSiE0xD4EfDhC0ey0iLux3oWwLzocf/mn+BpOu5Y8
         +J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlzZcoQi6N5H04cLMBPt4y2hPNxixoZVDelp6FruGTQ=;
        b=yznE11+V+sLPEeUQ1fR+VJkulKz4vz5XOI8hdqRnFU0EzoPschNPdSPxUH4ycjmJ8f
         /b2q/ZV3vPudso/X2L7UjBtwS9YkHNHAahiw8JpyOjk1Z3K3W28L+GCJLyvbnvtRDyv3
         UtRtK0DLf4d6mUAFQNKE9x8jDbPSw/8IapzEOLALG4Iqe6lqbqex6fWb8lgn8sGJFBz7
         t81FlsdT7bT37ROQJJQxRROzDXqLQKYs+THm9x4yTy/5I2+DDTDTkF0ukhiV6Ff6Fqfl
         5ma1VbRIS8gf9nIg9sxRtiPqdIm0q0qNh7jEpIicjp7OHy/moV3v/jOEG711i5FF7CVh
         wBgg==
X-Gm-Message-State: AJIora8pYWi/6l4ftJIp7vuatbTUdwNaQ4G0limLKclbeUykX0Q0Eb5j
        xyZ2YfFLwuX5sjy5Ef264C03fmILRPkj2Q==
X-Google-Smtp-Source: AGRyM1ubzaBSG6JaOfhQXw9+L4Ab4ssaj5D7vaysboibw3wo1V12sHckfhM7w0lVIZcP9rSxpd22Kw==
X-Received: by 2002:a2e:9004:0:b0:25a:7c03:eb73 with SMTP id h4-20020a2e9004000000b0025a7c03eb73mr2696654ljg.470.1657307141097;
        Fri, 08 Jul 2022 12:05:41 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z19-20020a056512371300b0047fa16f71e6sm7555446lfr.30.2022.07.08.12.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:05:40 -0700 (PDT)
Date:   Fri, 8 Jul 2022 22:05:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] eeprom: idt_89hpesx: uninitialized data in
 idt_dbgfs_csr_write()
Message-ID: <20220708190538.asdkcgmlxwqxjpbx@mobilestation>
References: <Ysg1Pu/nzSMe3r1q@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysg1Pu/nzSMe3r1q@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:46:38PM +0300, Dan Carpenter wrote:
> The simple_write_to_buffer() function will return positive/success if it
> is able to write a single byte anywhere within the buffer.  However that
> potentially leaves a lot of the buffer uninitialized.
> 
> In this code it's better to return 0 if the offset is non-zero.  This
> code is not written to support partial writes.  And then return -EFAULT
> if the buffer is not completely initialized.
> 
> Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Seems reasonable. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
> v2: In v1, I tried to be fancy and use strndup_user().  That potentially
> breaks the user space API.  I cannot test this code so it's better to be
> conservative.
> 
>  drivers/misc/eeprom/idt_89hpesx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index b0cff4b152da..7f430742ce2b 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -909,14 +909,18 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
>  	u32 csraddr, csrval;
>  	char *buf;
>  
> +	if (*offp)
> +		return 0;
> +
>  	/* Copy data from User-space */
>  	buf = kmalloc(count + 1, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = simple_write_to_buffer(buf, count, offp, ubuf, count);
> -	if (ret < 0)
> +	if (copy_from_user(buf, ubuf, count)) {
> +		ret = -EFAULT;
>  		goto free_buf;
> +	}
>  	buf[count] = 0;
>  
>  	/* Find position of colon in the buffer */
> -- 
> 2.35.1
> 
