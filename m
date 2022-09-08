Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8F5B12F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHDb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIHDbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:31:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6FC7435
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:31:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x14so10228738lfu.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 20:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KaoFc74GmRSLfr2we5jMwmRErDrqJp9U9XXRXD2HWw4=;
        b=T7O9HsOFEMK4XPHbLXga9V9XLxi/foOiup5gNWksgalQzWyuigBR4K8/e+4JGRBgUP
         W/1quQczCZX9I561s6zZOTx5nKMAfJhQh5Eiu7nUaSjLdxcjclVRFNyYEQYHY0HUNI9g
         WRxwnY5qYSVxuHDREb7RA+4X7a5Mqf2YGaqg0sitSVUf8f7Tp7xTLxgqBcbaOvE2MXWS
         wtpW/DMbGqa72eLcRD+9lWY1oqkRJ7nKNahxaATeAhLO5v7TrRmFaGUO3ce8S7mqtf8z
         IzO8MyVFfygX6BxsSJqyRSfYfeYptEyCWpowOETdnUlpk8EmIznyhcvn2Q+zdk2JG91A
         oZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KaoFc74GmRSLfr2we5jMwmRErDrqJp9U9XXRXD2HWw4=;
        b=NP0NmsMM1TpUBjfKu6if9BQEiC9szQlqOcNq00glTbnE9hQXY8X2/8ZPAa/p1COaZh
         O2GHhvGO5fd0DNV/1YERoa2lI+iYxDaiqMUc5OZSS7oFkN95+Er/WqnjsQZhDiFWQrhw
         UaqGSH61Csx5S1elzAcRK4S2E6RnNb6B6vbqIhKdZ6PeHrRxxM1rxBEgSHCjFPGXzsEc
         FWSdmcA5v4iquA1O2gDvdIgoh+nCNxA2V2BJsrK8psHn11SJP0kyLEBntj9MGrjJZ7GV
         DjiCA1PMuqdsUU9vZmhmWakBj9FcxaVdYGrBoleers0yCJuUQVY2PgATw87ZOzKXNKmg
         BsVA==
X-Gm-Message-State: ACgBeo10g9vD3JPQukwHr79fG/zjVTWiz0hnAXoxqpNc/ZrwoVPM39fL
        BHKPUJBDdQIWuX3zrN/zT/tnSf44ZyYjmiEkETyXcA==
X-Google-Smtp-Source: AA6agR4g4eNK25Uc91F9VeyGTJ2sIz4k+g+D4tzhNWI5fVTlxBI9NxJoHbk9hq7VkDZtwb+frPNXa0tbZ8atz9Qjeog=
X-Received: by 2002:ac2:4a61:0:b0:497:ae0c:4f66 with SMTP id
 q1-20020ac24a61000000b00497ae0c4f66mr766564lfp.660.1662607911503; Wed, 07 Sep
 2022 20:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
Date:   Thu, 8 Sep 2022 11:31:40 +0800
Message-ID: <CAP4dvsf9sMmsT2opNxKYk-37FUVaLJcYTuMVeVhVfTjAKpV5OA@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: Use ovl mounter's fsuid and fsgid in ovl_link()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 4:29 PM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> There is a wrong case of link() on overlay:
>   $ mkdir /lower /fuse /merge
>   $ mount -t fuse /fuse
>   $ mkdir /fuse/upper /fuse/work
>   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,\
>     workdir=work
>   $ touch /merge/file
>   $ chown bin.bin /merge/file // the file's caller becomes "bin"
>   $ ln /merge/file /merge/lnkfile
>
> Then we will get an error(EACCES) because fuse daemon checks the link()'s
> caller is "bin", it denied this request.
>
> In the changing history of ovl_link(), there are two key commits:
>
> The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> overrides the cred's fsuid/fsgid using the new inode. The new inode's
> owner is initialized by inode_init_owner(), and inode->fsuid is
> assigned to the current user. So the override fsuid becomes the
> current user. We know link() is actually modifying the directory, so
> the caller must have the MAY_WRITE permission on the directory. The
> current caller may should have this permission. This is acceptable
> to use the caller's fsuid.
>
> The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> which removed the inode creation in ovl_link(). This commit move
> inode_init_owner() into ovl_create_object(), so the ovl_link() just
> give the old inode to ovl_create_or_link(). Then the override fsuid
> becomes the old inode's fsuid, neither the caller nor the overlay's
> mounter! So this is incorrect.
>
> Fix this bug by using ovl mounter's fsuid/fsgid to do underlying
> fs's link().
>
> v1: https://lore.kernel.org/all/20220817102952.xnvesg3a7rbv576x@wittgenstein/T
> v2: https://lore.kernel.org/lkml/20220825130552.29587-1-zhangtianci.1997@bytedance.com/t
>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/overlayfs/dir.c | 46 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..c3032cef391e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -592,28 +592,42 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>                         goto out_revert_creds;
>         }
>
> -       err = -ENOMEM;
> -       override_cred = prepare_creds();
> -       if (override_cred) {
> +       if (!attr->hardlink) {
> +               err = -ENOMEM;
> +               override_cred = prepare_creds();
> +               if (!override_cred)
> +                       goto out_revert_creds;
> +               /*
> +                * In the creation cases(create, mkdir, mknod, symlink),
> +                * ovl should transfer current's fs{u,g}id to underlying
> +                * fs. Because underlying fs want to initialize its new
> +                * inode owner using current's fs{u,g}id. And in this
> +                * case, the @inode is a new inode that is initialized
> +                * in inode_init_owner() to current's fs{u,g}id. So use
> +                * the inode's i_{u,g}id to override the cred's fs{u,g}id.
> +                *
> +                * But in the other hardlink case, ovl_link() does not
> +                * create a new inode, so just use the ovl mounter's
> +                * fs{u,g}id.
> +                */
>                 override_cred->fsuid = inode->i_uid;
>                 override_cred->fsgid = inode->i_gid;
> -               if (!attr->hardlink) {
> -                       err = security_dentry_create_files_as(dentry,
> -                                       attr->mode, &dentry->d_name, old_cred,
> -                                       override_cred);
> -                       if (err) {
> -                               put_cred(override_cred);
> -                               goto out_revert_creds;
> -                       }
> +               err = security_dentry_create_files_as(dentry,
> +                               attr->mode, &dentry->d_name, old_cred,
> +                               override_cred);
> +               if (err) {
> +                       put_cred(override_cred);
> +                       goto out_revert_creds;
>                 }
>                 put_cred(override_creds(override_cred));
>                 put_cred(override_cred);
> -
> -               if (!ovl_dentry_is_whiteout(dentry))
> -                       err = ovl_create_upper(dentry, inode, attr);
> -               else
> -                       err = ovl_create_over_whiteout(dentry, inode, attr);
>         }
> +
> +       if (!ovl_dentry_is_whiteout(dentry))
> +               err = ovl_create_upper(dentry, inode, attr);
> +       else
> +               err = ovl_create_over_whiteout(dentry, inode, attr);
> +
>  out_revert_creds:
>         revert_creds(old_cred);
>         return err;
> --
> 2.32.1 (Apple Git-133)
>

Hello Miklos,

Gentle ping...

Thanks,
Tianci
