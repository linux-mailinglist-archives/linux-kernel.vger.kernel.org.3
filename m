Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDD483746
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiACS5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiACS5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:57:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67064C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 10:57:44 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id by39so57154379ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMhWstZ09q6Cszqpd54WHd2qjsYduZF9Gp6qbEFoKEg=;
        b=CYPX06mYYQ2+cOhSoLGgV/rWQWqKCDXJJ9Iw+5ssEOfXIYPGzUj7v+4rgZWAs1vh9q
         5dxy3dqwPKsdPh8M3wwJtoHaqrBWQUbMh0A78AgqwE65oMtsmJWN3KeAWc/54E/cAKAr
         Af4lQCwRkQcSkAYn+OL6rnmExbIWZFSFNvDj7/ZAPCsUj/Rz2SXUD2thJ9cfusFoDFQr
         QGbuXD9mOwVVPjgcFZxbjvS/9OAAV9ib3h9azZpUnhYbKgMGsSu28tLpirCWUJjnPYR+
         xzbw3RM5EoVWXwBcFP6EaXw9vEwmSo8tRcQaG21dwkUF+pAPRLaunXbEMhCn4sM7w1Y6
         xpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMhWstZ09q6Cszqpd54WHd2qjsYduZF9Gp6qbEFoKEg=;
        b=d5SFIUWxu+wfoWEi8lNRSaXn0zbN9myg3nxbaI9MJh0MnqxWFvUJZoS1+CMjHbVlez
         FqHskNOy+FLB5NiWVuBwGe/NB79NW/LIlYW0hE/o0apLch652MuFOlXTS0XJkcf9XHH6
         FDa5dkQ932BehLaQPoVhfzQgX+EP1Jz0rnMTEJLDGGj+63iCTRpVQXUf8VEb2M3f7vFV
         Myg+cvs7mZT5rOT440AZlm8121xGkJw5QPPQvcB1j5qD2Nnvec+rpZtB7ra2PBgldkOP
         a9gkQ12hXF5zuKtx24S5wrC0WUEXuesve99287Hj713TSGQEg5e1cBOZ1OAtxdgnKRM/
         fu0Q==
X-Gm-Message-State: AOAM532RNrW1EW+rDYHG57rwh12FtllmSd+rNyYI0XqKcv28AlOLD0HA
        0Cow8GBo5Qwlj3/hVfbVBh2bXmTM2HYAJ7IcZbIOvQ==
X-Google-Smtp-Source: ABdhPJxESlTLF6vDjNiq9g3jYw19mn2gjb5KvscdlznFgTwwArdG339mJObBz8nFkUB+6pOx0s4aqg8oPJhp9SWaWGY=
X-Received: by 2002:a2e:9b96:: with SMTP id z22mr37955720lji.427.1641236262660;
 Mon, 03 Jan 2022 10:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20211217094104.24977-1-guangming.cao@mediatek.com> <20211227095102.6054-1-guangming.cao@mediatek.com>
In-Reply-To: <20211227095102.6054-1-guangming.cao@mediatek.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 3 Jan 2022 10:57:30 -0800
Message-ID: <CALAqxLVA4jUk-2o28RZobrPDUnuXfV1xN77Pt8Pu1o27V3aUQQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: dma-heap: Add a size check for allocation
To:     guangming.cao@mediatek.com
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA-BUF HEAPS FRAMEWORK" <linux-media@vger.kernel.org>,
        "open list:DMA-BUF HEAPS FRAMEWORK" <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA-BUF HEAPS FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bo Song <bo.song@mediatek.com>,
        Libo Kang <libo.kang@mediatek.com>,
        jianjiao zeng <jianjiao.zeng@mediatek.com>,
        mingyuan ma <mingyuan.ma@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 1:52 AM <guangming.cao@mediatek.com> wrote:
>
> From: Guangming <Guangming.Cao@mediatek.com>
>

Thanks for submitting this!

> Add a size check for allcation since the allocation size is

nit: "allocation" above.

> always less than the total DRAM size.

In general, it might be good to add more context to the commit message
to better answer *why* this change is needed rather than what the
change is doing.  ie: What negative thing happens without this change?
And so how does this change avoid or improve things?


> Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
> Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
> ---
> v2: 1. update size limitation as total_dram page size.
>     2. update commit message
> ---
>  drivers/dma-buf/dma-heap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 56bf5ad01ad5..e39d2be98d69 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -55,6 +55,8 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>         struct dma_buf *dmabuf;
>         int fd;
>
> +       if (len / PAGE_SIZE > totalram_pages())
> +               return -EINVAL;

This seems sane. I know ION used to have some 1/2 of memory cap to
avoid unnecessary memory pressure on crazy allocations.

Could you send again with an improved commit message?

thanks
-john
