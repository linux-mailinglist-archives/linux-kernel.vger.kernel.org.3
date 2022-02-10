Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818C54B1953
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbiBJXTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiBJXTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:19:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D7266C;
        Thu, 10 Feb 2022 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=5OxpglYg6sSOJNdELP8v+HgsOKFwOz/qsyk4a6rak9U=; b=Qd03c5MlqJEMYHC3hB/oWR/+TY
        aaWkCh/eC5fNwh5DPfDP3Rc5x+bI8revhAi/AIICmNUsk5jp0x4i1LJC0oAU0JjIPP5DpNjsqFiEi
        4dr0jCuSBYgMBjtcouS2dzVyPLpc6hK+vcHrt+3c0+9UYJAlYVhcia4GHowFDNpwj7uM2jsBMjuDq
        LiqlmCpa6oFvUik4v8Yw36UE5i/NENSvhUomgRwLzP4zcxLYV4G5juD3I0SiuvE5sQFHgKOSkUlBN
        TNHm/U7rJCiJJTdIg+V+29DNxyH0UMWbNSN3awsu03/846D1rFKn6/pIBRcXTLskIq9fmCJw69iKN
        8cZ4soTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIIiT-0059e9-Ev; Thu, 10 Feb 2022 23:19:09 +0000
Date:   Thu, 10 Feb 2022 15:19:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tong Zhang <ztong0001@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <YgWdbYfWgHP2jBmI@bombadil.infradead.org>
References: <20220210184340.7eba108a@canb.auug.org.au>
 <20220210193302.686fa61a@canb.auug.org.au>
 <20220210214125.2b248790@canb.auug.org.au>
 <20220210222953.6e078d20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220210222953.6e078d20@canb.auug.org.au>
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

On Thu, Feb 10, 2022 at 10:29:53PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Thu, 10 Feb 2022 21:41:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Thu, 10 Feb 2022 19:33:02 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > On Thu, 10 Feb 2022 18:43:40 +1100 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote: =20
> > > >
> > > > My qemu boot of a powerpc pseries_le_defconfig kernel produced these
> > > > kernel messages:
> > > >=20
> > > >   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
> > > >   Call Trace:
> > > >   [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (u=
nreliable)
> > > >   [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x6=
0c/0x9f0
> > > >   [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0=
x60
> > > >   [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
> > > >   [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/=
0x3dc
> > > >   [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
> > > >   [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c=
/0x64
> > > >=20
> > > > Presumably introduced by commit
> > > >=20
> > > >   b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl=
 to its own file"")   =20
> > >=20
> > > OK, I cannot reproduce this with just Linus' tree.  I will try to bis=
ect. =20

OK so that's not the issue.

> > It bisected to commit
> >=20
> >   43a9443d5da2 ("Merge branch 'akpm-current/current'")
> >=20
> > and both parents of that commit are fine :-(

FWIW Linus merged a more newer version of the regression fix, and only
until today did we get that version on linux-next.

> So it seems that the parent of "fs/binfmt_misc" is a permanently empty
> directory - the is_empty_dir() check in insert_header() succeeds.

I am not seeing this issue on x86_64 KVM guest with:

CONFIG_BINFMT_MISC=3Dm
or
CONFIG_BINFMT_MISC=3Dy

I think the issue might be that linux-next has Andrew's earlier
version of the fix merged, and Linus now has the new version. So
linux-next has these extra things below. But I can't understand
why this is seen on ppc and not on x86_64.

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 241cfc6bc36f..788b9a34d5ab 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] =3D {
 	{ }
 };
=20
-static struct ctl_table fs_table[] =3D {
-#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
-	{
-		.procname	=3D "binfmt_misc",
-		.mode		=3D 0555,
-		.child		=3D sysctl_mount_point,
-	},
-#endif
-	{ }
-};
-
 static struct ctl_table debug_table[] =3D {
 #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
 	{
@@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] =3D {
=20
 DECLARE_SYSCTL_BASE(kernel, kern_table);
 DECLARE_SYSCTL_BASE(vm, vm_table);
-DECLARE_SYSCTL_BASE(fs, fs_table);
 DECLARE_SYSCTL_BASE(debug, debug_table);
 DECLARE_SYSCTL_BASE(dev, dev_table);
=20
@@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
 {
 	register_sysctl_base(kernel);
 	register_sysctl_base(vm);
-	register_sysctl_base(fs);
 	register_sysctl_base(debug);
 	register_sysctl_base(dev);
=20
