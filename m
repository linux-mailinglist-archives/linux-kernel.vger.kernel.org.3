Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0746313A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhK3Kmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhK3Kmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:42:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFADC061574;
        Tue, 30 Nov 2021 02:39:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id DCCEB1F44F18
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638268765; bh=1km00PSkhoaXgOQeLq++0nilbR4fWVerb1bawqQEQb0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JyqMgo7uzB4M6kSMJ0Pw+3aHFxmxQFslMe3uhJaqEHgb+ur/1XV9ShSmGwOHHvjd2
         z9iXnA0yZZkImCokRx7ONjoNUWy3wr09V91pSrrOjPgG+G6MdPl1VEynHxKZR/jrWc
         OWZg+pJMPLAMdtGFoMjTCuR6s8dAipvcVAcRBBxtWVGvunOsxD0WJkG9LrXQfC4jct
         wc0jzUPuLVNXw9J7a1xI+09g+PYxFtPHaNH48bziSKnAFRNrujj/NxAMmAPzLUlUfl
         bV2fSqIFxYi7LCFE0jCnOyYpJToBweFJEEnnaDraojxl4qHEwLcV2atGEgCM2/IXJR
         p2pRGzirju6lQ==
Subject: Re: [PATCH 1/7] media: hantro: add support for reset lines
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-media <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Robert Beckett <bob.beckett@collabora.com>
References: <20211122184702.768341-1-jernej.skrabec@gmail.com>
 <20211123145933.GD6514@kadam>
 <c474e2b5-8900-a7ca-620d-e03a284cf0fb@collabora.com>
 <9986998.nUPlyArG6x@kista>
 <CAAEAJfD3d4zjwvbv967+oe6awnAkZiGNKroYF5jvoTy=0sn+Pw@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <272ca19e-749e-92fb-bcfa-ca695b3b9ed6@collabora.com>
Date:   Tue, 30 Nov 2021 11:39:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAAEAJfD3d4zjwvbv967+oe6awnAkZiGNKroYF5jvoTy=0sn+Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

W dniu 23.11.2021 o 19:07, Ezequiel Garcia pisze:
> Hi all,
> 
> Reset logic tends to be highly integration-specific, so it  could be more robust 
> to deal  with this in  the machine specific file. I have some vague recollection 
> of our experience here when we  integrated vc8000 last year, but I cannot recall 
> the outcome.
> 

Do you mean vpu->variant->init()?

That is the very first thing we do after the devm_*() calls. So any subsequent
initialization that fails would want vpu->variant->deinit(). Maybe at this
moment handling the resets at the common level is simpler? Existing drivers
will get NULL anyway from devm_reset_control_array_get().

Regards,

Andrzej

> I'm Ccing Bob who might remember better.
> 
> Thanks,
> Ezequiel
> 
> 
> 
> El mar., nov. 23, 2021 1:46 PM, Jernej Škrabec <jernej.skrabec@gmail.com 
> <mailto:jernej.skrabec@gmail.com>> escribió:
> 
>     Hi all,
> 
>     Dne torek, 23. november 2021 ob 17:36:57 CET je Andrzej Pietrasiewicz
>     napisal(a):
>      > Hi Dan, hi Jernej,
>      >
>      > W dniu 23.11.2021 o 15:59, Dan Carpenter pisze:
>      > > On Tue, Nov 23, 2021 at 12:09:03PM +0100, Andrzej Pietrasiewicz wrote:
>      > >>> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/
>     media/hantro/hantro_drv.c
>      > >>> index ab2467998d29..8c3de31f51b3 100644
>      > >>> --- a/drivers/staging/media/hantro/hantro_drv.c
>      > >>> +++ b/drivers/staging/media/hantro/hantro_drv.c
>      > >>> @@ -905,6 +905,10 @@ static int hantro_probe(struct platform_device
>     *pdev)
>      > >>>                           return PTR_ERR(vpu->clocks[0].clk);
>      > >>>           }
>      > >>> + vpu->resets = devm_reset_control_array_get(&pdev->dev, false,
>     true);
>      > >>> + if (IS_ERR(vpu->resets))
>      > >>> +         return PTR_ERR(vpu->resets);
>      > >>> +
>      > >>>           num_bases = vpu->variant->num_regs ?: 1;
>      > >>>           vpu->reg_bases = devm_kcalloc(&pdev->dev, num_bases,
>      > >>>                                         sizeof(*vpu->reg_bases),
>     GFP_KERNEL);
>      > >>> @@ -978,10 +982,16 @@ static int hantro_probe(struct platform_device
>     *pdev)
>      > >>>           pm_runtime_use_autosuspend(vpu->dev);
>      > >>>           pm_runtime_enable(vpu->dev);
>      > >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      > > It looks like this is the pm stuff that we have to unwind on error
>      > >
>      > >>> + ret = reset_control_deassert(vpu->resets);
>      > >>> + if (ret) {
>      > >>> +         dev_err(&pdev->dev, "Failed to deassert resets\n");
>      > >>> +         return ret;
>      > >                  ^^^^^^^^^^
>      > > So this return should be a goto undo_pm_stuff
>      > >
>      > >
>      > >>> + }
>      > >>> +
>      > >>>           ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
>      > >>>           if (ret) {
>      > >>>                   dev_err(&pdev->dev, "Failed to prepare clocks\n");
>      > >>> -         return ret;
>      > >
>      > > And this return should also have been a goto so it's a bug in the
>      > > original code.
>      >
>      > So we probably want a separate patch addressing that first, and then
>      > the series proper on top of that.
> 
>     I was just about to suggest that.
> 
>     Other drivers usually enable PM last, so they don't have PM calls in unwind
>     code. However, I think current approach is just as valid (with a fix).
> 
>     Best regards,
>     Jernej
> 
>      >
>      > Regards,
>      >
>      > Andrzej
>      >
>      > >
>      > >>> +         goto err_rst_assert;
>      > >>
>      > >> Before your patch is applied if clk_bulk_prepare() fails, we
>      > >> simply return on the spot. After the patch is applied not only
>      > >> do you...
>      > >>
>      > >>>           }
>      > >>>           ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
>      > >>> @@ -1037,6 +1047,8 @@ static int hantro_probe(struct platform_device
>     *pdev)
>      > >>>           v4l2_device_unregister(&vpu->v4l2_dev);
>      > >>>    err_clk_unprepare:
>      > >>>           clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
>      > >>> +err_rst_assert:
>      > >>> + reset_control_assert(vpu->resets);
>      > >>
>      > >> ...revert the effect of reset_control_deassert(), you also...
>      > >>
>      > >>>           pm_runtime_dont_use_autosuspend(vpu->dev);
>      > >>>           pm_runtime_disable(vpu->dev);
>      > >>
>      > >> ... do pm_*() stuff. Is there any reason why this is needed?
>      > >
>      > > So, yes, it's needed, but you're correct to spot that it's not
>      > > consistent.
>      > >
>      > > regards,
>      > > dan carpenter
>      > >
>      >
>      >
> 
> 

