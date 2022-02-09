Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5959F4AEB0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiBIHbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBIHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:31:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F76C0613CB;
        Tue,  8 Feb 2022 23:31:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m11so3183582edi.13;
        Tue, 08 Feb 2022 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LV46nVT6ZyUm4CkAW3e5eCUPfVZ1+2GfU1mW0n/r+DU=;
        b=H69Zufbut5euCO/mhsNgnHpm5HF95kNT8FFxBZPneQ36ZWcmxcqtAf0tovWvk5UY84
         8b6UpfZbNy3Gu5IHyK/TYgsAU1nzGxbSUHiA7EffiG+jw9meOn8M6ORG29l/5wJF4ifi
         GtIkq8IwUXA7SUFwyEsA/z9ZR44S1uCNfPCx/VU5T6Q/9THAZjOJKTm1yo8j60i7oEGG
         e8O/Z0BvHhQ26ExvMPnywoN4pZ6qPEqD1RcnnIY8Wuc13XlpahSe/apkDCqC3Ws5uASI
         yW2xN5gTADriFkzeFBjhBzZ5k1owEfBxOby84JyMnqThuX68uU1pFxcv02y9L4H0h/+I
         o6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LV46nVT6ZyUm4CkAW3e5eCUPfVZ1+2GfU1mW0n/r+DU=;
        b=YeauyGyWfAAtvi6W5DGJnoe6y3m95wm2pcnnRtGf5k9P8QIpwyGRbc3TWqO6y9l/EK
         Aor8ovM8C5h/ECxz03VqYLYeFAlwG4Dm6y8QwS+4+v89xZxwLPgBMVYZxtqWFuFIwHiB
         Z8U+pIHbtmhHin/44xlEqSuQvSg0clqmd2DcEn2kKXE9kUl1i/EodVwwt8c2zyklURcL
         O1X8BvYAm5EKZ2wypNyBIXdDFCt/2+cjANx947Xq3sKjCvbGjRWCmSij+FylIPS9LFUf
         eZPNecjf5RjHqpBEYZpU0bGmyz6SsTY/O6JeJ3vSqWhhxv4VYZnrc5sLQCO6KTY4tV/W
         9vIA==
X-Gm-Message-State: AOAM533/3Smm942G7RdKkj6oDqzcOt186aSDgbGHHr/ftIaCWlIFjlCg
        h4tztC0FrSSjhG5QrU97/pU=
X-Google-Smtp-Source: ABdhPJwxxXeD0s8j9xGnQpug+hmPsXoxK3Md0tSKC+zT37eaK5mRNiORfFe11V+D/e4B71FM7EzZUw==
X-Received: by 2002:a05:6402:35d4:: with SMTP id z20mr1072349edc.13.1644391876048;
        Tue, 08 Feb 2022 23:31:16 -0800 (PST)
Received: from dumbo ([2a0b:f4c2:1::1])
        by smtp.gmail.com with ESMTPSA id ak15sm3300369ejc.73.2022.02.08.23.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:31:15 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by dumbo with local (Exim 4.94.2)
        (envelope-from <cavok@dumbo>)
        id 1nHhRZ-00051Y-B3; Wed, 09 Feb 2022 08:31:13 +0100
Date:   Wed, 9 Feb 2022 08:31:13 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, Greg KH <gregkh@linuxfoundation.org>,
        jack@suse.cz, jani.nikula@intel.com, jani.nikula@linux.intel.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jlbec@evilplan.org,
        john.ogness@linutronix.de, joonas.lahtinen@linux.intel.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>, julia.lawall@inria.fr,
        Kees Cook <keescook@chromium.org>, kernel@tuxforce.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mark@fasheh.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        phil@philpotter.co.uk, pjt@google.com, pmladek@suse.com,
        rafael@kernel.org, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, sre@kernel.org, steve@sk2.org,
        surenb@google.com, torvalds@linux-foundation.org, tytso@mit.edu,
        Al Viro <viro@zeniv.linux.org.uk>, wangqing@vivo.com,
        Iurii Zaikin <yzaikin@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix regression due to "fs: move binfmt_misc sysctl to
 its own file"
Message-ID: <YgNtwZg77417oFBO@dumbo>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
 <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org>
 <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
 <YgKmaggsipzzCGCg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgKmaggsipzzCGCg@bombadil.infradead.org>
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

On Tue, Feb 08, 2022 at 09:20:42AM -0800, Luis Chamberlain wrote:
> On Mon, Feb 07, 2022 at 02:53:21PM -0800, Tong Zhang wrote:
> > On Mon, Feb 7, 2022 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > OK I think the issue here should have been that declaring this on
> > > fs/binfmt_misc.c creates the chicken and the egg issue, and so we
> > > need to do this on built-in code. Instead of your patch can you try
> > > this instead, it just always creates the sysctl mount always now
> > > so long as proc sysctl is enabled. It does not do the unregistration
> > > as we always want the path present as it used to be before as well.
> > >
> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index 57edef16dce4..4f4739c9405c 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -119,6 +119,7 @@ static struct ctl_table fs_stat_sysctls[] = {
> > >  static int __init init_fs_stat_sysctls(void)
> > >  {
> > >         register_sysctl_init("fs", fs_stat_sysctls);
> > > +       register_sysctl_mount_point("fs/binfmt_misc");
> > >         return 0;
> > >  }
> > >  fs_initcall(init_fs_stat_sysctls);
> > 
> > I'm looking at the original code, and it seems that if we don't select
> > CONFIG_BINFMT_MISC at all,
> > this file won't be created. This would suggest an IF MACRO around
> > > +       register_sysctl_mount_point("fs/binfmt_misc");
> > and it should looks like
> > +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> > +       register_sysctl_mount_point("fs/binfmt_misc");
> > +#endif
> > or if you prefer original style:
> > #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> 
> Or better yet using IS_ENABLED() to avoid the ifdef cruft:
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index c07f35719ee3..4b8f1b11a7c8 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -817,20 +817,16 @@ static struct file_system_type bm_fs_type = {
>  };
>  MODULE_ALIAS_FS("binfmt_misc");
>  
> -static struct ctl_table_header *binfmt_misc_header;
> -
>  static int __init init_misc_binfmt(void)
>  {
>  	int err = register_filesystem(&bm_fs_type);
>  	if (!err)
>  		insert_binfmt(&misc_format);
> -	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
>  	return 0;
>  }
>  
>  static void __exit exit_misc_binfmt(void)
>  {
> -	unregister_sysctl_table(binfmt_misc_header);
>  	unregister_binfmt(&misc_format);
>  	unregister_filesystem(&bm_fs_type);
>  }
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 57edef16dce4..4969021fa676 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
>  static int __init init_fs_stat_sysctls(void)
>  {
>  	register_sysctl_init("fs", fs_stat_sysctls);
> +	if (IS_ENABLED(CONFIG_BINFMT_MISC))
> +		register_sysctl_mount_point("fs/binfmt_misc");
>  	return 0;
>  }
>  fs_initcall(init_fs_stat_sysctls);

Apologies for the late reply, I was notified the patch is added to the
mm patchset and thought to be late for any update but now I'm not seeing
it anywhere. Maybe it's been dropped?

Forgot of IS_ENABLED(), I would surely use it in the v2.

Not clear what's the benefit in registering the mount point in
fs/file_table.c vs. kernel/sysctl.c.  I'd keep it close to where people
was used to find it, unless there is a good reason otherwise.

Could you please elaborate?

Thanks for your review!

Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
