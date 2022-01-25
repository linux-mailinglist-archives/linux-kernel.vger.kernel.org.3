Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6778949AB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378996AbiAYFUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391195AbiAYFD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:03:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7FC0AD1A0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:35:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u130so13831126pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9x/Lsa7ti7gTSupQfhnG6ZXqf3XFn7FMKDh1kMENpvw=;
        b=OMYsr3z2K+XI/ZQ+BWmynvWMXqDyN50mi/156DKaicA8Rq1srJ9KHg/MEuYUKlumnT
         khIzm+PT8QwnBKfFhhBZD3936ZzZp4mBsnH010vHbZtwKHsTGxzwjQf6ktZDQ9RL+HC+
         UWTNZ/vY2xZZM5bQDWFQv1M9j837LeV4nk538=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9x/Lsa7ti7gTSupQfhnG6ZXqf3XFn7FMKDh1kMENpvw=;
        b=JNGG9wtl9vsDhA6QkJZ3tzI9B5jZxrKFDVz1TgrqkhPHXjhjeMnBi3UAR1DAqy5wwe
         vSraEh8PzcnSnOuIMsl/NTj7boA5RPDA0n3s3XK3hDKGaXKdGcmt3kItcJYmHzs9Gp8C
         rgHSNsbwmrA6BgGctNj7bxJir5XluwYrA0gixeGzpnVJgt6ua2TGhTpuPDcLpe6gitDr
         ZbQuGRss0V+/SE6bEn6nDQc8tQZAlZL9AeRP5VVM0i2DG4kdnMV9HGJ3vf4ix4hb0C3s
         XrMkeRwiJsK4zuSGJ72MtFZlDNwEf2LOy86T/Ia0nn2ehRDpwGO5fgJ3bZ0tYEzvIx+v
         PO8A==
X-Gm-Message-State: AOAM533LEABUe283m+HoRSQMAJ55p10JZ9D5maaMwW6OfmUnKKiVSe8o
        eAcMyktt+lz+kyXEmtl2CzG1FcucTHRvrw==
X-Google-Smtp-Source: ABdhPJzOSHR28VSWx0ruqnBVgXS6IERsb1Z/aoPvcziYyRFHW8j/TUdZRzIE1/2HprGg7JLj893NDg==
X-Received: by 2002:a63:8c06:: with SMTP id m6mr13843903pgd.498.1643081757547;
        Mon, 24 Jan 2022 19:35:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm5854164pgw.30.2022.01.24.19.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 19:35:57 -0800 (PST)
Date:   Mon, 24 Jan 2022 19:35:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201241924.20B85B89@keescook>
References: <20220125115757.20bc45e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125115757.20bc45e8@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:57:57AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/string.h:253,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from arch/x86/include/asm/cpumask.h:5,
>                  from arch/x86/include/asm/msr.h:11,
>                  from arch/x86/include/asm/processor.h:22,
>                  from arch/x86/include/asm/cpufeature.h:5,
>                  from arch/x86/include/asm/thread_info.h:53,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:7,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/wait.h:9,
>                  from include/linux/mempool.h:8,
>                  from include/linux/bio.h:8,
>                  from fs/btrfs/ioctl.c:7:
> In function 'fortify_memcpy_chk',
>     inlined from 'btrfs_ioctl_encoded_write' at fs/btrfs/ioctl.c:5082:3:
> include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   316 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/fortify-string.h:324:25: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   324 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   602670289b69 ("fortify: Detect struct member overflows in memcpy() at compile-time")
> 
> interacting with commit
> 
>   504e1ebb6316 ("btrfs: add BTRFS_IOC_ENCODED_WRITE")
> 
> from the btrfs tree.

Thanks!

I found the btrfs patch here:
https://lore.kernel.org/all/ec08e6f559ab47b3300ca5a67e8fc984fd3f040f.1637179348.git.osandov@fb.com/

> 
> I applied the following hack:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 25 Jan 2022 11:47:17 +1100
> Subject: [PATCH] fix up for "btrfs: add BTRFS_IOC_ENCODED_WRITE"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/btrfs/ioctl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 73ad918a05a9..d34620034f8e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -5079,9 +5079,14 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp,
>  		}
>  		args.iov = compat_ptr(args32.iov);
>  		args.iovcnt = args32.iovcnt;
> -		memcpy(&args.offset, &args32.offset,
> -		       sizeof(args) -
> -		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
> +		args.offset = args32.offset;
> +		args.flags = args32.flags;
> +		args.len = args32.len;
> +		args.unencoded_len = args32.unencoded_len;
> +		args.unencoded_offset = args32.unencoded_offset;
> +		args.compression = args32.compression;
> +		args.encryption = args32.encryption;
> +		memcpy(args.reserved, args32.reserved, sizeof(args.reserved));
>  #else
>  		return -ENOTTY;
>  #endif

I'll see if I can construct something shorter using struct_group().

-Kees

-- 
Kees Cook
