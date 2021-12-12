Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9D1471B75
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 16:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhLLPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhLLPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 10:51:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44197C061714;
        Sun, 12 Dec 2021 07:51:48 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 13so20377391ljj.11;
        Sun, 12 Dec 2021 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsLzc8H+GZEt3KOwearXOutXvaRaNgkbn2EA2Jl4464=;
        b=KDWtFqtVrDLPXuAZeJTCfEBgi9b6C9o1WUBoeqQJPNll8R7RqeiIXYme+HYIcZwRl5
         xuiBKE8NCR5em7CAw6IkndCTXAstCwQwDzBHnzyR2+bKkxdL3rTBO0JnyVk5OEQ8J9tj
         GjVDBWW8opJY6wwkezB9q2uzoqh8+hPefxKDY+ZoNJ2Qk+nNWHA6krz23vfJYUGS82HD
         8fXGkmXQeES/Y3Rei1pRGx+5AZ41Wq9p9qaomIrLfBcjyQOT6kVyigmz8mPUdvhubsRr
         kcbM/HyNddgRUDB0ubswOMBYTHye6FBh27T3Ioe7RlstJw05zr2RXcImAnwe+39LJ+eR
         0zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsLzc8H+GZEt3KOwearXOutXvaRaNgkbn2EA2Jl4464=;
        b=qodtLYzCs5k/mdn/T8Sy5faAB+VltcuOC+gt7dY1daE79Wuzin0+lGorPb9+oDA3kb
         EjnKiizDeVrSIYvkX/qrOVmXWcFPxr1NVqSEdj5tUY+98gybmE2XA0gcpo/R6iw2ksCY
         yNNEyPB3dD6TYe/Z4UQnzhFwKYsLuWiXQU5tHOPIdZx8+UDj/AuiLHigTPaBktmbq+0k
         GWKU3ynQ5dLs96EQ0CloGrxCZge7eXdJXAsXHP/rh/u4sg48IpFKAuNT3GNYwuL3qHvC
         IigWMEhQNfonTCj3GsAi/oZWgPqXTKHB/KKVSBpjM3jrg57mfV4RbbJLxT8sChFZL/R5
         5EPg==
X-Gm-Message-State: AOAM533jOkdgf27uZxCBuWQvOz3J0jBsQIM+a4hje/HO402T6xJQ6le9
        8A83nPmYAZJkSwcZ0K7Yg4hYiXPvolWK7QuS4Kk=
X-Google-Smtp-Source: ABdhPJyIEJGRkABCcxcHDH8NGnxW9Cq01811rNfomHL57m4I3W/hV/yodFWeaF9JzHZPiwVn49yvvR15VbhH31wSnP8=
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr24839371lji.330.1639324306165;
 Sun, 12 Dec 2021 07:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20211211180955.550380-1-colin.i.king@gmail.com>
In-Reply-To: <20211211180955.550380-1-colin.i.king@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 13 Dec 2021 00:51:34 +0900
Message-ID: <CAKFNMokO9CA6n2veR9JOg7CbzvgUc6rDMofOu2aiU+CDTTsjoA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: remove redundant pointer sbufs
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 3:09 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Pointer sbufs is being assigned a value but it's not being used
> later on. The pointer is redundant and can be removed. Cleans up
> scan-build static analysis warning:
>
> fs/nilfs2/page.c:203:8: warning: Although the value stored to 'sbufs'
> is used in the enclosing expression, the value is never actually read
> from 'sbufs' [deadcode.DeadStores]
>         sbh = sbufs = page_buffers(src);
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Looks good.
Will apply, thank you.

Ryusuke Konishi

> ---
>  fs/nilfs2/page.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index bc3e2cd4117f..063dd16d75b5 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -195,12 +195,12 @@ void nilfs_page_bug(struct page *page)
>   */
>  static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
>  {
> -       struct buffer_head *dbh, *dbufs, *sbh, *sbufs;
> +       struct buffer_head *dbh, *dbufs, *sbh;
>         unsigned long mask = NILFS_BUFFER_INHERENT_BITS;
>
>         BUG_ON(PageWriteback(dst));
>
> -       sbh = sbufs = page_buffers(src);
> +       sbh = page_buffers(src);
>         if (!page_has_buffers(dst))
>                 create_empty_buffers(dst, sbh->b_size, 0);
>
> --
> 2.33.1
>
