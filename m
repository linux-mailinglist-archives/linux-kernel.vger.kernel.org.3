Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A98529DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiEQJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244904AbiEQJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:16:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4E1EC5E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:16:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c14so16369063pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbT9MivaGcVQLFLyZe58CMZOydl8bMnPHecbxMnGlAA=;
        b=K926XyreguR/4XEGI2/XdLSg8xqkk79XZxpz2krQ3cDJULT8zIyem67TELbGWBtmTg
         b05B8JjUy+SFZn96XQv2wbJdy6P1+68y3XmUl2REMzKOsiCerWpY4gxfkPaXYimAbdMw
         aPDfZjT5rKLnZhvekRWx46Led/eHS37TdbpQ+k2rA3u5jcJAA1qE4EjEdY61h/y1aGDJ
         HwKKYCRVUMiHvXIhC9uLV+1DSufpqUQKWO7jZmK8YgLeFAdxBOwUCCjPXoideDBIZwgv
         +DFJROmmKg7yUnB015J5PHMAo6BmnjJV06lEU25NzkLOxPGGWKOdzM+q3EK1WrqC3yTM
         NXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbT9MivaGcVQLFLyZe58CMZOydl8bMnPHecbxMnGlAA=;
        b=1GTFNaH0ZipH19BdIL9v3fks7Z2JjS2B4gYdGeteVcdEbToYDHz4OS6cws+kTZu4Br
         UHOxTKkVR3WdTVN20UbEN1cmfjJFIamF50gzFB26D4l3OEXbL12fxzme2dOOAKXYz1YJ
         kIxO6tiIaNyUa4qC1a1wLoI7n7l63Y8iTdtUZxZtHd4TcvJ23AiApYifERCCHpKJoecH
         +Vw/vWaAV/kCmw7VDf+eGttRNtiSwWiNEqj11+pc1SK/2MG8Jxmizziz6jrEZuvLBEjq
         o+UgU/f56yuoD3lWlZrvt4JpgwEEmA2VWk7OUVSK7kOtLgkMkAaQEbA6gftySBHuppbX
         qXKA==
X-Gm-Message-State: AOAM533HurWjR7r/KI69ck6EGe/gIoClfEcDSYiHTMet7CSpzW/ifPoJ
        XcQsuv2q7yKLk2PYwEp//hftQyQixuU12DOP39Q=
X-Google-Smtp-Source: ABdhPJwb7TUPydJ5uJgGFBM3zIUz6PP1+ayvhR0HdyDTVVnTuilVTQ3Ohszxg4ss5MiddupCWgYYK0W77rGbKie7r8Q=
X-Received: by 2002:a63:4d4:0:b0:3c1:f13f:a9a1 with SMTP id
 203-20020a6304d4000000b003c1f13fa9a1mr18365793pge.398.1652778984401; Tue, 17
 May 2022 02:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220517082650.2005840-1-hsinyi@chromium.org> <20220517082650.2005840-2-hsinyi@chromium.org>
In-Reply-To: <20220517082650.2005840-2-hsinyi@chromium.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 17 May 2022 17:15:58 +0800
Message-ID: <CAEVVKH8vOYov+edGWOWbrgi=5UAnNN4FzcAV5i3EVJ8S7_NSDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "squashfs: provide backing_dev_info in
 order to disable read-ahead"
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, May 17, 2022 at 4:27 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> This reverts commit 9eec1d897139e5de287af5d559a02b811b844d82.
>
> Revert closing the readahead to squashfs since the readahead callback
> for squashfs is implemented.
>
> Suggested-by: Xiongwei Song <sxwjean@gmail.com>

I'd like to use "xiongwei.song@windriver.com" in my tag.

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  fs/squashfs/super.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
>
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 6d594ba2ed28..32565dafa7f3 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -29,7 +29,6 @@
>  #include <linux/module.h>
>  #include <linux/magic.h>
>  #include <linux/xattr.h>
> -#include <linux/backing-dev.h>
>
>  #include "squashfs_fs.h"
>  #include "squashfs_fs_sb.h"
> @@ -113,24 +112,6 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
>         return decompressor;
>  }
>
> -static int squashfs_bdi_init(struct super_block *sb)
> -{
> -       int err;
> -       unsigned int major = MAJOR(sb->s_dev);
> -       unsigned int minor = MINOR(sb->s_dev);
> -
> -       bdi_put(sb->s_bdi);
> -       sb->s_bdi = &noop_backing_dev_info;
> -
> -       err = super_setup_bdi_name(sb, "squashfs_%u_%u", major, minor);
> -       if (err)
> -               return err;
> -
> -       sb->s_bdi->ra_pages = 0;
> -       sb->s_bdi->io_pages = 0;
> -
> -       return 0;
> -}
>
>  static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> @@ -146,20 +127,6 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>
>         TRACE("Entered squashfs_fill_superblock\n");
>
> -       /*
> -        * squashfs provides 'backing_dev_info' in order to disable read-ahead. For
> -        * squashfs, I/O is not deferred, it is done immediately in read_folio,
> -        * which means the user would always have to wait their own I/O. So the effect
> -        * of readahead is very weak for squashfs. squashfs_bdi_init will set
> -        * sb->s_bdi->ra_pages and sb->s_bdi->io_pages to 0 and close readahead for
> -        * squashfs.
> -        */
> -       err = squashfs_bdi_init(sb);
> -       if (err) {
> -               errorf(fc, "squashfs init bdi failed");
> -               return err;
> -       }
> -
>         sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
>         if (sb->s_fs_info == NULL) {
>                 ERROR("Failed to allocate squashfs_sb_info\n");
> --
> 2.36.0.550.gb090851708-goog
>
>
