Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584A492292
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbiARJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbiARJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:19:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE4C06161C;
        Tue, 18 Jan 2022 01:19:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c71so76602059edf.6;
        Tue, 18 Jan 2022 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SB0wh1JvYuxb1nJDI7PyGganrQILU5xtGUXZvsW6ko0=;
        b=Eb3i4SvXu8XdwLGqOWL+zhPFAIwvhYqMVIWvCZjfeZ5ZrgYQD20Lhib1bopL3XrTDl
         YRO+tDpWXFKJmz+2BkS0nLE4ds0vw8VwIQblDXUFEDBghIwU93IgPJ5g8rXupxy2Wh2u
         NQfas8Nf0ifp3WNIDFayWkEArYkMRkZ3Rg+hab33gvawGk3aYLJDkfjrZtwqVsSohRkQ
         MbVlMgd+APnIHBIVW4drs9yPcKC9Fq5Z2axKha6s2Q/zUly2ttNFau2Ze08+VZyS4OHp
         2PiRK8RbKEPnCZUwEYIkOE5cun6lc2SmJTZ+9eRdXHaC2yFnmBl3Q1ZSnBsaujANHhuL
         jiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB0wh1JvYuxb1nJDI7PyGganrQILU5xtGUXZvsW6ko0=;
        b=HNWbRh+T8p/gqUp1gRazEL5bPor4/EtUnQF2QkOFXCybXROWUuGPiI7TZ3mEyQSy5P
         Morq0aFT4Zp257YsGzikV1Sd1sgGJPD5KfWKhYzik+bYIw5WjnQzU3mAp7VU0G3Vr2ti
         XBfC0ykw0IQAEp2L7iVw4sTZSXh5N1+C9Wn9dBp4QubctWZgRRjRR0ZA4owZGF+eP+a9
         +8LDvrMtrfQLy2+5ZG/0S5U/MtG2v+Nn+6GGXveKwk0TEWQIVIVOGI9sIwFBJeMFa5HD
         sCR1dzadMRLYI33RiBrWnkoxANRl8Atc+7zJ2jaJ2iD0kZd3RY7PZWqArtzODvCLjwJl
         MrvA==
X-Gm-Message-State: AOAM531X3B3has92CqqO4i16yYat2cppxGpmI5aNV89g4U8s1Hq5wZJk
        ghWqvPxeCB7ot4yWN1y+/je0gCQlBu1Sa0hC0Go=
X-Google-Smtp-Source: ABdhPJxSbMd+HQ6M+bgVFr1+OvobdOGajiL40zRQ24757+JEdYZ/E9oYJtr25sD0StBm4K7Oyl/FGS1x2frkSyRibbQ=
X-Received: by 2002:a17:907:6ea3:: with SMTP id sh35mr5517133ejc.497.1642497573955;
 Tue, 18 Jan 2022 01:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20220117082539.18713-1-axe.yang@mediatek.com> <20220117082539.18713-4-axe.yang@mediatek.com>
In-Reply-To: <20220117082539.18713-4-axe.yang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jan 2022 11:18:57 +0200
Message-ID: <CAHp75VdkKYujGZOdGkLK-tzC9q+RjkX59fFZe5cHajGOnDdL2w@mail.gmail.com>
Subject: Re: [RESEND v3 3/3] mmc: mediatek: add support for SDIO eint IRQ
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yong Mao <yong.mao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 7:33 PM Axe Yang <axe.yang@mediatek.com> wrote:
>
> Add support for eint IRQ when MSDC is used as an SDIO host. This
> feature requires SDIO device support async IRQ function. With this
> feature, SDIO host can be awakened by SDIO card in suspend state,
> without additional pin.
>
> MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> resume, switch GPIO function back to DAT1 mode then turn on clock.
>
> Some device tree property should be added or modified in MSDC node
> to support SDIO eint IRQ. Pinctrls named state_dat1 and state_eint
> are mandatory. And cap-sdio-async-irq flag is necessary since this
> feature depends on asynchronous interrupt:
>         &mmcX {
>                 ...
>                 pinctrl-names = "default", "state_uhs", "state_eint",
>                                 "state_dat1";
>                 ...
>                 pinctrl-2 = <&mmc2_pins_eint>;
>                 pinctrl-3 = <&mmc2_pins_dat1>;
>                 ...
>                 cap-sdio-async-irq;
>                 ...
>         };

...

> +static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
> +{
> +       struct msdc_host *host = dev_id;
> +       struct mmc_host *mmc = mmc_from_priv(host);

> +       unsigned long flags;

Same Q as per v2. Why do you need this?

Yes, you did the first step to the answer, but I want you to go deeper
and tell me why you need the spin_lock_irqsave() variant.

> +       spin_lock_irqsave(&host->lock, flags);
> +       if (likely(host->sdio_irq_cnt > 0)) {
> +               disable_irq_nosync(host->eint_irq);
> +               disable_irq_wake(host->eint_irq);
> +               host->sdio_irq_cnt--;
> +       }
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       sdio_signal_irq(mmc);
> +
> +       return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko
