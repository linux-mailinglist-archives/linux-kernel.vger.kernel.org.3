Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4592A52220C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347825AbiEJRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347841AbiEJRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:15:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EB496AA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:11:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id be20so20768461edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyNHCsFHssjn3zbR0NR3ZZ0sgxAdJxbsIG3gfIjrUV8=;
        b=ACHfeTA70D1ZNAnMiNJhLU/Opraxgv/jvpBeBpQ1DYMiU8lGPSxaGVKXIO9oDmCIt+
         tE0ry69/0T+lGoRbjQVS9V6mDOdSbOCkItBIMFqgU4g5y4A8nBHO4mz5iXjzFezUd1uA
         nYb9UgFSq/W/F0Nf8QYN9YGL0/vISFxA1SyWp424FRaKmm29MQMGnF7nUW2tQUAZWufW
         RGm+N42Z6YTjqSzS3wMSwcAceRxlQZqcxmi7fcLtk8PNc6kSI8EC786t0jcYIKr5YWL6
         78KZHB8qywucOwUwGA6kYo6mX2yBqTKO0EFYg2YFNkRil4DZNyEFj8flEj8S5CqZzAmr
         M9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyNHCsFHssjn3zbR0NR3ZZ0sgxAdJxbsIG3gfIjrUV8=;
        b=jADEKcrSPmIcbb7H6txYqtsLIJkrCYfUA889MHYIBcOuFAQf0spgC5K5yjmn/+qzmd
         pW0e7GqGbMOPlLNhCJghQg0e2wUXywGiEc1n1WSSgkroNtvqEUI2d5nVw3UsUhKb2693
         TbnR8wC60y2sDsXBjibUdr6V/JmcRJ6zWfXattB9+DHkZnqhpcqxiq9fw8u/7ko3dpeb
         GXZST46pHehA25W5UOKKg2qhkYEvE3qsswiVaSeEPV8uHjvKVrSZfAr+mE8ZTmQz/CoB
         sqwsxakZXYfPzl77/3BXAbEQZ19E8TnHe5ed/csJusiCGJzg3FXh8V7LyTjijSlRxFdK
         1bPg==
X-Gm-Message-State: AOAM5315FjIVXbLmiOvMwFkAgC4CMqLkzTgU0tR2jXlISH2LmRBSitYR
        DCCXvQjCS62VHAyXnBjq/8FRrv8p3g6DEq+Z9mpv2Q==
X-Google-Smtp-Source: ABdhPJwsfwv5eCPLQc/uzvs1bAR2eSnYRw+cAYOUkXo2dBciN+5iqf8VYiLI6m+03pLF7oV9DEfjscfDjzk4xZzawXQ=
X-Received: by 2002:a05:6402:2c4:b0:427:f4a3:2e94 with SMTP id
 b4-20020a05640202c400b00427f4a32e94mr23955650edx.138.1652202679663; Tue, 10
 May 2022 10:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <1652191562-18700-1-git-send-email-quic_charante@quicinc.com>
In-Reply-To: <1652191562-18700-1-git-send-email-quic_charante@quicinc.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 10 May 2022 10:11:08 -0700
Message-ID: <CABdmKX3A1dMwByum1dzbFzjTgq44dquZMzFXXQbzpfGGm2hCJQ@mail.gmail.com>
Subject: Re: [PATCH V2] dmabuf: ensure unique directory name for dmabuf stats
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Hridya Valsaraju <hridya@google.com>, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 7:07 AM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> The dmabuf file uses get_next_ino()(through dma_buf_getfile() ->
> alloc_anon_inode()) to get an inode number and uses the same as a
> directory name under /sys/kernel/dmabuf/buffers/<ino>. This directory is
> used to collect the dmabuf stats and it is created through
> dma_buf_stats_setup(). At current, failure to create this directory
> entry can make the dma_buf_export() to fail.
>
> Now, as the get_next_ino() can definitely give a repetitive inode no
> causing the directory entry creation to fail with -EEXIST. This is a
> problem on the systems where dmabuf stats functionality is enabled on
> the production builds can make the dma_buf_export(), though the dmabuf
> memory is allocated successfully, to fail just because it couldn't
> create stats entry.
>
> This issue we are able to see on the snapdragon system within 13 days
> where there already exists a directory with inode no "122602" so
> dma_buf_stats_setup() failed with -EEXIST as it is trying to create
> the same directory entry.
>
> To make the directory entry as unique, append the unique_id for every
> inode. With this change the stats directory entries will be in the
> format of: /sys/kernel/dmabuf/buffers/<inode_number-unique_id>.
>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
> Changes in V2:
>   -- Used the atomic64_t variable to generate a unique_id to be appended to inode
>      to have an unique directory with name <inode_number-unique_id> -- Suggested by christian
>   -- Updated the ABI documentation -- Identified by Greg.
>   -- Massaged the commit log.
>
> Changes in V1:
>   -- Used the inode->i_ctime->tv_secs as an id appended to inode to create the
>      unique directory with name <inode_number-time_in_secs>.
>   -- https://lore.kernel.org/all/1652178212-22383-1-git-send-email-quic_charante@quicinc.com/
>
>  Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers | 10 +++++-----
>  drivers/dma-buf/Kconfig                               |  6 +++---
>  drivers/dma-buf/dma-buf-sysfs-stats.c                 |  8 +++++---
>  3 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers b/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
> index 5d3bc99..9fffbd3 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
> +++ b/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
> @@ -4,19 +4,19 @@ KernelVersion:        v5.13
>  Contact:       Hridya Valsaraju <hridya@google.com>
>  Description:   The /sys/kernel/dmabuf/buffers directory contains a
>                 snapshot of the internal state of every DMA-BUF.
> -               /sys/kernel/dmabuf/buffers/<inode_number> will contain the
> -               statistics for the DMA-BUF with the unique inode number
> -               <inode_number>
> +               /sys/kernel/dmabuf/buffers/<inode_number-unique_id> will
> +               contain the statistics for the DMA-BUF with the unique
> +               pair <inode_number-unique_id>

