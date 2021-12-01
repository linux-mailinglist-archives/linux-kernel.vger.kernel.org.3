Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E60464C69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbhLALQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhLALQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:16:12 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A3C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 03:12:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t11so23555273qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/qgvOkZEM3lx0/khvl/WvVYYCH02Irf7u8oy1QcHGIE=;
        b=EYmBbkrozaG+4zbQmrjhWfYmeMvdxlC1bDluI0d39uYp+28ROCyJu36iJYDVVKubPI
         Z7ss7yiWziOwwDdyl+PwO2yTeRMSqpUwI7Gg0WgZviYnY7JZKXBUMcliL2qfhg+zNQ/Y
         w3pbS6KQkGJJLtJEAirAlXnBsa8mJaC3sjmu6vvrdZHjT6UekYvEan5W6H1yCiORRG8E
         3q8c5zihpOF1jG/9ifEMj+QU9r/Bhdhnuv+ghHSmBLlWyq0qrHUUS1AlKy0X/oPWZ5WI
         7DvCD4WDX3j9uw444fm/rt00ri9nVCfWGQhiy8Tso6n6Ua9PKgwoi9V8f81xm0eQib6P
         9WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/qgvOkZEM3lx0/khvl/WvVYYCH02Irf7u8oy1QcHGIE=;
        b=Ic6yVICGXtcNa0QsWGSJf8XsBufw1XMml8zFdJUEz0Z6D8KaA/rCmaCUGiMvtbJwlW
         WnCwj433MdM/0SsQLTBc6Bq5GCzf8EjuIYrnexcYC/fzh9+A2whisdhgDVs1WUgDsGc9
         0aR2+DA78wuWBLhXkm5m2vu+Psc/SdddHWf7y8u3mNKC77H8QkSVfm+71ZvYHqBcQsmh
         poMZMtgBwZn4PQTn+gpMM2PVyPD46nUS3kDhON5F9xKmQmhMZJ2clmy1a8oG5T7M4DfA
         LFIbWz0MHx2e0ONKMcgI9Zq5BBNa2Cl1bLlG68hIeuKIK35i8+v13r9HXGCoAw86mdLM
         Q63Q==
X-Gm-Message-State: AOAM5306GciY1lXbC1hGZGCDHXcnC8B4joXiqBIgmaQpKqZvIGLCeNyd
        aP/AlCF/CnFZa/K2UihTROw9ZXJj0SOelq2er9mCuq0oY74=
X-Google-Smtp-Source: ABdhPJwR/AYvVCQcFST+kZTP3V4IqZzbHGaDrE3Sk9aJtrHbw61EoQG1md2Sz9BGUrm31gbXyKTw8PKmw0unAQSnQAc=
X-Received: by 2002:a05:622a:1004:: with SMTP id d4mr5942284qte.95.1638357171215;
 Wed, 01 Dec 2021 03:12:51 -0800 (PST)
MIME-Version: 1.0
References: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 1 Dec 2021 19:12:30 +0800
Message-ID: <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: count zram read/write into PSI_IO_WAIT
To:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no chance for zram reading/writing to be counted in
PSI_IO_WAIT so far as zram will deal with the request just in current
context without invoking submit_bio and io_schedule.

On Wed, Dec 1, 2021 at 6:59 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Have zram reading/writing be counted in PSI_IO_WAIT.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/block/zram/zram_drv.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf275..b0e4766 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -34,6 +34,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/part_stat.h>
> +#include <linux/psi.h>
>
>  #include "zram_drv.h"
>
> @@ -1246,7 +1247,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>                                 zram_get_element(zram, index),
>                                 bio, partial_io);
>         }
> -
> +#ifdef CONFIG_PSI
> +       psi_task_change(current, 0, TSK_IOWAIT);
> +#endif
>         handle = zram_get_handle(zram, index);
>         if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
>                 unsigned long value;
> @@ -1257,6 +1260,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>                 zram_fill_page(mem, PAGE_SIZE, value);
>                 kunmap_atomic(mem);
>                 zram_slot_unlock(zram, index);
> +#ifdef CONFIG_PSI
> +               psi_task_change(current, TSK_IOWAIT, 0);
> +#endif
>                 return 0;
>         }
>
> @@ -1284,6 +1290,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>         if (WARN_ON(ret))
>                 pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
>
> +#ifdef CONFIG_PSI
> +       psi_task_change(current, TSK_IOWAIT, 0);
> +#endif
>         return ret;
>  }
>
> @@ -1471,7 +1480,13 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>                 vec.bv_offset = 0;
>         }
>
> +#ifdef CONFIG_PSI
> +       psi_task_change(current, 0, TSK_IOWAIT);
> +#endif
>         ret = __zram_bvec_write(zram, &vec, index, bio);
> +#ifdef CONFIG_PSI
> +       psi_task_change(current, TSK_IOWAIT, 0);
> +#endif
>  out:
>         if (is_partial_io(bvec))
>                 __free_page(page);
> @@ -1607,7 +1622,6 @@ static blk_qc_t zram_submit_bio(struct bio *bio)
>                 atomic64_inc(&zram->stats.invalid_io);
>                 goto error;
>         }
> -
>         __zram_make_request(zram, bio);
>         return BLK_QC_T_NONE;
>
> --
> 1.9.1
>
