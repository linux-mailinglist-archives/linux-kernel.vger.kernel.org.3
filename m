Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7C4C0ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiBWJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiBWJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:03:02 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F07CDD1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:02:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j22so12320664wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EGZBf4cf9q35A61ueYdr/S4CUHu1zPEDLp9/agKn7NI=;
        b=ufNvtEpKPdQXuHuBR1mJ7ZfGwsncQrWBH3P2BRwfmsxNOWeW6+c/9BMSyped9jhxXb
         7MHlzjtzP1wNNBBpVBNHBDLGmDjn8zZ3tDkLQiLEqJk1WmtgN0kxnU2h/+s1cEQkzWrP
         IGMVKRZW0EguNlTHlsvA1ntZr7q7TfkMZZn308VMjNAZadPiQXTk9Kh1NndUPc/9QHDl
         TW7+3T6Z1/DKuxaseWDFJVyM6qwtuDYxvmDaIJ2i/ZeGGGWwB8SlTFy7x0Dzd71MMN1E
         shIdrpu6hrgYsKe5PoSX4WNS1Z9o9sS+MmnmtfjQfcmQ0urtr40LgMlwR1ghd/Cd+EG6
         PI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EGZBf4cf9q35A61ueYdr/S4CUHu1zPEDLp9/agKn7NI=;
        b=zUkpjoPTcZDZIaek49rW0g3HT7XRkVDLYBh8xHw598KiYfsA1IDul3V+3S0GE7Wj57
         LBkPDjWLs2AsQTbLVv9BasR4O2DKAbRNJF5sMEZSnSwq2WhwlceiSrwKRkIJrcdMSHJy
         aLsJV0dLgn/QWBya43HRxow+s3xmrKP3tQxhiF2wcQRH6cHDnhNvxJ7bLEYRGOfUZZCh
         dH5ONLbhHsgVYNvBjpBfiono/wjRinjHboZIjNBAaqMJn/73KLVqqc+RwOs1ZfD0sUy9
         pihItEj3TRkBbKxB7+P1+/PmAO9dvsSGGxawfASbZcc8/pySbL91noZLVn8keg3DKXuC
         g0jw==
X-Gm-Message-State: AOAM530lF21vBhIMX2mPZNeRZtekQp/WHqflRStB9TEXcVAGV90P2vrs
        D6mab4mCeaEBS0/ng9D+KaeiPha/q6FHKg==
X-Google-Smtp-Source: ABdhPJzLOz1GtM/ULWkHOgp39Iksy7swcV80uD3anQz9/MUR3cKC0OFZyfOIUltUYWV8XfVFZgvk7w==
X-Received: by 2002:a5d:69ce:0:b0:1e3:2f7f:8f41 with SMTP id s14-20020a5d69ce000000b001e32f7f8f41mr22524558wrw.213.1645606953096;
        Wed, 23 Feb 2022 01:02:33 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p8sm49285543wro.106.2022.02.23.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:02:32 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:02:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/4] mfd: Add support for the MediaTek MT6366 PMIC
Message-ID: <YhX4JkRtrJZDMrY2@google.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-2-johnson.wang@mediatek.com>
 <Ygpbl/pxEVAug6jl@google.com>
 <0e528e1649d49a04ae28590309307789563c6105.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e528e1649d49a04ae28590309307789563c6105.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022, Johnson Wang wrote:

> On Mon, 2022-02-14 at 13:39 +0000, Lee Jones wrote:
> > On Thu, 06 Jan 2022, Johnson Wang wrote:
> > 
> > > This adds support for the MediaTek MT6366 PMIC. This is a
> > > multifunction device with the following sub modules:
> > > 
> > > - Regulator
> > > - RTC
> > > - Codec
> > > - Interrupt
> > > 
> > > It is interfaced to the host controller using SPI interface
> > > by a proprietary hardware called PMIC wrapper or pwrap.
> > > MT6366 MFD is a child device of the pwrap.
> > > 
> > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > ---
> > >  drivers/mfd/mt6358-irq.c             | 1 +
> > >  include/linux/mfd/mt6358/registers.h | 7 +++++++
> > >  include/linux/mfd/mt6397/core.h      | 1 +
> > >  3 files changed, 9 insertions(+)
> > 
> > Applied, thanks.
> > 
> 
> Hi Lee,
> 
> Thank you for your review and response.
> 
> However, it seems that my patches are not applied yet.
> Is it possible to merge my patches into mainline?

Thanks for the nudge.

I just found them on the wrong topic branch.

They are now applied to the correct branch and pushed.

The patches will arrive in -next tomorrow.

Apologies for the fuss.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
