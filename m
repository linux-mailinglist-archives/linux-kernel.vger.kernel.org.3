Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC46596C77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiHQJzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiHQJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:55:35 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF658522;
        Wed, 17 Aug 2022 02:55:34 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id q191so6438287vkb.6;
        Wed, 17 Aug 2022 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9jruxPToj7xc/oS5rHlxpPOpssy7XT3dNWOlNRoR2/0=;
        b=bzIXYFpJyFsVjIXTFqBMfmRAWz3RL336qW+IjfQ2uQ7jz8cazOJDKAnvzILS2LwTE9
         GSAq87Vrq+676hVxVm/1FBxHgyCj1Ac9lrAS5N8aWHq0zCh5qI4QCCpzxHLz9QSaQ0S+
         jxLePMYK9dxOgbaV1FnblBooL2BFJ4vt3VDas5XAj/GeN/y/8ViOpgK5XM5RUHYIOLvK
         vp2eaVWIQj2aBuMIQnj4muphljQzkHOvLTTm42jL7ww15YFR0MV7LIKcxyefM1I9nyGm
         5AzKQTxcLWg3V9/yPvx9HkWr0C4s+O5jiN1Che8szMHCaC+Xuz0a/pii0cZ/ytKW9lao
         Tk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9jruxPToj7xc/oS5rHlxpPOpssy7XT3dNWOlNRoR2/0=;
        b=kGgvHwt+3szhlnHz53+dUZTeTQQZ9QKBSvNYnUVmz13eJ/fV1iwd0dZxei33cyt0sy
         ECPcFGyjz43Fh1PijcdelOgfVuIXCNSM9hokzhN+0xWW6NjutZZ1dr0t+JcnBCoGpisn
         BxGoKBN5BkwsAiQVzZeT1D79CQBK5A6QFXpumRKMnO4AD14adwNagG1/xMR09bC5OQLO
         j2HY4tin04db2TMlYlX6wkk//6b+JSnGLLLRV4pnGZX0pzaOA9Gfga4iEAaZ87o3i7cu
         YFvDYP04SaaJEv92u5XT7YoawrgblQg7ciEROPYyn8/nINRUAkj1byhyK6OzMALVdAnL
         px6A==
X-Gm-Message-State: ACgBeo0miot98LHerjsDK6ylET5C4j/TiShBQzKX413vs0HeL6y2CTKI
        WtxcMqppFjfBieezu0JyiRGwC0TIv/6vrJN0XC7Y78eg
X-Google-Smtp-Source: AA6agR5TWSVQ8+H7PRbxFERQAYOLBU8FJX5gyBo1Khhj6TwklLIfv3hl/AXI3ZgLGNvNjtteJMwVp+zuCNDJiUttc20=
X-Received: by 2002:a1f:e3c5:0:b0:380:68eb:e647 with SMTP id
 a188-20020a1fe3c5000000b0038068ebe647mr2730301vkh.11.1660730133526; Wed, 17
 Aug 2022 02:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
 <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com> <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Aug 2022 12:55:22 +0300
Message-ID: <CAOQ4uxj_XhC51yS0QCoo8kYWmMxm1XQH4bhoSMZReUd7nc2UFA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
To:     =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Aug 17, 2022 at 12:11 PM =E5=A4=A9=E8=B5=90=E5=BC=A0 <zhangtianci=
.1997@bytedance.com> wrote:
> >
> > On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wro=
te:
> > >
> > > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > > <zhangtianci.1997@bytedance.com> wrote:
> > > >
> > > > ovl_link() did not create a new inode after commit
> > > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > > in ovl_create_or_link() we should not override cred's
> > > > fsuid and fsgid when called by ovl_link().
> > > >
> > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > > ---
> > > >  fs/overlayfs/dir.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > index 6b03457f72bb..568d338032db 100644
> > > > --- a/fs/overlayfs/dir.c
> > > > +++ b/fs/overlayfs/dir.c
> > > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *de=
ntry, struct inode *inode,
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
> > > > --
> > >
> > > This change looks incorrect.
> > > Unless I am missing something, fsuid/fsgid still need to
> > > be overridden for calling link() on underlying fs.
> > > What made you do this change?
> > >
> > > Thanks,
> > > Amir.
> >
> > Hi Amir,
> >
> > I ran into an error when I tested overlay on fuse:
> >   $ mkdir /lower /fuse /merge
> >   $ mount -t fuse /fuse
> >   $ mkdir /fuse/upper /fuse/work
> >   $ mount -t overlay /merge -o lowerdir=3D/lower,upperdir=3D/fuse/upper=
,workdir=3Dwork
> >   $ touch /merge/file
> >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> >   $ ln /merge/file /merge/lnkfile
> >
> > Then I got an error(EACCES) because fuse daemon checks the link()'s
> > caller is "bin", it denied this request.
> > I browsed the changing history of ovl_link(). There are two key commits=
:
> > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> > overrides the cred's fsuid/fsgid using the new inode. The new inode's
> > owner is initialized by inode_init_owner(), and inode->fsuid is
> > assigned to the current user. So the override fsuid becomes the
> > current user. We know link() is actually modifying the directory, so
> > the caller must have the MAY_WRITE permission on the directory. The
> > current caller may should have this permission. I think this is
> > acceptable to use the caller's fsuid(But I still feel a little
> > conflicted with the overlay's design).
> > The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> > which removed the inode creation in ovl_link(). This commit move
> > inode_init_owner() into ovl_create_object(), so the ovl_link() just
> > give the old inode to ovl_create_or_link(). Then the override fsuid
> > becomes the old inode's fsuid, neither the caller nor the overlay's
> > creator! So I think this is incorrect.
> > I think the link() should be like unlink(), overlay fs should just use
> > the creator cred to do underlying fs's operations.
> >
>
> I see. The reproducer and explanation belong in the commit message.
>
> Your argument makes sense to me, but CC Christian to make
> sure I am not missing anything related to ACLs and what not.

Once again with correct email address...

>
> Thanks,
> Amir.
