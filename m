Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F0596E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiHQMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHQMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE09F67155;
        Wed, 17 Aug 2022 05:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC68611A1;
        Wed, 17 Aug 2022 12:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD6BC433C1;
        Wed, 17 Aug 2022 12:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660739868;
        bh=q08Y03Qkyx6cbwTFvSSYD7gHoL6eRsSNWV0mwujAT8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/qKlhbTs/ZrdYKPhb3Fj+ArbIyWSxEoidLFxWMY+dkpzYAY8xC+MNNp6bSZvJgtv
         hTzyLN9dY6oVWH2G/SIcRTSr1ootdYm1rNZSJV6i3T9kSo8xLoY5z84TZOFwItshCW
         ale6PpNX9Fxhm+aab2qxU4kLGVPqPb6gVZbhqu7gtpjxRJnkz0hcf9yjzAccIcaRH7
         1yTIrvRIagMmvK0IWgRvOyGRatNAtoW4n5j58OXjzU6H5AeFxcQIFna403BekAALhq
         aRIuu68ze8SkvHU4V/VrtOY9UXi0Zr/t0C1upNVKNqfVEDIqoel6BTxdbLGfneWyqa
         UYJaG+OtQOzMg==
Date:   Wed, 17 Aug 2022 14:37:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in
 ovl_link()
Message-ID: <20220817123738.dfqct34rudkt4by4@wittgenstein>
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
 <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
 <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
 <CAOQ4uxj_XhC51yS0QCoo8kYWmMxm1XQH4bhoSMZReUd7nc2UFA@mail.gmail.com>
 <20220817102722.wny7x5iwf62edpkd@wittgenstein>
 <20220817102951.xnvesg3a7rbv576x@wittgenstein>
 <CAP4dvscpm2FyuJ6gqZz=32ffrN9BORaa=Q0grPEgB+KUXbJniw@mail.gmail.com>
 <20220817115638.2etj6ruuutjurgjv@wittgenstein>
 <20220817122915.k6aps55sjr4hnm5j@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817122915.k6aps55sjr4hnm5j@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:29:20PM +0200, Christian Brauner wrote:
