Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2535A597F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiH3Coy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiH3Cou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:44:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7852ACE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:44:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y64so568801ede.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PUle248un9nFpWse2HmQCbQvlzfY5nGwjwjVeSIbGGM=;
        b=aqNQyj6UdGrxvwZN99NZDPDPJcujP7vv9lVzU2qei6tMYd3Yxzm/loAxNef5CIDtVC
         OspnMSJ4GNt9auc4attmAUqsIpj9RsCFO8RHncB4al3u8wArHiBVd4cs+4wbItYLq8U2
         He2QeXru3vS7Q7m/wj1gD8r6EWZbnatKVz9nic7Ovd2XtXNJGkaLL8A4FYxBWo8x7dDT
         ZxP/LmlVIIv7ahV8rOSUB7sn4t3M0X32GyX+oh+qo2Io7MIokc+TlnlDuduMYnW9ZAPr
         Ewm90qHvlnqPxLpOLa8AfryMSkf8buFD9ljl7XIHTo19gsbz+88bognpByUMEzpB80Ud
         FucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PUle248un9nFpWse2HmQCbQvlzfY5nGwjwjVeSIbGGM=;
        b=EpBnIOyfGUS5hOS4NTKASrQcctLgpa5dN9p2h0giNegu6J1Y9A2JzKBp5fUukOvjYW
         +6HFSwtCy9GlQhIxwKS3yLvx/tqYDOM6Zq6vBA3VB/GoxVuaKTi1fFSOJidM0sIydVM4
         Uu+TfTjhHuZSpgRUg0BLkWEW7Ya9qmrECXtqeClK84YYkSY7PhKh32RkB6pPXtE6qpfP
         u15OckCy0yF8qhDabYZtZcobYaanl+Fy34BmWivqoXMSheuO50AIyfRt/VUcfFe/r3ST
         7Rr/9INSgT0IPiLBJvhPziDfrcTEPUeJLds4idsEUqgG4yjeczmmJkmBr1UIxD8VzOuv
         sTTw==
X-Gm-Message-State: ACgBeo02fW9m2BeMbmak6ruT8iHrZ/FZbeKVe3SraXSDjI1mYu7tCI+1
        CL1pUoT4/Ug5EiNBUaiLB3pIbrkh0OiP+ntaczvkEA==
X-Google-Smtp-Source: AA6agR4LWWmKrGbYhsLumV4xeXbcdBHCGSpV/QUkHPBgitdooKavBIdMTfEu7mRbrWRk/bRHKLRpL0Ji+jVGTJGDtic=
X-Received: by 2002:aa7:dccb:0:b0:448:8084:1df9 with SMTP id
 w11-20020aa7dccb000000b0044880841df9mr5285808edu.259.1661827486750; Mon, 29
 Aug 2022 19:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220825130552.29587-1-zhangtianci.1997@bytedance.com> <20220825132552.loybzprnkwdkmu3k@wittgenstein>
In-Reply-To: <20220825132552.loybzprnkwdkmu3k@wittgenstein>
From:   =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Date:   Tue, 30 Aug 2022 10:44:35 +0800
Message-ID: <CAP4dvseJi58dhDcf4pybkRoquBOdQeTL139Dkx0i=CBV+7hoFQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] ovl: Use current fsuid and fsgid in ovl_link()
To:     Christian Brauner <brauner@kernel.org>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
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

