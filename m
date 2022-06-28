Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8BE55D5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiF1H0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiF1H0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:26:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAF42CE34
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:26:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v38so10033973ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uto9EobkP0WojhVEjYvx1l88xfjdKMI1uMfZ8YaCROA=;
        b=Zz5NixJh4HJgTIb06YIHJ94O3w+bu9++8ykqNoJ7fswmaU/CogyoQemUpL4HQKbb+T
         OjCOIAz+3l61bxJ8zkx+mJy6EMi5jYAZBRKouXO+BOaVx8WI3bfDtV/swlON6xZv3KZ/
         Ca9+015+kkJZet6dOzqR5WKm8DlC+YRoxXM0+wUiFg8/WL6qY66oR7vtgflo6KcNqVKy
         DQUUBLXDPBoe7+xd7Z9s/J2f7wMYzeugSjDgEN+8EQX1nPKQ3GXQPB147XgA4aw6EBVV
         IOJVgDbdIJa5R+XxWlyqMoJwJkSrMcFOXfOSiFtfdR5nygSGOn8iSl7+E4/y2LFaikdG
         fl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uto9EobkP0WojhVEjYvx1l88xfjdKMI1uMfZ8YaCROA=;
        b=67p4riKIb/3g9bXR6Ntq1qjTrQsiTwUDogj1RetiM6QvY2ayBGaVT+L3K+JUDiFRvD
         6r8hwqHyIllg2Oc/ChaRgkFRNjTfi9x+t3oJxqJ3capL2A8/8050G8XrNIyIiM4g0Nvn
         3l7uhaexP3OdnzbySf8MR+UP9EpKkw68i3zEj5wTocmCJceKP1AjFHx6HiFNfJR/Tzfh
         cF3ZjrFnaBazgcZe8PMovYQNVfAU+C8zc1vkHw+qYdGgXFkWS9CJoqxs/8yjfyNmOPwu
         Fj1a4wVQJoSgM1uatWLL1r4TBYIq9Mof60Rmp1wSHHPUvkAuPQVnATWriyv1+AaZanhG
         rZRw==
X-Gm-Message-State: AJIora9yI7BOdfQiNvBaPpeFqJF85ZWldbLu+PkE40/+Fux1QlFFy5fO
        tmhG+IHcW2Cb8Bg+eAGa9vO853ZOx+33vg6G4V1e5tSNzn8=
X-Google-Smtp-Source: AGRyM1tZja++4yw/IpQxXTZiryi9L5L9Yt0HSZ5XaTnNZlRVpDGyOYTD7gaikjK7+HID7PVRqz/St568tOu+kmjg+pQ=
X-Received: by 2002:a25:3497:0:b0:66c:c013:4bea with SMTP id
 b145-20020a253497000000b0066cc0134beamr10903346yba.625.1656401173876; Tue, 28
 Jun 2022 00:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220623111937.6491-1-yee.lee@mediatek.com> <20220623111937.6491-2-yee.lee@mediatek.com>
 <CANpmjNN-jsZoVmJWD2Dz6O3_YVjy0av6e0iD-+OYXpik1LbLvg@mail.gmail.com>
 <bdfd039fbde06113071f773ae6d5635ff4664e2c.camel@mediatek.com>
 <CANpmjNPfkFjUteMCDzUSPmTKbpnSfjmWqp9ft8vb-v=B8eeRKw@mail.gmail.com> <9c6fcb1c178a923f2406466a3f9f2345e4e7a1c1.camel@mediatek.com>
In-Reply-To: <9c6fcb1c178a923f2406466a3f9f2345e4e7a1c1.camel@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 09:25:37 +0200
Message-ID: <CANpmjNOADG3UqC+6aGEmfh5kzaiaqjGTFieUonC=_XwOophJ+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: kfence: skip kmemleak alloc in kfence_pool
To:     Yee Lee <yee.lee@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, catalin.marinas@arm.com
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