> On Wed, Aug 17, 2022 at 01:56:43PM +0200, Christian Brauner wrote:
> > On Wed, Aug 17, 2022 at 07:36:44PM +0800, 天赐张 wrote:
> > > On Wed, Aug 17, 2022 at 6:29 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Wed, Aug 17, 2022 at 12:27:27PM +0200, Christian Brauner wrote:
> > > > > On Wed, Aug 17, 2022 at 12:55:22PM +0300, Amir Goldstein wrote:
> > > > > > On Wed, Aug 17, 2022 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 17, 2022 at 12:11 PM 天赐张 <zhangtianci.1997@bytedance.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > > > > > > > > <zhangtianci.1997@bytedance.com> wrote:
> > > > > > > > > >
> > > > > > > > > > ovl_link() did not create a new inode after commit
> > > > > > > > > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > > > > > > > > in ovl_create_or_link() we should not override cred's
> > > > > > > > > > fsuid and fsgid when called by ovl_link().
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > > > > > > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > > > > > > > > ---
> > > > > > > > > >  fs/overlayfs/dir.c | 4 ++--
> > > > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > > > > > > index 6b03457f72bb..568d338032db 100644
> > > > > > > > > > --- a/fs/overlayfs/dir.c
> > > > > > > > > > +++ b/fs/overlayfs/dir.c
> > > > > > > > > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > > > > > > > > >         err = -ENOMEM;
> > > > > > > > > >         override_cred = prepare_creds();
> > > > > > > > > >         if (override_cred) {
> > > > > > > > > > -               override_cred->fsuid = inode->i_uid;
> > > > > > > > > > -               override_cred->fsgid = inode->i_gid;
> > > > > > > > > >                 if (!attr->hardlink) {
> > > > > > > > > > +                       override_cred->fsuid = inode->i_uid;
> > > > > > > > > > +                       override_cred->fsgid = inode->i_gid;
> > > > > > > > > >                         err = security_dentry_create_files_as(dentry,
> > > > > > > > > >                                         attr->mode, &dentry->d_name, old_cred,
> > > > > > > > > >                                         override_cred);
> > > > > > > > > > --
> > > > > > > > >
> > > > > > > > > This change looks incorrect.
> > > > > > > > > Unless I am missing something, fsuid/fsgid still need to
> > > > > > > > > be overridden for calling link() on underlying fs.
> > > > > > > > > What made you do this change?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Amir.
> > > > > > > >
> > > > > > > > Hi Amir,
> > > > > > > >
> > > > > > > > I ran into an error when I tested overlay on fuse:
> > > > > > > >   $ mkdir /lower /fuse /merge
> > > > > > > >   $ mount -t fuse /fuse
> > > > > > > >   $ mkdir /fuse/upper /fuse/work
> > > > > > > >   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,workdir=work
> > > > > > > >   $ touch /merge/file
> > > > > > > >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> > > > > > > >   $ ln /merge/file /merge/lnkfile
> > > > > > > >
> > > > > > > > Then I got an error(EACCES) because fuse daemon checks the link()'s
> > > > > > > > caller is "bin", it denied this request.
> > > > > > > > I browsed the changing history of ovl_link(). There are two key commits:
> > > > > > > > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> > > > > > > > overrides the cred's fsuid/fsgid using the new inode. The new inode's
> > > > > > > > owner is initialized by inode_init_owner(), and inode->fsuid is
> > > > > > > > assigned to the current user. So the override fsuid becomes the
> > > > > > > > current user. We know link() is actually modifying the directory, so
> > > > > > > > the caller must have the MAY_WRITE permission on the directory. The
> > > > > > > > current caller may should have this permission. I think this is
> > > > > > > > acceptable to use the caller's fsuid(But I still feel a little
> > > > > > > > conflicted with the overlay's design).
> > > > > > > > The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> > > > > > > > which removed the inode creation in ovl_link(). This commit move
> > > > > > > > inode_init_owner() into ovl_create_object(), so the ovl_link() just
> > > > > > > > give the old inode to ovl_create_or_link(). Then the override fsuid
> > > > > > > > becomes the old inode's fsuid, neither the caller nor the overlay's
> > > > > > > > creator! So I think this is incorrect.
> > > > > > > > I think the link() should be like unlink(), overlay fs should just use
> > > > > > > > the creator cred to do underlying fs's operations.
> > > > > > > >
> > > > > > >
> > > > > > > I see. The reproducer and explanation belong in the commit message.
> > > > > > >
> > > > > > > Your argument makes sense to me, but CC Christian to make
> > > > > > > sure I am not missing anything related to ACLs and what not.
> > > > > >
> > > > > > Once again with correct email address...
> > > > >
> > > > > So we have:
> > > > >
> > > > > ovl_create_object()
> > > > > -> ovl_override_creds(ovl_sb)
> > > > > -> ovl_new_inode()
> > > > >    -> inode_init_owner()
> > > > >       {
> > > > >               inode->i_uid = current_fsuid();
> > > > >               inode->i_gid = current_fsgid();
> > > 
> > > In inode_init_owner(), the inode->i_gid may inherit from parent dir.
> > > And this is the main purpose of the commit bb0d2b8ad296 ("ovl: fix
> > > sgid on directory").
> > > 
> > > > >       }
> > > > > -> ovl_create_or_link(inode, ...)
> > > > > -> prepare_creds() // Copy of caller's creds
> > > >
> > > > s/caller's/creator's/
> > > >
> > > > > {
> > > > >         override_creds->fsuid = inode->i_uid;
> > > > >         override_creds->fsgid = inode->i_gid;
> > > > > }
> > > > > -> revert_creds()
> > > > >
> > > > > which afaict means that the mounter's credentials are used apart from
> > > > > the fs{g,u}id which is taken from inode->i_{g,u}id which should
> > > > > correspond to current_fs{g,u}id().
> > > > >
> > > > > The commit that is pointed out in the patch
> > > > > 51f7e52dc943 ("ovl: share inode for hard link")
> > > > > seems to have broken that assumption.
> > > > >
> > > > > Given that the intention was to use the creator's creds _with the
> > > > > caller's fs{g,u}id_ wouldn't it make more sense to simply ensure that
> > > > > the caller's fs{g,u}id are always used instead of using the full
> > > > > creator's creds just for the link operation? So something like this
> > > > > (untested):
> > > > >
> > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > index 6b03457f72bb..4a3ee16a6d70 100644
> > > > > --- a/fs/overlayfs/dir.c
> > > > > +++ b/fs/overlayfs/dir.c
> > > > > @@ -575,6 +575,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > > > >         const struct cred *old_cred;
> > > > >         struct cred *override_cred;
> > > > >         struct dentry *parent = dentry->d_parent;
> > > > > +       /* Retrieve caller's fs{g,u}id before we override creds below. */
> > > > > +       kuid_t caller_fsuid = current_fsuid();
> > > > > +       kgid_t caller_fsgid = current_fsgid();
> > > > >
> > > > >         err = ovl_copy_up(parent);
> > > > >         if (err)
> > > > > @@ -595,8 +598,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > > > >         err = -ENOMEM;
> > > > >         override_cred = prepare_creds();
> > > > >         if (override_cred) {
> > > > > -               override_cred->fsuid = inode->i_uid;
> > > > > -               override_cred->fsgid = inode->i_gid;
> > > > > +               override_cred->fsuid = caller_fsuid;
> > > > > +               override_cred->fsgid = caller_fsgid;
> > > 
> > > So the override_cred->fsgid should be inode->i_gid if the inode is a new inode.
> > > 
> > > > >                 if (!attr->hardlink) {
> > > > >                         err = security_dentry_create_files_as(dentry,
> > > > >                                         attr->mode, &dentry->d_name, old_cred,
> > > 
> > > So your meaning should be like this:
> > > 
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index 6b03457f72bb..9aead6ddc071 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -575,6 +575,8 @@ static int ovl_create_or_link(struct dentry
> > > *dentry, struct inode *inode,
> > >         const struct cred *old_cred;
> > >         struct cred *override_cred;
> > >         struct dentry *parent = dentry->d_parent;
> > > +       kuid_t caller_fsuid = current_fsuid();
> > > +       kgid_t caller_fsgid = current_fsgid();
> > > 
> > >         err = ovl_copy_up(parent);
> > >         if (err)
> > > @@ -595,9 +597,9 @@ static int ovl_create_or_link(struct dentry
> > > *dentry, struct inode *inode,
> > >         err = -ENOMEM;
> > >         override_cred = prepare_creds();
> > >         if (override_cred) {
> > > -               override_cred->fsuid = inode->i_uid;
> > > -               override_cred->fsgid = inode->i_gid;
> > >                 if (!attr->hardlink) {
> > > +                       override_cred->fsuid = inode->i_uid;
> > > +                       override_cred->fsgid = inode->i_gid;
> > >                         err = security_dentry_create_files_as(dentry,
> > >                                         attr->mode, &dentry->d_name, old_cred,
> > >                                         override_cred);
> > > @@ -605,6 +607,9 @@ static int ovl_create_or_link(struct dentry
> > > *dentry, struct inode *inode,
> > >                                 put_cred(override_cred);
> > >                                 goto out_revert_creds;
> > >                         }
> > > +               } else {
> > > +                       override_cred->fsuid = caller_fsuid;
> > > +                       override_cred->fsgid = caller_fsgid;
> > >                 }
> > >                 put_cred(override_creds(override_cred));
> > >                 put_cred(override_cred);
> > 
> > Hah, wait. I had a pretty obvious braino when I did that. I forgot to
> > account for setgid handling in inode_init_owner(). Let me take another
> > close look...
> 
> Ok, so if we look at all the callchains:
> 
> (1) .create = ovl_create()
>     -> ovl_create_object()
>        -> ovl_create_or_link()
>    
> (2) .mkdir = ovl_mkdir()
>     -> ovl_create_object()
>        -> ovl_create_or_link()
>    
> (3) .mknod = ovl_mknod()
>     -> ovl_create_object()
>        -> ovl_create_or_link()
>    
> (4) .symlink = ovl_symlink()
>     -> ovl_create_object()
>        -> ovl_create_or_link()
> 
> (5) .link = ovl_link()
>      -> ovl_create_or_link()
> 
> we see that (1) to (4) set the caller's fs{g,u}id to the
> inode->i_{g,u}id. That was instantiated by inode_init_owner(). This will
> be current_fs{g,u}id() of the caller unless the directory the file is
> created in was setgid in which case inode->i_gid can be different from
> current_fsgid().
> 
> So iiuc, taking the inode->i_{g,u}id is done to get fsgid set to
> inode->i_gid when the parent directory is setgid.
> 
> But for (5) the inode->i_{g,u}id should be irrelevant because it's a
> hardlink and so we should just use the caller's fs{g,u}id. So with all
> that in mind we should be doing:
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..74b3813eda47 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
>         inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
>         attr.mode = inode->i_mode;
> 
> +       attr.fsuid = inode->i_uid;
> +       attr.fsgid = inode->i_gid;
>         err = ovl_create_or_link(dentry, inode, &attr, false);
>         /* Did we end up using the preallocated inode? */
>         if (inode != d_inode(dentry))
> @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
>  {
>         int err;
>         struct inode *inode;
> +       struct ovl_cattr attr;
> 
>         err = ovl_want_write(old);
>         if (err)
> @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
>         inode = d_inode(old);
>         ihold(inode);
> 
> -       err = ovl_create_or_link(new, inode,
> -                       &(struct ovl_cattr) {.hardlink = ovl_dentry_upper(old)},
> -                       ovl_type_origin(old));
> +       attr = (struct ovl_cattr){
> +               .hardlink = ovl_dentry_upper(old),
> +               .fsuid = current_fsuid(),
> +               .fsgid = current_fsgid(),
> +       };
> +       err = ovl_create_or_link(new, inode, &attr, ovl_type_origin(old));
>         if (err)
>                 iput(inode);
> 
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 87759165d32b..85043123a103 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -655,6 +655,8 @@ struct ovl_cattr {
>         umode_t mode;
>         const char *link;
>         struct dentry *hardlink;
> +       kuid_t fsuid;
> +       kgid_t fsgid;
>  };
> 
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
> 
> Using the full creator's credentials for just hardlinks seems odd to me
> when all creation requests use the caller's fs{g,u}id...

Sigh, omitted something in the patch:

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..cf4dc303fa4d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
        err = -ENOMEM;
        override_cred = prepare_creds();
        if (override_cred) {
-               override_cred->fsuid = inode->i_uid;
-               override_cred->fsgid = inode->i_gid;
+               override_cred->fsuid = attr->fsuid;
+               override_cred->fsgid = attr->fsgid;
                if (!attr->hardlink) {
                        err = security_dentry_create_files_as(dentry,
                                        attr->mode, &dentry->d_name, old_cred,
@@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
        inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
        attr.mode = inode->i_mode;

+       attr.fsuid = inode->i_uid;
+       attr.fsgid = inode->i_gid;
        err = ovl_create_or_link(dentry, inode, &attr, false);
        /* Did we end up using the preallocated inode? */
        if (inode != d_inode(dentry))
@@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
 {
        int err;
        struct inode *inode;
+       struct ovl_cattr attr;

        err = ovl_want_write(old);
        if (err)
@@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
        inode = d_inode(old);
        ihold(inode);

-       err = ovl_create_or_link(new, inode,
-                       &(struct ovl_cattr) {.hardlink = ovl_dentry_upper(old)},
-                       ovl_type_origin(old));
+       attr = (struct ovl_cattr){
+               .hardlink = ovl_dentry_upper(old),
+               .fsuid = current_fsuid(),
+               .fsgid = current_fsgid(),
+       };
+       err = ovl_create_or_link(new, inode, &attr, ovl_type_origin(old));
        if (err)
                iput(inode);

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..85043123a103 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -655,6 +655,8 @@ struct ovl_cattr {
        umode_t mode;
        const char *link;
        struct dentry *hardlink;
+       kuid_t fsuid;
+       kgid_t fsgid;
 };

