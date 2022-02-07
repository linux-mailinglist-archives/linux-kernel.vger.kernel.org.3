Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B324ACB91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiBGVrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiBGVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:47:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEDCC061355;
        Mon,  7 Feb 2022 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WTLHsRuDo0Kmv8T0AeQW2bl2SYgMY9Rc1wnxTFKAxD8=; b=x9wSvaCIjxMdzhOVgZc4nT/gyv
        RjR4GoPq0LCzkRJmGgpdswZmkCBaFiV10tfDG74bxgZ6WgsIR0kLIJgP/sUaRNhsQ+kVMZNvHMhsM
        FR7Eb3r7P0zIi8cu46ZcOXWWRfYcnL2fgZt/TC+KC8KVnQQ4kZzSllTO9He835HE69PF62+MzOi+m
        FDscSzVw34q69OEZlDld6qvYkKLCigAccYzPWQ6XPfYuMhvlVzy3K5JU8oa2sR8gGQY988obVqPI8
        RvKFTwufkBVa7BTgL36vKisl/p8q0iYp05GEircLU5DT0Xu6rT3KID6p0iKox07Az0gZJ0VYXmnuK
        POYLGxyA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHBqT-00BnlU-8E; Mon, 07 Feb 2022 21:46:49 +0000
Date:   Mon, 7 Feb 2022 13:46:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     airlied@linux.ie, akpm@linux-foundation.org, amir73il@gmail.com,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, gregkh@linuxfoundation.org, jack@suse.cz,
        jani.nikula@intel.com, jani.nikula@linux.intel.com,
        jejb@linux.ibm.com, jlbec@evilplan.org, john.ogness@linutronix.de,
        joonas.lahtinen@linux.intel.com, joseph.qi@linux.alibaba.com,
        julia.lawall@inria.fr, keescook@chromium.org, kernel@tuxforce.de,
        linux-mm@kvack.org, mark@fasheh.com, martin.petersen@oracle.com,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        phil@philpotter.co.uk, pjt@google.com, pmladek@suse.com,
        rafael@kernel.org, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, sre@kernel.org, steve@sk2.org,
        surenb@google.com, torvalds@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, wangqing@vivo.com, yzaikin@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix regression due to "fs: move binfmt_misc sysctl to
 its own file"
Message-ID: <YgGTSR628xhRvCjB@bombadil.infradead.org>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
 <YgEeQNdgBuHRyEWl@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgEeQNdgBuHRyEWl@dumbo>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:27:28PM +0100, Domenico Andreoli wrote:
> Commit 3ba442d5331f did not go unnoticed, binfmt-support stopped to
> work on my Debian system since v5.17-rc2 (did not check with -rc1).
> 
> The existance of /proc/sys/fs/binfmt_misc is a precondition for
> attempting to mount the binfmt_misc fs, which in turn triggers the
> autoload of the binfmt_misc module. Without it, no module is loaded
> and no binfmt is available at boot.
> 
> Building as built-in or manually loading the module and mounting the fs
> works fine, it's therefore only a matter of interaction with user-space.
> 
> I could try to improve the Debian systemd configuration but I can't
> say anything about the other distributions.
> 
> In the meanwhile this patch restores a working system right after boot.
> 
> Fixes: 3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Antti Palosaari <crope@iki.fi>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Lukas Middendorf <kernel@tuxforce.de>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Qing Wang <wangqing@vivo.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Stephen Kitt <steve@sk2.org>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> 
> ---
>  fs/binfmt_misc.c |    6 +-----
>  kernel/sysctl.c  |   13 +++++++++++++
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> Index: b/fs/binfmt_misc.c
> ===================================================================
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -817,20 +817,16 @@ static struct file_system_type bm_fs_typ
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
> -	return 0;
> +	return err;
>  }

OK I think the issue here should have been that declaring this on
fs/binfmt_misc.c creates the chicken and the egg issue, and so we
need to do this on built-in code. Instead of your patch can you try
this instead, it just always creates the sysctl mount always now
so long as proc sysctl is enabled. It does not do the unregistration
as we always want the path present as it used to be before as well.

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c07f35719ee3..4b8f1b11a7c8 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -817,20 +817,16 @@ static struct file_system_type bm_fs_type = {
 };
 MODULE_ALIAS_FS("binfmt_misc");
 
-static struct ctl_table_header *binfmt_misc_header;
-
 static int __init init_misc_binfmt(void)
 {
 	int err = register_filesystem(&bm_fs_type);
 	if (!err)
 		insert_binfmt(&misc_format);
-	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
 	return 0;
 }
 
 static void __exit exit_misc_binfmt(void)
 {
-	unregister_sysctl_table(binfmt_misc_header);
 	unregister_binfmt(&misc_format);
 	unregister_filesystem(&bm_fs_type);
 }
diff --git a/fs/file_table.c b/fs/file_table.c
index 57edef16dce4..4f4739c9405c 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -119,6 +119,7 @@ static struct ctl_table fs_stat_sysctls[] = {
 static int __init init_fs_stat_sysctls(void)
 {
 	register_sysctl_init("fs", fs_stat_sysctls);
+	register_sysctl_mount_point("fs/binfmt_misc");
 	return 0;
 }
 fs_initcall(init_fs_stat_sysctls);
