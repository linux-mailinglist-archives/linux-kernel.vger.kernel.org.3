Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32646CB07
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbhLHCsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhLHCsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:48:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C7C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nbrt0ubK6by8h1sBwSBuLVC3tUerVEO6URalty4wPxo=; b=WbGAKwbcUsYFxvFC4qIb50g/Xd
        w4VgN3JGtYPZJ5UzK9ySc948G7nZGZnyxlwEdS6DPgeZUK02T1dUaLvt0/GKNCD0lscDJwwwGCv/m
        oBt9ANr3n8rcSIrQOQhaAddBUN2h5UqfpA7HHsE80w7PQbWMAGzu4RoWw0MH6LZwPxyT17M/9Y1sg
        9TkDKCOCqxZG4J+R80/JLPt1kZ8kAr1RHXC3XscxMyNiqIIgAQ+9gKJGgyhFeb5+4XdDvBG8oaoj2
        7C/9dUCt9/tr5J1kX2hCxP5zCWiS8WVVcpfHvaY90q79l6KdfXVeS3a5YFQIa93gZ94SOGnBt4FU1
        hjFHpnvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mumwr-00AiWF-Pr; Wed, 08 Dec 2021 02:44:49 +0000
Date:   Tue, 7 Dec 2021 18:44:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
Message-ID: <YbAcISNGYlpSkYee@bombadil.infradead.org>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
 <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
 <875ys0azt8.fsf@email.froward.int.ebiederm.org>
 <Ya/iv33Ud+KRt9E9@bombadil.infradead.org>
 <17a19e3e-7a66-de73-ca83-078869f4d025@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a19e3e-7a66-de73-ca83-078869f4d025@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:10:08AM +0800, Xiaoming Ni wrote:
> On 2021/12/8 6:39, Luis Chamberlain wrote:
> > On Tue, Dec 07, 2021 at 03:08:03PM -0600, Eric W. Biederman wrote:
> > > Luis Chamberlain <mcgrof@kernel.org> writes:
> > > 
> > > > On Mon, Dec 06, 2021 at 05:38:42PM -0800, Andrew Morton wrote:
> > > > > On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > > > > > --- a/fs/inode.c
> > > > > > +++ b/fs/inode.c
> > > > > > @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
> > > > > >   	{ }
> > > > > >   };
> > > > > > -static int __init init_fs_inode_sysctls(void)
> > > > > > -{
> > > > > > -	register_sysctl_init("fs", inodes_sysctls);
> > > > > > -	return 0;
> > > > > > -}
> > > > > > -early_initcall(init_fs_inode_sysctls);
> > > > > > +fs_sysctl_initcall(inodes_sysctls);
> > > > > >   #endif
> > > > > 
> > > > > Here's another, of many.
> > > > > 
> > > > > Someone made the decision to use early_initcall() here (why?) and this
> > > > > patch switches it to late_initcall()!  Worrisome.  Each such stealth
> > > > > conversion should be explained and justified, shouldn't it?
> > > > 
> > > > I made the decisions for quite a bit of the ordering and yes I agree
> > > > this need *very careful* explanation, specially if we are going to
> > > > generalize this.
> > > > 
> > > > First and foremost. git grep for sysctl_init_bases and you will see
> > > > that the bases for now are initialized on proc_sys_init() and that
> > > > gets called on proc_root_init() and that in turn on init/main.c's
> > > > start_kernel(). And so this happens *before* the init levels.
> > > > 
> > > > The proper care for what goes on top of this needs to take into
> > > > consideration the different init levels and that the if a sysctl
> > > > is using a directory *on top* of a base, then that sysctl registration
> > > > must be registered *after* that directory. The *base* directory for
> > > > "fs" is now registered through fs/sysctls.c() on init_fs_sysctls()
> > > > using register_sysctl_base(). I made these changes with these names
> > > > and requiring the DECLARE_SYSCTL_BASE() so it would be easy for us
> > > > to look at where these are declared.
> > > > 
> > > > So the next step in order to consider is *link* ordering and that
> > > > order is maintained by the Makefile. That is why I put this at the
> > > > top of the fs Makfile:
> > > > 
> > > > obj-$(CONFIG_SYSCTL)            += sysctls.o
> > > > 
> > > > So any file after this can use early_initcall(), because the base
> > > > for "fs" was declared first in link order, and it used early_initcall().
> > > > It is fine to have the other stuff that goes on top of the "fs" base
> > > > use late_initcall() but that assumes that vetting has been done so that
> > > > if a directory on "fs" was created, let's call it "foo", vetting was done
> > > > to ensure that things on top of "foo" are registered *after* the "foo"
> > > > directory.
> > > > 
> > > > We now have done the cleanup for "fs", and we can do what we see fine
> > > > for "fs", but we may run into surprises later with the other bases, so
> > > > I'd be wary of making assumptions at this point if we can use
> > > > late_initcall().
> > > > 
> > > > So, as a rule of thumb I'd like to see bases use early_initcall(). The
> > > > rest requires manual work and vetting.
> > > > 
> > > > So, how about this, we define fs_sysctl_initcall() to use also
> > > > early_initcall(), and ask susbsystems to do their vetting so that
> > > > the base also gets linked first.
> > > > 
> > > > After this, if a directory on top of a base is created we should likely create
> > > > a new init level and just bump that to use the next init level. So
> > > > something like fs_sysctl_base_initcall_subdir_1() map to core_initcall()
> > > > and so on.
> > > > 
> > > > That would allow us to easily grep for directory structures easily and
> > > > puts some implicit onus of ordering on those folks doing these conversions.
> > > > We'd document well the link order stuff for those using the base stuff
> > > > too as that is likely only where this will matter most.
> > > 
> > > I am a bit confused at this explanation of things.
> > > 
> > > Last I looked the implementation of sysctls allocated the directories
> > > independently of the sysctls entries that populated them.
> > 
> > With most sysctls being created using the same kernel/sysctl.c file and
> > structure, yes, this was true. With the changes now on linux-next things
> > change a bit. The goal is to move sysctls to be registered where they
> > are actually defined. But the directory that holds them must be
> > registered first. During the first phase of cleanups now on linux-next
> > all filesystem "fs" syscls were moved to be delcared in the kernel's
> > fs/ directory. The last part was to register the base "fs" directory.
> > For this declareres were added to simplify that and to clarify which
> > are base directories:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ededd3fc701668743087c77ceeeb7490107cc12c
> > 
> > Then, this commit moves the "fs" base to be declared to fs/ as well:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d0f885a73ec6e05803ce99f279232b3116061ed8
> > 
> > This used early_initcall() for the base for "fs" and that is
> > because there are no built-in sysctls for "fs" which need to
> > be exposed prior to the init levels.
> > 
> > So after this then order is important. If you are using the same
> > init level, the the next thing which will ensure order is the order
> > of things being linked, so what order they appear on the Makefile.
> > And this is why the base move for the "fs" sysctl directory is kept
> > at the top of fs/Makfile:
> > 
> > obj-$(CONFIG_SYSCTL)		+= sysctls.o
> > 
> >    Luis
> > .
> > 
> 
> Root node of the tree, using "early_initcall":
> 	Basic framework,  "fs", "kernel", "debug", "vm", "dev", "net"

register_sysctl_base() and yes these use early_initcall() as-is on
linux-next.

> Fork node. Select initcall_level based on the number of directory levels:
> 	Registration directory shared by multiple features.

Sure.

> Leaf node, use "late_initcall":
> 	File Interface

I am not sure this gives enough guidance. What is the difference between
fork node and a leaf node?

> Is this a feasible classification?

  Luis