On Tue, 28 Jun 2022 at 08:41, Yee Lee <yee.lee@mediatek.com> wrote:
>
> On Fri, 2022-06-24 at 10:28 +0200, Marco Elver wrote:
>
> On Fri, 24 Jun 2022 at 10:20, 'Yee Lee' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>
>
> On Thu, 2022-06-23 at 13:59 +0200, Marco Elver wrote:
>
> On Thu, 23 Jun 2022 at 13:20, yee.lee via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> Use MEMBLOCK_ALLOC_NOLEAKTRACE to skip kmemleak registration when
> the kfence pool is allocated from memblock. And the kmemleak_free
> later can be removed too.
>
>
> Is this purely meant to be a cleanup and non-functional change?
>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
>
> ---
>  mm/kfence/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4e7cd4c8e687..0d33d83f5244 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -600,14 +600,6 @@ static unsigned long kfence_init_pool(void)
>                 addr += 2 * PAGE_SIZE;
>         }
>
> -       /*
> -        * The pool is live and will never be deallocated from this
> point on.
> -        * Remove the pool object from the kmemleak object tree, as
> it would
> -        * otherwise overlap with allocations returned by
> kfence_alloc(), which
> -        * are registered with kmemleak through the slab post-alloc
> hook.
> -        */
> -       kmemleak_free(__kfence_pool);
>
>
> This appears to only be a non-functional change if the pool is
> allocated early. If the pool is allocated late using page-alloc, then
> there'll not be a kmemleak_free() on that memory and we'll have the
> same problem.
>
>
> Do you mean the kzalloc(slab_is_available) in memblock_allc()? That
> implies that MEMBLOCK_ALLOC_NOLEAKTRACE has no guarantee skipping
> kmemleak_alloc from this. (Maybe add it?)
>
>
> No, if KFENCE is initialized through kfence_init_late() ->
> kfence_init_pool_late() -> kfence_init_pool().
>
> Thanks for the information.
>
> But as I known, page-alloc does not request kmemleak areas.
> So the current kfence_pool_init_late() would cause another kmemleak warning on unknown freeing.
>
> Reproducing test: (kfence late enable + kmemleak debug on)
>
> / # echo 500 > /sys/module/kfence/parameters/sample_interval
> [  153.433518] kmemleak: Freeing unknown object at 0xffff0000c0600000
> [  153.433804] CPU: 0 PID: 100 Comm: sh Not tainted 5.19.0-rc3-74069-gde5c208d533a-dirty #1
> [  153.434027] Hardware name: linux,dummy-virt (DT)
> [  153.434265] Call trace:
> [  153.434331]  dump_backtrace+0xdc/0xfc
> [  153.434962]  show_stack+0x18/0x24
> [  153.435106]  dump_stack_lvl+0x64/0x7c
> [  153.435232]  dump_stack+0x18/0x38
> [  153.435347]  kmemleak_free+0x184/0x1c8
> [  153.435462]  kfence_init_pool+0x16c/0x194
> [  153.435587]  param_set_sample_interval+0xe0/0x1c4
> [  153.435694]  param_attr_store+0x98/0xf4
> [  153.435804]  module_attr_store+0x24/0x3c
> [  153.435910]  sysfs_kf_write+0x3c/0x50
> ...(skip)
> [  153.444496] kfence: initialized - using 524288 bytes for 63 objects at 0x00000000a3236b01-0x00000000901655d3
> / #
>
> Hence, now there are two issues to solve.
> (1) (The original)To prevent the undesired kmemleak scanning on the kfence pool. As Cataline's suggestion, we can just apply kmemleak_ignore_phys instead of free it at all.
> ref: https://lore.kernel.org/linux-mm/YrWPg3xIHbm9bFxP@arm.com/
>
> (2) The late-allocated kfence pool doesn't need to go through kmemleak_free. We can relocate the opeartion to kfence_init_pool_early() to seperate them.
> That is, kfence_init_pool_early(memblock) has it and kfence_init_pool_late(page alloc) does not.
>
> The draft is like the following.

Looks reasonable - feel free to send v2.

Thanks,
-- Marco
