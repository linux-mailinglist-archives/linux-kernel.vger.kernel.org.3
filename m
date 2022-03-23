Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B14E4DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiCWIR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiCWIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:17:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE874DF1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:15:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so1371953lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYpa6RfccL7lgQ3DFXF/bjASQpeaVzOGJrxLauNYQAY=;
        b=OI99Ma5dkKGq5xoX1MNtEp35uzOAK4SK9dZLORO5oJylBi9zxnRqcsn/0hFad3Vhw1
         arzXj68X8COLCI8LIvZb4MchqnTHZc5s512bj0YeZ/QAcDfH+/a70AM9uAJ/QDYYlRm3
         sY6VNtDNHJeIJQrOu9zUroGyzadsME86ABmIkr9mKttRx3WB6xiYvxKRqxX+pNGd7M7E
         iqr2Wp9ldFsf8wMXyfidaelJunJuCiKocSLLWCPuFE7lva6lcbHL4WbeAYiMQCEv3hLy
         iiSAIvcjC2f26NWhx0AE8+izwGyAzLquFuiqE+So/cQsNqk15HOS2WD/DkrykOfSVrd/
         OnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYpa6RfccL7lgQ3DFXF/bjASQpeaVzOGJrxLauNYQAY=;
        b=4LxN8hDNBBDhgzroePDC98IUeGQe9uU4kCSMhN+vaGYq4u090Zgg7XcqZhRZ4e1Ysr
         qFcdKlTl6kRTDOtV3/RItoiXJM7hMA55i/Dv1coDwBo/xbYiY1tqbI7kSwpNJsiG40kW
         uOfxMTomP6c+0hWx366Ad/3VXA5fBuUuuoCoMFkkTzk3uFnLsTq+7vTuuiOTFv3iqe56
         cBsZ3vyrlg+fxSNY/74vpZM37x/KlHZCKZ0VBDJrExOwmzRNsMEbvh+gUNiw4vpuSbu5
         pp7kbWnhXi1dA38M4lbSxyw1NdQ1u2hFBK7qEonNUrsr9k95QvnX0JSw2csMiN9kitIG
         VDdA==
X-Gm-Message-State: AOAM533jIuC0wsEaFMXEFN0d+A7iJUod+YpcJcpnOR/8YKMUwDgCgz5b
        hiUtuOjBCTsM1AOt6cDwoEsuB2rd9AO94xuVEePBdQ==
X-Google-Smtp-Source: ABdhPJxXLsL8FKUlSe34JwJ0cRfV0ooDftHOt3TUM6Evsw/1C0Kit2jMagBnuErIWMSnvATB0PDZ18+i+Nd0dmwmeWY=
X-Received: by 2002:a05:6512:130b:b0:44a:3b2d:3a85 with SMTP id
 x11-20020a056512130b00b0044a3b2d3a85mr4929770lfu.358.1648023349398; Wed, 23
 Mar 2022 01:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220317152846.246281-1-ulf.hansson@linaro.org> <98472721-7f3c-3f2b-42a6-d50b51c6191f@foss.st.com>
