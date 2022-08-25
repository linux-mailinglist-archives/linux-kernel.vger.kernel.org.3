Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A75A0BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiHYIqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiHYIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:46:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36EEA7A9E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:46:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u24so13166681lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=W8uDf7jKAw3p2XxQTHnmv9x8IV9nX43bENYaBWyla+E=;
        b=btbZI5cm9r0y0XkoVbNBQA2GDRjqLSJlbjqUdKZ719ZPKuPNj5fgJMNuXz7XCZZj6r
         Qe1QxeDMdHRyTdiYuRyjMPAvIMtjiSD4bf+4Ds0Wf+f/rSTsxcIzEPmiA9KWMEhrqXH1
         P1BSrLhczenptlMTiYwygCvCRimtxVUxPe/JdzjQS2f/5tNcON4mfyQLPcEixvxAt2hI
         HVIQ4z1G3cNQW3yITzyoXcMMV1YLr6134hsy8+ERA4N7kYxpwPwWk5E3ZZxUtMil6z7/
         ElhpwMwnzyr42v/WG3oHz27aIPAGg6QVWimvIowQQrEDfA07AqPKQ++YjWF49uhd6CE8
         Av7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=W8uDf7jKAw3p2XxQTHnmv9x8IV9nX43bENYaBWyla+E=;
        b=ybgzkw2T6YoNBCePODVRDDHalpvfE7POTPaBm0buNK0p5N6ES+89RaM9iJGC7Va35X
         2veuFkINC+/Nz55TP+Ps/mY87T0E1t2JX0qmno1pSmQKy6Dsseutb1rzT0wY57LaJax2
         IG6uczf13KqJAcssngq3kv4UAU4Pe3zGUQF2iSQs6encWrW6LcSQGhj6hLvTepJEOVM8
         06a080vD2pkzpJHXWsc6VjSRUEzlgauKOo9sFDf/daVzBIUN4ao+bqAiXfLUEiIGwYU/
         4VurJKQOYO3+jQQoVTcONyndzhGZLOb7sW6i0HwAp6oYJYt1R4QJBB+vZa/k/7k7MiaZ
         /yew==
X-Gm-Message-State: ACgBeo3oFtAdSVrkbeZvv4xueAu+9PxYWUDjyIlLp3jncT/K2zBTmWOP
        WA5hB+sOaGuYAP4EJgZEBO7EzBhZMxm2SG4S39+r4A==
X-Google-Smtp-Source: AA6agR4PJ4DuVSnbF0VS2K3nvAK0sV8vQJyiWBZS4TW4WQTYC9g2SfQf6QsbQZ3Wl3GzBsoWFeyOQD4+R+heydTsEq0=
X-Received: by 2002:a2e:6e17:0:b0:261:c872:8198 with SMTP id
 j23-20020a2e6e17000000b00261c8728198mr818605ljc.358.1661417203179; Thu, 25
 Aug 2022 01:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
 <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
 <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
 <CAOQ4uxj_XhC51yS0QCoo8kYWmMxm1XQH4bhoSMZReUd7nc2UFA@mail.gmail.com>
 <20220817102722.wny7x5iwf62edpkd@wittgenstein> <20220817102951.xnvesg3a7rbv576x@wittgenstein>
 <CAP4dvscpm2FyuJ6gqZz=32ffrN9BORaa=Q0grPEgB+KUXbJniw@mail.gmail.com>
 <20220817115638.2etj6ruuutjurgjv@wittgenstein> <20220817122915.k6aps55sjr4hnm5j@wittgenstein>
 <20220817123738.dfqct34rudkt4by4@wittgenstein>
In-Reply-To: <20220817123738.dfqct34rudkt4by4@wittgenstein>
From:   =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Date:   Thu, 25 Aug 2022 16:46:32 +0800
Message-ID: <CAP4dvsc5LgFrcoQMuhGcjbK53_ejmkvsu=Gu_EhRNrRQVAYQOA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 20:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 17, 2022 at 02:29:20PM +0200, Christian Brauner wrote:
> > On Wed, Aug 17, 2022 at 01:56:43PM +0200, Christian Brauner wrote:
> > > On Wed, Aug 17, 2022 at 07:36:44PM +0800, =E5=A4=A9=E8=B5=90=E5=BC=A0=
 wrote:
> > > > On Wed, Aug 17, 2022 at 6:29 PM Christian Brauner <brauner@kernel.o=
rg> wrote:
> > > > >
> > > > > On Wed, Aug 17, 2022 at 12:27:27PM +0200, Christian Brauner wrote=
:
> > > > > > On Wed, Aug 17, 2022 at 12:55:22PM +0300, Amir Goldstein wrote:
> > > > > > > On Wed, Aug 17, 2022 at 12:53 PM Amir Goldstein <amir73il@gma=
il.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Aug 17, 2022 at 12:11 PM =E5=A4=A9=E8=B5=90=E5=BC=
=A0 <zhangtianci.1997@bytedance.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@=
gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > > > > > > > > > <zhangtianci.1997@bytedance.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > ovl_link() did not create a new inode after commit
> > > > > > > > > > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > > > > > > > > > in ovl_create_or_link() we should not override cred's
> > > > > > > > > > > fsuid and fsgid when called by ovl_link().
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedan=
ce.com>
> > > > > > > > > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@byt=
edance.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  fs/overlayfs/dir.c | 4 ++--
> > > > > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > > > > > > > index 6b03457f72bb..568d338032db 100644
> > > > > > > > > > > --- a/fs/overlayfs/dir.c
> > > > > > > > > > > +++ b/fs/overlayfs/dir.c
> > > > > > > > > > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(str=
uct dentry *dentry, struct inode *inode,
> > > > > > > > > > >         err =3D -ENOMEM;
> > > > > > > > > > >         override_cred =3D prepare_creds();
> > > > > > > > > > >         if (override_cred) {
> > > > > > > > > > > -               override_cred->fsuid =3D inode->i_uid=
;
> > > > > > > > > > > -               override_cred->fsgid =3D inode->i_gid=
;
> > > > > > > > > > >                 if (!attr->hardlink) {
> > > > > > > > > > > +                       override_cred->fsuid =3D inod=
e->i_uid;
> > > > > > > > > > > +                       override_cred->fsgid =3D inod=
e->i_gid;
> > > > > > > > > > >                         err =3D security_dentry_creat=
e_files_as(dentry,
> > > > > > > > > > >                                         attr->mode, &=
dentry->d_name, old_cred,
> > > > > > > > > > >                                         override_cred=
);
> > > > > > > > > > > --
> > > > > > > > > >
> > > > > > > > > > This change looks incorrect.
> > > > > > > > > > Unless I am missing something, fsuid/fsgid still need t=
o
> > > > > > > > > > be overridden for calling link() on underlying fs.
> > > > > > > > > > What made you do this change?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Amir.
> > > > > > > > >
> > > > > > > > > Hi Amir,
> > > > > > > > >
> > > > > > > > > I ran into an error when I tested overlay on fuse:
> > > > > > > > >   $ mkdir /lower /fuse /merge
> > > > > > > > >   $ mount -t fuse /fuse
> > > > > > > > >   $ mkdir /fuse/upper /fuse/work
> > > > > > > > >   $ mount -t overlay /merge -o lowerdir=3D/lower,upperdir=
=3D/fuse/upper,workdir=3Dwork
> > > > > > > > >   $ touch /merge/file
> > > > > > > > >   $ chown bin.bin /merge/file // the file's caller become=
s "bin"
> > > > > > > > >   $ ln /merge/file /merge/lnkfile
> > > > > > > > >
> > > > > > > > > Then I got an error(EACCES) because fuse daemon checks th=
e link()'s
> > > > > > > > > caller is "bin", it denied this request.
> > > > > > > > > I browsed the changing history of ovl_link(). There are t=
wo key commits:
> > > > > > > > > The first is commit bb0d2b8ad296 ("ovl: fix sgid on direc=
tory") which
> > > > > > > > > overrides the cred's fsuid/fsgid using the new inode. The=
 new inode's
> > > > > > > > > owner is initialized by inode_init_owner(), and inode->fs=
uid is
> > > > > > > > > assigned to the current user. So the override fsuid becom=
es the
> > > > > > > > > current user. We know link() is actually modifying the di=
rectory, so
> > > > > > > > > the caller must have the MAY_WRITE permission on the dire=
ctory. The
> > > > > > > > > current caller may should have this permission. I think t=
his is
> > > > > > > > > acceptable to use the caller's fsuid(But I still feel a l=
ittle
> > > > > > > > > conflicted with the overlay's design).
> > > > > > > > > The second is commit 51f7e52dc943 ("ovl: share inode for =
hard link")
> > > > > > > > > which removed the inode creation in ovl_link(). This comm=
it move
> > > > > > > > > inode_init_owner() into ovl_create_object(), so the ovl_l=
ink() just
> > > > > > > > > give the old inode to ovl_create_or_link(). Then the over=
ride fsuid
> > > > > > > > > becomes the old inode's fsuid, neither the caller nor the=
 overlay's
> > > > > > > > > creator! So I think this is incorrect.
> > > > > > > > > I think the link() should be like unlink(), overlay fs sh=
ould just use
> > > > > > > > > the creator cred to do underlying fs's operations.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I see. The reproducer and explanation belong in the commit =
message.
> > > > > > > >
> > > > > > > > Your argument makes sense to me, but CC Christian to make
> > > > > > > > sure I am not missing anything related to ACLs and what not=
.
> > > > > > >
> > > > > > > Once again with correct email address...
> > > > > >
> > > > > > So we have:
> > > > > >
> > > > > > ovl_create_object()
> > > > > > -> ovl_override_creds(ovl_sb)
> > > > > > -> ovl_new_inode()
> > > > > >    -> inode_init_owner()
> > > > > >       {
> > > > > >               inode->i_uid =3D current_fsuid();
> > > > > >               inode->i_gid =3D current_fsgid();
> > > >
> > > > In inode_init_owner(), the inode->i_gid may inherit from parent dir=
.
> > > > And this is the main purpose of the commit bb0d2b8ad296 ("ovl: fix
> > > > sgid on directory").
> > > >
> > > > > >       }
> > > > > > -> ovl_create_or_link(inode, ...)
> > > > > > -> prepare_creds() // Copy of caller's creds
> > > > >
> > > > > s/caller's/creator's/
> > > > >
> > > > > > {
> > > > > >         override_creds->fsuid =3D inode->i_uid;
> > > > > >         override_creds->fsgid =3D inode->i_gid;
> > > > > > }
> > > > > > -> revert_creds()
> > > > > >
> > > > > > which afaict means that the mounter's credentials are used apar=
t from
> > > > > > the fs{g,u}id which is taken from inode->i_{g,u}id which should
> > > > > > correspond to current_fs{g,u}id().
> > > > > >
> > > > > > The commit that is pointed out in the patch
> > > > > > 51f7e52dc943 ("ovl: share inode for hard link")
> > > > > > seems to have broken that assumption.
> > > > > >
> > > > > > Given that the intention was to use the creator's creds _with t=
he
> > > > > > caller's fs{g,u}id_ wouldn't it make more sense to simply ensur=
e that
> > > > > > the caller's fs{g,u}id are always used instead of using the ful=
l
> > > > > > creator's creds just for the link operation? So something like =
this
> > > > > > (untested):
> > > > > >
> > > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > > index 6b03457f72bb..4a3ee16a6d70 100644
> > > > > > --- a/fs/overlayfs/dir.c
> > > > > > +++ b/fs/overlayfs/dir.c
> > > > > > @@ -575,6 +575,9 @@ static int ovl_create_or_link(struct dentry=
 *dentry, struct inode *inode,
> > > > > >         const struct cred *old_cred;
> > > > > >         struct cred *override_cred;
> > > > > >         struct dentry *parent =3D dentry->d_parent;
> > > > > > +       /* Retrieve caller's fs{g,u}id before we override creds=
 below. */
> > > > > > +       kuid_t caller_fsuid =3D current_fsuid();
> > > > > > +       kgid_t caller_fsgid =3D current_fsgid();
> > > > > >
> > > > > >         err =3D ovl_copy_up(parent);
> > > > > >         if (err)
> > > > > > @@ -595,8 +598,8 @@ static int ovl_create_or_link(struct dentry=
 *dentry, struct inode *inode,
> > > > > >         err =3D -ENOMEM;
> > > > > >         override_cred =3D prepare_creds();
> > > > > >         if (override_cred) {
> > > > > > -               override_cred->fsuid =3D inode->i_uid;
> > > > > > -               override_cred->fsgid =3D inode->i_gid;
> > > > > > +               override_cred->fsuid =3D caller_fsuid;
> > > > > > +               override_cred->fsgid =3D caller_fsgid;
> > > >
> > > > So the override_cred->fsgid should be inode->i_gid if the inode is =
a new inode.
> > > >
> > > > > >                 if (!attr->hardlink) {
> > > > > >                         err =3D security_dentry_create_files_as=
(dentry,
> > > > > >                                         attr->mode, &dentry->d_=
name, old_cred,
> > > >
> > > > So your meaning should be like this:
> > > >
> > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > index 6b03457f72bb..9aead6ddc071 100644
> > > > --- a/fs/overlayfs/dir.c
> > > > +++ b/fs/overlayfs/dir.c
> > > > @@ -575,6 +575,8 @@ static int ovl_create_or_link(struct dentry
> > > > *dentry, struct inode *inode,
> > > >         const struct cred *old_cred;
> > > >         struct cred *override_cred;
> > > >         struct dentry *parent =3D dentry->d_parent;
> > > > +       kuid_t caller_fsuid =3D current_fsuid();
> > > > +       kgid_t caller_fsgid =3D current_fsgid();
> > > >
> > > >         err =3D ovl_copy_up(parent);
> > > >         if (err)
> > > > @@ -595,9 +597,9 @@ static int ovl_create_or_link(struct dentry
> > > > *dentry, struct inode *inode,
> > > >         err =3D -ENOMEM;
> > > >         override_cred =3D prepare_creds();
> > > >         if (override_cred) {
> > > > -               override_cred->fsuid =3D inode->i_uid;
> > > > -               override_cred->fsgid =3D inode->i_gid;
> > > >                 if (!attr->hardlink) {
> > > > +                       override_cred->fsuid =3D inode->i_uid;
> > > > +                       override_cred->fsgid =3D inode->i_gid;
> > > >                         err =3D security_dentry_create_files_as(den=
try,
> > > >                                         attr->mode, &dentry->d_name=
, old_cred,
> > > >                                         override_cred);
> > > > @@ -605,6 +607,9 @@ static int ovl_create_or_link(struct dentry
> > > > *dentry, struct inode *inode,
> > > >                                 put_cred(override_cred);
> > > >                                 goto out_revert_creds;
> > > >                         }
> > > > +               } else {
> > > > +                       override_cred->fsuid =3D caller_fsuid;
> > > > +                       override_cred->fsgid =3D caller_fsgid;
> > > >                 }
> > > >                 put_cred(override_creds(override_cred));
> > > >                 put_cred(override_cred);
> > >
> > > Hah, wait. I had a pretty obvious braino when I did that. I forgot to
> > > account for setgid handling in inode_init_owner(). Let me take anothe=
r
> > > close look...
> >
> > Ok, so if we look at all the callchains:
> >
> > (1) .create =3D ovl_create()
> >     -> ovl_create_object()
> >        -> ovl_create_or_link()
> >
> > (2) .mkdir =3D ovl_mkdir()
> >     -> ovl_create_object()
> >        -> ovl_create_or_link()
> >
> > (3) .mknod =3D ovl_mknod()
> >     -> ovl_create_object()
> >        -> ovl_create_or_link()
> >
> > (4) .symlink =3D ovl_symlink()
> >     -> ovl_create_object()
> >        -> ovl_create_or_link()
> >
> > (5) .link =3D ovl_link()
> >      -> ovl_create_or_link()
> >
> > we see that (1) to (4) set the caller's fs{g,u}id to the
> > inode->i_{g,u}id. That was instantiated by inode_init_owner(). This wil=
l
> > be current_fs{g,u}id() of the caller unless the directory the file is
> > created in was setgid in which case inode->i_gid can be different from
> > current_fsgid().
> >
> > So iiuc, taking the inode->i_{g,u}id is done to get fsgid set to
> > inode->i_gid when the parent directory is setgid.
> >
> > But for (5) the inode->i_{g,u}id should be irrelevant because it's a
> > hardlink and so we should just use the caller's fs{g,u}id. So with all
> > that in mind we should be doing:
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 6b03457f72bb..74b3813eda47 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry,=
 int mode, dev_t rdev,
> >         inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inod=
e, mode);
> >         attr.mode =3D inode->i_mode;
> >
> > +       attr.fsuid =3D inode->i_uid;
> > +       attr.fsgid =3D inode->i_gid;
> >         err =3D ovl_create_or_link(dentry, inode, &attr, false);
> >         /* Did we end up using the preallocated inode? */
> >         if (inode !=3D d_inode(dentry))
> > @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inod=
e *newdir,
> >  {
> >         int err;
> >         struct inode *inode;
> > +       struct ovl_cattr attr;
> >
> >         err =3D ovl_want_write(old);
> >         if (err)
> > @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct ino=
de *newdir,
> >         inode =3D d_inode(old);
> >         ihold(inode);
> >
> > -       err =3D ovl_create_or_link(new, inode,
> > -                       &(struct ovl_cattr) {.hardlink =3D ovl_dentry_u=
pper(old)},
> > -                       ovl_type_origin(old));
> > +       attr =3D (struct ovl_cattr){
> > +               .hardlink =3D ovl_dentry_upper(old),
> > +               .fsuid =3D current_fsuid(),
> > +               .fsgid =3D current_fsgid(),
> > +       };
> > +       err =3D ovl_create_or_link(new, inode, &attr, ovl_type_origin(o=
ld));
> >         if (err)
> >                 iput(inode);
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 87759165d32b..85043123a103 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -655,6 +655,8 @@ struct ovl_cattr {
> >         umode_t mode;
> >         const char *link;
> >         struct dentry *hardlink;
> > +       kuid_t fsuid;
> > +       kgid_t fsgid;
> >  };
> >
> >  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode =3D (m) })
> >
> > Using the full creator's credentials for just hardlinks seems odd to me
> > when all creation requests use the caller's fs{g,u}id...
>
> Sigh, omitted something in the patch:
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..cf4dc303fa4d 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *dentry, =
struct inode *inode,
>         err =3D -ENOMEM;
>         override_cred =3D prepare_creds();
>         if (override_cred) {
> -               override_cred->fsuid =3D inode->i_uid;
> -               override_cred->fsgid =3D inode->i_gid;
> +               override_cred->fsuid =3D attr->fsuid;
> +               override_cred->fsgid =3D attr->fsgid;
>                 if (!attr->hardlink) {
>                         err =3D security_dentry_create_files_as(dentry,
>                                         attr->mode, &dentry->d_name, old_=
cred,
> @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry, i=
nt mode, dev_t rdev,
>         inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode,=
 mode);
>         attr.mode =3D inode->i_mode;
>
> +       attr.fsuid =3D inode->i_uid;
> +       attr.fsgid =3D inode->i_gid;
>         err =3D ovl_create_or_link(dentry, inode, &attr, false);
>         /* Did we end up using the preallocated inode? */
>         if (inode !=3D d_inode(dentry))
> @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inode =
*newdir,
>  {
>         int err;
>         struct inode *inode;
> +       struct ovl_cattr attr;
>
>         err =3D ovl_want_write(old);
>         if (err)
> @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct inode=
 *newdir,
>         inode =3D d_inode(old);
>         ihold(inode);
>
> -       err =3D ovl_create_or_link(new, inode,
> -                       &(struct ovl_cattr) {.hardlink =3D ovl_dentry_upp=
er(old)},
> -                       ovl_type_origin(old));
> +       attr =3D (struct ovl_cattr){
> +               .hardlink =3D ovl_dentry_upper(old),
> +               .fsuid =3D current_fsuid(),
> +               .fsgid =3D current_fsgid(),
> +       };
> +       err =3D ovl_create_or_link(new, inode, &attr, ovl_type_origin(old=
));
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

There were no more comments some days ago so I will send the v2 patch
according to your modification later.

Thanks,
Tianci.
