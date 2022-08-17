Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C548596C56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiHQJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiHQJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:53:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD4353018;
        Wed, 17 Aug 2022 02:53:56 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 67so12651373vsv.2;
        Wed, 17 Aug 2022 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Ijh4v4cvdH5u6/rzdvvm0sI3IanTIWCmgzh7YAitTAk=;
        b=ItN0A7MVBot24mVuOaqqZ9AzQQWIqzciTojxYI2SuVrfdLerfoIghZI+BMjrTwUs4E
         kKoT0knK8zh1HB9GZVrXSNCi1j3NQURMnZfI0+mE7h3vPkrsPcnZvM0xh9693yR+VEyQ
         Kd7YWwu5avCHnQd0NIL4PmOO7CVAdQMXfUQufLAkWe+8IHruX0l3zA1N2LiySmtUfh5c
         OAfSYRLD2X12TU51k//MBUl5unWT+zZlDCkF4KO6WLuzoFapmmJ3BNJQUrZZW3MMzNbm
         A0Fkbjt/oCrIiLEywJXZouF/cLT5WOnuBuVg0wEC1y1/ripvCh1gJ1HnfdoOsxdJSQTi
         Lu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Ijh4v4cvdH5u6/rzdvvm0sI3IanTIWCmgzh7YAitTAk=;
        b=p/ovPuseoO35SPJMGAV6xuCqOUzcEo2Ab3f2Yd6yfub+Su9PYwrmu0jc+tpseGs5Nf
         lfeBb8drgiOYvQCh9DwmQi6Come1z+vUkXtVOhA6YWnz0DRZ8va3ujBIB+txezJzEcvW
         sDVRKBlXVNZsg6xzQN5mFgTy1QUxCMyPS8j03PCyz6Y++zNZbUNJ+tv0Ky35xXGx9Ytf
         wbsv3LawOrXJhMsqEY/a+pgWtOwiMjP5ND2cPcHW8uWPwtktLZlideeCTQ+r3t6Z3kqp
         jfOHFDvv3XqjA8skpaESugSlXmpcfx3uMnmBX9ZXH1rCgfrBl/X++kiwvIM8cAJEO/n4
         nSAA==
X-Gm-Message-State: ACgBeo1OyH3ef1wXG+qLvvZ5JBUg56Uv53oZh/6QAS0AG1oZ/02cPhuB
        yqoUqlTYestKVHWreHaCG8u+dS/mOha5TIjYZOdmLZ1C
X-Google-Smtp-Source: AA6agR6N4EWyoxj2Z2mzIw02ZaD6Zl8zB8A2VvkCtftQYWLjzzQZggG4ZyWrWKR7KL2BUeuxeFVjogrfk8s+ABvbMOE=
X-Received: by 2002:a67:ec57:0:b0:388:d564:3ae9 with SMTP id
 z23-20020a67ec57000000b00388d5643ae9mr9911913vso.71.1660730035660; Wed, 17
 Aug 2022 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com> <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
In-Reply-To: <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Aug 2022 12:53:44 +0300
Message-ID: <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
To:     =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
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

On Wed, Aug 17, 2022 at 12:11 PM =E5=A4=A9=E8=B5=90=E5=BC=A0 <zhangtianci.1=
997@bytedance.com> wrote:
>
> On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > <zhangtianci.1997@bytedance.com> wrote:
> > >
> > > ovl_link() did not create a new inode after commit
> > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > in ovl_create_or_link() we should not override cred's
> > > fsuid and fsgid when called by ovl_link().
> > >
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > ---
> > >  fs/overlayfs/dir.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index 6b03457f72bb..568d338032db 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dent=
ry, struct inode *inode,
> > >         err =3D -ENOMEM;
> > >         override_cred =3D prepare_creds();
> > >         if (override_cred) {
> > > -               override_cred->fsuid =3D inode->i_uid;
> > > -               override_cred->fsgid =3D inode->i_gid;
> > >                 if (!attr->hardlink) {
> > > +                       override_cred->fsuid =3D inode->i_uid;
> > > +                       override_cred->fsgid =3D inode->i_gid;
> > >                         err =3D security_dentry_create_files_as(dentr=
y,
> > >                                         attr->mode, &dentry->d_name, =
old_cred,
> > >                                         override_cred);
> > > --
> >
> > This change looks incorrect.
> > Unless I am missing something, fsuid/fsgid still need to
> > be overridden for calling link() on underlying fs.
> > What made you do this change?
> >
> > Thanks,
> > Amir.
>
> Hi Amir,
>
> I ran into an error when I tested overlay on fuse:
>   $ mkdir /lower /fuse /merge
>   $ mount -t fuse /fuse
>   $ mkdir /fuse/upper /fuse/work
>   $ mount -t overlay /merge -o lowerdir=3D/lower,upperdir=3D/fuse/upper,w=
orkdir=3Dwork
>   $ touch /merge/file
>   $ chown bin.bin /merge/file // the file's caller becomes "bin"
>   $ ln /merge/file /merge/lnkfile
>
> Then I got an error(EACCES) because fuse daemon checks the link()'s
> caller is "bin", it denied this request.
> I browsed the changing history of ovl_link(). There are two key commits:
> The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> overrides the cred's fsuid/fsgid using the new inode. The new inode's
> owner is initialized by inode_init_owner(), and inode->fsuid is
> assigned to the current user. So the override fsuid becomes the
> current user. We know link() is actually modifying the directory, so
> the caller must have the MAY_WRITE permission on the directory. The
> current caller may should have this permission. I think this is
> acceptable to use the caller's fsuid(But I still feel a little
> conflicted with the overlay's design).
> The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> which removed the inode creation in ovl_link(). This commit move
> inode_init_owner() into ovl_create_object(), so the ovl_link() just
> give the old inode to ovl_create_or_link(). Then the override fsuid
> becomes the old inode's fsuid, neither the caller nor the overlay's
> creator! So I think this is incorrect.
> I think the link() should be like unlink(), overlay fs should just use
> the creator cred to do underlying fs's operations.
>

I see. The reproducer and explanation belong in the commit message.

Your argument makes sense to me, but CC Christian to make
sure I am not missing anything related to ACLs and what not.

Thanks,
Amir.
