Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17552FA7E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiEUJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349907AbiEUJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:51:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723225641D;
        Sat, 21 May 2022 02:51:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o16so6937650ilq.8;
        Sat, 21 May 2022 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tJ3wJ8Zdt9XhT+IGej+mRCHHGWY+7eB7aTqh81bNi8=;
        b=LyKHvjiTTQZlpIxlbYhPoU3iF4IPHjf5NxfrVW0hpfFsehOhGhCIJczX4JQKRp/nPG
         KaZwT4/Rb/0q/EKYnsoIbRMvkrAX2ExjwWxHQTUz62Ji69/ZnIdxsVzQvPJGQCRAzxGQ
         gf9tFfL3MhP8OKerXF+IYanIZAj2Wq34WMd6ZYwiVPatmXe+li8F47gi8EJ1b3ytiwcf
         fH4PFv8YN1eeswtZN2UyswJljiaoYqyGsvXlnYb1PWRkJBnU1QytXWz6QRUfMLieq4Qw
         Xh56V2XHPtXgwCM0znK/T6NTWsz6gnbqutSX3A1T1DuWF7M8IU5Xk6RHELxJmFB7ac6H
         VVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tJ3wJ8Zdt9XhT+IGej+mRCHHGWY+7eB7aTqh81bNi8=;
        b=HV9Oy/uNVPRMppWMRDmONnjpS/Z2wwbR6I+BclnYFIi/OwgEuOErhaSp6rWWphCJIp
         j/fUOzJsiFIme3PaJzh12Lw6GT1MOwSf4hOu1tw5V810JIm8naeMsqqn8cTyzgJrW+ro
         +o6flMg37HwLBBDQpClVpPN//xfNkZKw5xaRI5ZNezbHLnSoaoN1zZDw74nljDAvr6NZ
         BXkNFkPKv8qD8XsY/c08YPAIHEId6oMBHfeqZMNpEhvVls34zo5U4Y1xf2Unj3SvEKmI
         j23NqQRdQGoOkhzEMPelGHFn6POxRgoyrLDftHXbAfw0IOXHm0bZq+sv/Bg4HJxEDcgT
         AhgQ==
X-Gm-Message-State: AOAM530Zf4OsZkihjbsdEzZINW5ZJipuKlDKNJmn3URhi+Cn0yRHbLS3
        MHdbXWG1wmZiuTZYqpvxf9+iIIKxW3TXDh85RoM=
X-Google-Smtp-Source: ABdhPJwjAT51VSypAN+WRVdDPgokwvFgXtI1FA0eQBI/BOcUy50kiuDCUoPkgQzJMRJHBNEB2HDBbQtEHGZkroxqwG8=
X-Received: by 2002:a05:6e02:188a:b0:2cf:7adc:7a86 with SMTP id
 o10-20020a056e02188a00b002cf7adc7a86mr7468132ilu.276.1653126685896; Sat, 21
 May 2022 02:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-3-linux.amoon@gmail.com>
 <68969550-e18b-3c27-d449-1478b314e129@linaro.org> <CANAwSgRBpm9gybfUWZbu3-eXLTYkpTZ=s3fmhpNyQcuj7+xdOA@mail.gmail.com>
 <a197ed7f-6115-4407-6931-f37b719587be@linaro.org>
In-Reply-To: <a197ed7f-6115-4407-6931-f37b719587be@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 21 May 2022 15:21:09 +0530
Message-ID: <CANAwSgRLFr=3GGQ6AZWnzoL9knJrWCY3ONdozd_pbqhFwgpHvg@mail.gmail.com>
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

On Wed, 18 May 2022 at 12:58, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/05/2022 20:43, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Sun, 15 May 2022 at 15:11, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/05/2022 08:41, Anand Moon wrote:
> >>> Reorder the tmu_gpu clock initialization for exynos5422 SoC.
> >>
> >> Why?
> > It just code reorder
>
> I know what it is. I asked why. The answer in English to question "Why"
> is starting with "Because".
>
> You repeated again the argument what are you doing to my question "Why
> are you doing it".
>
tmu_triminfo_apbif is not a core driver to all the Exynos SOC board
it is only used by the Exynos542x SOC family

