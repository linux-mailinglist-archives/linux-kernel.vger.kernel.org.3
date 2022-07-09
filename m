Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC356C6F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGIEt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGIEt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:49:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F27CB6B;
        Fri,  8 Jul 2022 21:49:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso427137pjh.1;
        Fri, 08 Jul 2022 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0HO/qAsB3R8gbRneYsc8yW1xNcur0kYOLUwd4bhxh3Y=;
        b=qXembta/FNx7UyrxcagGKJ6ixuWKcxa/grpERCT6pF2YEUwZXHWR4oHWLV9aEaVPJu
         StVn+iIESc3ZaGulEfIwTqVYdhGo2lc0pJKoUwyTQ4upDrJwp2EUiQRxSLnod1uYLMS5
         GcHcDYZjX1mGKWDBZYf8hrQ5ktZE77AumwCSIbOeecfSfE0SYknyotfCLZyRvmaqCxzd
         LqsKViYx4FJQVnCXyTTbuUnMKr0/juXjo1D1c6UK4EvB1+rXx3ZYc3vfHh4TvtgNWsQv
         BZz+aZ8UEs3Dww6qw+PCvUzUSalBy/GOyAInx+x1eqTQL7PIZY5cGNfVO68PDQdbWUWs
         a/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0HO/qAsB3R8gbRneYsc8yW1xNcur0kYOLUwd4bhxh3Y=;
        b=rVbHXO5kJrjoqc+Fl5YE7j/+Z2WaJI6yoLi78qe8i85+xQy43aZWZxr/AMBn3wzjX5
         S4W1AuyLGf4uIWWd2HSFlMT769/Id2xGxtaRb/7ijb7HSGrSGjxhzTjMemC94B2u0QSb
         ZpDrk3+kvRnrt7TO5nMerJyBHIi9wgO2Gop5Is6fFQIhYdJ24ris7mK3PXTKSOmg6eOI
         ujxe7eCj6r8AJjZucnRejD4bvLFTziM17+EjUWyMJgbiXPuGYTolmIOvkeDys3OCz0ki
         mQU71Bdsw/R/W2W8sBDaeHLns2GvxsHlwXoCffau5Zt8T/xv70sZg17FukvWoSIlBtzI
         nOQQ==
X-Gm-Message-State: AJIora/3zkBFugEZPXRoSzRT943BX31SRY2C33mOdQlU3xYqZLM2RqFg
        rzZvsZimiSgmwubYFxmsRAs=
X-Google-Smtp-Source: AGRyM1sg4llNHKoKW4wKCEigx3su3UywhPvNpuZFce/XHma7HsoMI8nt9AuciqNsMwL/0FAi9Ja/UQ==
X-Received: by 2002:a17:90a:e00c:b0:1ef:81e6:9044 with SMTP id u12-20020a17090ae00c00b001ef81e69044mr3877832pjy.169.1657342166676;
        Fri, 08 Jul 2022 21:49:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5011:9ea9:1cc2:a4c0])
        by smtp.gmail.com with ESMTPSA id i3-20020a639d03000000b003fd1deccd4dsm285966pgd.59.2022.07.08.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 21:49:25 -0700 (PDT)
Date:   Fri, 8 Jul 2022 21:49:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Liang He <windhl@126.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/serio: Fix refcount leak bug in i8042-sparcio
Message-ID: <YskI088DEjt39Dqm@google.com>
References: <20220619073036.4067872-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619073036.4067872-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Sun, Jun 19, 2022 at 03:30:36PM +0800, Liang He wrote:
> In i8042_platform_init() and i8042_platform_exit(), we need call
> of_node_put() to keep refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/input/serio/i8042-sparcio.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> index fce76812843b..a2a9db9220d7 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -108,6 +108,8 @@ static int __init i8042_platform_init(void)
>  	struct device_node *root = of_find_node_by_path("/");
>  	const char *name = of_get_property(root, "name", NULL);
>  
> +	of_node_put(root);
> +
>  	if (name && !strcmp(name, "SUNW,JavaStation-1")) {
>  		/* Hardcoded values for MrCoffee.  */
>  		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
> @@ -139,6 +141,8 @@ static inline void i8042_platform_exit(void)
>  	struct device_node *root = of_find_node_by_path("/");
>  	const char *name = of_get_property(root, "name", NULL);
>  
> +	of_node_put(root);
> +
>  	if (!name || strcmp(name, "SUNW,JavaStation-1"))
>  		platform_driver_unregister(&sparc_i8042_driver);
>  }

There already was an attempt to fix this issue in a slightly better way,
unfortunately the original author did not finish the work:

https://lore.kernel.org/all/20181212163548.23723-1-tiny.windzz@gmail.com/

Thanks.

-- 
Dmitry
