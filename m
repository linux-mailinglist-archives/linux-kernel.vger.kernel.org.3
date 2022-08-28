Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46D5A3FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiH1Upj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Upf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:45:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7A2AE17
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:45:34 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33dc31f25f9so153436027b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lTbQlx4PkxNAh0QSudwPBNTkD42cR5tC/Ap2lDc3w6Y=;
        b=KhlOQIOAeTpdnM+sF8snTdaCrhKCwi76ieHPVn3D/E7D/fYvKtYTy3zJmfp0fOeCkG
         4zikwDxVGfZh5DgI/6iyd2GC7tTih9smKiLO7R5l7aYxeXNbDzyPckUEYLzdAFoazV3j
         Da5nPikOGeazQBY8c0cAg3EiJU7IdbO4jKwqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lTbQlx4PkxNAh0QSudwPBNTkD42cR5tC/Ap2lDc3w6Y=;
        b=bEzlqbVnhI5AbSU3By1knpvmGbQjwb8SuX9aSK7FYkxzCqWiqVPdlLBIBnxDH2V58U
         liGAXxGScYYn8d+LfumaLJ+flBZvb6tejEa25ms339bkt8THQlnEIlw+7qjYrLZAi87D
         vUSFS0TzDPg1kPkFV8PsbuSl4gl4Co8khhOHRxcFc+hvZK4O8UfOd/25khnuhnI8sju/
         5iROR8ZCxd+RzerzX7dJ6ApKpdAGYyZfp4kx3RNRQ3fQoH3J8/vmuZIaDjqzpu3Hp7Qb
         zU4BUTzQqPMLjnmkz9h74MRmYoB7XAfUDWZsbM+o84vagcrJDD0NEAWcOqRObMTpP+0n
         11fg==
X-Gm-Message-State: ACgBeo2m6CIdZV3XZnO0A7yNjja0eP1QvotsuH/D8WD20TCYI0fzdwvR
        nX4yh6zqpISpnfQZtOP4Ad+n4Ox0XbakjmRt62BvuA==
X-Google-Smtp-Source: AA6agR6KtLzg40ma1/vaSZ9K4goGn5yX893iWBPL7fGmJbAiLLyjq9anzIP7IbhHDLl0h2FZl1fGW2/WtxDW+ehuaTg=
X-Received: by 2002:a0d:cb55:0:b0:340:b1ef:6dae with SMTP id
 n82-20020a0dcb55000000b00340b1ef6daemr6250015ywd.287.1661719533782; Sun, 28
 Aug 2022 13:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220827104600.1813214-1-liushixin2@huawei.com> <20220827104600.1813214-5-liushixin2@huawei.com>
In-Reply-To: <20220827104600.1813214-5-liushixin2@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 28 Aug 2022 22:45:22 +0200
Message-ID: <CAM4kBBKOVb9DFSaw6NX3zfN_RqemR5J0HvWHhGiEToRf7e-LUA@mail.gmail.com>
Subject: Re: [PATCH -next v3 4/5] mm/zswap: delay the initializaton of zswap
 until the first enablement
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:12 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> In the initialization of zswap, about 18MB memory will be allocated for
> zswap_pool in my machine. Since not all users use zswap, the memory may be
> wasted. Save the memory for these users by delaying the initialization of
> zswap to first enablement.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  mm/zswap.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 84e38300f571..4c476c463035 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
>
>  #define ZSWAP_PARAM_UNSET ""
>
> +static int zswap_setup(void);
> +
>  /* Enable/disable zswap */
>  static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
> @@ -220,6 +222,8 @@ static atomic_t zswap_pools_count = ATOMIC_INIT(0);
>
>  /* init state */
>  static int zswap_init_state;
> +/* used to ensure the integrity of initialization */
> +static DEFINE_MUTEX(zswap_init_lock);
>
>  /* init completed, but couldn't create the initial pool */
>  static bool zswap_has_pool;
> @@ -273,13 +277,13 @@ static void zswap_update_total_size(void)
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>
> -static int __init zswap_entry_cache_create(void)
> +static int zswap_entry_cache_create(void)
>  {
>         zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
>         return zswap_entry_cache == NULL;
>  }
>
> -static void __init zswap_entry_cache_destroy(void)
> +static void zswap_entry_cache_destroy(void)
>  {
>         kmem_cache_destroy(zswap_entry_cache);
>  }
> @@ -664,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>         return NULL;
>  }
>
> -static __init struct zswap_pool *__zswap_pool_create_fallback(void)
> +static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
>         bool has_comp, has_zpool;
>
> @@ -782,11 +786,17 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>         if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
>                 return 0;
>
> -       /* if this is load-time (pre-init) param setting,
> +       /*
> +        * if zswap has not been initialized,
>          * don't create a pool; that's done during init.
>          */
> -       if (zswap_init_state == ZSWAP_UNINIT)
> -               return param_set_charp(s, kp);
> +       mutex_lock(&zswap_init_lock);
> +       if (zswap_init_state == ZSWAP_UNINIT) {
> +               ret = param_set_charp(s, kp);
> +               mutex_unlock(&zswap_init_lock);
> +               return ret;
> +       }
> +       mutex_unlock(&zswap_init_lock);
>
>         if (!type) {
>                 if (!zpool_has_pool(s)) {
> @@ -876,6 +886,14 @@ static int zswap_zpool_param_set(const char *val,
>  static int zswap_enabled_param_set(const char *val,
>                                    const struct kernel_param *kp)
>  {
> +       if (system_state == SYSTEM_RUNNING) {
> +               mutex_lock(&zswap_init_lock);
> +               if (zswap_setup()) {
> +                       mutex_unlock(&zswap_init_lock);
> +                       return -ENODEV;
> +               }
> +               mutex_unlock(&zswap_init_lock);
> +       }
>         if (zswap_init_state == ZSWAP_INIT_FAILED) {
>                 pr_err("can't enable, initialization failed\n");
>                 return -ENODEV;
> @@ -1432,7 +1450,7 @@ static const struct frontswap_ops zswap_frontswap_ops = {
>
>  static struct dentry *zswap_debugfs_root;
>
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)
>  {
>         if (!debugfs_initialized())
>                 return -ENODEV;
> @@ -1463,7 +1481,7 @@ static int __init zswap_debugfs_init(void)
>         return 0;
>  }
>  #else
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)
>  {
>         return 0;
>  }
> @@ -1472,11 +1490,14 @@ static int __init zswap_debugfs_init(void)
>  /*********************************
>  * module init and exit
>  **********************************/
> -static int __init init_zswap(void)
> +static int zswap_setup(void)
>  {
>         struct zswap_pool *pool;
>         int ret;
>
> +       if (zswap_init_state != ZSWAP_UNINIT)
> +               return 0;
> +
>         if (zswap_entry_cache_create()) {
>                 pr_err("entry cache creation failed\n");
>                 goto cache_fail;
> @@ -1534,8 +1555,17 @@ static int __init init_zswap(void)
>         zswap_enabled = false;
>         return -ENOMEM;
>  }
> +
> +static int __init zswap_init(void)
> +{
> +       /* skip init if zswap is disabled when system startup */
> +       if (!zswap_enabled)
> +               return 0;
> +       return zswap_setup();
> +}
> +
>  /* must be late so crypto has time to come up */
> -late_initcall(init_zswap);
> +late_initcall(zswap_init);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");
> --
> 2.25.1
>
