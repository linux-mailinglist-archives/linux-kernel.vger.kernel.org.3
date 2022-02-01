Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5222F4A5837
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiBAIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiBAIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:05:26 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42890C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:05:26 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id q22so22904262ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0PJJMIRjpabG82Db2BkgEWkwXsmVMEfTVi2vjGRhtw=;
        b=izEqZAN6elcstfVcTg/tMHTABwgB/UMX/WOkNRN//agL7z/6AQ8IQpDwjRbjFiOFyW
         NSBjTU+DIpdkHEZSRFsK6dVcNOQXPRBlm+IInH2I4wUMQzKZVRtRzB0KgyZg3h/sWkIF
         P+52Df+wsBiYo+fABOASc+LW2G3zz9xmANft5nYdfMcrNmXe9eCuLBu7ufKU7t845c0w
         qDT1+SS6cYJ+t5Acbj+TXosOfeB5NFVfglRyE7tANu/CnIgwimMAw8vHGbNFYvo9eoDv
         /ap5CD/+2MDDcxr82vy5XgYwsoCyOoR3ymgxdDClfxnWzEMk4tdJbPN0uZwLLmOONJyV
         v1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0PJJMIRjpabG82Db2BkgEWkwXsmVMEfTVi2vjGRhtw=;
        b=hQ5NcL1J82rG8Pf93wMwckjYw87d4jlW3VX1d8Nn1nPHcW879cKPntLa8Z2G1zfqZG
         a1eg94JHhL+7mxRqm6Hrsnti38QE9KfBC6Hz/sJHEPP99D82CF9tJQ0YynueYI5lzGt1
         pdIFpWcfWw+izUh3YWw3iSHQaZEq40bPBl4wX7gdhK5PY3b95iF7ssiDDdLZZx8RUg/Z
         iojl4ZxmEbTFq8soFlo3qANJrPz0DLpCPZRL3A4R4ZBTtRix3kFYGplX8XKSF2Sryf4t
         Bszz7F8CprmjSZHw8bvyIg2OTyb+ANir7ExlUGt2lhbF74hatsL0G5bHveG2vzNQplVN
         sB1w==
X-Gm-Message-State: AOAM530t5swigA+QfJeXzCW1fxtt8JZ/nH9JnVT0bd4jssc/pyMxIoHs
        9+Yh2Jv4PSwP+Ptf+k8q+eSwxdnRb+6gHYP9s0cRbf7eDxc=
X-Google-Smtp-Source: ABdhPJxZwJ8f1U9XZiyGVaA6XDvnmQLDIfQhyp8AtRxgE5A16/QfHpbjmzbDOUwB09+DzDui2DpTkgQ/ryAXMams73Q=
X-Received: by 2002:a2e:a405:: with SMTP id p5mr15566025ljn.121.1643702724483;
 Tue, 01 Feb 2022 00:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20220129150604.3461652-1-jordy@pwning.systems> <CALAqxLU58UYLRNrf4C7t4_SmSa1aUVaDj4SP=zCPfb9m6HBUNw@mail.gmail.com>
In-Reply-To: <CALAqxLU58UYLRNrf4C7t4_SmSa1aUVaDj4SP=zCPfb9m6HBUNw@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 1 Feb 2022 13:35:12 +0530
Message-ID: <CAO_48GGw3bfLdLArCMHNUsiGK_brHZ3D2dQd19wJj2_FoggCUA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Fix potential spectre v1 gadget
To:     John Stultz <john.stultz@linaro.org>
Cc:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jordy,

On Tue, 1 Feb 2022 at 02:09, John Stultz <john.stultz@linaro.org> wrote:
>
> On Sat, Jan 29, 2022 at 7:06 AM Jordy Zomer <jordy@pwning.systems> wrote:
> >
> > It appears like nr could be a Spectre v1 gadget as it's supplied by a
> > user and used as an array index. Prevent the contents
> > of kernel memory from being leaked to userspace via speculative
> > execution by using array_index_nospec.
> >
> > Signed-off-by: Jordy Zomer <jordy@pwning.systems>
Thanks very much for your patch; I've pushed it to drm-misc-fixes, so
we should see it in mainline soon.

> > ---
> >  drivers/dma-buf/dma-heap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 56bf5ad01ad5..8f5848aa144f 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/xarray.h>
> >  #include <linux/list.h>
> >  #include <linux/slab.h>
> > +#include <linux/nospec.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/dma-heap.h>
> > @@ -135,6 +136,7 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
> >         if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
> >                 return -EINVAL;
> >
> > +       nr = array_index_nospec(nr, ARRAY_SIZE(dma_heap_ioctl_cmds));
> >         /* Get the kernel ioctl cmd that matches */
> >         kcmd = dma_heap_ioctl_cmds[nr];
>
> Thanks for submitting this! It looks sane to me.
>
> Acked-by: John Stultz <john.stultz@linaro.org>
>
> thanks
> -john


Best,
Sumit.
