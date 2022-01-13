Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A205948E0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbiAMX1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiAMX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:27:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:27:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id br17so24890128lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Br5WfYiTc37TH3IA3cWwwQvBdeV/BPdpfjqxoTbjUg8=;
        b=W5TpqtMMfX5D0g3MqtnYghqkOFySoHX8V7Y3CDIEk/QzE1qbCwAEJgPpiJrTJPckV+
         6N2Vqv9WJ3XylOrXOadOYeXgV1y464f5VNQVaG+8o2Glkx36tVcTGtTSSygXE9SjYxv1
         RnoyaBK5nCwB6EOFL7/mwCLnckkE1s60MGfxHeQCmCJhhJZOBIv+VRduC1HOrb6bkNsL
         FVwFtXFQXUD8Gx/cQQ5XhZOwds/VF/zUQ0OARSiZM0Xy9Ppb3w6T0wwLrYPxiySAyUbE
         20XLOCa+lmlXMZ8C2ul6MEW+k28ADcena2T1vx5h/MaIhRGddm0bLJivZ074kU2ydzvf
         0q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Br5WfYiTc37TH3IA3cWwwQvBdeV/BPdpfjqxoTbjUg8=;
        b=my64tfvjeQeRqYr75USgwoerzSpoiKcRItXUPbWgL0F5ixRPaVlbESmhGHaAvmzhlL
         LRv2ZAfsya7eG1xS5nnIaggYJB0iY8CJ3Ffc6gb8u5ET+8YuBuFieF8zsyNTW+hmDuHI
         tY4eqgkfZWQV9OggxgNYYQDLGlGpzyewObIakfbzW9k1Vw+CIvsIK7zKq3Ly3qWBOJ/a
         YosO7ut/bM8IwngQRaFmlQ4tolJb5UIwVvZZQxtccxGgYuc41qkK7l0RcqmYadHg4pfk
         EDLKypqW/QI01qVEaZ8Xua/D4uq8q3JZUSpva6ssSZGLxD/8e+wBw/+N/yOgIIQeeUPr
         udWQ==
X-Gm-Message-State: AOAM5306xva1VtjSA/H6wRdf0Tf1nxAU9fy9V/+piJFLQk0jCCU0LOL2
        rLPWo0zB+xBQJSYUnJ4w43SzUZFuNP48yXzb5Yy9G8yDw5U=
X-Google-Smtp-Source: ABdhPJxQ6vukwqgYAso2HtDl4olPJlAPhHEDkugkY9sHGK03iZx+0X4RXJF67ZQjXjdGFfz53L/S+5nppyW0SRY2Ae4=
X-Received: by 2002:a2e:9346:: with SMTP id m6mr4880056ljh.130.1642116419137;
 Thu, 13 Jan 2022 15:26:59 -0800 (PST)
MIME-Version: 1.0
References: <CAO_48GF=ttKqSOm9GRoA3Mq+-RQOtRjWp449XPcz-wH=kjaTjw@mail.gmail.com>
 <20220113123406.11520-1-guangming.cao@mediatek.com> <4f88205c1b344aea8608960e2f85b8f4@intel.com>
 <e657f5257cbf4955817b0bbf037de9f9@intel.com> <24157767-dc29-bbdd-5428-d89ecc6b9606@amd.com>
In-Reply-To: <24157767-dc29-bbdd-5428-d89ecc6b9606@amd.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 13 Jan 2022 15:26:47 -0800
Message-ID: <CALAqxLXRtYDNQ8y1efVGa4SwUH_oAaHviZFjsOVSNFmUHnCCeQ@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: dma-heap: Add a size check for allocation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "guangming.cao@mediatek.com" <guangming.cao@mediatek.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>,
        "libo.kang@mediatek.com" <libo.kang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "yf.wang@mediatek.com" <yf.wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "lmark@codeaurora.org" <lmark@codeaurora.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "bo.song@mediatek.com" <bo.song@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "mingyuan.ma@mediatek.com" <mingyuan.ma@mediatek.com>,
        "jianjiao.zeng@mediatek.com" <jianjiao.zeng@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 5:05 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 13.01.22 um 14:00 schrieb Ruhl, Michael J:
> >> -----Original Message-----
> >> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> >> Ruhl, Michael J
> >>> -----Original Message-----
> >>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf O=
f
> >>> guangming.cao@mediatek.com
> >>> +   /*
> >>> +    * Invalid size check. The "len" should be less than totalram.
> >>> +    *
> >>> +    * Without this check, once the invalid size allocation runs on a=
 process
> >>> that
> >>> +    * can't be killed by OOM flow(such as "gralloc" on Android devic=
es), it
> >>> will
> >>> +    * cause a kernel exception, and to make matters worse, we can't =
find
> >>> who are using
> >>> +    * so many memory with "dma_buf_debug_show" since the relevant
> >>> dma-buf hasn't exported.
> >>> +    */
> >>> +   if (len >> PAGE_SHIFT > totalram_pages())
> >> If your "heap" is from cma, is this still a valid check?
> > And thinking a bit further, if I create a heap from something else (say=
 device memory),
> > you will need to be able to figure out the maximum allowable check for =
the specific
> > heap.
> >
> > Maybe the heap needs a callback for max size?
>
> Well we currently maintain a separate allocator and don't use dma-heap,
> but yes we have systems with 16GiB device and only 8GiB system memory so
> that check here is certainly not correct.

Good point.

> In general I would rather let the system run into -ENOMEM or -EINVAL
> from the allocator instead.

Probably the simpler solution is to push the allocation check to the
heap driver, rather than doing it at the top level here.

For CMA or other contiguous heaps, letting the allocator fail is fast
enough. For noncontiguous buffers, like the system heap, the
allocation can burn a lot of time and consume a lot of memory (causing
other trouble) before a large allocation might naturally fail.

thanks
-john
