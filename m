Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8F4F8291
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344560AbiDGPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbiDGPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:12:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E26FDEEF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:10:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g24so7835536lja.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LGWw2kVCEuEDYp9L995BHNM/E/68VFcptn8+/BGALX8=;
        b=DOyRv2vuSsupa+/xHf8iYQRe24gS3+gIvUETnkOdOAE3PkfA9jryAYGFIOA0VvNGtG
         pcibbWNh5jvnPZaQlYGirkgdEj0aTQaq2ceiMSBLR6O9RIDz4tjazTFa+TcIsmsEu5Yn
         +UDx24wv6ek367JuaiDuc5MPZN/X+qBGXsDqQKnAEXUuNAtaipvhsOwLOhNc2BAf//81
         B77iioOOq0/22QrxsG/Y3hunlrfdsCWnU9MkKr5XAkGB1Jg49HDCNj7cx3I78c88rVvM
         R73oMMcs9jsmS6XrHn6PF6pel1rFqQYi6GRVLDl/Ju6Km9M0KPQbhVv2ij2x59Bdo8uQ
         WLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LGWw2kVCEuEDYp9L995BHNM/E/68VFcptn8+/BGALX8=;
        b=hKfBkfFPCGjUe600k0jcTsCUVknIyXxfcBG/4RxGt9h3NUZN4yRMeXW/T6kVfrhh3G
         WoVueImvGWPvQ9hqI3/oYrk4j+9ETfTY7ODP010yrcCg6OfN9V6wX2bJGENyohAscQQA
         5OS9YqmTpdDHsArUu5X6DTP4CNEx6TFpZf8EB8esEXzY4QFNmBaZ63k7wVzZf0uoFvNy
         vifsX/rREhdaWk3TfcuRmAKyz5x/y1K1i2736JXmdlkXn6aWG4lFXyziq//ChwotNpm8
         g1Rt8y/H4Q2dqSVQ6hoC4Ov5QtYZG9mtTxuUsBrNpk4K+yQFjHnKvX7EzPd55Uc7b/37
         Wtkw==
X-Gm-Message-State: AOAM530lK/6+OgEQi5zoZElMLz32dUqAybMG8O9d4LLSyy1HU3O6hHXS
        tds4KgtFs7qSdcGrV+F6/Y2IShV1PtuVw9Wf7b8njQ==
X-Google-Smtp-Source: ABdhPJyLJQXEdkfvIvdV/o+bGlQivaCdVYI5YDT2swQd0R7Wbvq8imZUtER4C/PQOpsmm82Uki4NG0Kpg4leTI1n6AA=
X-Received: by 2002:a2e:8189:0:b0:249:7d3a:ceb0 with SMTP id
 e9-20020a2e8189000000b002497d3aceb0mr8652350ljg.367.1649344223490; Thu, 07
 Apr 2022 08:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220330075255.12127-1-a-govindraju@ti.com> <CAPDyKFoEZPaPG1bGq+nHtyO=FNzSfmwDPtVh5tobSJcctmQD4A@mail.gmail.com>
 <4cc5cc8f-3249-4caf-0c09-995860bd379d@ti.com>
