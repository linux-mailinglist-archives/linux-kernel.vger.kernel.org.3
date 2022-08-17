Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2351596DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiHQLhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHQLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:37:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7FF7823C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:36:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v2so18645838lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=vyF96h/Qyjj6lyCZt6oC8PI7seUwVffrl3CQSx71pNM=;
        b=Ia5rdSQYR5mnJ7sojPl2gt+Nrvp94faa9tbaKBNmnXd3C/e6D5YFdW+YuinT7m3T+0
         WLI+gKJElRjyLEKNropdhrih47c7wLN65QWWdaEjClL376Px2cm46HV95IOFJ6BmsQrc
         0B6SZBCnZVyc1B857i2lWU5xz2E1LXX0Ry6gUlMP4mKsgiXg9pARzYNkbVpSRbKd+CuK
         ef6lEEy1r2U36xo1IAu784O36tIuS+evtDVOoyvMu7M9IPrvpc6U3w+2xMNTyaDXSjbV
         YoXocF+fkMkCLAIJpL2wBQF3A+hiEjCY3Z8jL4CO4oiAP9hXMk4J0soVPPIfizbCYq42
         nfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vyF96h/Qyjj6lyCZt6oC8PI7seUwVffrl3CQSx71pNM=;
        b=pNk2Mk7glKLnwKh1FjqgVK5ahV0WNhFPEnHUaIqTmuKo60F1ECYsDO8UBse1APnnL9
         cbQ91a6K4/xH/KHQSrAMYOelZPGXjBDDZkPMzrpBTqaSTv3bXcAvsaEqsVVXYebjtGaq
         Wpe6iCSW8EwdeQDnZ+IAhj53a7Ds/ym2FnOGO2X6GF2rRvM5mCnWQHgheW9rdUDzpVM7
         DePVlEr13STPh/vsXjl82Ibna/kPOltadGD0V5uObM8ooJQYtMefTerorYjOLFRzqZhV
         1QdkG9RuteOLzBfN5hT/fqYaXEx3b8XTMzJGwlHvTlmM3R/+DyuKJFGlJJ9E38rs/ar/
         E6sQ==
X-Gm-Message-State: ACgBeo3Y/fepxoTlkaxvHWwEcvfBycukHDuDjxzPzYkJt0Mpu7PZk7gU
        o1Rbhvv3y80rWSBBUgnIaLLuFZ5eOEOx1lhPFTmTRQ==
X-Google-Smtp-Source: AA6agR6GtvHwMzHtvUkkQgUepJCZjnfp0hwLgCbLFsuZzKDzvCrrtVtkjMdfKkHJYdIkUPz/G7rKafyBqO7GnOS1xzw=
X-Received: by 2002:a05:6512:4c1:b0:48c:fe67:5e87 with SMTP id
 w1-20020a05651204c100b0048cfe675e87mr9641912lfq.297.1660736215726; Wed, 17
 Aug 2022 04:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
 <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
 <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
 <CAOQ4uxj_XhC51yS0QCoo8kYWmMxm1XQH4bhoSMZReUd7nc2UFA@mail.gmail.com>
 <20220817102722.wny7x5iwf62edpkd@wittgenstein> <20220817102951.xnvesg3a7rbv576x@wittgenstein>
In-Reply-To: <20220817102951.xnvesg3a7rbv576x@wittgenstein>
From:   =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Date:   Wed, 17 Aug 2022 19:36:44 +0800
Message-ID: <CAP4dvscpm2FyuJ6gqZz=32ffrN9BORaa=Q0grPEgB+KUXbJniw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
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

