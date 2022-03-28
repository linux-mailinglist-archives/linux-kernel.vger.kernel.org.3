Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06B4E9A21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbiC1OxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbiC1OxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:53:02 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DD3F8A7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:51:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5e31c34bfso151531767b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh492AvAmd1IfP231Dj/fJ74UloGtVlkt9YVNW5vE7I=;
        b=rTK8HzanSVvHJeaRUqDoYN+cyp2drqzhCBdkBIia2K9UHYErmLeBK1OF/IhtkMKjMd
         4+DvzSiFP3vAayYc5opVfj41MCgxmEQBqkQQRWWbIG0LAIcbrOs8KZdtMVelLS2er9dZ
         jaxB9J/SWWUrxSXh1SWupnN36l+s9gh7UnQCAiKuuQusGpvuHHsROcp8xmilrEEIYbK3
         Aetv6B61+/xAPj5dfK/gSAJJKbvDVjsZZI7/EcFX/nzsileuM+QGjh/tkT4SafDIs5qm
         Drssu3limcmRrZ657CulEGvWJwC4sWBiDlSFDu3Z3q0wpQoorJ/UqttXZSqCWrnkNHX5
         zOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh492AvAmd1IfP231Dj/fJ74UloGtVlkt9YVNW5vE7I=;
        b=uqIzuOi5WILsc8mK3ZBu6BFLfGl/06LFWDudRp0iLLktNKnElmb6oPpenj8o0oqWt3
         i/sajb9lC/S5dbEJ5onAECMutYi+AQdSdZLaHxIWksoNWFC5PdunZUVioO4x/eisFHed
         s73WLAcDFFhsGiHa3jlaIhxyOAW/k80I6upSzK7VM89uH426icrz4YLPVJiHQvr4AZDN
         3YOTi3/ijKNLue8k3sbVAs6XE23mrNaNrHQohcALHWGpOgLHx/aMcAu4QCgsTNRlenca
         CS7+D3OZ+qYz5x7mt/KjpA6xdlMDxhj5yXLU+M23mG6bR7RW5uOCpAwP4ZBoOha4ldg4
         DKJA==
X-Gm-Message-State: AOAM533b7EpKeXZHiUZy+rT8E+7SyKao4a3BZmf8j1A8tLHmJC8d4u0g
        LzKoXS4e/iwChzQFT/5Na4jIWC+AAUAgVfRsSjAaJQ==
X-Google-Smtp-Source: ABdhPJwmyDAZlA/7hxHve0d0gyq6aqe1zkCsFLU02yLIaouW62yvoiJYimjxjmhfS2vJzYOHdSk9d4pF7QNrsYPzPxA=
X-Received: by 2002:a81:1c4f:0:b0:2e5:9db3:7a8e with SMTP id
 c76-20020a811c4f000000b002e59db37a8emr24636467ywc.319.1648479081138; Mon, 28
 Mar 2022 07:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220328112707.22217-1-linmiaohe@huawei.com>
In-Reply-To: <20220328112707.22217-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Mar 2022 22:50:45 +0800
Message-ID: <CAMZfGtXccwgR6TxNJc6aYV+WGJvAWWAz=RXEHNWDwjKfV49JuA@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: make shmem_init return void
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 7:44 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The return value of shmem_init is never used. So we can make it
> return void now.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/shmem_fs.h | 2 +-
>  mm/shmem.c               | 9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index ab51d3cd39bd..3e915cc550bc 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -56,7 +56,7 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
>   * Functions in mm/shmem.c called directly from elsewhere:
>   */
>  extern const struct fs_parameter_spec shmem_fs_parameters[];
> -extern int shmem_init(void);
> +extern void shmem_init(void);
>  extern int shmem_init_fs_context(struct fs_context *fc);
>  extern struct file *shmem_file_setup(const char *name,
>                                         loff_t size, unsigned long flags);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 529c9ad3e926..26e09a022087 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3879,7 +3879,7 @@ static struct file_system_type shmem_fs_type = {
>         .fs_flags       = FS_USERNS_MOUNT,
>  };
>
> -int __init shmem_init(void)
> +void __init shmem_init(void)
>  {
>         int error;
>
> @@ -3904,14 +3904,13 @@ int __init shmem_init(void)
>         else
>                 shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
>  #endif
> -       return 0;
> +       return;
>
>  out1:
>         unregister_filesystem(&shmem_fs_type);
>  out2:
>         shmem_destroy_inodecache();
>         shm_mnt = ERR_PTR(error);
> -       return error;
>  }
>
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
> @@ -3989,14 +3988,14 @@ static struct file_system_type shmem_fs_type = {
>         .fs_flags       = FS_USERNS_MOUNT,
>  };
>
> -int __init shmem_init(void)
> +void __init shmem_init(void)
>  {
>         BUG_ON(register_filesystem(&shmem_fs_type) != 0);
>
>         shm_mnt = kern_mount(&shmem_fs_type);
>         BUG_ON(IS_ERR(shm_mnt));
>
> -       return 0;
> +       return;

Weird. Using return at the end of a void function.
