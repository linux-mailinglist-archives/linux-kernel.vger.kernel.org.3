Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4E52AB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352304AbiEQSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEQSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:43:33 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006928987;
        Tue, 17 May 2022 11:43:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s12so10620095iln.11;
        Tue, 17 May 2022 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVhGpLDPIMJ1jKqNJ7YcIzGSyh+JT6yv1/JRk4Sn7ec=;
        b=gMi7PS/U+eVsyZV+4+T5Y/BzBI6PSpfPyL4+NJnBME872xizvwBiEVMrUeWUiISJ/Q
         8noIsKVTcD9BTxTOXMLNuAbPycbFEqOJ0EObGbasM8L0ffJM1GPyauvuqQsCqFDN1yqf
         C11L/G2psQ2hZo/bTuqD3ayw8IVCWxyBaC2fplqPASTQXTDAajF7ptE5sYVKEh0BUyyx
         OKyntv84UnY2C7KeJ+1V/qezk/LE5ASAvALVWyGVqc2+9pRrmTvwr4rShpDS3lJHZoAA
         S3Kk3JD5eDHNIBYyt2Xo+TU08MmGmCQGaL4EQcv4SoC7tA5U/tx7Q98W3cur2T0Z7Vl0
         BzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVhGpLDPIMJ1jKqNJ7YcIzGSyh+JT6yv1/JRk4Sn7ec=;
        b=cgHbbkoZJKWosg9mWjjQJJhq9TqHWnalCQixJ2/ZdirH51UbMPPqpWqLw6AHSZJAlv
         g7z3jRF7DuT7ibjJwHBA03FiQCuNDL6RTmuUpYdX4p+XjZimdIDAfCmWb3UAkX/yDHbe
         IvawiTvl38RbTVfzY4V2J33p/Q27O2QrfcMNIi5z5xg5g13AoOlD/fxcBNBsZZLlUcGE
         DnRv35vyUwNMraGE8QMjx8IOk9iGw8bdKET+hALnqzM6Imqyhi1K5egfuCNzegCbEIXA
         rUv5Vgn3b8l9IuyLqWXHZu3YaprHo11Dt+26E/S70wBGgS0V2sXHO/j3IALxErf0RjWd
         4TTA==
X-Gm-Message-State: AOAM532bW9gK6lgCT9IAdUL9adBp7yQCsD3rzA6D99nicI98olBbYM30
        rwJRo0pSUmU1QTUROKi0TIvmU6eJumC3SHeZJfc=
X-Google-Smtp-Source: ABdhPJzycJgLl9CuA7DVGkTUkQ5O4qKFkezxWbYAGtfiLBjJsnDdBgDfAvmcKnPArqqfwg7rgAdE911eEd1C2ZXWHW8=
X-Received: by 2002:a05:6e02:160c:b0:2d1:4ba1:b22 with SMTP id
 t12-20020a056e02160c00b002d14ba10b22mr661001ilu.127.1652813011368; Tue, 17
 May 2022 11:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-3-linux.amoon@gmail.com>
 <68969550-e18b-3c27-d449-1478b314e129@linaro.org>
In-Reply-To: <68969550-e18b-3c27-d449-1478b314e129@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:13:16 +0530
Message-ID: <CANAwSgRBpm9gybfUWZbu3-eXLTYkpTZ=s3fmhpNyQcuj7+xdOA@mail.gmail.com>
Subject: Re: [PATCHv2 2/6] thermal: exynos: Reorder the gpu clock
 initialization for exynos5420 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

Hi Krzysztof,

On Sun, 15 May 2022 at 15:11, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 08:41, Anand Moon wrote:
> > Reorder the tmu_gpu clock initialization for exynos5422 SoC.
>
> Why?
It just code reorder
>
> >
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v1: split the changes and improve the commit messages
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 43 ++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 75b3afadb5be..1ef90dc52c08 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -1044,42 +1044,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
> >               dev_err(&pdev->dev, "Failed to get clock\n");
> >               ret = PTR_ERR(data->clk);
> >               goto err_sensor;
> > -     }
> > -
> > -     data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
> > -     if (IS_ERR(data->clk_sec)) {
> > -             if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> > -                     dev_err(&pdev->dev, "Failed to get triminfo clock\n");
> > -                     ret = PTR_ERR(data->clk_sec);
> > -                     goto err_sensor;
> > -             }
> >       } else {
> > -             ret = clk_prepare_enable(data->clk_sec);
> > +             ret = clk_prepare_enable(data->clk);
>
> This looks a bit odd. The clock was before taken unconditionally, not
> within "else" branch...

The whole *clk_sec*  ie tmu_triminfo_apbif clock enable is being moved
down to the switch case.
tmu_triminfo_apbif  clock is not used by Exynos4412 and Exynos5433 and
Exynos7 SoC.

>
>
> Best regards,
> Krzysztof

Thanks & Regards

-Anand
