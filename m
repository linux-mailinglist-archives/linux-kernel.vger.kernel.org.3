Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2CF480B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhL1Qub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhL1Qua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:50:30 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:50:29 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id g13so19402343ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unr2+C9UDbW8T46co3NWa5j1UiNVxrIVSFTa7beJaDM=;
        b=fLI6TYfuxVERwX4QlAsMWHBtyazhhH7HpDqq9l4sB6hNxx2u7vr5Z5bpc1yVLhLM3M
         XzDfksVXzwTQw90OgEc73IIoz2MNlE1guDww3adKA+YxtMEa1Fog0MgGkp6N/NCtlYHI
         ZfJrNLzbW6cFlmsToTU1g//oDp6i0lhWalO3xbae/YE8/3pcIGPv8g5OVMmbM85CiYmq
         XRbJ/c8cyuj266fkDhv/3DcHxCjqaR8QmYICqY5CRauBA9PzG0HjulM4w7HscZ8biyE+
         gRa2x5rlCIm9en6C0K33b3jpB5NYc//MKG2a559PFyANzF69LEB1Pstx2QF+PurfBbrR
         QEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unr2+C9UDbW8T46co3NWa5j1UiNVxrIVSFTa7beJaDM=;
        b=41+wAo8oBe6GMpG89JTEnUjmTIuEUSRUl9rF8gCX5+ckUB1rbHDOFEmzFNJ2z0saRt
         Nn7Ah92AcFgt77IyiqnHcQx8p+EpqPnQqM30BSDk2k22k/HRH/ybyZr6dyvziFqcbGJL
         DrxuJerZ4CCg7ZafAjA7gRfAvADxo7sswkDV6GBKv4SspzHe3RAVInflTiS/e7Dkm12L
         R4loi+D/p8AAGwRIRApUyCJ5Y2AwXxy8Tf5c+c7e0joLznWvo/dtcIUdinFbAtL9+5Sa
         CGG3P8Ws42TGvzE79wrAoJKurF1UcDtk0wDW/+BYPAaxdVAyvrUbkspasPcCMtdpunCC
         TZew==
X-Gm-Message-State: AOAM533WZ0btNYM959OThszIWzYDAI9c0HZgRMStapGwUQmySdOeyp0L
        AGmyOm61Sq83e8D8dngL4J7eTQTWLGMnsTxmWDK+vw==
X-Google-Smtp-Source: ABdhPJwBEuUtMUcZbhEl6kB9GQpPMWkdQ9Cdp5mJhjpHwFTiHW16NBqMZQmm0WuwLvxUjdamhhD+3VQLz0Sej64yIww=
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr14737336ljc.273.1640710227978;
 Tue, 28 Dec 2021 08:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20211222030634.33816-1-michael@allwinnertech.com>
In-Reply-To: <20211222030634.33816-1-michael@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:49:51 +0100
Message-ID: <CAPDyKFoNuWX76Haq0MfvukbHR8mMq0rX7qC+o_ZhEAxAwwpBbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc:sunxi-mmc:add support on discrete device power supply
To:     Michael Wu <michael@allwinnertech.com>
Cc:     mripard@kernel.org, wens@csie.org, samuel@sholland.org,
        andre.przywara@arm.com, jernej.skrabec@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 at 04:07, Michael Wu <michael@allwinnertech.com> wrote:
>
> Because some platform has no regulator, only use discrete devices
> to supply power,For this situation, to use sd/mmc card, we add ocr manually
>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2702736a1c57..afeefead6501 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1300,6 +1300,14 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         if (ret)
>                 return ret;
>
> +       /**
> +        * Some platforms has no regulator. Discrete devices are used instead.
> +        * To support sd/mmc card, we need to add ocr manually.
> +        */
> +       if (!host->mmc->ocr_avail)
> +               host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +

Rather than doing this, I suggest you hook up a fixed vmmc regulator in the DTS.

Nevertheless, it seems reasonable to check that the ocr_avail gets set
up correctly. And if it doesn't, perhaps we should print a warning and
return an error code.

> +
>         host->reg_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(host->reg_base))
>                 return PTR_ERR(host->reg_base);

Kind regards
Uffe