If we look into the original code its place in between
the devm_clk_get(data->clk) and clk_prepare(data->clk)
after this change, the code is in the correct order of initialization
of the clock.

> It was the same before, many, many times. It's a waste of reviewers
> time, because you receive a review and you do not implement the feedback.
>
> >>
> >>>
> >>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> v1: split the changes and improve the commit messages
> >>> ---
> >>>  drivers/thermal/samsung/exynos_tmu.c | 43 ++++++++++++++--------------
> >>>  1 file changed, 21 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> >>> index 75b3afadb5be..1ef90dc52c08 100644
> >>> --- a/drivers/thermal/samsung/exynos_tmu.c
> >>> +++ b/drivers/thermal/samsung/exynos_tmu.c
> >>> @@ -1044,42 +1044,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
> >>>               dev_err(&pdev->dev, "Failed to get clock\n");
> >>>               ret = PTR_ERR(data->clk);
> >>>               goto err_sensor;
> >>> -     }
> >>> -
> >>> -     data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
> >>> -     if (IS_ERR(data->clk_sec)) {
> >>> -             if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> >>> -                     dev_err(&pdev->dev, "Failed to get triminfo clock\n");
> >>> -                     ret = PTR_ERR(data->clk_sec);
> >>> -                     goto err_sensor;
> >>> -             }
> >>>       } else {
> >>> -             ret = clk_prepare_enable(data->clk_sec);
> >>> +             ret = clk_prepare_enable(data->clk);
> >>
> >> This looks a bit odd. The clock was before taken unconditionally, not
> >> within "else" branch...
> >
> > The whole *clk_sec*  ie tmu_triminfo_apbif clock enable is being moved
> > down to the switch case.
> > tmu_triminfo_apbif  clock is not used by Exynos4412 and Exynos5433 and
> > Exynos7 SoC.
>
> This is not the answer. Why are you preparing data->clk within else{}
> branch?
>
After cleanly applying the patches I see the below changes.
if you want me to remove the else part below and keep
the original code I am ok.

        data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
        if (IS_ERR(data->clk)) {
                dev_err(&pdev->dev, "Failed to get clock\n");
                ret = PTR_ERR(data->clk);
                goto err_sensor;
        } else {
                ret = clk_prepare_enable(data->clk);
                if (ret) {
                        dev_err(&pdev->dev, "Failed to get clock\n");
                        goto err_sensor;
                }
        }

        switch (data->soc) {
        case SOC_ARCH_EXYNOS5420_TRIMINFO:
                data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
                if (IS_ERR(data->clk_sec)) {
                        dev_err(&pdev->dev, "Failed to get triminfo clock\n");
                        ret = PTR_ERR(data->clk_sec);
                        goto err_clk_apbif;
                } else {
                        ret = clk_prepare_enable(data->clk_sec);
                        if (ret) {
                                dev_err(&pdev->dev, "Failed to get clock\n");
                                goto err_clk_apbif;
                        }
                }
                break;
        case SOC_ARCH_EXYNOS5433:
        case SOC_ARCH_EXYNOS7:
                data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
                if (IS_ERR(data->sclk)) {
                        dev_err(&pdev->dev, "Failed to get sclk\n");
                        ret = PTR_ERR(data->sclk);
                        goto err_clk_sec;
                } else {
                        ret = clk_prepare_enable(data->sclk);
                        if (ret) {
                                dev_err(&pdev->dev, "Failed to enable sclk\n");
                                goto err_clk_sec;
                        }
                }
                break;
        default:
                break;
        }
>
> Best regards,
> Krzysztof

Thanks and Regards

-Anand
