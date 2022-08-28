Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF375A3FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiH1UqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1UqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:46:15 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845C2B616
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:46:14 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-33dc31f25f9so153454307b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rcuj4eqor/tMUl+92xtJXWtyAbmWdiW/DNBcK8L1A4E=;
        b=EpmLESfRnDAlQrkQMdkOozd2wC8lw1XI3R60wjUECEIDUttx3DpMndFz4YUg799pwr
         F31NQI3MX9bRqm4k5D3/Kec4ytw5SfSlAr538JlBYj+EVTAIH+TcyrtOGQLcdLGWNqvR
         6X9P//9c7xliyx0z0QLk9SSfsXwME9+rv3KQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rcuj4eqor/tMUl+92xtJXWtyAbmWdiW/DNBcK8L1A4E=;
        b=7f5puvyE1aGokYiyO/uGG9mJFud13NMDbTO/18Bj8+KPMW2Tj4tiJ07ecLBqsSi1mE
         5CK3dqdswRPTbYSaPz1oaEfqae/LGHqMTtoYoHJPXORCAGUG4vXOh63Y6xZ1kqMj36Jh
         nDfklDNMPEbN42vNrXYWx3gsspT/8auBPBrYRqA9oZ5pTZ7xxPbSGftZB/qC6DA50bmN
         KJAXo4vl65Ix/v+eTGlUdNxyu0YXYGTUu/GycL8xLjdNlBdCmS8cXUZJzXF3PKLmeyip
         Nzsl701f3nGetmfdVC2FtIoibVw97FHRJfjbLTqr3kX8wCzvkh7/WAQElOkfdtEHqCi8
         gnpA==
X-Gm-Message-State: ACgBeo3yqQAKvRdbO9zdUJn3n+1rPY+RnMHL6+V15U0qn/2Qf3rp1Rrg
        cLirE+cchCyu0cWQDioN6k/N46KNjtwgKRX3NKdYyA==
X-Google-Smtp-Source: AA6agR45VAs8kV8OLlYZ9u1maUeGSQDPBTo+38GVMViWyD2hj4wlTTyvZmd53uf4bM3EluQs9NIBZlu6noIjC13N12k=
X-Received: by 2002:a05:690c:806:b0:340:a4c7:60fb with SMTP id
 bx6-20020a05690c080600b00340a4c760fbmr7562350ywb.355.1661719573357; Sun, 28
 Aug 2022 13:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220827104600.1813214-1-liushixin2@huawei.com> <20220827104600.1813214-4-liushixin2@huawei.com>
In-Reply-To: <20220827104600.1813214-4-liushixin2@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 28 Aug 2022 22:46:02 +0200
Message-ID: <CAM4kBBKYRkr6OSQ3dHcAKTSdVgsx4GKFanyBpr1jX4Yg1objBw@mail.gmail.com>
Subject: Re: [PATCH -next v3 3/5] mm/zswap: replace zswap_init_{started/failed}
 with zswap_init_state
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
> zswap_init_started indicates that the initialization is started. And
> zswap_init_failed indicates that the initialization is failed. As we will
> support to init zswap after system startup, it's necessary to add a state
> to indicate the initialization is complete and succeed to avoid
> concurrency issues. Since we don't care about the difference between
> init started with init completion. We only need three states:
> uninitialized, initial failed, initial succeed.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konulko.com>

> ---
>  mm/zswap.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2d48fd59cc7a..84e38300f571 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -214,11 +214,12 @@ static DEFINE_SPINLOCK(zswap_pools_lock);
>  /* pool counter to provide unique names to zpool */
>  static atomic_t zswap_pools_count = ATOMIC_INIT(0);
>
> -/* used by param callback function */
> -static bool zswap_init_started;
> +#define ZSWAP_UNINIT           0
> +#define ZSWAP_INIT_SUCCEED     1
> +#define ZSWAP_INIT_FAILED      2
>
> -/* fatal error during init */
> -static bool zswap_init_failed;
> +/* init state */
> +static int zswap_init_state;
>
>  /* init completed, but couldn't create the initial pool */
>  static bool zswap_has_pool;
> @@ -772,7 +773,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>         char *s = strstrip((char *)val);
>         int ret;
>
> -       if (zswap_init_failed) {
> +       if (zswap_init_state == ZSWAP_INIT_FAILED) {
>                 pr_err("can't set param, initialization failed\n");
>                 return -ENODEV;
>         }
> @@ -784,7 +785,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>         /* if this is load-time (pre-init) param setting,
>          * don't create a pool; that's done during init.
>          */
> -       if (!zswap_init_started)
> +       if (zswap_init_state == ZSWAP_UNINIT)
>                 return param_set_charp(s, kp);
>
>         if (!type) {
> @@ -875,11 +876,11 @@ static int zswap_zpool_param_set(const char *val,
>  static int zswap_enabled_param_set(const char *val,
>                                    const struct kernel_param *kp)
>  {
> -       if (zswap_init_failed) {
> +       if (zswap_init_state == ZSWAP_INIT_FAILED) {
>                 pr_err("can't enable, initialization failed\n");
>                 return -ENODEV;
>         }
> -       if (!zswap_has_pool && zswap_init_started) {
> +       if (!zswap_has_pool && zswap_init_state == ZSWAP_INIT_SUCCEED) {
>                 pr_err("can't enable, no pool configured\n");
>                 return -ENODEV;
>         }
> @@ -1476,8 +1477,6 @@ static int __init init_zswap(void)
>         struct zswap_pool *pool;
>         int ret;
>
> -       zswap_init_started = true;
> -
>         if (zswap_entry_cache_create()) {
>                 pr_err("entry cache creation failed\n");
>                 goto cache_fail;
> @@ -1517,6 +1516,7 @@ static int __init init_zswap(void)
>                 goto destroy_wq;
>         if (zswap_debugfs_init())
>                 pr_warn("debugfs initialization failed\n");
> +       zswap_init_state = ZSWAP_INIT_SUCCEED;
>         return 0;
>
>  destroy_wq:
> @@ -1530,7 +1530,7 @@ static int __init init_zswap(void)
>         zswap_entry_cache_destroy();
>  cache_fail:
>         /* if built-in, we aren't unloaded on failure; don't allow use */
> -       zswap_init_failed = true;
> +       zswap_init_state = ZSWAP_INIT_FAILED;
>         zswap_enabled = false;
>         return -ENOMEM;
>  }
> --
> 2.25.1
>
