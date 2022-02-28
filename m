Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA94C637B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiB1HBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiB1HBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:01:04 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEFD673D5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:00:20 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id u3so18574862ybh.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkKQR+dUpKXqBM8AHEGKF1sHelKhsPJQTQvAXHyt+YE=;
        b=W6Kc/r0NfxBnxUFJU5c8bqgbJ2ydU6stIHk5YOvqSsz8cH/TW8f+QgM4ZTYUzxF4hd
         HNU3QayU7eR1RzKlciywEjK/4cA4ZZDE65CucKsBI0pvldgXvhZikmV81SB/XfoNRnCG
         9YaKhzImE+zCm4OkYVGNZCtA5peAMdox8oKNg83SrFugDsmew3MgyZJcv+Y6VoV6Gf/a
         xWAyRtbbPYfwPar+RhFzzjCfS4q9sb5lr6i6esCtyk2h3s2cSFuLkxVm6hPtRhp1lZ20
         v8Mm/jKlUOzNLa9GIcQuXT0ZPbhWQbF80J6n0KhMPCUWLQVJ4Pg4PkH9Oz1pY5jP5GFT
         CS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkKQR+dUpKXqBM8AHEGKF1sHelKhsPJQTQvAXHyt+YE=;
        b=BQH0xBsAePLcOqr6elNqzhtZmu5OYU7EiyIGL/rTaOPUZ28xp1QUDf/Eg884lMXIF4
         asJGQUDjYrMfL6Naq23Sdyui1yoQs/6RaESVKshN7MhgLs/z1MBoZhlkxZZZQimuIyWW
         VOtXD9SJnWbeRcgHm7CUoXtkl7HXVSgtHZRozsSd2E2/eh46/xDX3ChTAO54r1Ax7gkm
         IINKsO2qT3bxBuCmQ1vHYmlnmoK5Xr9Eu1MfUQYVKkeExiyKYInHK61B1/cfmy7PiOUo
         4OPdyXhpdE40hSKnhBpTsNlUb0P8nleu790BXPHRM2CaYzvT1zRFQNctUh7QmtCceNDV
         VILw==
X-Gm-Message-State: AOAM531y2qNS1RjzzfV+cnaQk2eJhTPNzh8nNETarcv5tJKGGaPVipi6
        lzbIxkgU7z6Ril/97eeQn2MjA+v9QfNc07nln9a11w==
X-Google-Smtp-Source: ABdhPJzRGOAZYAiTMoEauVuuRnrjl5p6n/d/oUhCPnfLhQEhJKvuIfpkv9C+r8sDyjrKSFx6bjS7uxjoeOwznN9U0Hw=
X-Received: by 2002:a25:aa51:0:b0:624:6fbf:c494 with SMTP id
 s75-20020a25aa51000000b006246fbfc494mr17413961ybi.425.1646031619624; Sun, 27
 Feb 2022 23:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20220225180318.20594-3-vbabka@suse.cz> <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Feb 2022 08:00:00 +0100
Message-ID: <CANpmjNOyVTQZroOEVF_ZLASCtQ=SiC12WGWEwOib3vDk3sCbtw@mail.gmail.com>
Subject: Re: [PATCH] lib/stackdepot: Use page allocator if both slab and
 memblock is unavailable
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 04:08, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> After commit 2dba5eb1c73b ("lib/stackdepot: allow optional init and
> stack_table allocation by kvmalloc()"), stack_depot_init() is called
> later if CONFIG_STACKDEPOT_ALWAYS_INIT=n to remove unnecessary memory
> usage. It allocates stack_table using memblock_alloc() or kvmalloc()
> depending on availability of slab allocator.
>
> But when stack_depot_init() is called while creating boot slab caches,
> both slab allocator and memblock is not available. So kernel crashes.
> Allocate stack_table from page allocator when both slab allocator and
> memblock is unavailable.

This is odd - who is calling stack_depot_init() while neither slab nor
memblock are available? Do you have a stacktrace?

> Limit size of stack_table when using page allocator because vmalloc()
> is also unavailable in kmem_cache_init(). it must not be larger than
> (PAGE_SIZE << (MAX_ORDER - 1)).
>
> This patch was tested on both CONFIG_STACKDEPOT_ALWAYS_INIT=y and n.
>
> Fixes: 2dba5eb1c73b ("lib/stackdepot: allow optional init and stack_table allocation by kvmalloc()")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  lib/stackdepot.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index bf5ba9af0500..606f80ae2bf7 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -73,6 +73,14 @@ static int next_slab_inited;
>  static size_t depot_offset;
>  static DEFINE_RAW_SPINLOCK(depot_lock);
>
> +static unsigned int stack_hash_size = (1 << CONFIG_STACK_HASH_ORDER);
> +static inline unsigned int stack_hash_mask(void)
> +{
> +       return stack_hash_size - 1;
> +}
> +
> +#define STACK_HASH_SEED 0x9747b28c
> +
>  static bool init_stack_slab(void **prealloc)
>  {
>         if (!*prealloc)
> @@ -142,10 +150,6 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>         return stack;
>  }
>
> -#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER)
> -#define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
> -#define STACK_HASH_SEED 0x9747b28c
> -
>  static bool stack_depot_disable;
>  static struct stack_record **stack_table;
>
> @@ -172,18 +176,28 @@ __ref int stack_depot_init(void)
>
>         mutex_lock(&stack_depot_init_mutex);
>         if (!stack_depot_disable && !stack_table) {
> -               size_t size = (STACK_HASH_SIZE * sizeof(struct stack_record *));
> +               size_t size = (stack_hash_size * sizeof(struct stack_record *));
>                 int i;
>
>                 if (slab_is_available()) {
>                         pr_info("Stack Depot allocating hash table with kvmalloc\n");
>                         stack_table = kvmalloc(size, GFP_KERNEL);
> +               } else if (totalram_pages() > 0) {
> +                       /* Reduce size because vmalloc may be unavailable */
> +                       size = min(size, PAGE_SIZE << (MAX_ORDER - 1));
> +                       stack_hash_size = size / sizeof(struct stack_record *);
> +
> +                       pr_info("Stack Depot allocating hash table with __get_free_pages\n");
> +                       stack_table = (struct stack_record **)
> +                                     __get_free_pages(GFP_KERNEL, get_order(size));
>                 } else {
>                         pr_info("Stack Depot allocating hash table with memblock_alloc\n");
>                         stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
>                 }
> +
>                 if (stack_table) {
> -                       for (i = 0; i < STACK_HASH_SIZE;  i++)
> +                       pr_info("Stack Depot hash table size=%u\n", stack_hash_size);
> +                       for (i = 0; i < stack_hash_size;  i++)
>                                 stack_table[i] = NULL;
>                 } else {
>                         pr_err("Stack Depot hash table allocation failed, disabling\n");
> @@ -363,7 +377,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>                 goto fast_exit;
>
>         hash = hash_stack(entries, nr_entries);
> -       bucket = &stack_table[hash & STACK_HASH_MASK];
> +       bucket = &stack_table[hash & stack_hash_mask()];
>
>         /*
>          * Fast path: look the stack trace up without locking.
> --
> 2.33.1
