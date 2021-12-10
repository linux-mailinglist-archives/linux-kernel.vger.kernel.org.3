Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A394F4706E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbhLJRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhLJRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:23:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41025C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XfeTZlDTlrY0QPJ8JyCgucXjeGL7PbMmWdzwnPjOLcg=; b=XjwgUAuCx637M0HuAGO5XxyGlD
        Pgt9ORWGj2a2yK2m2r1FfM8K/7ij2FJXIxCeFbKFNYIFrBHBBe+ZRKyDDmeiYoWuv233Rd77Xx7M1
        N7BBDZBRmEWXFGw/ajxE5hkNFzmc+nl3l8LmNSvB6CduVbvPaeMsQ7uqvTFbPBJS3RYe3yZ1U6jOD
        F/wM4cLtPANKWRN3dYVkmGpb2aUlMC2yw/NiFvi92yDVizOA6MwtYsYiI6SR0W0pgJWw754cRAI5Y
        lckbB+NCHxJ4ukDrCK8JlfU721wYK4ef5FW0iG0LivR5eZl2XIQnxfRgMLPUQhmnc3l3tQBhctrQm
        h5DINgWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvjZ3-002niS-K7; Fri, 10 Dec 2021 17:20:09 +0000
Date:   Fri, 10 Dec 2021 09:20:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org, jlayton@kernel.org,
        bfields@fieldses.org, yzaikin@google.com, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        julia.lawall@inria.fr, akpm@linux-foundation.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2] sysctl: Add a group of macro functions to initcall
 the sysctl table of each feature
Message-ID: <YbOMSUBRWAUFyDbQ@bombadil.infradead.org>
References: <YbEQG1MrjHreKFmw@bombadil.infradead.org>
 <20211210085849.66169-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210085849.66169-1-nixiaoming@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 04:58:49PM +0800, Xiaoming Ni wrote:
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

It was nice to have this documented in the commit log, however you
don't provide a developer documentation for this in your changes.
Can you justify through documentation why we can use init levels
with the above information for the sysctl_initcall() macro?

> The sysctl interface of each subfeature should be registered after
> sysctl_init_bases() and before do_sysctl_args().

Indeed.

> It seems 

Seems is poor judgement for a change in the kernel. It is or not.

> that the sysctl
> interface does not depend on initcall_levels. To prevent the sysctl
> interface from being initialized before the feature itself. The
> lowest-level

Lower to me means early, but since we are talking about time, best
to clarify and say the latest init level during kernel bootup.

> late_initcall() is used as the common sysctl interface
> registration level.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> ---
> v2:
>   Add a simple checkpatch check.
>   Add code comment.
> v1:
>   https://lore.kernel.org/lkml/20211207011320.100102-1-nixiaoming@huawei.com/
> ---
>  fs/coredump.c          |  7 +------
>  fs/dcache.c            |  7 +------
>  fs/exec.c              |  8 +-------
>  fs/file_table.c        |  7 +------
>  fs/inode.c             |  7 +------
>  fs/locks.c             |  7 +------
>  fs/namei.c             |  8 +-------
>  fs/namespace.c         |  7 +------
>  include/linux/sysctl.h | 19 +++++++++++++++++++
>  kernel/stackleak.c     |  7 +------
>  scripts/checkpatch.pl  |  6 ++++++
>  11 files changed, 34 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 570d98398668..8f6c6322651d 100644
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

Nice.

Yes, although I went with fs_initcall() your documentation above
does give us certainty that this is fine as well. No need to kick
this through earlier.

>  #endif /* CONFIG_SYSCTL */
>  
>  /*
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 0eef1102f460..c1570243aaee 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -195,12 +195,7 @@ static struct ctl_table fs_dcache_sysctls[] = {
>  	{ }
>  };
>  
> -static int __init init_fs_dcache_sysctls(void)
> -{
> -	register_sysctl_init("fs", fs_dcache_sysctls);
> -	return 0;
> -}
> -fs_initcall(init_fs_dcache_sysctls);
> +fs_sysctl_initcall(fs_dcache_sysctls);

Seems fine by me using the same logic as above and I like that
you are splitting this by bases. Likewise for the others, this
is looking good.

> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index acf0805cf3a0..ce33e61a8287 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -231,6 +231,25 @@ extern int sysctl_init_bases(void);
>  extern void __register_sysctl_init(const char *path, struct ctl_table *table,
>  				 const char *table_name);

Yes please take the time to write some documentation here which can
explain to developers *why* we use the init levels specified.

>  #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
> +
> +#define sysctl_initcall(path, table) \
> +	static int __init init_##table(void) \
> +	{ \
> +		register_sysctl_init(path, table); \
> +		return  0;\
> +	} \
> +	late_initcall(init_##table)
> +
> +/*
> + * Use xxx_sysctl_initcall() to initialize your sysctl interface unless you want
> + * to register the sysctl directory and share it with other features.
> + */
> +#define kernel_sysctl_initcall(table) sysctl_initcall("kernel", table)
> +#define fs_sysctl_initcall(table) sysctl_initcall("fs", table)
> +#define vm_sysctl_initcall(table) sysctl_initcall("vm", table)
> +#define debug_sysctl_initcall(table) sysctl_initcall("debug", table)
> +#define dev_sysctl_initcall(table) sysctl_initcall("dev", table)
> +
>  extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
>  
>  void do_sysctl_args(void);

  Luis
