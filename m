Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53E50D7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbiDYD6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiDYD56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:57:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835D326DF;
        Sun, 24 Apr 2022 20:54:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h12so20471830plf.12;
        Sun, 24 Apr 2022 20:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pQXIC5eVOwKC8ZidFmX8UNKR4XEADdpPS0SFi/IbbEA=;
        b=dj6ybFRKBhDhlqQ4Fw8knCIIbky0BgYCR/5sX7gsmDIMGiT5qIoXrP77zYHiK0F9Mi
         dfB3AJLKLZesp9KYjCtUHioLfstLYGuILSoLuVQrYOkHmjkmH/k5QXWS7mdv1ibCxgmt
         QTyy/b83y1LswIacWZ+Kf5pamqyZz7KTSGUNyY8iAGVjQKmFjQIURad1e/jlv/J9QcAs
         dp6to0Gf1PGa+DBMCR4hfwi9KGn0HXSKjOMbsBUz/r/qIB2REQgLCJGxiQE+oSkXXrir
         gFz2r5RaPaqmjws/hDMMLRkQvIG3GFIrcCeId8bJKO6igo5pCv2TSXb5Nz46uZvaCeDR
         j70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQXIC5eVOwKC8ZidFmX8UNKR4XEADdpPS0SFi/IbbEA=;
        b=GcCVLGB2dyCx4cOwH2BLLUb8pdFgQrQd6OS4fa8BjKVPoi2MVopX4KgUoQourucDsb
         JipixbKt+ACnYW4DH+ENKHFauJN8VqdQLGvQViuDQi5gFlRRWZs8xNU1s8ZRyV59udmy
         Q6eDFntmalSW3PVkDHjli6/QB/8WQc7EzseD9ZgWR0LfAw0F4tWbvedqeVa/IEda0pie
         3XLLg6HSa4Tb38ub5hR93X3myvApnmHMkb4ESqikPGQYfLSBdbt3DwZYIrKLxEnvJ/wO
         CHHMqTeWiBIOefy8acaDjcx2cjyc6a7I3hJUKzwCjJ85jBG0+d3bw2ugIshZP2Pq1853
         jUlw==
X-Gm-Message-State: AOAM532e6uVhO/0M4LRC6W+bE9Y11HCYvLGJCOjtxaJfLwo4jZbWbczt
        ICD5b3jWBhXOW+nCqI6Mj434/nO0uw0=
X-Google-Smtp-Source: ABdhPJxnH2mGhXyml2JLDOMkoeSeHEFx4rRW0yMieF9Ic373jKaxIwbjuljYciTw7RZbhwB2nJ9bYQ==
X-Received: by 2002:a17:903:240c:b0:153:c8df:7207 with SMTP id e12-20020a170903240c00b00153c8df7207mr15853801plo.44.1650858894321;
        Sun, 24 Apr 2022 20:54:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id w4-20020a056a0014c400b004fb0c7b3813sm9899591pfu.134.2022.04.24.20.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:54:53 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:54:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cgel.zte@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] input: omap4-keypad: using pm_runtime_resume_and_get
 instead of pm_runtime_get_sync
Message-ID: <YmYbihgXZTs9pgOg@google.com>
References: <20220414085710.2541867-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414085710.2541867-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:57:10AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/input/keyboard/omap4-keypad.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index 43375b38ee59..df6ab8006807 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -179,11 +179,9 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int irq, void *dev_id)
>  	int error;
>  	u64 keys;
>  
> -	error = pm_runtime_get_sync(dev);
> -	if (error < 0) {
> -		pm_runtime_put_noidle(dev);
> +	error = pm_runtime_resume_and_get(dev);
> +	if (error < 0)

pm_runtime_resume_and_get() returns 0 or negative error, so we can
simplify the check to "if (error)".

I adjusted locally and applied, thank you.

-- 
Dmitry
