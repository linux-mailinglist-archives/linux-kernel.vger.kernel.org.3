Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A132596CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiHQKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiHQK37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:29:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2319753A3;
        Wed, 17 Aug 2022 03:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55AAAB81C02;
        Wed, 17 Aug 2022 10:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4843FC433C1;
        Wed, 17 Aug 2022 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660732196;
        bh=MnPYzp5W8sB2Ju6i8m/PlVUzI4SSY78hH5YcE4odSbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUfuFx1MfZK67V4gh9g8lZt13UXLXrTVbBZaN9xJa0abe4WUJ2KcyJ0hKXyL1tysO
         difDE68E3XyDyH0GNp43bCHszLMRQKv+BsACVxTvsVCOI/fYSb9qZQ94cTzckEsTkA
         ZQzIwfCGOqQGuTfE0bsBIAT8o3x6H9IAjbQnsZmsxnIhAN86XDENBmjKApb6BX5BCh
         Azy8jY24oZwjfoCQLnmmYpPmCe5+L1XCq3gWPfX9oFWLafipv5STHHCEp8GUnZzOLY
         J62OXjrD91ZKPdbvTTdxG8A5/FdlcfdazUyNdqTpyTqROaLxYiAXrZ2pGw9rbE6i4C
         LYYSPm3tLhqlg==
Date:   Wed, 17 Aug 2022 12:29:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     =?utf-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in
 ovl_link()
Message-ID: <20220817102951.xnvesg3a7rbv576x@wittgenstein>
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
 <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
 <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
 <CAOQ4uxj_XhC51yS0QCoo8kYWmMxm1XQH4bhoSMZReUd7nc2UFA@mail.gmail.com>
 <20220817102722.wny7x5iwf62edpkd@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817102722.wny7x5iwf62edpkd@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:27:27PM +0200, Christian Brauner wrote:
> On Wed, Aug 17, 2022 at 12:55:22PM +0300, Amir Goldstein wrote:
> > On Wed, Aug 17, 2022 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Wed, Aug 17, 2022 at 12:11 PM 天赐张 <zhangtianci.1997@bytedance.com> wrote:
> > > >
> > > > On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > > > > <zhangtianci.1997@bytedance.com> wrote:
> > > > > >
> > > > > > ovl_link() did not create a new inode after commit
> > > > > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > > > > in ovl_create_or_link() we should not override cred's
> > > > > > fsuid and fsgid when called by ovl_link().
> > > > > >
> > > > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > > > > ---
> > > > > >  fs/overlayfs/dir.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > > index 6b03457f72bb..568d338032db 100644
> > > > > > --- a/fs/overlayfs/dir.c
> > > > > > +++ b/fs/overlayfs/dir.c
> > > > > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > > > > >         err = -ENOMEM;
> > > > > >         override_cred = prepare_creds();
> > > > > >         if (override_cred) {
> > > > > > -               override_cred->fsuid = inode->i_uid;
> > > > > > -               override_cred->fsgid = inode->i_gid;
> > > > > >                 if (!attr->hardlink) {
> > > > > > +                       override_cred->fsuid = inode->i_uid;
> > > > > > +                       override_cred->fsgid = inode->i_gid;
> > > > > >                         err = security_dentry_create_files_as(dentry,
> > > > > >                                         attr->mode, &dentry->d_name, old_cred,
> > > > > >                                         override_cred);
> > > > > > --
> > > > >
> > > > > This change looks incorrect.
> > > > > Unless I am missing something, fsuid/fsgid still need to
> > > > > be overridden for calling link() on underlying fs.
> > > > > What made you do this change?
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > >
> > > > Hi Amir,
> > > >
> > > > I ran into an error when I tested overlay on fuse:
> > > >   $ mkdir /lower /fuse /merge
> > > >   $ mount -t fuse /fuse
> > > >   $ mkdir /fuse/upper /fuse/work
> > > >   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,workdir=work
> > > >   $ touch /merge/file
> > > >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> > > >   $ ln /merge/file /merge/lnkfile
> > > >
> > > > Then I got an error(EACCES) because fuse daemon checks the link()'s
> > > > caller is "bin", it denied this request.
> > > > I browsed the changing history of ovl_link(). There are two key commits:
> > > > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> > > > overrides the cred's fsuid/fsgid using the new inode. The new inode's
> > > > owner is initialized by inode_init_owner(), and inode->fsuid is
> > > > assigned to the current user. So the override fsuid becomes the
> > > > current user. We know link() is actually modifying the directory, so
> > > > the caller must have the MAY_WRITE permission on the directory. The
> > > > current caller may should have this permission. I think this is
> > > > acceptable to use the caller's fsuid(But I still feel a little
> > > > conflicted with the overlay's design).
> > > > The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> > > > which removed the inode creation in ovl_link(). This commit move
> > > > inode_init_owner() into ovl_create_object(), so the ovl_link() just
> > > > give the old inode to ovl_create_or_link(). Then the override fsuid
> > > > becomes the old inode's fsuid, neither the caller nor the overlay's
> > > > creator! So I think this is incorrect.
> > > > I think the link() should be like unlink(), overlay fs should just use
> > > > the creator cred to do underlying fs's operations.
> > > >
> > >
> > > I see. The reproducer and explanation belong in the commit message.
> > >
> > > Your argument makes sense to me, but CC Christian to make
> > > sure I am not missing anything related to ACLs and what not.
> > 
> > Once again with correct email address...
> 
> So we have:
> 
> ovl_create_object()
> -> ovl_override_creds(ovl_sb)
> -> ovl_new_inode()
>    -> inode_init_owner()
>       {
>               inode->i_uid = current_fsuid();
>               inode->i_gid = current_fsgid();
>       }
> -> ovl_create_or_link(inode, ...)
> -> prepare_creds() // Copy of caller's creds

s/caller's/creator's/

> {
>         override_creds->fsuid = inode->i_uid;
>         override_creds->fsgid = inode->i_gid;
> }
> -> revert_creds()
> 
> which afaict means that the mounter's credentials are used apart from
> the fs{g,u}id which is taken from inode->i_{g,u}id which should
> correspond to current_fs{g,u}id().
> 
> The commit that is pointed out in the patch
> 51f7e52dc943 ("ovl: share inode for hard link")
> seems to have broken that assumption.
> 
> Given that the intention was to use the creator's creds _with the
> caller's fs{g,u}id_ wouldn't it make more sense to simply ensure that
> the caller's fs{g,u}id are always used instead of using the full
> creator's creds just for the link operation? So something like this
> (untested):
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..4a3ee16a6d70 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -575,6 +575,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>         const struct cred *old_cred;
>         struct cred *override_cred;
>         struct dentry *parent = dentry->d_parent;
> +       /* Retrieve caller's fs{g,u}id before we override creds below. */
> +       kuid_t caller_fsuid = current_fsuid();
> +       kgid_t caller_fsgid = current_fsgid();
> 
>         err = ovl_copy_up(parent);
>         if (err)
> @@ -595,8 +598,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>         err = -ENOMEM;
>         override_cred = prepare_creds();
>         if (override_cred) {
> -               override_cred->fsuid = inode->i_uid;
> -               override_cred->fsgid = inode->i_gid;
> +               override_cred->fsuid = caller_fsuid;
> +               override_cred->fsgid = caller_fsgid;
>                 if (!attr->hardlink) {
>                         err = security_dentry_create_files_as(dentry,
>                                         attr->mode, &dentry->d_name, old_cred,
