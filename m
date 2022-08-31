Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1B5A7F20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiHaNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiHaNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA1D3EFC;
        Wed, 31 Aug 2022 06:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CA2AB8211D;
        Wed, 31 Aug 2022 13:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A5C433D6;
        Wed, 31 Aug 2022 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661953412;
        bh=hdPPXuEIy2Rz52l1BNA3Pe9+/enFKPbopocRtFZZN3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEWURXxaGaWGPXoTurSkCKMeJ8vQAHUfyMsYTzLSyteOmAwKYhoDZ06XGbS5Hpl1Z
         Fu2s2EgOlcC9VPxekueBvL/8YNPTwhOzSDBkUVm6mDaFdkvj8u6gdVBXoXkWhbni90
         r0W4dJ6UDB8mVf5VoSqTGPUFilNRpw5GqsgG0EDAGHNA5PTM6eFT8Fc59hEwZXQRK/
         6vobedqP7Mr5EjhSMDN2OyP5Q5x35gmsgbe9yyBj613UFTG4Hpm47/XTmRzyhXo69K
         90TzsXinRgJV39ldrFPXxvrvu88aNTySUaTE8MzhSjWtNnIuep6c5rKyUDnyXo/OUd
         MSuPyXlMEy4/Q==
Date:   Wed, 31 Aug 2022 15:43:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH v2] ovl: Use current fsuid and fsgid in ovl_link()
Message-ID: <20220831134327.dria7um4bhpk62mn@wittgenstein>
References: <20220825130552.29587-1-zhangtianci.1997@bytedance.com>
 <CAJfpegsAOJmT=9FdanDVA_s5xF3iy9ccXxmin4cKW9-XxKG3xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsAOJmT=9FdanDVA_s5xF3iy9ccXxmin4cKW9-XxKG3xQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:00:18PM +0200, Miklos Szeredi wrote:
> On Thu, 25 Aug 2022 at 15:08, Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > There is a wrong case of link() on overlay:
> >   $ mkdir /lower /fuse /merge
> >   $ mount -t fuse /fuse
> >   $ mkdir /fuse/upper /fuse/work
> >   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,\
> >     workdir=work
> >   $ touch /merge/file
> >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> >   $ ln /merge/file /merge/lnkfile
> >
> > Then we will get an error(EACCES) because fuse daemon checks the link()'s
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
> > Link: https://lore.kernel.org/all/20220817102951.xnvesg3a7rbv576x@wittgenstein/T
> >
> > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >  fs/overlayfs/dir.c       | 16 +++++++++++-----
> >  fs/overlayfs/overlayfs.h |  2 ++
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 6b03457f72bb..dd84e6fc5f6e 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> >         err = -ENOMEM;
> >         override_cred = prepare_creds();
> >         if (override_cred) {
> > -               override_cred->fsuid = inode->i_uid;
> > -               override_cred->fsgid = inode->i_gid;
> > +               override_cred->fsuid = attr->fsuid;
> > +               override_cred->fsgid = attr->fsgid;
> >                 if (!attr->hardlink) {
> >                         err = security_dentry_create_files_as(dentry,
> >                                         attr->mode, &dentry->d_name, old_cred,
> > @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
> >         inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
> >         attr.mode = inode->i_mode;
> >
> > +       attr.fsuid = inode->i_uid;
> > +       attr.fsgid = inode->i_gid;
> >         err = ovl_create_or_link(dentry, inode, &attr, false);
> >         /* Did we end up using the preallocated inode? */
> >         if (inode != d_inode(dentry))
> > @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
> >  {
> >         int err;
> >         struct inode *inode;
> > +       struct ovl_cattr attr;
> >
> >         err = ovl_want_write(old);
> >         if (err)
> > @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
> >         inode = d_inode(old);
> >         ihold(inode);
> >
> > -       err = ovl_create_or_link(new, inode,
> > -                       &(struct ovl_cattr) {.hardlink = ovl_dentry_upper(old)},
> > -                       ovl_type_origin(old));
> > +       attr = (struct ovl_cattr) {
> > +               .hardlink = ovl_dentry_upper(old),
> > +               .fsuid = current_fsuid(),
> > +               .fsgid = current_fsgid(),
> > +       };
> 
> Why do we need to override fsuid/fsgid for the hardlink case?
> 
> Wouldn't it be simpler to just use the mounter's creds unmodified in
> this case?   The inode is not created in this case, so overriding with
> current uid/gid is not necessary, I think.
> 
> Another way to look at it is: rename(A, B) is equivalent to an
> imaginary atomic [link(A, B) + unlink(A)] pair.  But we don't override
> uid/gid for rename() or unlink() so why should we for link().

So my assumption has been that we want to override for any creation
request and so for the sake of consistency I would've expected to also
use that for ->link(). Plus, this is also what has been done before the
commit  51f7e52dc943 ("ovl: share inode for hard link") iiuc.

Fwiw, I would've opted for consistency and even use the caller's
fs{g,u}id during ->rename() and ->unlink().

Right now the caller's fs{g,u}id - indirectly through inode_init_owner()
- is used to ensure that the ownership of newly created files in the
upper layer are based on the caller's not on the mounter's fs{g,u}id
afaict. If we continue to only override for those cases it would really
help that we document this in a good comment in ovl_create_or_link().
