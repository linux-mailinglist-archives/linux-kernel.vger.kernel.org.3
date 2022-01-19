Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE04941EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiASUhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiASUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:37:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:37:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m3so13259828lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVNoxQMp637bgUGyLKUQMTT6jCUfGMhBKrAhjOzC1jA=;
        b=Vw/hy5bg5C+CCYO+oJtgWYZCGRowuXfpuM1y/pli43kr+OiB3OWzkR6ZyW+nfXxt/s
         VAn2AjX3mL+nlHsEF9z/pBhrlFgPcsEA0h1sAo1ZC4YcWsIWZ0jeb+wpDXa+U2omlUCF
         pf/73OVbaBLU61/xMVSHktQI827IhnQn2hI4w8Tkbj/fmE8A6Xntpo4ktyfN/ATLaSyR
         OmbGO1wuYpDN6JCPJ6apqXqpoeOCB/ZbqWFXSeJZIDyaqZ4S0vxFtOgFaUm3xw+cnlGx
         I1oFnxocUDYadU9R73MgSd6PbQAJyeaWf6JpFnbLe1rT3w0y4YtI4EsZ5WHxq0hL/Blm
         wwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVNoxQMp637bgUGyLKUQMTT6jCUfGMhBKrAhjOzC1jA=;
        b=MpuveFq9I6XMiNEH9wg3gHKo8aRhwiPj37bIV/cjWUWccsAD5KCbMTeu21dqPFTeUU
         /Vn1QASvXZ7OQFzRTXey6iMXaRyOzopQ+7Az1s6nIhKnvNLq4iye35I+34cPf+Og3SKE
         L/xMgAUFGOJ9qCfXQ7I+cQf+/lQy5iRp2miGSvU5tPgcFspXLYwj5I13wDwmEZSItkb8
         om1dERAAZLRlLi7Pcy4/jOOpzVUDqDa8wgQ9EzCm5UIgx5q7tgzaHUEquzUcb0nttLVp
         dNdauS3EU+nE7nDV4GRf+Ytkh71WaV0Y2JUSdhoxVitrytWh7g+vq6glEGD3I2LycbPF
         gnEQ==
X-Gm-Message-State: AOAM533hy/KMR1Q4C+kxdin8L8uLm4pyyKVKwoayJ0eqRMtkR5QC6fw0
        +IadOMnFgMuaFj4Q1dyT9d9g2E1D12KA+QKc2XMiYg==
X-Google-Smtp-Source: ABdhPJwjspQiMNHOBlTaaj+hdTY9hJrpsFobebo94UsQ78o3vrS70VesOp4vSiK9m1G+NqmP7oa+dvJBc2Sn675qSo0=
X-Received: by 2002:a05:6512:329b:: with SMTP id p27mr30040874lfe.36.1642624659492;
 Wed, 19 Jan 2022 12:37:39 -0800 (PST)
MIME-Version: 1.0
References: <CAO_48GF=ttKqSOm9GRoA3Mq+-RQOtRjWp449XPcz-wH=kjaTjw@mail.gmail.com>
 <20220113123406.11520-1-guangming.cao@mediatek.com> <4f88205c1b344aea8608960e2f85b8f4@intel.com>
 <e657f5257cbf4955817b0bbf037de9f9@intel.com> <24157767-dc29-bbdd-5428-d89ecc6b9606@amd.com>
 <CALAqxLXRtYDNQ8y1efVGa4SwUH_oAaHviZFjsOVSNFmUHnCCeQ@mail.gmail.com>
 <6b8182a1-7cdc-7369-5c34-e6d0c24efcca@amd.com> <82faa62f1bc946cf2f9ee2f7d15c567162238eab.camel@mediatek.com>
 <CALAqxLUSjHoLpgFLcvqmDfv7Uip2VwHS5d_5x2nzw=P3rA2NDA@mail.gmail.com> <f09938519f1fcf51f20a0de5eb4063b0ff1a1e87.camel@mediatek.com>
In-Reply-To: <f09938519f1fcf51f20a0de5eb4063b0ff1a1e87.camel@mediatek.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 19 Jan 2022 12:37:27 -0800
Message-ID: <CALAqxLUtK8V9LgC-DY+tkzFYyWfzF+JhbrLZk6UhEG57HQBDSA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: dma-heap: Add a size check for allocation
To:     "Guangming.Cao" <guangming.cao@mediatek.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 1:58 AM Guangming.Cao
<guangming.cao@mediatek.com> wrote:
> On Fri, 2022-01-14 at 17:17 -0800, John Stultz wrote:
> > If the max value is per-heap, why not enforce that value in the
> > per-heap allocation function?
> >
> > Moving the check to the heap alloc to me seems simpler to me than
> > adding complexity to the infrastructure to add a heap max_size
> > callback. Is there some other use for the callback that you envision?
> >
>
> If you think max the value is per-heap, why not add an optional
> callback for dma-heap to solve this issue(prevent consuming too much
> time for a doomed to fail allocation), if the dma-heap doesn't have a
> special size check, just use the default value(totalram) in dma-heap
> framework to do the size check.

As the totalram default isn't correct for all heaps (or necessarily
even most heaps), so those heaps would need to implement the callback.

I'm just not sure adding complexity to the framework to address this
is useful. Instead of an additional check in the allocation function,
heap implementers will need to assess if the default logic in a
framework is correct, and then possibly implement the callback.

> Yes, for linux dma-heaps, only system-heap needs it, so adding it in
> system heap is the simplest. However, there are many vendor dma-heaps
> like system-heap which won't be uploaded to linux codebase, and maybe
> have same limitation, all these heaps need to add the same limitation.

My worry is that without seeing these vendor heaps, this is a bit of a
theoretical concern. We don't have the data on how common this is.
I very much hope that vendors can start submitting their heaps
upstream (along with drivers that benefit from the heaps). Then we can
really assess what makes the most sense for the community maintained
code.


> I just think it's boring. However, If you think discussing these absent
> cases based on current linux code is meaningless, I also agree to it.

So, as a rule, the upstream kernel doesn't create/maintain logic to
accommodate out of tree code.

Now, I agree there is the potential for some duplication in the checks
in the allocation logic, but until it affects the upstream kernel,
community maintainers can't really make an appropriate evaluation.

As a contra-example, if the allocation is some extreme hotpath, adding
an extra un-inlinable function pointer traversal for the size callback
may actually have a negative impact. This isn't likely but again, if
we cannot demonstrate it one way or the other against the upstream
tree, we can't figure out what the best solution might be.


> So, to summarize, if you still think adding it in system_heap.c is
> better, I also agree and I will update the patch to add it in
> system_heap.c

I think this is the best solution for now. As this is not part of an
userland ABI, we can always change it in the future once we see the
need.

thanks
-john