On Wed, Aug 17, 2022 at 6:29 PM Christian Brauner <brauner@kernel.org> wrot=
e:
>
> On Wed, Aug 17, 2022 at 12:27:27PM +0200, Christian Brauner wrote:
> > On Wed, Aug 17, 2022 at 12:55:22PM +0300, Amir Goldstein wrote:
> > > On Wed, Aug 17, 2022 at 12:53 PM Amir Goldstein <amir73il@gmail.com> =
wrote:
> > > >
> > > > On Wed, Aug 17, 2022 at 12:11 PM =E5=A4=A9=E8=B5=90=E5=BC=A0 <zhang=
tianci.1997@bytedance.com> wrote:
> > > > >
> > > > > On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > > > > >
> > > > > > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > > > > > <zhangtianci.1997@bytedance.com> wrote:
> > > > > > >
> > > > > > > ovl_link() did not create a new inode after commit
> > > > > > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > > > > > in ovl_create_or_link() we should not override cred's
> > > > > > > fsuid and fsgid when called by ovl_link().
> > > > > > >
> > > > > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > > > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.c=
om>
> > > > > > > ---
> > > > > > >  fs/overlayfs/dir.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > > > index 6b03457f72bb..568d338032db 100644
> > > > > > > --- a/fs/overlayfs/dir.c
> > > > > > > +++ b/fs/overlayfs/dir.c
> > > > > > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dent=
ry *dentry, struct inode *inode,
> > > > > > >         err =3D -ENOMEM;
> > > > > > >         override_cred =3D prepare_creds();
> > > > > > >         if (override_cred) {
> > > > > > > -               override_cred->fsuid =3D inode->i_uid;
> > > > > > > -               override_cred->fsgid =3D inode->i_gid;
> > > > > > >                 if (!attr->hardlink) {
> > > > > > > +                       override_cred->fsuid =3D inode->i_uid=
;
> > > > > > > +                       override_cred->fsgid =3D inode->i_gid=
;
> > > > > > >                         err =3D security_dentry_create_files_=
as(dentry,
> > > > > > >                                         attr->mode, &dentry->=
d_name, old_cred,
> > > > > > >                                         override_cred);
> > > > > > > --
> > > > > >
> > > > > > This change looks incorrect.
> > > > > > Unless I am missing something, fsuid/fsgid still need to
> > > > > > be overridden for calling link() on underlying fs.
> > > > > > What made you do this change?
> > > > > >
> > > > > > Thanks,
> > > > > > Amir.
> > > > >
> > > > > Hi Amir,
> > > > >
> > > > > I ran into an error when I tested overlay on fuse:
> > > > >   $ mkdir /lower /fuse /merge
> > > > >   $ mount -t fuse /fuse
> > > > >   $ mkdir /fuse/upper /fuse/work
> > > > >   $ mount -t overlay /merge -o lowerdir=3D/lower,upperdir=3D/fuse=
/upper,workdir=3Dwork
> > > > >   $ touch /merge/file
> > > > >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> > > > >   $ ln /merge/file /merge/lnkfile
> > > > >
> > > > > Then I got an error(EACCES) because fuse daemon checks the link()=
's
> > > > > caller is "bin", it denied this request.
> > > > > I browsed the changing history of ovl_link(). There are two key c=
ommits:
> > > > > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") w=
hich
> > > > > overrides the cred's fsuid/fsgid using the new inode. The new ino=
de's
> > > > > owner is initialized by inode_init_owner(), and inode->fsuid is
> > > > > assigned to the current user. So the override fsuid becomes the
> > > > > current user. We know link() is actually modifying the directory,=
 so
> > > > > the caller must have the MAY_WRITE permission on the directory. T=
he
> > > > > current caller may should have this permission. I think this is
> > > > > acceptable to use the caller's fsuid(But I still feel a little
> > > > > conflicted with the overlay's design).
> > > > > The second is commit 51f7e52dc943 ("ovl: share inode for hard lin=
k")
> > > > > which removed the inode creation in ovl_link(). This commit move
> > > > > inode_init_owner() into ovl_create_object(), so the ovl_link() ju=
st
> > > > > give the old inode to ovl_create_or_link(). Then the override fsu=
id
> > > > > becomes the old inode's fsuid, neither the caller nor the overlay=
's
> > > > > creator! So I think this is incorrect.
> > > > > I think the link() should be like unlink(), overlay fs should jus=
t use
> > > > > the creator cred to do underlying fs's operations.
> > > > >
> > > >
> > > > I see. The reproducer and explanation belong in the commit message.
> > > >
> > > > Your argument makes sense to me, but CC Christian to make
> > > > sure I am not missing anything related to ACLs and what not.
> > >
> > > Once again with correct email address...
> >
> > So we have:
> >
> > ovl_create_object()
> > -> ovl_override_creds(ovl_sb)
> > -> ovl_new_inode()
> >    -> inode_init_owner()
> >       {
> >               inode->i_uid =3D current_fsuid();
> >               inode->i_gid =3D current_fsgid();

In inode_init_owner(), the inode->i_gid may inherit from parent dir.
And this is the main purpose of the commit bb0d2b8ad296 ("ovl: fix
sgid on directory").

> >       }
> > -> ovl_create_or_link(inode, ...)
> > -> prepare_creds() // Copy of caller's creds
>
> s/caller's/creator's/
>
> > {
> >         override_creds->fsuid =3D inode->i_uid;
> >         override_creds->fsgid =3D inode->i_gid;
> > }
> > -> revert_creds()
> >
> > which afaict means that the mounter's credentials are used apart from
> > the fs{g,u}id which is taken from inode->i_{g,u}id which should
> > correspond to current_fs{g,u}id().
> >
> > The commit that is pointed out in the patch
> > 51f7e52dc943 ("ovl: share inode for hard link")
> > seems to have broken that assumption.
> >
> > Given that the intention was to use the creator's creds _with the
> > caller's fs{g,u}id_ wouldn't it make more sense to simply ensure that
> > the caller's fs{g,u}id are always used instead of using the full
> > creator's creds just for the link operation? So something like this
> > (untested):
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 6b03457f72bb..4a3ee16a6d70 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -575,6 +575,9 @@ static int ovl_create_or_link(struct dentry *dentry=
, struct inode *inode,
> >         const struct cred *old_cred;
> >         struct cred *override_cred;
> >         struct dentry *parent =3D dentry->d_parent;
> > +       /* Retrieve caller's fs{g,u}id before we override creds below. =
*/
> > +       kuid_t caller_fsuid =3D current_fsuid();
> > +       kgid_t caller_fsgid =3D current_fsgid();
> >
> >         err =3D ovl_copy_up(parent);
> >         if (err)
> > @@ -595,8 +598,8 @@ static int ovl_create_or_link(struct dentry *dentry=
, struct inode *inode,
> >         err =3D -ENOMEM;
> >         override_cred =3D prepare_creds();
> >         if (override_cred) {
> > -               override_cred->fsuid =3D inode->i_uid;
> > -               override_cred->fsgid =3D inode->i_gid;
> > +               override_cred->fsuid =3D caller_fsuid;
> > +               override_cred->fsgid =3D caller_fsgid;

So the override_cred->fsgid should be inode->i_gid if the inode is a new in=
ode.

> >                 if (!attr->hardlink) {
> >                         err =3D security_dentry_create_files_as(dentry,
> >                                         attr->mode, &dentry->d_name, ol=
d_cred,

So your meaning should be like this:

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..9aead6ddc071 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -575,6 +575,8 @@ static int ovl_create_or_link(struct dentry
*dentry, struct inode *inode,
        const struct cred *old_cred;
        struct cred *override_cred;
        struct dentry *parent =3D dentry->d_parent;
+       kuid_t caller_fsuid =3D current_fsuid();
+       kgid_t caller_fsgid =3D current_fsgid();

        err =3D ovl_copy_up(parent);
        if (err)
@@ -595,9 +597,9 @@ static int ovl_create_or_link(struct dentry
*dentry, struct inode *inode,
        err =3D -ENOMEM;
        override_cred =3D prepare_creds();
        if (override_cred) {
-               override_cred->fsuid =3D inode->i_uid;
-               override_cred->fsgid =3D inode->i_gid;
                if (!attr->hardlink) {
+                       override_cred->fsuid =3D inode->i_uid;
+                       override_cred->fsgid =3D inode->i_gid;
                        err =3D security_dentry_create_files_as(dentry,
                                        attr->mode, &dentry->d_name, old_cr=
ed,
                                        override_cred);
@@ -605,6 +607,9 @@ static int ovl_create_or_link(struct dentry
*dentry, struct inode *inode,
                                put_cred(override_cred);
                                goto out_revert_creds;
                        }
+               } else {
+                       override_cred->fsuid =3D caller_fsuid;
+                       override_cred->fsgid =3D caller_fsgid;
                }
                put_cred(override_creds(override_cred));
                put_cred(override_cred);

As I said before, I think this is acceptable to use the caller's
fsuid. But I still feel a little conflicted with the overlay's design.
Because I am not sure if there should be some difference between
link() and unlink() after commit 51f7e52dc943 ("ovl: share inode for
hard link") remove the creation in ovl_link().