Christian Brauner <brauner@kernel.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E5=9B=9B 21:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 25, 2022 at 09:05:52PM +0800, Zhang Tianci wrote:
> > There is a wrong case of link() on overlay:
> >   $ mkdir /lower /fuse /merge
> >   $ mount -t fuse /fuse
> >   $ mkdir /fuse/upper /fuse/work
> >   $ mount -t overlay /merge -o lowerdir=3D/lower,upperdir=3D/fuse/upper=
,\
> >     workdir=3Dwork
> >   $ touch /merge/file
> >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> >   $ ln /merge/file /merge/lnkfile
> >
> > Then we will get an error(EACCES) because fuse daemon checks the link()=
's
> > caller is "bin", it denied this request.
> >
> > In the changing history of ovl_link(), there are two key commits:
> >
> > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> > overrides the cred's fsuid/fsgid using the new inode. The new inode's
> > owner is initialized by inode_init_owner(), and inode->fsuid is
> > assigned to the current user. So the override fsuid becomes the
> > current user. We know link() is actually modifying the directory, so
> > the caller must have the MAY_WRITE permission on the directory. The
> > current caller may should have this permission. This is acceptable
> > to use the caller's fsuid.
> >
> > The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> > which removed the inode creation in ovl_link(). This commit move
> > inode_init_owner() into ovl_create_object(), so the ovl_link() just
> > give the old inode to ovl_create_or_link(). Then the override fsuid
> > becomes the old inode's fsuid, neither the caller nor the overlay's
> > creator! So this is incorrect.
> >
> > Fix this bug by using current fsuid/fsgid to do underlying fs's link().
> >
> > Link: https://lore.kernel.org/all/20220817102951.xnvesg3a7rbv576x@wittg=
enstein/T
> >
> > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
>
> (Should probably also use a
> Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>, I
> think. But not that important.)
>
> Looks good to me but this really should be tested to survive xfstests,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>
> >  fs/overlayfs/dir.c       | 16 +++++++++++-----
> >  fs/overlayfs/overlayfs.h |  2 ++
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 6b03457f72bb..dd84e6fc5f6e 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *dentry=
, struct inode *inode,
> >       err =3D -ENOMEM;
> >       override_cred =3D prepare_creds();
> >       if (override_cred) {
> > -             override_cred->fsuid =3D inode->i_uid;
> > -             override_cred->fsgid =3D inode->i_gid;
> > +             override_cred->fsuid =3D attr->fsuid;
> > +             override_cred->fsgid =3D attr->fsgid;
> >               if (!attr->hardlink) {
> >                       err =3D security_dentry_create_files_as(dentry,
> >                                       attr->mode, &dentry->d_name, old_=
cred,
> > @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry,=
 int mode, dev_t rdev,
> >       inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode,=
 mode);
> >       attr.mode =3D inode->i_mode;
> >
> > +     attr.fsuid =3D inode->i_uid;
> > +     attr.fsgid =3D inode->i_gid;
> >       err =3D ovl_create_or_link(dentry, inode, &attr, false);
> >       /* Did we end up using the preallocated inode? */
> >       if (inode !=3D d_inode(dentry))
> > @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inod=
e *newdir,
> >  {
> >       int err;
> >       struct inode *inode;
> > +     struct ovl_cattr attr;
> >
> >       err =3D ovl_want_write(old);
> >       if (err)
> > @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct ino=
de *newdir,
> >       inode =3D d_inode(old);
> >       ihold(inode);
> >
> > -     err =3D ovl_create_or_link(new, inode,
> > -                     &(struct ovl_cattr) {.hardlink =3D ovl_dentry_upp=
er(old)},
> > -                     ovl_type_origin(old));
> > +     attr =3D (struct ovl_cattr) {
> > +             .hardlink =3D ovl_dentry_upper(old),
> > +             .fsuid =3D current_fsuid(),
> > +             .fsgid =3D current_fsgid(),
> > +     };
> > +     err =3D ovl_create_or_link(new, inode, &attr, ovl_type_origin(old=
));
> >       if (err)
> >               iput(inode);
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 87759165d32b..85043123a103 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -655,6 +655,8 @@ struct ovl_cattr {
> >       umode_t mode;
> >       const char *link;
> >       struct dentry *hardlink;
> > +     kuid_t fsuid;
> > +     kgid_t fsgid;
> >  };
> >
> >  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode =3D (m) })
> > --
> > 2.32.1 (Apple Git-133)
> >

I tested this patch base on linux-6.0.0-rc3, and all were successful.
I tested xfstest using this local config:
  export TEST_DEV=3D/dev/vdb1
  export TEST_DIR=3D/mnt/test
  export SCRATCH_DEV=3D/dev/vdb2
  export SCRATCH_MNT=3D/mnt/scratch
  FSTYP=3Dxfs
run ./check -overlay in xfstest.
