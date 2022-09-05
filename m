Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA305ACEBA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiIEJVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIEJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:21:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6B225C6C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:21:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id cu2so15895663ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Bzgk2kvFWfq5Vbs09rCpc7/jVwptKe73lRP69SAAluc=;
        b=YWpu8GXnN3Fbj4F87Rjc+bDHoUVZQkquGU/VxYNE/m8Q2evLe/E9HPwbv4GzeaoPq5
         UR/O5DNqY3etvdM3Ku1Etz2UF9RwOaBvLIcp7mvSEfrKBXL7wXbVYSMABJ1XYouVXhL3
         gsh/ucEhvyZpNl8qQId1K4l1scsbKZxQIxk4Kg5vB+dNSm+YUNADBwlCgOSTATzRI4PE
         KB8njmHlRvDs4/rG4IrW6brZ2b48eIEuhL/xD43PCQWN5IcbIKTW3JKRThmaSbg6aw72
         hTrbftUqtSbGhdJ8QvCAlEGZMCotnNKWKn3t8Wyp9u4Jhn2i0LKm392mrro7Uqi0eLl+
         r7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Bzgk2kvFWfq5Vbs09rCpc7/jVwptKe73lRP69SAAluc=;
        b=RAmHJSYkHNDfp4BdwoZiVC0NNAxvSc3SsgIlDZf1/f98w/b4zzXslb1SFgr8ioN3wc
         SGNViXgQGvHnTfWeJfVjONvK56l3IBxLiLRb4GtkDhMsgzaHElFSCu/5AuTYALMvuQOp
         l3nuNU23+aSwFQmDtbeVf5xDBuhSkDanlRXvijACWmGhm0PyasCH4ptqC4Gl7BE8PJmY
         OmSIl7//6BdfjwPyr1tGzNZAj+sXa8lwEJb5yy/SwaSQHetirOz7oGf7Mg1oBYDgWrZR
         1hK+pAfEUO54zyCOyioEwNKm5xRR46bpisvTlJYZpHcWAcQsjdUkC+GFpEqCD9wuoXh5
         bE5Q==
X-Gm-Message-State: ACgBeo2POI1oNMyEepeJ96Pprrl+56ArheE/T6/w743ZjKZ7tW2NbDqJ
        TG1XAcM7EiI/fPhWUlY0/HeV+BOHc1W58+9DisA=
X-Google-Smtp-Source: AA6agR7ELWpTzip5f1/FkMhanV0POJD0iyyUXGYC9/5I1Z39K6wIJbAeasZVctIJkY7zR5+/8R+3o5yAjPpzOuD3qz0=
X-Received: by 2002:a17:906:dc93:b0:742:133b:42c3 with SMTP id
 cs19-20020a170906dc9300b00742133b42c3mr21397883ejc.502.1662369677195; Mon, 05
 Sep 2022 02:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220905081552.2740917-1-senozhatsky@chromium.org> <20220905081552.2740917-8-senozhatsky@chromium.org>
In-Reply-To: <20220905081552.2740917-8-senozhatsky@chromium.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 5 Sep 2022 21:21:05 +1200
Message-ID: <CAGsJ_4yciyk49cTk9A4di2sM=io-4z5oi4Q7P-SUOG-MGJGcQg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] zram: Introduce recompress sysfs knob
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Sep 5, 2022 at 9:00 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Allow zram to recompress (using secondary compression streams)
> pages. We support three modes:
>
> 1) IDLE pages recompression is activated by `idle` mode
>
>         echo idle > /sys/block/zram0/recompress
>
> 2) Since there may be many idle pages user-space may pass a size
> watermark value and we will recompress IDLE pages only of equal
> or greater size:
>
>         echo 888 > /sys/block/zram0/recompress
>
> 3) HUGE pages recompression is activated by `huge` mode
>
>         echo huge > /sys/block/zram0/recompress

Thanks for developing this interesting feature. It seems reasonable for cold
pages. But for a huge page,  do you have some data to show that the hugepage
is not compressed by lzo/lz4 so we need zstd further? i assume the size of
the huge page you are talking about is 2MB?

what if the huge page is not cold and swapped out/in frequently?

on second thoughts, it seems you mean hugepage is those pages
whose compressed data is big? if so, can you please avoid using
"huge page" as it is quite misleading in linux. we are using hugepage
for pages larger than 4KB.

