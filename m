Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F646C44F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhLGUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhLGUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:22:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93852C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tGskZwno/TuU2L9cUw3QSpKTYvw2dAJtI9fnfywHz+g=; b=vjvAb2A33xuib3f/juZoip+9wB
        rC2W2kAW1pJ5axKy1ibjKw5cC3TCfF5aTH872w1Esa5TfqGMptPpiQ+f9+AffxLm32ACjAH2/RWB3
        KBWYWbm5iNmhSb2D8QV9IxSq3Sghyr5zu3DD31JL2kd04DnLAzGRT1dn+uopqumPCEcETGyrS5MiN
        gzM8PkX6SHy7itWddiy2tAvhl74izo9p0iM43A1nohWntOhUO53W7lBrTOvHagligkJEcnR1jmj+7
        zBngi5HDFnPYHM25EBbd2rKWjqRfYmNYT21R3ZX16Cmfj9FDghSBGG2neLtP8mbriP8RqD8Jybol+
        LCg/9ogw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mugv8-00A0Db-Hf; Tue, 07 Dec 2021 20:18:38 +0000
Date:   Tue, 7 Dec 2021 12:18:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
Message-ID: <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 05:38:42PM -0800, Andrew Morton wrote:
> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
> >  	{ }
> >  };
> >  
> > -static int __init init_fs_inode_sysctls(void)
> > -{
> > -	register_sysctl_init("fs", inodes_sysctls);
> > -	return 0;
> > -}
> > -early_initcall(init_fs_inode_sysctls);
> > +fs_sysctl_initcall(inodes_sysctls);
> >  #endif
> 
> Here's another, of many.
> 
> Someone made the decision to use early_initcall() here (why?) and this
> patch switches it to late_initcall()!  Worrisome.  Each such stealth
> conversion should be explained and justified, shouldn't it?

I made the decisions for quite a bit of the ordering and yes I agree
this need *very careful* explanation, specially if we are going to
generalize this.

First and foremost. git grep for sysctl_init_bases and you will see
that the bases for now are initialized on proc_sys_init() and that
gets called on proc_root_init() and that in turn on init/main.c's
start_kernel(). And so this happens *before* the init levels.

The proper care for what goes on top of this needs to take into
consideration the different init levels and that the if a sysctl
is using a directory *on top* of a base, then that sysctl registration
must be registered *after* that directory. The *base* directory for
"fs" is now registered through fs/sysctls.c() on init_fs_sysctls()
using register_sysctl_base(). I made these changes with these names
and requiring the DECLARE_SYSCTL_BASE() so it would be easy for us
to look at where these are declared.

So the next step in order to consider is *link* ordering and that
order is maintained by the Makefile. That is why I put this at the
top of the fs Makfile:

obj-$(CONFIG_SYSCTL)            += sysctls.o 

So any file after this can use early_initcall(), because the base
for "fs" was declared first in link order, and it used early_initcall().
It is fine to have the other stuff that goes on top of the "fs" base
use late_initcall() but that assumes that vetting has been done so that
if a directory on "fs" was created, let's call it "foo", vetting was done
to ensure that things on top of "foo" are registered *after* the "foo"
directory.

We now have done the cleanup for "fs", and we can do what we see fine
for "fs", but we may run into surprises later with the other bases, so
I'd be wary of making assumptions at this point if we can use
late_initcall().

So, as a rule of thumb I'd like to see bases use early_initcall(). The
rest requires manual work and vetting.

So, how about this, we define fs_sysctl_initcall() to use also
early_initcall(), and ask susbsystems to do their vetting so that
the base also gets linked first.

After this, if a directory on top of a base is created we should likely create
a new init level and just bump that to use the next init level. So
something like fs_sysctl_base_initcall_subdir_1() map to core_initcall()
and so on.

That would allow us to easily grep for directory structures easily and
puts some implicit onus of ordering on those folks doing these conversions.
We'd document well the link order stuff for those using the base stuff
too as that is likely only where this will matter most.

  Luis
