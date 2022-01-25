Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34649B5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387336AbiAYOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:10:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42478 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578005AbiAYOIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:08:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1BF57212BD;
        Tue, 25 Jan 2022 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643119691;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qgv+MCqvmwhK2qBc6bQ3xFsDD/T8tTwmC45myn5GeeM=;
        b=SAgTkskqs+WGzMZOZnENh+aVQbQAFb8kjORO9SRQRKTeaaANpyaKdGkVzG6LtfWbCJ5aZi
        z88UdoDpTbtqZBKDze9Cndl8o+0voBduRbbdp6X58Nvvy/Z0ZZEb4LrRevw0RlFJrGqh1H
        aJC74ElK0MeWHbkeIY3uUxD+jwuvZ2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643119691;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qgv+MCqvmwhK2qBc6bQ3xFsDD/T8tTwmC45myn5GeeM=;
        b=ckxb176UMExRWNpklDJLGSm2kS+aYyJ2UW5kMD2QH/4UAZwThcxvOCA61ILX6sBZ781hdO
        xGMYtC1ukaW9DyAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 12363A3B83;
        Tue, 25 Jan 2022 14:08:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90789DA7A9; Tue, 25 Jan 2022 15:07:30 +0100 (CET)
Date:   Tue, 25 Jan 2022 15:07:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125140730.GO14046@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220125115757.20bc45e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125115757.20bc45e8@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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

Thanks, the patchset is still in progress so I'll apply this a fixup
until the patch gets updated.
