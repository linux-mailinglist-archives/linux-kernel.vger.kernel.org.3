Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6A536D25
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiE1Nml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiE1Nmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:42:39 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6E5FD5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:42:38 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h188so2422045oia.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKpNSqmJyc1shBqMlT5prVldbUvob7Rd4vFWEPuuWto=;
        b=fjVmfPSNYRpqwphaGhURNuDnDdgHyg/WoDK1VtYpkAMM18CoBqGxan49lp6lT/2Kih
         EmlLReFpHH94QEjOjNK4R0/3XY5ds77+tEx5EREvT8FhaJU1clSFYe00oZalvmd8E2Xl
         tarFK9WQKu62Xbx6/fB0g6NYFSqh4Aab3DSdF6+HMzOCq0C9AT9GNhzOFrOtbPT73Rr4
         mjxvizPCqNdPqTm+m2VHWr1B3M4JLwlMstZDWi8s1ugy8Ua1aU+yDTnjbGp7MvQHss+a
         GEe3Xb84p5yKgxzF6Nrtm8IgAJ/IWKLo0eVPIlWgHHT8UKBZILMzTfOYElB+MyWHEBlA
         idJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKpNSqmJyc1shBqMlT5prVldbUvob7Rd4vFWEPuuWto=;
        b=Dj6RcDVEn8nMxgZr809WjAZl7BQC5cPOT09+Cy6RICrYVfBrfEJkh3qv5N3AxzgDoN
         Hiztqzgg8EVdGHYkzylUBk1eo3hz9cAPG7U/zovuU82twjszNWJaWSCGhWNn/yWUSrlu
         yP9gGhFoNNP3jYyVro+nZDC1kXIYbidHZBwcT6BjCM/5n67xB1eqqaKigBiiPL+llFxG
         qmDwxRww1BqsbHBs8aKAmE4Fn5vRrkKxScB2TtJjzcf56iZ6zOdg6y7NB2Go9VJW4Y7D
         /ICNt+0zzmzb3vH5+nzqGF/d6Mf9Ik/0KkMp1r+4tDCAEVry/8OT44wPJaAxAC3OiQkF
         ekbQ==
X-Gm-Message-State: AOAM532anX9pFUS2CY8KETRgF3rZIEDwXnRyTcjh2jGkBFz2OUjGIX1T
        QcvfwciLIQwy4y6R+n5XxOT4wDSvIM4ctOQv0rebjVbT/EgDCw==
X-Google-Smtp-Source: ABdhPJwtKUwt73stNMVhFtfOqxAg5fXTLoVWI6r4XBXkcNoRYm8rnSm/ghiol73l5Ix4xXqD10j9UyHI8So3OAUJN9Q=
X-Received: by 2002:a05:6808:20a5:b0:32b:2825:acba with SMTP id
 s37-20020a05680820a500b0032b2825acbamr6206816oiw.283.1653745358037; Sat, 28
 May 2022 06:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220506034656.50038-1-jjm2473@gmail.com> <14b2ae23-2f7b-401a-dcee-cc6114849022@paragon-software.com>
In-Reply-To: <14b2ae23-2f7b-401a-dcee-cc6114849022@paragon-software.com>
From:   =?UTF-8?B?57uD5Lqu5paM?= <jjm2473@gmail.com>
Date:   Sat, 28 May 2022 21:42:26 +0800
Message-ID: <CAP_9mL7O7YyW56HBorZ7727m22NjbQcfcu_J4_XOBoXigQvGCg@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: fix null pointer dereference in d_flags_for_inode
To:     Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
`inode->i_op` already initialized when inode alloc, this bug was
introduced by `inode->i_op = NULL;`, just delete this line.
Please check my patch, maybe it's a better one, I have tested it on my project.

On 5/26/22 18:23, Almaz Alexandrovich wrote:
>
> Hello.
>
> Thank you for reporting this bug.
> The bug happens because we don't initialize i_op for records in $Extend.
> We tested patch on our side, let me know if patch helps you too.
>
>      fs/ntfs3: Fix missing i_op in ntfs_read_mft
>
>      There is null pointer dereference because i_op == NULL.
>      The bug happens because we don't initialize i_op for records in $Extend.
>      Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
>
>      Reported-by: Liangbin Lian <jjm2473@gmail.com>
>      Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 879952254071..b2cc1191be69 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -430,6 +430,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>          } else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
>                     fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
>                  /* Records in $Extend are not a files or general directories. */
> +               inode->i_op = &ntfs_file_inode_operations;
>          } else {
>                  err = -EINVAL;
>                  goto out;
>
>
> On 5/6/22 06:46, Liangbin Lian wrote:
> > ntfs_read_mft may return inode with null i_op, cause null pointer dereference in d_flags_for_inode (inode->i_op->get_link).
> > Reproduce:
> >   - sudo mount -t ntfs3 -o loop ntfs.img ntfs
> >   - ls ntfs/'$Extend/$Quota'
> >
> > The call trace is shown below (striped):
> >   BUG: kernel NULL pointer dereference, address: 0000000000000008
> >   CPU: 0 PID: 577 Comm: ls Tainted: G           OE     5.16.0-0.bpo.4-amd64 #1  Debian 5.16.12-1~bpo11+1
> >   RIP: 0010:d_flags_for_inode+0x65/0x90
> >   Call Trace:
> >   ntfs_lookup
> >   +--- dir_search_u
> >   |    +--- ntfs_iget5
> >   |         +--- ntfs_read_mft
> >   +--- d_splice_alias
> >        +--- __d_add
> >             +--- d_flags_for_inode
> >
> > Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> > ---
> >   fs/ntfs3/inode.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> > index 9eab11e3b..b68d26fa8 100644
> > --- a/fs/ntfs3/inode.c
> > +++ b/fs/ntfs3/inode.c
> > @@ -45,7 +45,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
> >       struct MFT_REC *rec;
> >       struct runs_tree *run;
> >
> > -     inode->i_op = NULL;
> >       /* Setup 'uid' and 'gid' */
> >       inode->i_uid = sbi->options->fs_uid;
> >       inode->i_gid = sbi->options->fs_gid;
