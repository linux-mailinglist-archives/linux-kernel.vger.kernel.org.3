Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1054ADF62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384160AbiBHRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbiBHRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:21:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4EC061576;
        Tue,  8 Feb 2022 09:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qa2/OpTRnZR6XCJ42u6II3WcBdJPjRxjOZX8VpHnT7Y=; b=EKvAN9P2bdw4MI3T1lHp53q3Ec
        zAe7iFvnkibbwzHMR+0Lp69Jj//rIUwSZrCCwvVR/ODasZb/OPeLNZTLsoyTBM610UaZZFjNZ/y++
        WsPb0LOzWvDajtIPaw1noGRxo3V5BgHDQjK52aJ2GPGAfbrHNj/r6jyCtBgYvzMYwvhjXuHmpNuiS
        XL/3bDmFpkGjmHkhPc1fBFWmaBub+YxIHqVryEMAa77831LXhstlZJ2oVpZecyP5a2A/uHGFhgTwJ
        ly6CiMvB7/e5XOHW8+XnWLMBHJKrn0dI2Ooc2V5Ga382Z4vAKWPKu/QMjdCG2X4QHXRQQ5t5XzeE5
        jv+7kavQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHUAU-00F2wG-Nq; Tue, 08 Feb 2022 17:20:42 +0000
Date:   Tue, 8 Feb 2022 09:20:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
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
Message-ID: <YgKmaggsipzzCGCg@bombadil.infradead.org>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
 <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org>
 <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
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

On Mon, Feb 07, 2022 at 02:53:21PM -0800, Tong Zhang wrote:
> On Mon, Feb 7, 2022 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > OK I think the issue here should have been that declaring this on
> > fs/binfmt_misc.c creates the chicken and the egg issue, and so we
> > need to do this on built-in code. Instead of your patch can you try
> > this instead, it just always creates the sysctl mount always now
> > so long as proc sysctl is enabled. It does not do the unregistration
> > as we always want the path present as it used to be before as well.
> >
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 57edef16dce4..4f4739c9405c 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -119,6 +119,7 @@ static struct ctl_table fs_stat_sysctls[] = {
> >  static int __init init_fs_stat_sysctls(void)
> >  {
> >         register_sysctl_init("fs", fs_stat_sysctls);
> > +       register_sysctl_mount_point("fs/binfmt_misc");
> >         return 0;
> >  }
> >  fs_initcall(init_fs_stat_sysctls);
> 
> I'm looking at the original code, and it seems that if we don't select
> CONFIG_BINFMT_MISC at all,
> this file won't be created. This would suggest an IF MACRO around
> > +       register_sysctl_mount_point("fs/binfmt_misc");
> and it should looks like
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +       register_sysctl_mount_point("fs/binfmt_misc");
> +#endif
> or if you prefer original style:
> #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)

Or better yet using IS_ENABLED() to avoid the ifdef cruft:

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
index 57edef16dce4..4969021fa676 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
 static int __init init_fs_stat_sysctls(void)
 {
 	register_sysctl_init("fs", fs_stat_sysctls);
+	if (IS_ENABLED(CONFIG_BINFMT_MISC))
+		register_sysctl_mount_point("fs/binfmt_misc");
 	return 0;
 }
 fs_initcall(init_fs_stat_sysctls);
