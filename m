Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6D4DDF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiCRQnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiCRQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:43:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFFB1D41AA;
        Fri, 18 Mar 2022 09:41:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mm4-20020a17090b358400b001c68e836fa6so4340551pjb.3;
        Fri, 18 Mar 2022 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KSGmpVI8uN21zYNyBxBAA5nNVcHc735cJRCpzBk9Njc=;
        b=WZFnE78FkaigHA7v7qRb+dO1PG+CoDzlvOL3gw1FaKCT64U6kGKf4MBitm20+U3fUY
         zBJiFo4heNqSBMYsgTE2KzGmMwg23Nt5vaXgLsmBlx8qnL3ifCK+HTfk1dK4rfGa1E+J
         azuUQX9LXzKef3EM6z6fnEC0osLB/LUCZf6xXsKMNQ0+mwr+A692mr2LWuXZlZAqXSXo
         qIWllFWBZS9zmK0ywu21GhcYT6w7YHxuJvPQ81A44hwrHrTiu7PfYNhxfW2JupsOKYRb
         4XW02oacJIzeU1q0uZzTIUWD799DwaXZ33Q3Do4sq5ZvMWir8cJs0s8V23mZuFJOt6G1
         yM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KSGmpVI8uN21zYNyBxBAA5nNVcHc735cJRCpzBk9Njc=;
        b=Zr6fO6sdWott1HRoD3RHkf8+yQBbF0rg6fsc7me63YEfJ3lpUFBiSVxiOdN0FApfs8
         L59CrIo6JhN0i2vaEpNvuyjxG5O4R97rylTxE8+rVKvs9zSrmVkAAIYDntM7dSHUFcVb
         AAYaTZ1g4qy26D/cvofmMqTUNIGX34tyyHAbMLLaPNb/mxUiZYLJjwdrqagn3uaXUXfJ
         /XMNSzsEfacMUYeyveZQaydhQnxAN8wfb1BcX/ZTucPAve0zW5yMK1Wk2NPAdrDOlPWz
         lo4NZp1ByK52X8JW/VtXbiLsrBrQ/EsjAMrOJdnaH8j70AdKU+/vOsc/vTwWY/dtgtCl
         +uuw==
X-Gm-Message-State: AOAM532Re7Z8LYFzsyOgPGfC3RRtSJf+N2xKNfpPVd10FCd7/6Tsh8d1
        ILCY4zYl94CcT7YxhVwlx7Y=
X-Google-Smtp-Source: ABdhPJxq8hOnNeD8ltQ+doWSFriEfvMEmHsu4aD8GEXjDMw6roLzmDrESylkPyd2eHvtUCaI+i2SAA==
X-Received: by 2002:a17:902:b590:b0:153:a243:3331 with SMTP id a16-20020a170902b59000b00153a2433331mr283230pls.129.1647621707058;
        Fri, 18 Mar 2022 09:41:47 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:bd26:cec:b459:db6e])
        by smtp.gmail.com with ESMTPSA id v16-20020a056a00149000b004f7ae2cbd3asm10258179pfu.166.2022.03.18.09.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:41:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Mar 2022 09:41:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
Message-ID: <YjS2SJU7VE1bGb/F@google.com>
References: <20220315172221.9522-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315172221.9522-1-bgeffon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> Today it's only possible to write back as a page, idle, or huge.
> A user might want to writeback pages which are huge and idle first
> as these idle pages do not require decompression and make a good
> first pass for writeback.

Hi Brian,

I am not sure how much the decompression overhead matter for idle pages
writeback since it's already *very slow* path in zram but I agree that
it would be a good first pass since the memory saving for huge writing
would be cost efficient.

Just out of curiosity. Do you have real usecase?

> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  Documentation/admin-guide/blockdev/zram.rst |  6 ++++++
>  drivers/block/zram/zram_drv.c               | 10 ++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> index 3e11926a4df9..af1123bfaf92 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -343,6 +343,12 @@ Admin can request writeback of those idle pages at right timing via::
>  
>  With the command, zram writeback idle pages from memory to the storage.
>  
> +Additionally, if a user choose to writeback only huge and idle pages
> +this can be accomplished with::
> +
> +        echo huge_idle > /sys/block/zramX/writeback
> +
> +
>  If admin want to write a specific page in zram device to backing device,
>  they could write a page index into the interface.
>  
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index cb253d80d72b..f196902ae554 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -643,8 +643,8 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  #define PAGE_WB_SIG "page_index="
>  
>  #define PAGE_WRITEBACK 0
> -#define HUGE_WRITEBACK 1
> -#define IDLE_WRITEBACK 2
> +#define HUGE_WRITEBACK (1<<0)
> +#define IDLE_WRITEBACK (1<<1)
>  
>  
>  static ssize_t writeback_store(struct device *dev,
> @@ -664,6 +664,8 @@ static ssize_t writeback_store(struct device *dev,
>  		mode = IDLE_WRITEBACK;
>  	else if (sysfs_streq(buf, "huge"))
>  		mode = HUGE_WRITEBACK;
> +	else if (sysfs_streq(buf, "huge_idle"))
> +		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
>  	else {
>  		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
>  			return -EINVAL;
> @@ -725,10 +727,10 @@ static ssize_t writeback_store(struct device *dev,
>  				zram_test_flag(zram, index, ZRAM_UNDER_WB))
>  			goto next;
>  
> -		if (mode == IDLE_WRITEBACK &&
> +		if (mode & IDLE_WRITEBACK &&
>  			  !zram_test_flag(zram, index, ZRAM_IDLE))
>  			goto next;
> -		if (mode == HUGE_WRITEBACK &&
> +		if (mode & HUGE_WRITEBACK &&
>  			  !zram_test_flag(zram, index, ZRAM_HUGE))
>  			goto next;
>  		/*
> -- 
> 2.35.1.723.g4982287a31-goog
> 