In-Reply-To: <98472721-7f3c-3f2b-42a6-d50b51c6191f@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Mar 2022 09:15:12 +0100
Message-ID: <CAPDyKFpAmrdZQEAS8Vs98y5LrdYM4OM0srEo1XiNHy1bV6QT7g@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Avoid keeping power to SDIO card unless WOWL is used
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        Christophe KERELLO - foss <christophe.kerello@foss.st.com>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 at 11:47, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/17/22 16:28, Ulf Hansson wrote:
> > Keeping the power to the SDIO card during system wide suspend, consumes
> > energy. Especially on battery driven embedded systems, this can be a
> > problem. Therefore, let's change the behaviour into allowing the SDIO card
> > to be powered off, unless WOWL is supported and enabled.
> >
> > Note that, the downside from this change, is that at system resume the SDIO
> > card needs to be re-initialized and the FW must re-programmed. Even it that
> > may take some time to complete, it should we worth it, rather than draining
> > a battery.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Please note that, I have only compile-tested this patch, so I am relying on help
> > from Yann and others to run tests on real HW.
> >
> > Kind regards
> > Ulf Hansson
> >
> > ---
> >   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 33 +++++++++++--------
> >   1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > index ac02244a6fdf..351886c9d68e 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > @@ -1119,9 +1119,21 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
> >   {
> >       struct brcmf_bus *bus_if = dev_get_drvdata(dev);
> >       struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
> > +     mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(sdiodev->func1);
> >
> > -     brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
> > -     sdiodev->wowl_enabled = enabled;
> > +     /* Power must be preserved to be able to support WOWL. */
> > +     if (!(pm_caps & MMC_PM_KEEP_POWER))
> > +             goto notsup;
> > +
> > +     if (sdiodev->settings->bus.sdio.oob_irq_supported ||
> > +         pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
> > +             sdiodev->wowl_enabled = enabled;
> > +             brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
> > +             return;
> > +     }
> > +
> > +notsup:
> > +     brcmf_dbg(SDIO, "WOWL not supported\n");
> >   }
> >
> >   #ifdef CONFIG_PM_SLEEP
> > @@ -1130,7 +1142,7 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
> >       struct sdio_func *func;
> >       struct brcmf_bus *bus_if;
> >       struct brcmf_sdio_dev *sdiodev;
> > -     mmc_pm_flag_t pm_caps, sdio_flags;
> > +     mmc_pm_flag_t sdio_flags;
> >       int ret = 0;
> >
> >       func = container_of(dev, struct sdio_func, dev);
> > @@ -1142,20 +1154,15 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
> >       bus_if = dev_get_drvdata(dev);
> >       sdiodev = bus_if->bus_priv.sdio;
> >
> > -     pm_caps = sdio_get_host_pm_caps(func);
> > -
> > -     if (pm_caps & MMC_PM_KEEP_POWER) {
> > -             /* preserve card power during suspend */
> > +     if (sdiodev->wowl_enabled) {
> >               brcmf_sdiod_freezer_on(sdiodev);
> >               brcmf_sdio_wd_timer(sdiodev->bus, 0);
> >
> >               sdio_flags = MMC_PM_KEEP_POWER;
> > -             if (sdiodev->wowl_enabled) {
> > -                     if (sdiodev->settings->bus.sdio.oob_irq_supported)
> > -                             enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
> > -                     else
> > -                             sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
> > -             }
> > +             if (sdiodev->settings->bus.sdio.oob_irq_supported)
> > +                     enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
> > +             else
> > +                     sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
> >
> >               if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
> >                       brcmf_err("Failed to set pm_flags %x\n", sdio_flags);
>
> Hi Ulf,
>
> You are missing the counter part in brcmf_ops_sdio_resume:
>
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -1190,14 +1190,13 @@ static int brcmf_ops_sdio_resume(struct device *dev)
>          if (func->num != 2)
>                  return 0;
>
> -       if (!(pm_caps & MMC_PM_KEEP_POWER)) {
> +       if (!sdiodev->wowl_enabled) {
>                  /* bus was powered off and device removed, probe again */
>                  ret = brcmf_sdiod_probe(sdiodev);
>                  if (ret)
>                          brcmf_err("Failed to probe device on resume\n");
>          } else {
> -               if (sdiodev->wowl_enabled &&
> -                   sdiodev->settings->bus.sdio.oob_irq_supported)
> +               if (sdiodev->settings->bus.sdio.oob_irq_supported)
>
> disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
>
>
> Else, we get an oops when calling brcmf_sdio_sleep.

Yes, of course - thanks for reviewing and testing. A v2 is on the way out.

>
>
> Best regards,
> Yann

Kind regards
Uffe
