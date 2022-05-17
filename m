Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71052529B76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiEQHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiEQHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:52:01 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382351B7A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:51:59 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id ay15so6687669uab.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WShrHtR7o1bEMN+GHtHpoPB1ADyCcz+AwfB1sJZyYR4=;
        b=LOFlwn77BRGGTHQ9iEWKPwBc8EC7NIg2bDsjKTz7PFhls9SUyJa0RoGbGs4i0gbs2h
         FhVaPs5DErd6RbgHLLK0Psn0eW45ltdzDAmbdKIaYF8kbVhy3CrR3d7qdO6TueERI14t
         1nslAb6aebvVqxtyL6KGKnnuTrLo4NW+MwcPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WShrHtR7o1bEMN+GHtHpoPB1ADyCcz+AwfB1sJZyYR4=;
        b=mE0/3OrvYCnjkRXuFwb3ahu7JYnbCGsDWJ2nWA+ASlRJekRstRyYXuTy1a+k3lPlk1
         vD9ACFkVIWslkiIZ7avc4dlyg+yfXflV2eHoSTw+pgXvlCcJHcDn0NhWVhZT84CVjUfv
         CkSlSaqn2NH6kg3RYKyBpEDbHKP6mej9XOCz5jutSF+mb6A3UEWzRAFKJ9alRWBXjfPf
         JyfFXqnZll0Yn7ZGxqb5wM5unEhMZQfoKmXkdprk8xoKIFZgS/F2fMiXOsF6/u0oqgcF
         7ueszcvRbIpkWASeygb7MbU2NItVwbzV5AOber72m1ORlBo3UbJzv1rZkLjogegVp26d
         vlyA==
X-Gm-Message-State: AOAM5302O7nn3IPswa9luUCiwuHAPDDPZ5c8qN3Ckyy94jK02S0uktsy
        Lm41g9RNT/i9lcEDfxKa0Yapa9gF7JN8vZYHI3FgCQ==
X-Google-Smtp-Source: ABdhPJwEplLYKvh+UGWkRWwFL7aUrldDFea1pw9lk57FA3WLEL60dkwzpZTESwKPQX9FIONp5mTUpyvS1luMK3t7Bqs=
X-Received: by 2002:a9f:3193:0:b0:35d:21ec:4ae1 with SMTP id
 v19-20020a9f3193000000b0035d21ec4ae1mr7292105uad.100.1652773918317; Tue, 17
 May 2022 00:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220516105100.1412740-1-hsinyi@chromium.org> <20220517033557.3492-1-phillip@squashfs.org.uk>
In-Reply-To: <20220517033557.3492-1-phillip@squashfs.org.uk>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 17 May 2022 15:51:32 +0800
Message-ID: <CAJMQK-g2G=yDC9GW9Kcpuia+kdOcH_-WpR8xyLvx+5w0BHJJmg@mail.gmail.com>
Subject: Re: [PATCH 3/2] squashfs: always build "file direct" version of page actor
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Xiongwei.Song@windriver.com, akpm@linux-foundation.org,
        houtao1@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, miaoxie@huawei.com,
        squashfs-devel@lists.sourceforge.net, willy@infradead.org,
        yi.zhang@huawei.com, zhengliang6@huawei.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:36 AM Phillip Lougher
<phillip@squashfs.org.uk> wrote:
>
> Squashfs_readahead uses the "file direct" version of the page
> actor, and so build it unconditionally.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested with CONFIG_SQUASHFS_FILE_DIRECT unselected. I'll pick this
patch to the series. Thanks

> ---
>  fs/squashfs/Makefile     |  4 ++--
>  fs/squashfs/page_actor.h | 41 ----------------------------------------
>  2 files changed, 2 insertions(+), 43 deletions(-)
>
> diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
> index 7bd9b8b856d0..477c89a519ee 100644
> --- a/fs/squashfs/Makefile
> +++ b/fs/squashfs/Makefile
> @@ -5,9 +5,9 @@
>
>  obj-$(CONFIG_SQUASHFS) += squashfs.o
>  squashfs-y += block.o cache.o dir.o export.o file.o fragment.o id.o inode.o
> -squashfs-y += namei.o super.o symlink.o decompressor.o
> +squashfs-y += namei.o super.o symlink.o decompressor.o page_actor.o
>  squashfs-$(CONFIG_SQUASHFS_FILE_CACHE) += file_cache.o
> -squashfs-$(CONFIG_SQUASHFS_FILE_DIRECT) += file_direct.o page_actor.o
> +squashfs-$(CONFIG_SQUASHFS_FILE_DIRECT) += file_direct.o
>  squashfs-$(CONFIG_SQUASHFS_DECOMP_SINGLE) += decompressor_single.o
>  squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI) += decompressor_multi.o
>  squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU) += decompressor_multi_percpu.o
> diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
> index 2e3073ace009..26e07373af8a 100644
> --- a/fs/squashfs/page_actor.h
> +++ b/fs/squashfs/page_actor.h
> @@ -6,46 +6,6 @@
>   * Phillip Lougher <phillip@squashfs.org.uk>
>   */
>
> -#ifndef CONFIG_SQUASHFS_FILE_DIRECT
> -struct squashfs_page_actor {
> -       void    **page;
> -       int     pages;
> -       int     length;
> -       int     next_page;
> -};
> -
> -static inline struct squashfs_page_actor *squashfs_page_actor_init(void **page,
> -       int pages, int length)
> -{
> -       struct squashfs_page_actor *actor = kmalloc(sizeof(*actor), GFP_KERNEL);
> -
> -       if (actor == NULL)
> -               return NULL;
> -
> -       actor->length = length ? : pages * PAGE_SIZE;
> -       actor->page = page;
> -       actor->pages = pages;
> -       actor->next_page = 0;
> -       return actor;
> -}
> -
> -static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
> -{
> -       actor->next_page = 1;
> -       return actor->page[0];
> -}
> -
> -static inline void *squashfs_next_page(struct squashfs_page_actor *actor)
> -{
> -       return actor->next_page == actor->pages ? NULL :
> -               actor->page[actor->next_page++];
> -}
> -
> -static inline void squashfs_finish_page(struct squashfs_page_actor *actor)
> -{
> -       /* empty */
> -}
> -#else
>  struct squashfs_page_actor {
>         union {
>                 void            **buffer;
> @@ -76,4 +36,3 @@ static inline void squashfs_finish_page(struct squashfs_page_actor *actor)
>         actor->squashfs_finish_page(actor);
>  }
>  #endif
> -#endif
> --
> 2.34.1
>
