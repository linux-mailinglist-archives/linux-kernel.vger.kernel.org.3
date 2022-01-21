Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64126495A42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348851AbiAUHBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:01:32 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45625 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiAUHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:01:32 -0500
Received: by mail-ed1-f42.google.com with SMTP id z22so38864971edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EauRHZ/GVVCGfn8G5vgi+TQVC0ch7f4S8Xm0B+EGC7A=;
        b=I2BIH3Faq4rU+XKp18pW9rOlPZqwgFbg8JVqb/fH5KnDfnGpFQ8/YUD84ypJcul3x0
         uoqpCtV4rNYbabQ6BtR259doTIqcxec0/Ce4UwDIDZYaYcGjhbBk1VbdEY2N5LjpcRni
         JjoELaYkrZvvTC0GswbeguevC7BdSi+KIc7Khq5bfnBexcIlXS+ygv6iUG6b40uqSEC0
         ZUWlP3i9zBpuNkv+caRD2uKdi3cIu9K7W/N9yHbkb4dxLFACC2l022fO25xgYsGyz8Nj
         qDdmhjODmR6CYaDcoApeZKRmzZNW3xrZTjsU3UZ9fjNW/UJ/Sgd7fJp+IJyac3ClENB/
         cM0w==
X-Gm-Message-State: AOAM530grdZ07BYbdYaJUvfpL0CziRv7bwZfU+JX5+tG5NEfDdZMP0df
        QJYnJtHOm69otrZRUy/GAjz7txGM1xA=
X-Google-Smtp-Source: ABdhPJxirR/uHxNW8W8wAcv+Lq++gIda5gxO7JAR/KIIG79j3WoT4turRyVLh4yt5PTMukBESQ/l9g==
X-Received: by 2002:a05:6402:1bcc:: with SMTP id ch12mr3102142edb.227.1642748490713;
        Thu, 20 Jan 2022 23:01:30 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z4sm1711242ejd.39.2022.01.20.23.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 23:01:29 -0800 (PST)
Message-ID: <716113c0-13d6-6fbc-f1a0-9fea6091bb90@kernel.org>
Date:   Fri, 21 Jan 2022 08:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tty: vt: Check for NULL pointer after calling kzalloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org,
        jcmvbkbc@gmail.com, dsterba@suse.com, johan@kernel.org,
        dankamongmen@gmail.com, penguin-kernel@I-love.SAKURA.ne.jp,
        igormtorrente@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220121065320.2283544-1-jiasheng@iscas.ac.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220121065320.2283544-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 01. 22, 7:53, Jiasheng Jiang wrote:
> As the potential failure of the allocation, the kzalloc() will return
> NULL pointer.
> Therefore, it should be better to check it in order to avoid the
> dereference of the NULL pointer.
> When it fails, we should free all the allocated memory and return error
> number.
> To make the code more clear, I use the 'err_free', like how
> vc_allocate() deals with the allocation failure.

https://lore.kernel.org/all/X+CRTqDQwVYSZQBi@kroah.com/

> Fixes: a5f4f52e8211 ("vt: use kzalloc() instead of the bootmem allocator")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/tty/vt/vt.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index f8c87c4d7399..343fa6fffc18 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3519,11 +3519,17 @@ static int __init con_init(void)
>   
>   	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>   		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc)
> +			goto err_free;
> +
>   		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   		tty_port_init(&vc->port);
>   		visual_init(vc, currcons, 1);
>   		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
>   		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto err_free_vc;
> +
>   		vc_init(vc, vc->vc_rows, vc->vc_cols,
>   			currcons || !vc->vc_sw->con_save_screen);
>   	}
> @@ -3545,6 +3551,19 @@ static int __init con_init(void)
>   	register_console(&vt_console_driver);
>   #endif
>   	return 0;
> +err_free_vc:
> +	visual_deinit(vc);
> +	kfree(vc);
> +	vc_cons[currcons].d = NULL;
> +err_free:
> +	for (i = 0; i < currcons; i++) {
> +		kfree(vc_cons[currcons].d->vc_screenbuf);
> +		visual_deinit(vc_cons[currcons].d);
> +		kfree(vc_cons[currcons].d);
> +		vc_cons[currcons].d = NULL;
> +	}
> +	console_unlock();
> +	return -ENOMEM;
>   }
>   console_initcall(con_init);
>   


-- 
js
