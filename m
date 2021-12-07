Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A121746AFE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbhLGBmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:42:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33982 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhLGBmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:42:16 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66AC1B81668
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 01:38:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6375360E09;
        Tue,  7 Dec 2021 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638841124;
        bh=KtZVeIV9/kUXM7KORE+RW29p/mSylWTn6JPfRu2I4/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=du9V0EVsROMQ53CJXf9QAa9D5CdygnKtZuOXELdbFYR+NFvGv5k6OnOIV1BE/MkNa
         Rxk1gC7x9662oL2Sr498Qx0In6+QbbkDVY7DG+xPA98I0mEZ3ITb8Vu6G+RPbfIROO
         R+LH9KhTBLZw2G59VanWhP6MHMefalwakF/z3O/Y=
Date:   Mon, 6 Dec 2021 17:38:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>,
        <keescook@chromium.org>, <jlayton@kernel.org>,
        <bfields@fieldses.org>, <yzaikin@google.com>, <wangle6@huawei.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
Message-Id: <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
In-Reply-To: <20211207011320.100102-1-nixiaoming@huawei.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:

> To avoid duplicated code, add a set of macro functions to initialize the
> sysctl table for each feature.
> 
> The system initialization process is as follows:
> 
> 	start_kernel () {
> 		...
> 		/* init proc and sysctl base,
> 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
> 		 */
> 		proc_root_init(); /* init proc and sysctl base */
> 		...
> 		arch_call_rest_init();
> 	}
> 
> 	arch_call_rest_init()-->rest_init()-->kernel_init()
> 	kernel_init() {
> 		...
> 		kernel_init_freeable(); /* do all initcalls */
> 		...
> 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
> 	}
> 
> 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
> 	do_initcalls() {
> 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> 			do_initcall_level
> 	}
> 
> The sysctl interface of each subfeature should be registered after
> sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
> interface does not depend on initcall_levels. To prevent the sysctl
> interface from being initialized before the feature itself. The
> lowest-level late_initcall() is used as the common sysctl interface
> registration level.

I'm not normally a fan of wrapping commonly-used code sequences into
magical macros, but this one does seem to make sense.

I wonder if it is possible to cook up a checkpatch rule to tell people
to henceforth use the magic macros rather than to open-code things in
the old way.  Sounds hard.

> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -943,12 +943,7 @@ static struct ctl_table coredump_sysctls[] = {
>  	{ }
>  };
>  
> -static int __init init_fs_coredump_sysctls(void)
> -{
> -	register_sysctl_init("kernel", coredump_sysctls);
> -	return 0;
> -}
> -fs_initcall(init_fs_coredump_sysctls);
> +kernel_sysctl_initcall(coredump_sysctls);

But this and several like it are functional changes.

>  #endif /* CONFIG_SYSCTL */
>
> ...
>
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
>  	{ }
>  };
>  
> -static int __init init_fs_inode_sysctls(void)
> -{
> -	register_sysctl_init("fs", inodes_sysctls);
> -	return 0;
> -}
> -early_initcall(init_fs_inode_sysctls);
> +fs_sysctl_initcall(inodes_sysctls);
>  #endif

Here's another, of many.

Someone made the decision to use early_initcall() here (why?) and this
patch switches it to late_initcall()!  Worrisome.  Each such stealth
conversion should be explained and justified, shouldn't it?