>
> 4) HUGE_IDLE pages recompression is activated by `huge_idle` mode
>
>         echo huge_idle > /sys/block/zram0/recompress
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/Kconfig    |  11 ++
>  drivers/block/zram/zram_drv.c | 191 +++++++++++++++++++++++++++++++++-
>  drivers/block/zram/zram_drv.h |   1 +
>  3 files changed, 200 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index d4100b0c083e..81ae4b96ec1a 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -78,3 +78,14 @@ config ZRAM_MEMORY_TRACKING
>           /sys/kernel/debug/zram/zramX/block_state.
>
>           See Documentation/admin-guide/blockdev/zram.rst for more information.
> +
> +config ZRAM_MULTI_COMP
> +       bool "Enable multiple per-CPU compression streams"
> +       depends on ZRAM
> +       help
> +       This will enable per-CPU multi-compression streams, so that ZRAM
> +       can re-compress IDLE pages, using a potentially slower but more
> +       effective compression algorithm.
> +
> +          echo TIMEOUT > /sys/block/zramX/idle
> +          echo SIZE > /sys/block/zramX/recompress
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index de2970865b7b..386e49a13806 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1293,6 +1293,9 @@ static void zram_free_page(struct zram *zram, size_t index)
>                 atomic64_dec(&zram->stats.huge_pages);
>         }
>
> +       if (zram_test_flag(zram, index, ZRAM_RECOMP))
> +               zram_clear_flag(zram, index, ZRAM_RECOMP);
> +
>         if (zram_test_flag(zram, index, ZRAM_WB)) {
>                 zram_clear_flag(zram, index, ZRAM_WB);
>                 free_block_bdev(zram, zram_get_element(zram, index));
> @@ -1357,6 +1360,7 @@ static int zram_read_from_zspool(struct zram *zram,
>         unsigned long handle;
>         unsigned int size;
>         void *src, *dst;
> +       u32 idx;
>         int ret;
>
>         handle = zram_get_handle(zram, index);
> @@ -1373,8 +1377,13 @@ static int zram_read_from_zspool(struct zram *zram,
>
>         size = zram_get_obj_size(zram, index);
>
> -       if (size != PAGE_SIZE)
> -               zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
> +       if (size != PAGE_SIZE) {
> +               idx = ZRAM_PRIMARY_ZCOMP;
> +               if (zram_test_flag(zram, index, ZRAM_RECOMP))
> +                       idx = ZRAM_SECONDARY_ZCOMP;
> +
> +               zstrm = zcomp_stream_get(zram->comps[idx]);
> +       }
>
>         src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>         if (size == PAGE_SIZE) {
> @@ -1386,7 +1395,7 @@ static int zram_read_from_zspool(struct zram *zram,
>                 dst = kmap_atomic(page);
>                 ret = zcomp_decompress(zstrm, src, size, dst);
>                 kunmap_atomic(dst);
> -               zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
> +               zcomp_stream_put(zram->comps[idx]);
>         }
>         zs_unmap_object(zram->mem_pool, handle);
>         return ret;
> @@ -1612,6 +1621,180 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>         return ret;
>  }
>
> +#ifdef CONFIG_ZRAM_MULTI_COMP
> +/*
> + * This function will decompress (unless it's ZRAM_HUGE) the page and then
> + * attempt to compress it using secondary compression algorithm (which is
> + * potentially more effective).
> + *
> + * Corresponding ZRAM slot should be locked.
> + */
> +static int zram_recompress(struct zram *zram,
> +                          u32 index,
> +                          struct page *page,
> +                          int size_watermark)
> +{
> +       unsigned long handle_prev;
> +       unsigned long handle_next;
> +       unsigned int comp_len_next;
> +       unsigned int  comp_len_prev;
> +       struct zcomp_strm *zstrm;
> +       void *src, *dst;
> +       int ret;
> +
> +       handle_prev = zram_get_handle(zram, index);
> +       if (!handle_prev)
> +               return -EINVAL;
> +
> +       comp_len_prev = zram_get_obj_size(zram, index);
> +       /*
> +        * Do not recompress objects that are already "small enough".
> +        */
> +       if (comp_len_prev < size_watermark)
> +               return 0;
> +
> +       ret = zram_read_from_zspool(zram, page, index);
> +       if (ret)
> +               return ret;
> +
> +       zstrm = zcomp_stream_get(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +       src = kmap_atomic(page);
> +       ret = zcomp_compress(zstrm, src, &comp_len_next);
> +       kunmap_atomic(src);
> +
> +       /*
> +        * Either a compression error or we failed to compressed the object
> +        * in a way that will save us memory. Mark object as "recompressed"
> +        * if it's huge, so that we don't try to recompress it again. Ideally
> +        * we want to set some bit for all such objects, but we for now do so
> +        * only for huge ones (we are out of bits in flags on 32-bit systems).
> +        */
> +       if (comp_len_next >= huge_class_size ||
> +           comp_len_next >= comp_len_prev ||
> +           ret) {
> +               if (zram_test_flag(zram, index, ZRAM_HUGE))
> +                       zram_set_flag(zram, index, ZRAM_RECOMP);
> +               zram_clear_flag(zram, index, ZRAM_IDLE);
> +               zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +               return ret;
> +       }
> +
> +       /*
> +        * No direct reclaim (slow path) for handle allocation and no
> +        * re-compression attempt (unlike in __zram_bvec_write()) since
> +        * we already stored that object in zsmalloc. If we cannot alloc
> +        * memory then me bail out.
> +        */
> +       handle_next = zs_malloc(zram->mem_pool, comp_len_next,
> +                               __GFP_KSWAPD_RECLAIM |
> +                               __GFP_NOWARN |
> +                               __GFP_HIGHMEM |
> +                               __GFP_MOVABLE);
> +       if (IS_ERR((void *)handle_next)) {
> +               zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +               return -ENOMEM;
> +       }
> +
> +       dst = zs_map_object(zram->mem_pool, handle_next, ZS_MM_WO);
> +       memcpy(dst, zstrm->buffer, comp_len_next);
> +       zcomp_stream_put(zram->comps[ZRAM_SECONDARY_ZCOMP]);
> +
> +       zs_unmap_object(zram->mem_pool, handle_next);
> +
> +       zram_free_page(zram, index);
> +       zram_set_handle(zram, index, handle_next);
> +       zram_set_obj_size(zram, index, comp_len_next);
> +
> +       zram_set_flag(zram, index, ZRAM_RECOMP);
> +       atomic64_add(comp_len_next, &zram->stats.compr_data_size);
> +       atomic64_inc(&zram->stats.pages_stored);
> +
> +       return 0;
> +}
> +
> +#define RECOMPRESS_IDLE                (1 << 0)
> +#define RECOMPRESS_HUGE                (1 << 1)
> +
> +static ssize_t recompress_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf,
> +                               size_t len)
> +{
> +       struct zram *zram = dev_to_zram(dev);
> +       unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> +       unsigned long index;
> +       struct page *page;
> +       ssize_t ret = 0;
> +       int mode, size_watermark = 0;
> +
> +       if (sysfs_streq(buf, "idle")) {
> +               mode = RECOMPRESS_IDLE;
> +       } else if (sysfs_streq(buf, "huge")) {
> +               mode = RECOMPRESS_HUGE;
> +       } else if (sysfs_streq(buf, "huge_idle")) {
> +               mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
> +       } else {
> +               /*
> +                * We will re-compress only idle objects equal or greater
> +                * in size than watermark.
> +                */
> +               ret = kstrtoint(buf, 10, &size_watermark);
> +               if (ret)
> +                       return ret;
> +               mode = RECOMPRESS_IDLE;
> +       }
> +
> +       if (size_watermark > PAGE_SIZE)
> +               return ret;
> +
> +       down_read(&zram->init_lock);
> +       if (!init_done(zram)) {
> +               ret = -EINVAL;
> +               goto release_init_lock;
> +       }
> +
> +       page = alloc_page(GFP_KERNEL);
> +       if (!page) {
> +               ret = -ENOMEM;
> +               goto release_init_lock;
> +       }
> +
> +       for (index = 0; index < nr_pages; index++) {
> +               zram_slot_lock(zram, index);
> +
> +               if (!zram_allocated(zram, index))
> +                       goto next;
> +
> +               if (mode & RECOMPRESS_IDLE &&
> +                   !zram_test_flag(zram, index, ZRAM_IDLE))
> +                       goto next;
> +
> +               if (mode & RECOMPRESS_HUGE &&
> +                   !zram_test_flag(zram, index, ZRAM_HUGE))
> +                       goto next;
> +
> +               if (zram_test_flag(zram, index, ZRAM_WB) ||
> +                   zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> +                   zram_test_flag(zram, index, ZRAM_SAME) ||
> +                   zram_test_flag(zram, index, ZRAM_RECOMP))
> +                       goto next;
> +
> +               ret = zram_recompress(zram, index, page, size_watermark);
> +next:
> +               zram_slot_unlock(zram, index);
> +               if (ret)
> +                       break;
> +       }
> +
> +       ret = len;
> +       __free_page(page);
> +
> +release_init_lock:
> +       up_read(&zram->init_lock);
> +       return ret;
> +}
> +#endif
> +
>  /*
>   * zram_bio_discard - handler on discard request
>   * @index: physical block index in PAGE_SIZE units
> @@ -2001,6 +2184,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
>  #endif
>  #ifdef CONFIG_ZRAM_MULTI_COMP
>  static DEVICE_ATTR_RW(recomp_algorithm);
> +static DEVICE_ATTR_WO(recompress);
>  #endif
>
>  static struct attribute *zram_disk_attrs[] = {
> @@ -2027,6 +2211,7 @@ static struct attribute *zram_disk_attrs[] = {
>         &dev_attr_debug_stat.attr,
>  #ifdef CONFIG_ZRAM_MULTI_COMP
>         &dev_attr_recomp_algorithm.attr,
> +       &dev_attr_recompress.attr,
>  #endif
>         NULL,
>  };
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index af3d6f6bfcff..b4eecef2a11f 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -50,6 +50,7 @@ enum zram_pageflags {
>         ZRAM_UNDER_WB,  /* page is under writeback */
>         ZRAM_HUGE,      /* Incompressible page */
>         ZRAM_IDLE,      /* not accessed page since last idle marking */
> +       ZRAM_RECOMP,    /* page was recompressed */
>
>         __NR_ZRAM_PAGEFLAGS,
>  };
> --
> 2.37.2.789.g6183377224-goog
>

Thanks
Barry