In-Reply-To: <4cc5cc8f-3249-4caf-0c09-995860bd379d@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Apr 2022 17:09:46 +0200
Message-ID: <CAPDyKFo5V8WfcJaZfRAVg6RteTTRDP=uv7SnO4xmE3bdV3rHLg@mail.gmail.com>
Subject: Re: [PATCH RFC] mmc: sdhci_am654: Add support for PM suspend/resume
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Faiz Abbas <faiz_abbas@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 14:24, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Hi Uffe,
>
> On 07/04/22 16:12, Ulf Hansson wrote:
> > + Faiz
> >
> > On Wed, 30 Mar 2022 at 09:53, Aswath Govindraju <a-govindraju@ti.com> w=
rote:
> >>
> >> Add support for suspend/resume and pm_runtime resume/suspend.
> >>
> >> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> >> ---
> >>  drivers/mmc/host/sdhci_am654.c | 204 ++++++++++++++++++++++++++++++--=
-
> >>  1 file changed, 191 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_a=
m654.c
> >> index e54fe24d47e7..e86df72dfd78 100644
> >> --- a/drivers/mmc/host/sdhci_am654.c
> >> +++ b/drivers/mmc/host/sdhci_am654.c
> >> @@ -84,6 +84,7 @@
> >>  #define DRIVER_STRENGTH_40_OHM 0x4
> >>
> >>  #define CLOCK_TOO_SLOW_HZ      50000000
> >> +#define SDHCI_AM654_AUTOSUSPEND_DELAY  100
> >>
> >>  /* Command Queue Host Controller Interface Base address */
> >>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
> >> @@ -791,16 +792,10 @@ static int sdhci_am654_probe(struct platform_dev=
ice *pdev)
> >>
> >>         pltfm_host->clk =3D clk_xin;
> >>
> >> -       /* Clocks are enabled using pm_runtime */
> >> -       pm_runtime_enable(dev);
> >> -       ret =3D pm_runtime_resume_and_get(dev);
> >> -       if (ret)
> >> -               goto pm_runtime_disable;
> >> -
> >>         base =3D devm_platform_ioremap_resource(pdev, 1);
> >>         if (IS_ERR(base)) {
> >>                 ret =3D PTR_ERR(base);
> >> -               goto pm_runtime_put;
> >> +               goto err_pltfm_free;
> >>         }
> >>
> >>         sdhci_am654->base =3D devm_regmap_init_mmio(dev, base,
> >> @@ -808,30 +803,42 @@ static int sdhci_am654_probe(struct platform_dev=
ice *pdev)
> >>         if (IS_ERR(sdhci_am654->base)) {
> >>                 dev_err(dev, "Failed to initialize regmap\n");
> >>                 ret =3D PTR_ERR(sdhci_am654->base);
> >> -               goto pm_runtime_put;
> >> +               goto err_pltfm_free;
> >>         }
> >>
> >>         ret =3D sdhci_am654_get_of_property(pdev, sdhci_am654);
> >>         if (ret)
> >> -               goto pm_runtime_put;
> >> +               goto err_pltfm_free;
> >>
> >>         ret =3D mmc_of_parse(host->mmc);
> >>         if (ret) {
> >>                 dev_err(dev, "parsing dt failed (%d)\n", ret);
> >> -               goto pm_runtime_put;
> >> +               goto err_pltfm_free;
> >>         }
> >>
> >>         host->mmc_host_ops.execute_tuning =3D sdhci_am654_execute_tuni=
ng;
> >>
> >> +       pm_runtime_set_active(dev);
> >> +       pm_runtime_enable(dev);
> >> +       clk_prepare_enable(pltfm_host->clk);
> >
> > I think some error handling is missing, at least for clk_prepare_enable=
().
> >
> >> +       ret =3D pm_runtime_resume_and_get(dev);
> >
> > This can be replaced with a pm_runtime_get_noresume() - and I think it
> > would improve the readability of the code, to put the call above
> > pm_runtime_set_active().
> >
>
> Shouldn't pm_runtime_get_* be only done after we execute
> pm_runtime_enable and pm_runtime_set_active should be called before
> pm_runtime_enable()

pm_runtime_get_noresume() is somewhat special in this regard. It only
bumps the usage count, which is to prevent any following attempts from
runtime suspending the device.

It's perfectly okay to call it, both before and after runtime PM has
been enabled.

>
> "In addition to that, the initial runtime PM status of all devices is
> =E2=80=98suspended=E2=80=99, but it need not reflect the actual physical =
state of the
> device. Thus, if the device is initially active (i.e. it is able to
> process I/O), its runtime PM status must be changed to =E2=80=98active=E2=
=80=99, with
> the help of pm_runtime_set_active(), before pm_runtime_enable() is
> called for the device." [1]
>
>
> Yeah, and I agree that pm_runtime_get_noresume would be better to use
> over here.

Great!

>
> [1] - https://www.infradead.org/~mchehab/kernel_docs/power/runtime_pm.htm=
l
>
>
> >> +       if (ret)
> >> +               goto clk_disable;
> >> +
> >>         ret =3D sdhci_am654_init(host);
> >>         if (ret)
> >> -               goto pm_runtime_put;
> >> +               goto clk_disable;
> >>
> >> +       /* Setting up autosuspend */
> >> +       pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_=
DELAY);
> >> +       pm_runtime_use_autosuspend(dev);
> >> +       pm_runtime_mark_last_busy(dev);
> >> +       pm_runtime_put_autosuspend(dev);
> >>         return 0;
> >>
> >> -pm_runtime_put:
> >> +clk_disable:
> >> +       clk_disable_unprepare(pltfm_host->clk);
> >>         pm_runtime_put_sync(dev);
> >> -pm_runtime_disable:
> >>         pm_runtime_disable(dev);
> >>  err_pltfm_free:
> >>         sdhci_pltfm_free(pdev);
> >> @@ -841,6 +848,7 @@ static int sdhci_am654_probe(struct platform_devic=
e *pdev)
> >>  static int sdhci_am654_remove(struct platform_device *pdev)
> >>  {
> >>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >>         int ret;
> >>
> >>         sdhci_remove_host(host, true);
> >> @@ -848,16 +856,186 @@ static int sdhci_am654_remove(struct platform_d=
evice *pdev)
> >>         if (ret < 0)
> >>                 return ret;
> >>
> >> +       clk_disable_unprepare(pltfm_host->clk);
> >
> > To gate the clock, you need to make sure it has been ungated first. As
> > you anyway need to add a call pm_runtime_get_sync() prior to calling
> > sdhci_remove_host() a few lines above, this would fix it.
> >
>
> This call was the counter part for the clk_enable_prepare called in
> probe(). Yes, and I should have done a pm_runtime_get_sync before
> calling sdhci_remove_host() in sdhci_am654_remove()
>
> > Moreover, the existing call to pm_runtime_put_sync() a few lines above
> > in sdhci_am654_remove(), should be replaced with a call to
> > pm_runtime_put_noidle() - and that call should be made below the call
> > pm_runtime_disable() to become correct.
>
> Again shouldn't we disable pm_runtime after putting the device?

pm_runtime_put_noidle() is special in this regard, it only decreases
the usage count and doesn't try to runtime suspend the device.

It's perfectly okay to call it, both before and after runtime PM has
been enabled.

>
> >
> >>         pm_runtime_disable(&pdev->dev);
> >>         sdhci_pltfm_free(pdev);
> >> +       return 0;
> >> +}

[...]

Kind regards
Uffe
