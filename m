Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13D596A83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiHQHh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiHQHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:36:52 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190B575CF6;
        Wed, 17 Aug 2022 00:36:51 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id w129so6295571vkg.10;
        Wed, 17 Aug 2022 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D+Wh1I5cqYGHkslt4DZh0xiKf9lFC9rLAk9e5WpFHyg=;
        b=JriSE6+ITnwaiATCLk/li/D3cJh+MrPNSAqg++zkwSeVz1YuWXWMjUzlL0DCriToKS
         ZSBRkRmD3lu5QkHnHTzgAgbigMF7I7vXhfv6F62stI7fus8uy7QdkAUJ02bHEt35olUW
         A246owdZ/kPd3EuodDe9zpr54GE05vjA3swexo+RBBZKSDmIs5w8BtQhPaw6aEBAdgxL
         +O3KhaHiszL5st0XsmRitmOIkmLmiiq4iMgEuLq7MDPWypjdg3c/GWo89LAbmTmBkH5X
         pE9XjYVg6WjD6eJUFUe2w5ZEVhzNh5YdWcONgAS7js04rC7FKizPNUUlr1xpJYz/5aHd
         uJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D+Wh1I5cqYGHkslt4DZh0xiKf9lFC9rLAk9e5WpFHyg=;
        b=uwc4Wy9UhzvShjg3h/qzqSyl13hSgr/WoP/ZivT8hwM5QNz26248+kgOYpI1g/b0Lg
         +FS4DCtTp8UAfByXep6X/TKlKNOpD1gcv9dVMvF4sux43gmpStrq6za7XMsxVIlBlF/A
         +7Sd4uyvhdG0J4TZcn1fXwaJcun6/AO2/N3hg1WyPewI9gE/YkyNxVK8gKe8KyqSzlqI
         t61LzAPQO75ZnHIq7rR4s+330jo9LOBeCfCnfO+DQAM0qFRW/CUjC+pU/OWNg2RfdSRB
         AF6QVj9y1m2G4M/wVWYvGmdpaH2ovGmf+aNrHHjm4OkuhA0QTwOMiGTGJNTuEuDjZ+fW
         1Xhg==
X-Gm-Message-State: ACgBeo2liHVPbNqYbdXH0ZYBiGyqa+k7Dy58gaxyuOkqAyFdvsi5Uhah
        iuaGLa+3MbdpDe51swACpJiOin5uOlQ8shGHipU=
X-Google-Smtp-Source: AA6agR6zgFS8IrrsDxylcSN0kOwJ5QleEDT3hb+MEc8EMNfrXnySAOpVUZeiWmPr2mOKs7WuMUEUsQCk1nlXhhTnPmM=
X-Received: by 2002:a1f:2d06:0:b0:380:679d:fb9b with SMTP id
 t6-20020a1f2d06000000b00380679dfb9bmr2641716vkt.25.1660721810173; Wed, 17 Aug
 2022 00:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Aug 2022 10:36:38 +0300
Message-ID: <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
Subject: Re: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
To:     Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> ovl_link() did not create a new inode after commit
> 51f7e52dc943 ("ovl: share inode for hard link"), so
> in ovl_create_or_link() we should not override cred's
> fsuid and fsgid when called by ovl_link().
>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/overlayfs/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..568d338032db 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>         err = -ENOMEM;
>         override_cred = prepare_creds();
>         if (override_cred) {
> -               override_cred->fsuid = inode->i_uid;
> -               override_cred->fsgid = inode->i_gid;
>                 if (!attr->hardlink) {
> +                       override_cred->fsuid = inode->i_uid;
> +                       override_cred->fsgid = inode->i_gid;
>                         err = security_dentry_create_files_as(dentry,
>                                         attr->mode, &dentry->d_name, old_cred,
>                                         override_cred);
> --

This change looks incorrect.
Unless I am missing something, fsuid/fsgid still need to
be overridden for calling link() on underlying fs.
What made you do this change?

Thanks,
Amir.
