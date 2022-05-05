Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BDC51BA48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbiEEIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349011AbiEEI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:29:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F02D1CE
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:25:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i38so6356695ybj.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKvsgWQUg0gMqeUR3q7cJz8EBr7iOI0sJ8d081w4vJA=;
        b=kGfS3bGeiu6lveuQ4kdgVfruOGv7LsufFzgu9lf9V0T2ClNwGvDnrvaQkeK2PA23E0
         KC3TG3PugQIuIhH2FBbL+CwiX86nuxjvCbp2+P+wCG4BJKqIfdUiTkHwKn/cEbPh+5e3
         9BPMW39rsRGeQ4Wp1Uxad6wfVYCYa+zFEdPOQSfS6IcrGt1fq/UQLdqTBXqyPQ/RirrW
         E14o7WY4KgkgPIPb8o+xighdKDYzbwQsabrDkFahK5prFANSmmuOO8oqXcn+nT/e5yHC
         VNVkuCWImM+/0ZfzczOUxVYm1ynprxg8TtFGrUpQ8X/mBc4zM8Em4doz3Q+JKXglsxHJ
         TnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKvsgWQUg0gMqeUR3q7cJz8EBr7iOI0sJ8d081w4vJA=;
        b=p5ZlrX53mCG0E2BjI0ACqLTOneoJ1eICljqSK0P3zFCbOE4Rl3Vv+a4IkZOi+Hhdjj
         S6F10/3nzDdDZTGZJQ98n3QsgocMCrWNZz4s1L1+XpRPmVTSwt8BvNznSuGTo+AuZrxC
         CT+qQcMNe7Rxbkh1okYlGbGqb7mmKQGBgioGC+RTSpGMezI7pPzQnG6f+Ulvy5Fr5qrL
         lZFr46xAZINaoeEJQEBLc28640xNkKN1YaBWHy0uoPxdXyf5ntCt/Ekf9A7VfX9dQ3kU
         lUUGN86Nd52xELTWh4m8N/vUOGXyq0ZaUDs1qO6HBFCZj4HXmjaXuMthmLtU1ZJNze+y
         KIWg==
X-Gm-Message-State: AOAM5328T8IRYG6u8jk9ANojjrAfWtVhjuv6j7BxVi4hNHdsGIBsBRXh
        CA0GLAQakyQrr5UHa5odXuJhCIydT2nJ5KufaeSnFs02DpxzJg==
X-Google-Smtp-Source: ABdhPJxqgWPxdPhlMUn8kNuFyUpKwS8p9b4ea4HxMHa89K1lYxYllNEbIlUwBXh6PYFp3d5EDBwvUyhY9/TKJS1OH5I=
X-Received: by 2002:a05:6902:1342:b0:648:a4d2:ff43 with SMTP id
 g2-20020a056902134200b00648a4d2ff43mr19964190ybu.425.1651739155360; Thu, 05
 May 2022 01:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220505070105.1835745-1-42.hyeyoo@gmail.com> <20220505073920.1880661-1-42.hyeyoo@gmail.com>
In-Reply-To: <20220505073920.1880661-1-42.hyeyoo@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 5 May 2022 10:25:18 +0200
Message-ID: <CANpmjNPBFMtxZKZqveoZwggjJozSoJGYLrJ+DY=R9=H5cOKOFw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kfence: reset PG_slab and memcg_data before freeing __kfence_pool
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Thu, 5 May 2022 at 09:40, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
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
>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Marco Elver <elver@google.com>

, with small comment below.

> ---
>
> v1 -> v2:
>         - Use folio instead of page
>         - Add Fixes: tags
>         - Wrap #ifdef ~ #endif around folio->memcg_data = 0;
>
>  mm/kfence/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index a203747ad2c0..bb1c6c489d0a 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -642,6 +642,15 @@ static bool __init kfence_init_pool_early(void)
>          * fails for the first page, and therefore expect addr==__kfence_pool in
>          * most failure cases.
>          */
> +       for (char *p = (char *)addr; p < __kfence_pool + KFENCE_POOL_SIZE; p += PAGE_SIZE) {
> +               struct folio *folio;
> +
> +               folio = virt_to_folio(p);

Assign folio where it is defined above. Better to always initialize
and guard against accidental uninit use in future.

Thanks,
-- Marco
