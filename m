Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD3B51B883
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbiEEHQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbiEEHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:16:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316235273
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:12:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h10so6163785ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfIOkRZ6twwlsVq7LPAuc7rDKCIGPs8QeABSEQr/fQs=;
        b=H7H2f3q0+qqzRnTvoXnZweOxqGU80TTLxMshqe+rVobEvVXkJPNQwH88IjPYhPFAZW
         qCfLwAwNjNN1nmJZTJ1rBtogddVOqLPeq8LVBHwpJEJyOspd0H/SV3ihJ09fmr5hNd8V
         NiIjZ2kTydUQN+1xM5zo8rH+aXlPEq0lh8daLYLq+YoS1eHkHCZQvg+PYZk/dLDheGML
         2sk9dlTD2cfGuxMayM9Z7i6eR2mvxqLxsmX8/4cZuNbdFw/uc6u2D9cJs1UmL2M493FA
         C7PKU6FUoP2KUGXzhMshB3a4YNITUloo25lV0OTA0Ps/83WM+7Ph+xEAsY9hl+rVPV1l
         ykMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfIOkRZ6twwlsVq7LPAuc7rDKCIGPs8QeABSEQr/fQs=;
        b=VS3Lu3TJ/yd6cNvEC0+1+G+zLCMy8lpvKfvStM4DOVN2881Z5y+Gxdl1equZSGDzTE
         OAO7L5MfpckvgBbAHGR/icHFroje+Oj72Rmr5Br5WC05O04O6PaGjOpREg3PsRdGQzWF
         othppMZIQWWknv3l2IFmcWNUw4ugo4v47tz3PrrBbn0xz7B0qPiqd0yCeGSULdeD16Tb
         fdAL1nmeVrWdr+xpH6HtYs1IOBN5cSfgwOcQHXnQrT41CXCH5Je4FnztC3hjcY00uxmN
         a4PgjiEmyq1h2rpsUuKJ8OR9grtre0sgOGcWPN26wTjJyFzYEWuYWd5ohZ4uCE4o4UPx
         xjhw==
X-Gm-Message-State: AOAM532AxsAWhBVgJWgNfmaVf6O8MMMIOKWwBhEhgRkA4iKE2eqSoRpy
        Jptu2cig7P0jkJ3T5N7+ZH5LXM1ILG2h3CIFXmfqkA==
X-Google-Smtp-Source: ABdhPJxjJOcBPijJ+UuYDZbSy+0Q+ExeJS8fHz1umGyJQhtJVG0eLOe7bhN2Zp5Oeiew6kT5WeRnFin143BDpNcOwew=
X-Received: by 2002:a25:3623:0:b0:649:e6fd:2b54 with SMTP id
 d35-20020a253623000000b00649e6fd2b54mr8839710yba.625.1651734771001; Thu, 05
 May 2022 00:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
In-Reply-To: <20220505070105.1835745-1-42.hyeyoo@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 5 May 2022 09:12:14 +0200
Message-ID: <CANpmjNN5B5xjcTfcAF78d9Bpxqypt8p=OHTLU+QHbtV6vJJjeg@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 at 09:01, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> When kfence fails to initialize kfence pool, it frees the pool.
> But it does not reset PG_slab flag and memcg_data of struct page.
>
> Below is a BUG because of this. Let's fix it by resetting PG_slab
> and memcg_data before free.
>
> [    0.089149] BUG: Bad page state in process swapper/0  pfn:3d8e06
> [    0.089149] page:ffffea46cf638180 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d8e06
> [    0.089150] memcg:ffffffff94a475d1
> [    0.089150] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> [    0.089151] raw: 0017ffffc0000200 ffffea46cf638188 ffffea46cf638188 0000000000000000
> [    0.089152] raw: 0000000000000000 0000000000000000 00000000ffffffff ffffffff94a475d1
> [    0.089152] page dumped because: page still charged to cgroup
> [    0.089153] Modules linked in:
> [    0.089153] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.18.0-rc1+ #965
> [    0.089154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [    0.089154] Call Trace:
> [    0.089155]  <TASK>
> [    0.089155]  dump_stack_lvl+0x49/0x5f
> [    0.089157]  dump_stack+0x10/0x12
> [    0.089158]  bad_page.cold+0x63/0x94
> [    0.089159]  check_free_page_bad+0x66/0x70
> [    0.089160]  __free_pages_ok+0x423/0x530
> [    0.089161]  __free_pages_core+0x8e/0xa0
> [    0.089162]  memblock_free_pages+0x10/0x12
> [    0.089164]  memblock_free_late+0x8f/0xb9
> [    0.089165]  kfence_init+0x68/0x92
> [    0.089166]  start_kernel+0x789/0x992
> [    0.089167]  x86_64_start_reservations+0x24/0x26
> [    0.089168]  x86_64_start_kernel+0xa9/0xaf
> [    0.089170]  secondary_startup_64_no_verify+0xd5/0xdb
> [    0.089171]  </TASK>

This is probably:

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/kfence/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index a203747ad2c0..2ab3d473321e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -642,6 +642,13 @@ static bool __init kfence_init_pool_early(void)
>          * fails for the first page, and therefore expect addr==__kfence_pool in
>          * most failure cases.
>          */
> +       for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> +               struct page *page;
> +
> +               page = virt_to_page(p);

#ifdef CONFIG_MEMCG

> +               page->memcg_data = 0;

#endif

> +               __ClearPageSlab(page);

We're now using __folio_set_slab(), so I'm guessing this should be
__folio_clear_slab()?

> +       }
>         memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>         __kfence_pool = NULL;
>         return false;
> --
> 2.32.0
>
