Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8147594DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351333AbiHPA21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355808AbiHPA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:26:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A35A924F;
        Mon, 15 Aug 2022 13:34:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a9so12088606lfm.12;
        Mon, 15 Aug 2022 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=edBKqiVnU84WIOC5Qmj5Rk7CwLqtESwhF2nX0tSKFBo=;
        b=qDe9CTkaYOZ8QfGGEZWgKVaU6v0Be3OJaGRxWiA/Gip12e6+QSOm7BQy8NHS99Vl8J
         kXXaVp08xA725DVH0WEKUkl78emxsl++Z3MJcrsXhCwFqS2RXGm/EtgApd0XVgzPAMoS
         oRI1c9StJ748f73evLhknd1xfoYVYNwDof8RD9eIwRyQLGtbT+aBz7JkFmqzuIF9yMTf
         IXBNbxmV7HGZ/v4REGo8UHR2FSjhqZM69UdtlwAXn3Gs0HEuFUvPZDs40ldPpnGMKard
         fqb4EQtz2g8ELtQt/xXaTs74RDZaMeOiBS88ZkTW3crVT6mod5gWWU7dXKcuK8KV+NSC
         Hghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=edBKqiVnU84WIOC5Qmj5Rk7CwLqtESwhF2nX0tSKFBo=;
        b=llMdcaq1lQJ2uO9FU88lRPWunx0elrFuC79juaOTVKDNFr1UC4X3zU7/epQ5rZIe+z
         a2FoRiyeMX+HaT9m2RU1tN3AlSiQXshEqHEyXT7MFvco2IDEbcCDNh59n7LD2yxBf0IT
         3lZLg9muyehdIxSJa2F6yf5dPm8RBmPWj2AVyYxAH2ts3im1zWnGCSMKNf7BcwJR/ckM
         EN7P415pbKzgYlzny1e04oPaUmtikBhj3Gt7+HGC7mNpqhFEcmRcA0/yZlw9puCY9HO8
         SDOVat4l+Lha/xenwZQOxAmDR78oT57T3f/doTnx3csUVKbfDHR+1HGVQeq5LhMMkdJq
         ESXg==
X-Gm-Message-State: ACgBeo2flfr1YucvyKzE4KYn3HsHN6C/Y07NWEYZ5ZC2aJZ4f/LhhYZo
        E0xT0K9QOTNq+UdSpyraVF5UsIFQQkRtkpUHnJU=
X-Google-Smtp-Source: AA6agR5vM+UNSRwhLs/v9HbarggElOPYzJ7rZD9sUdiNhmBn1UguMr3CWEt1kQ40IUwrV94Dd/Kuy0+PDwLsh239dcA=
X-Received: by 2002:a05:6512:308a:b0:48b:4dd:5362 with SMTP id
 z10-20020a056512308a00b0048b04dd5362mr6146081lfd.575.1660595670001; Mon, 15
 Aug 2022 13:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220815175114.23576-1-konishi.ryusuke@gmail.com> <YvqP/f2P2YgIIO9U@ZenIV>
In-Reply-To: <YvqP/f2P2YgIIO9U@ZenIV>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 16 Aug 2022 05:34:12 +0900
Message-ID: <CAKFNMomyjXpsz-=BtG+G3q1J7CFUBMEfP13FfxwhWB==9qb++w@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiacheng Xu <stitch@zju.edu.cn>,
        Mudong Liang <mudongliangabcd@gmail.com>
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

On Tue, Aug 16, 2022 at 3:27 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 16, 2022 at 02:51:14AM +0900, Ryusuke Konishi wrote:
> > In alloc_inode(), inode_init_always() could return -ENOMEM if
> > security_inode_alloc() fails.  If this happens for nilfs2,
> > nilfs_free_inode() is called without initializing inode->i_private and
> > nilfs_free_inode() wrongly calls nilfs_mdt_destroy(), which frees
> > uninitialized inode->i_private and can trigger a crash.
> >
> > Fix this bug by initializing inode->i_private in nilfs_alloc_inode().
> >
> > Link: https://lkml.kernel.org/r/CAFcO6XOcf1Jj2SeGt=jJV59wmhESeSKpfR0omdFRq+J9nD1vfQ@mail.gmail.com
> > Link: https://lkml.kernel.org/r/20211011030956.2459172-1-mudongliangabcd@gmail.com
> > Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Reported-by: Jiacheng Xu <stitch@zju.edu.cn>
> > Reported-by: Mudong Liang <mudongliangabcd@gmail.com>
> > Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/nilfs2/super.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> > index ba108f915391..aca5614f1b44 100644
> > --- a/fs/nilfs2/super.c
> > +++ b/fs/nilfs2/super.c
> > @@ -159,6 +159,7 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
> >       ii->i_cno = 0;
> >       ii->i_assoc_inode = NULL;
> >       ii->i_bmap = &ii->i_bmap_data;
> > +     ii->vfs_inode.i_private = NULL;
> >       return &ii->vfs_inode;
> >  }
>
> FWIW, I think it's better to deal with that in inode_init_always(), but
> not just moving ->i_private initialization up - we ought to move
> security_inode_alloc() to the very end.  No sense playing whack-a-mole
> with further possible bugs of that sort...

Yes, I agree it's better if security_inode_alloc() is moved to the end as
possible in the sense of avoiding similar issues.
But, would that vfs change be safe to backport to stable trees?

It looks like the error handling for security_inode_alloc()  is in the
middle of inode_init_always() for a very long time..

If you want to see the impact of the vfs change, I think it's one way
to apply this one in advance.  Or if you want to fix it in one step,
I think it's good too.  How do you feel about this ?

Thanks,
Ryusuke Konishi