Android userspace does have a dependency on this being an inode
number. Or at least, a single unsigned int. Not the end of the world,
but still... this will break.
https://cs.android.com/android/platform/superproject/+/master:system/memory/libmeminfo/libdmabufinfo/dmabuf_sysfs_stats.cpp;l=76-77;drc=6951984bbefb96423970b82005ae381065e36704

>  Users:         kernel memory tuning/debugging tools
>
> -What:          /sys/kernel/dmabuf/buffers/<inode_number>/exporter_name
> +What:          /sys/kernel/dmabuf/buffers/<inode_number-unique_id>/exporter_name
>  Date:          May 2021
>  KernelVersion: v5.13
>  Contact:       Hridya Valsaraju <hridya@google.com>
>  Description:   This file is read-only and contains the name of the exporter of
>                 the DMA-BUF.
>
> -What:          /sys/kernel/dmabuf/buffers/<inode_number>/size
> +What:          /sys/kernel/dmabuf/buffers/<inode_number-unique_id>/size
>  Date:          May 2021
>  KernelVersion: v5.13
>  Contact:       Hridya Valsaraju <hridya@google.com>
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 541efe0..5bcbdb1 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -81,9 +81,9 @@ menuconfig DMABUF_SYSFS_STATS
>            Choose this option to enable DMA-BUF sysfs statistics
>            in location /sys/kernel/dmabuf/buffers.
>
> -          /sys/kernel/dmabuf/buffers/<inode_number> will contain
> -          statistics for the DMA-BUF with the unique inode number
> -          <inode_number>.
> +          /sys/kernel/dmabuf/buffers/<inode_number-unique_id> will contain
> +          statistics for the DMA-BUF with the unique pair
> +          <inode_number-unique_id>.
>
>  source "drivers/dma-buf/heaps/Kconfig"
>
> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
> index 2bba0ba..29e9e23 100644
> --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> +++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
> @@ -38,8 +38,8 @@
>   *
>   * The following stats are exposed by the interface:
>   *
> - * * ``/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name``
> - * * ``/sys/kernel/dmabuf/buffers/<inode_number>/size``
> + * * ``/sys/kernel/dmabuf/buffers/<inode_number-unique_id>/exporter_name``
> + * * ``/sys/kernel/dmabuf/buffers/<inode_number-unique_id>/size``
>   *
>   * The information in the interface can also be used to derive per-exporter
>   * statistics. The data from the interface can be gathered on error conditions
> @@ -172,6 +172,7 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
>  {
>         struct dma_buf_sysfs_entry *sysfs_entry;
>         int ret;
> +       static atomic64_t unique_id = ATOMIC_INIT(0);
>
>         if (!dmabuf || !dmabuf->file)
>                 return -EINVAL;
> @@ -192,7 +193,8 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
>
>         /* create the directory for buffer stats */
>         ret = kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, NULL,
> -                                  "%lu", file_inode(dmabuf->file)->i_ino);
> +                                  "%lu-%lu", file_inode(dmabuf->file)->i_ino,
> +                                  atomic64_add_return(1, &unique_id));
>         if (ret)
>                 goto err_sysfs_dmabuf;
>
> --
> 2.7.4
>
