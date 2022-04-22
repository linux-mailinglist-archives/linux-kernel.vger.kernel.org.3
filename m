Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3C50C2C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiDVWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiDVWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:13:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2735122C3C3;
        Fri, 22 Apr 2022 14:00:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so6741681pfe.13;
        Fri, 22 Apr 2022 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iv87v9Yca5TZDg/ZQ/iYjZjkzk7tiOH6BRDDm7Dxt0Y=;
        b=fu0F1CAVqlD9Irw8VYYm8YmF+EPHITJrPwLkshaOAGcPbpAgnfpdLx0vAZX9gI6xZf
         SJ3CNdXK9Y4YbnjX5RygQu9E9ZFtDXEPrebfQd3u5POyYIP/Ain4NphhDZtQxZw1qEWm
         GVHPujZWudp0ogm9MVDdUGMOua6INR1GlA/VTNT+51PUfdHdyWZRxrtZ4UfkIohsoRDZ
         x6Xb3GJShmjXlrTYFvslFdVuPnj0OIshb7baSnSrKa2AJRzLHtXs4Rigv6SB6J+zEdzD
         mNcD6DsEGguEyrnS2cSNZ9R4XGpR4i6+Fd8vol5CLckzjVcNBKjroiIYIfPetGqY+Os+
         5New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iv87v9Yca5TZDg/ZQ/iYjZjkzk7tiOH6BRDDm7Dxt0Y=;
        b=inZsCiCj/gBRuTSaEpp+5cKCK8GA1Pzh8OVgON/XzqBpiZtp9x/ElLyrnxhxDLuRgX
         q1Z848viyvTt9c9sCcf0HijTOgHAIvUmv/yC7KNiAmKWyozX6Ntka9gS7vqRmls2pTvF
         LMfMTNHB8KN2zRIpN0D0Pc/Ya26JC+rQXQliC1jmFcA75D7TD6FPY3SGJibe0C/5WPGt
         Mort2IEILJHtghBgeLu6GvTXwc1MdAYDddzeA3pTWpg2SzM4BiBBt2czutyEm/2XO52D
         D4U1K88Il7LIWtsr+kRY1QeIIWC37BFK1kTWWnhY53RrW5rr/+iLwSgHOb16jhlOGvBv
         yacQ==
X-Gm-Message-State: AOAM533vbirifgrU71c1BSQXugmjL7DwcqcpL8r3d24xNAHsQ+N7zTQe
        XV2OgaI0ps27uhnVB/e4MjkO5n7JHuE=
X-Google-Smtp-Source: ABdhPJzDgamSPgly3WQ+00xbiuqkgQliUhJZzRcFR4QOhP8ELajgX3fvATKicZLowHshGlszxbesiQ==
X-Received: by 2002:a17:903:2352:b0:159:3fa:261 with SMTP id c18-20020a170903235200b0015903fa0261mr6183552plh.21.1650659239352;
        Fri, 22 Apr 2022 13:27:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:2194:db4:85a8:b0df])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a4bc900b001d26f134e43sm7206404pjl.51.2022.04.22.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 13:27:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 22 Apr 2022 13:27:17 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     ngupta@vflare.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org, axboe@chromium.org,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        mnitenko@gmail.com, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v1] zram: don't retry compress incompressible page
Message-ID: <YmMPpaseLn4i6MYk@google.com>
References: <20220422115959.3313-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422115959.3313-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:59:59PM +0300, Alexey Romanov wrote:
> It doesn't make sense for us to retry to compress an uncompressible
> page (comp_len == PAGE_SIZE) in zsmalloc slowpath, because we will
> be storing it uncompressed anyway. We can avoid wasting time on
> another compression attempt. It is enough to take lock
> (zcomp_stream_get) and execute the code below.

Totally make sense. However, I'd like to discuss removing the double
compression logic entirely.

Ccing Sergey to get some opinion.

[da9556a2367c, zram: user per-cpu compression streams]

The 2nd trial allocation under per-cpu pressmption has been used to
prevent regression of allocation failure. However, it makes trouble
for maintenance without significant benefit.
(I gathered some of data from my device and writestall was just 38 for
10 days even though swap was very heap - pswpout 164831211).

Even, such 38 attempts don't guarantee 2nd trial allocation was
successful because it's timing dependent and __GFP_DIRECT_RECLAIM is
never helpful in reclaim context.

I'd like to remove the double compression logic and make it simple.
What do you think?

> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/block/zram/zram_drv.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cb253d80d72b..bb9dd8b64176 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1413,9 +1413,20 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  		handle = zs_malloc(zram->mem_pool, comp_len,
>  				GFP_NOIO | __GFP_HIGHMEM |
>  				__GFP_MOVABLE);
> -		if (handle)
> +		if (!handle)
> +			return -ENOMEM;
> +
> +		if (comp_len != PAGE_SIZE)
>  			goto compress_again;
> -		return -ENOMEM;
> +
> +		/*
> +		 * If the page is not compressible, you need to acquire the lock and
> +		 * execute the code below. The zcomp_stream_get() call is needed to
> +		 * disable the cpu hotplug and grab the zstrm buffer back.
> +		 * It is necessary that the dereferencing of the zstrm variable below
> +		 * occurs correctly.
> +		 */
> +		zstrm = zcomp_stream_get(zram->comp);
>  	}
>  
>  	alloced_pages = zs_get_total_pages(zram->mem_pool);
> -- 
> 2.30.1
> 
