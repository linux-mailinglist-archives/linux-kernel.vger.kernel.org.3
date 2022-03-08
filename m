Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8DA4D194D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiCHNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347173AbiCHNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:37:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4A496A0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:36:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w7so18583798lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYBVyOw/jQFGIr6GyFmmUL1KjMeFXQPX2EGW015MmY8=;
        b=XEJKHgW+qOM9hCTAxVOsEciI9wGIDg/n2/0NwnRFHY/AvPWXNtqow+SKVqr/L3UYQB
         5LCHnu0y/cBxqFX4Q9xygJRMI1qhWkCucvcUQLYFf4ZIYc1x4v5MtdiZiURsKvRwKp0u
         WBxEke5AQ1sjdbz1Kg9Vvu8DLK/PXkaVZsjotNOYz2zvt7nBC5qB5fik4bWRMkw+waoF
         r+spnuNgehJXE8qnmxWmYYKbLIoSkAA3H7bxIuzsWzHAAe7SI4m8mMzaP1qsvAeCkk2T
         4NI3Kdx0mMN0SKr2hvqlIik3LPHu9tCQwsVe/yZSJD3UnKFGtyYTdxkrE8341CRxg7Hl
         xOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYBVyOw/jQFGIr6GyFmmUL1KjMeFXQPX2EGW015MmY8=;
        b=YDT5ZGlE/EGI7Ceo3RwWCN23mv1X+yrJd4LOkDE+ab6L0jtIg3b1/2XWD5AuCeDE3H
         4K0FOqPzYeV4b5lHHzeMg3JkYSMACMO5jSi+L4pRTaqsT/YyySkNKMZZntbaZT8eNPll
         4Ae47H7SMTyfBMHto4dq0aMgLuK1yvpFu4Xhz9Gr/7slTIXOn3SfyJisj50UDWnLuMXZ
         WmBVve+pa1cdw/D5GNpuIUSoNqoFqPLr0FQMOYWFtmrVe2dHWtv01PHcr0pIJHEqfIsh
         E//gOJACOu0bcRRKy2+2KH2VGXKBeiUzmMuNd7kJjgO83roT9kZaFyxvWzQBG3vdd/XB
         XjXA==
X-Gm-Message-State: AOAM530Iy6KcZVU7KmvA9c8XG12/xqpJ/K+sE1bQic56KoOeFJRtYV3T
        tNrJVdQs1gOCIOKH2U9lraO2NUzhnsa7jVOpmlH61w==
X-Google-Smtp-Source: ABdhPJyaBZXPpHXunr37L3bMLyy0YhR1BIKiVTwgDDKe5fvRDAjPt+D0FS9J/HXwRCPXeCEZQBp0IXJ+JUNhUVcU3sM=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr3948099lfd.184.1646746616253; Tue, 08
 Mar 2022 05:36:56 -0800 (PST)
MIME-Version: 1.0
References: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
 <20220308125445.GE3293@kadam>
In-Reply-To: <20220308125445.GE3293@kadam>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Mar 2022 14:36:19 +0100
Message-ID: <CAPDyKFpdghX5je_Dvy+aam3zmbJpArFocrqURK1LVCZNwAvVSA@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 at 13:55, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sun, Mar 06, 2022 at 06:44:56PM +0100, Christophe JAILLET wrote:
> > A dma_free_coherent() call is missing in the error handling path of the
> > probe, as already done in the remove function.
> >
> > Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > I've not been able to find a Fixes tag because of the renaming of
> > function and files.
> > However, it looks old (before 2008)
>
> You did add a fixes tag and it's from 2012.  :P
>
> > ---
> >  drivers/mmc/host/wmt-sdmmc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> > index 163ac9df8cca..8e18f01c0938 100644
> > --- a/drivers/mmc/host/wmt-sdmmc.c
> > +++ b/drivers/mmc/host/wmt-sdmmc.c
> > @@ -863,6 +863,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
> >       return 0;
> >  fail6:
> >       clk_put(priv->clk_sdmmc);
> > +     dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> > +                       priv->dma_desc_buffer, priv->dma_desc_device_addr);
> >  fail5:
> >       free_irq(dma_irq, priv);
>
> This isn't quite right.  If of_clk_get() fails it should call
> dma_free_coherent() but it does not.  You need to add:
>
>  fail6:
>         clk_put(priv->clk_sdmmc);
> +fail5_and_a_half:
> +       dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_addr);
>  fail5:
>         free_irq(dma_irq, priv);
>
> regards,
> dan carpenter

Thanks Dan for reviewing, I have dropped the $subject patch from my next branch.

Kind regards
Uffe
