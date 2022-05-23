Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC2530C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiEWIXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiEWIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:23:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19240220F5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:23:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i11so24054545ybq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTcOGuIxOzrfJcXVclrxF1J8paB+UsOUzDwAJnZBxCw=;
        b=Om1eS4LrLfjIeZEVD09q/hvEeaaaOAuHb7mlZ3HTSboDAjw8oakTY57guTKQEBGrlA
         5EYmfzEfP2o1vUaq/GdqX4DWhMMaLZMgMnIUIbBlDqwID8hNwPerRzMznOzm2MqxgPaL
         h9f6QaLW1qyo0wrKeOKgWB2sRwVd0/TUiAQGYoivnQenINLTVFHfSDL8Je8zHjaekmSb
         clcvBJ+fZUY2fro8bTMMcGLOZZc1MJ9Uy4NT3PC9kmwk3Ihq6Rb63Nu6NTjPzgO+Au+6
         bIt383T34CzIn/yiZS020gth2C05695pqFnWCQNy2f3TG+on2pRf48Y6MrcxS+RayX22
         bE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTcOGuIxOzrfJcXVclrxF1J8paB+UsOUzDwAJnZBxCw=;
        b=NJjQUYtZuvqb1V8/78ZlyZyJ9oTydB28lPdoltnA/xlWOSXBlnSR4ZSoGdvp07tyUK
         VUzBQPbsrsxmamhoPyG7ErVTSPPIPoVf4wDUANFsVBSt/GYb3Z41Dq864ZjkRT4urG/S
         4VsWLNXlQQgIAHFSZjyp+2F/LXNTnP663nRqZO20BlsonvD4iQyO+mAH3bZhch2YrdDc
         +S3/D8x2ozHbK0wuDXqGB8nPfR+g2xZdwLbdhzvJn7AG067t/0/OIGZDyFnTYNpFVP7w
         h6Oguw/++sHYhYJqkDlEIrJ6h9+6M8mnd3S2G9B9saKkKU3OA8dldtpZCWj3KwRfO9Hf
         g/dg==
X-Gm-Message-State: AOAM53388OBIZi4isgd1DLGY9Wr6wM+oHInAka/iNXPGdgVtbNcUIuku
        EVOnmX8YFRs79RGcrcCozJz4NZNZHKh+dxmfd89g/Q==
X-Google-Smtp-Source: ABdhPJy6cvTczDvpCgMLRVi68Dl2KEDEmWHBsDSjxv25IIzYMQNPJEh5wpFfDJpeRPxWYkV8OQWVROOrVe8ig99AbMY=
X-Received: by 2002:a25:2d4b:0:b0:64d:a722:b4ae with SMTP id
 s11-20020a252d4b000000b0064da722b4aemr19995657ybe.87.1653294194134; Mon, 23
 May 2022 01:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020051.141460-1-wangkefeng.wang@huawei.com> <20220523020051.141460-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20220523020051.141460-2-wangkefeng.wang@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 23 May 2022 10:22:38 +0200
Message-ID: <CANpmjNMxmRsWVvqe=30JEhCqPdGvUcKUgLoe2VjfMbKfHwFyaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] asm-generic: Add memory barrier dma_mb()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
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

On Mon, 23 May 2022 at 03:50, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> The memory barrier dma_mb() is introduced by commit a76a37777f2c
> ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> which is used to ensure that prior (both reads and writes) accesses
> to memory by a CPU are ordered w.r.t. a subsequent MMIO write, this
> is only defined on arm64, but it is a generic memory barrier, let's
> add dma_mb() into documentation and include/asm-generic/barrier.h.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  Documentation/memory-barriers.txt | 11 ++++++-----
>  include/asm-generic/barrier.h     |  8 ++++++++
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..07a8b8e1b12a 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
>
>   (*) dma_wmb();
>   (*) dma_rmb();
> + (*) dma_mb();
>
>       These are for use with consistent memory to guarantee the ordering
>       of writes or reads of shared memory accessible to both the CPU and a
> @@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
>       The dma_rmb() allows us guarantee the device has released ownership
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
> -     can see it now has ownership.  Note that, when using writel(), a prior
> -     wmb() is not needed to guarantee that the cache coherent memory writes
> -     have completed before writing to the MMIO region.  The cheaper
> -     writel_relaxed() does not provide this guarantee and must not be used
> -     here.
> +     can see it now has ownership. The dma_mb() implies both a dma_rmb() and
> +     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> +     to guarantee that the cache coherent memory writes have completed before
> +     writing to the MMIO region. The cheaper writel_relaxed() does not provide
> +     this guarantee and must not be used here.

It seems you've changed that spacing. This document uses 2 spaces
after a sentence-ending '.'. (My original suggestion included the 2
spaces after dots.)

Otherwise it all looks fine to me.

Thanks,
-- Marco
