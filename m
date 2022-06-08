Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24AF542D18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiFHKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiFHKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:18:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CDC18E453
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:06:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so40473520ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+skOxNEIDVYZr0JcmYzlab0ebLbIZBRhQJGr7c39G4=;
        b=YIIoDUrf1gn3sMbVP9TDvyB4fG67sjhT3RN1xXqKIK1m+azW1yU18YfgFcbsWpzZW0
         58iTKb8RAOYnpEF93ro4uF8G8ZfBhpLkWmivCMKF+5r/lvY8N5aa74rM+IekeyELH4TD
         0IBJpeDQikhBFji9cdvguSMSwZnsqWDclFZ+fFyi36mL7iAr1msJw60zdFbJgdxVehqG
         nvvFzSpKSKRk9uQiGcZugzhRvuYUZxu+2CIizx4wo8ZIh+jBOYYc7XnIo6hryd1n7gig
         4Wvpuv2sLD445Q3ROyVdcsbQhfsRvMjGGBT+2RwAR7FdfMvZFUBUZ6XP+ua8917slTSU
         GnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+skOxNEIDVYZr0JcmYzlab0ebLbIZBRhQJGr7c39G4=;
        b=jF6PxVa23Uj+p9r4IfaZGa77AgwUMeyDVpdbTIXeF6FzX4pZVRXaHx9jqPwGk3cCtv
         j4GYbsad8+n4etuoxq6J7wIm4m1gC6rFbp9yjtzrs3qKPvJism+IknbKXiqhagJF4O8W
         6+CB1/lRO4hny4wCeSBYoQ5oirlY2A0k/vv6eIjZ0oHGGVARWuWlLVe8eH+BXW2K5Upu
         ur3AHd1WXiWUqQ18q63BBEVTTfLVzSHi1xOSlcsRg++XeflzWZJ9COPRIBWLXU1L2Ei3
         lVig5/LMYRe5gHoIS/F346IyGhnFsAiNUeFmoVdzo0iOCVJfY5rYgTjPW84xvMO6qqk2
         70Wg==
X-Gm-Message-State: AOAM532TBsJ9YnCvIJBta1nhR1OP2hvweMqB0O2nteup60dbFLsUwj3D
        8vXQweOly/YI+FjQY/cZmeAfJop8NdXRY+pPjUFLGzA8YZRfXA==
X-Google-Smtp-Source: ABdhPJxH/rCMTjSkW93eQ5uIIfUxxl9yBuGOUyJ88qK8lSm54ekA6mu1UjrYoPfQ6ntVCbJbqcSc1yBhFpRyjuUDDRc=
X-Received: by 2002:a17:906:c302:b0:6fe:a216:20a4 with SMTP id
 s2-20020a170906c30200b006fea21620a4mr31611419ejz.556.1654682763093; Wed, 08
 Jun 2022 03:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093449.3100-1-urezki@gmail.com> <20220607153544.7727e87f669ea3a7c9f4a6b5@linux-foundation.org>
In-Reply-To: <20220607153544.7727e87f669ea3a7c9f4a6b5@linux-foundation.org>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 8 Jun 2022 12:05:50 +0200
Message-ID: <CA+KHdyUgdVUrvMONTNkPZi-wKLk_6jzfa4NNTaKoHBAdyX3spg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reduce a vmalloc internal lock contention preparation work
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
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

>
> I can toss it in for some runtime testing, but...
>
> What lock are we talking about here, what is the magnitude of the
> performance issues it is causing and what is the status of the patch
> which uses all this preparation?
>
1.
The vmalloc still uses the global lock in order to access to the global
vmap space. As for magnitude it depends on number of CPUs, higher
number higher contention. Linear dependence.

2.
I am not aware about performance issues which i run into on my setup,
from the other hand there is a "Per cpu kva allocator" built on top of
vmalloc. See vm_map_ram() vm_unmap_ram(). Having vmalloc-per
CPU we can get rid of it.

It is used by the XFS, f2fs and some drivers. The reason is that a
vmalloc is costly due to internal global lock. That is why those users
go with "Per cpu kva allocator" to accelerate their workloads.

3.
My synthetic test shows a big difference between per-CPU vmalloc
patches and default variant. I have different prototypes based on
various ways how to make it per-CPU. I still do not have a fully solution
that satisfies all the needs. But i do not think it is possible due to many
constraints.

4.
This series is not tighten to future per-cpu-vmalloc patches, it is rather
makes the vmalloc code to be more generic as a result of such common
code it would be easier to extend it to per-cpu variant.

It means if per-cpu is not in place it is not needed to be reverted back.

That is the status.

-- 
Uladzislau Rezki
