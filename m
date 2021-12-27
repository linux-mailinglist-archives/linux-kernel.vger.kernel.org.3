Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17BE4802C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhL0R2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhL0R2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:28:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F4C06173E;
        Mon, 27 Dec 2021 09:28:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so64148171edc.11;
        Mon, 27 Dec 2021 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvswGQErb/IXWp0Ujxv53FZ/wcn6vDPizJMswGWYt8k=;
        b=aEMf3nbv9x24qgp4OFEQiFZrAXHzGkp7M3MCwIk4+HnvH3pFPlLBWPibXCATBAB7DP
         vdfVC5yi2yOPNyV8uSN4FQXnET0HHVlXNmBzYMsz5celB929zqcc+wq/DWXuLSiIo8XI
         kn4uMfielj16oEo/6WczySrmt6COrDTwJyzXPqll3HP4tfqvwi+0I34rMInWidzeFqPK
         EuWZRDPEJr6Un5PnLSlZSEF5pdYuUNfaH+kmOVtcAzGJ7pqh+XkJ3uLpC867HRXqX3Xe
         oKSzX0mgDL4QlclhTiPS6tC08q6usMTM/aQCNgUrJnRNOTqkZ6R6HdJcgNeG5mSz2UE4
         3XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvswGQErb/IXWp0Ujxv53FZ/wcn6vDPizJMswGWYt8k=;
        b=MKdg5jsLh2jP7gee67uxQecmMLDqgTUId8tACahXFMkwy3W+PIQYJqnSG6XGPXE7vt
         MTm8Y3qgLjacoS2sDwm/8E3S6jV//twmsf+/NawlIC9g5UcGLxcGnra6rELKibOxulIf
         KG59MHLjVWbDty+307gsEgMPTuhUHvkLQ33O7AMXna+2c5R5m4b4hpxm/hENixwWb+Dn
         ex/XaUfgYCti1Sj6jRCKljexDwZLafOIZyYfgUJ3y1GG1gtyt0Lvdj009xZHIwuQqjC3
         X/aqWnlphQhjab1y5p5ekbhdnItb5kWd2yh79EFDNPn5OTeLvPev7kQbCGsMhaT1GA9P
         w4Pw==
X-Gm-Message-State: AOAM531FmcHoWr6hby63XS+C/vwuAjbb5XonhNpF7218YjJtPiJbNB4n
        UKmSp58JViLwz+PiGv2x586Dw5/2y6/mGicWHNc=
X-Google-Smtp-Source: ABdhPJwMGxE07ANpk+vQAh+chlk8FEfyr4VtcPtxTYO2uTEqvp91J9JDPq3tRLAak0uFSD/dsB9drtwjBOUh92a1XeY=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr17294314edx.122.1640626110012;
 Mon, 27 Dec 2021 09:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20211227083641.12538-1-axe.yang@mediatek.com> <20211227083641.12538-4-axe.yang@mediatek.com>
In-Reply-To: <20211227083641.12538-4-axe.yang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 19:27:53 +0200
Message-ID: <CAHp75VcVx4Yf69TEoSy8GL-he9ZAW+yvoH8-DXAotQ3Mwx7n2A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mmc: mediatek: add support for SDIO eint irq
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
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 6:46 PM Axe Yang <axe.yang@mediatek.com> wrote:

...

> +       if (mmc->card && !mmc->card->cccr.enable_async_int) {
> +               if (enb)

Spell it fully, i.e. enable.


> +                       pm_runtime_get_noresume(host->dev);
> +               else
> +                       pm_runtime_put_noidle(host->dev);
> +       }

...

> +       int ret = 0;

Redundant assignment, see below.

...

> +       desc = devm_gpiod_get_index(host->dev, "eint", 0, GPIOD_IN);

Why _index variant? By default devm_gpiod_get() uses 0 for index.

> +       if (IS_ERR(desc))
> +               return PTR_ERR(desc);

...

> +       irq = gpiod_to_irq(desc);

ret = ...
if (ret < 0)
  ...handle error...

> +       if (irq >= 0) {

(for the record, 0 is never returned by gpiod_to_irq() according to
all its versions).

> +               irq_set_status_flags(irq, IRQ_NOAUTOEN);

Use corresponding flag:
https://elixir.bootlin.com/linux/latest/source/include/linux/interrupt.h#L83

> +               ret = devm_request_threaded_irq(host->dev, irq, NULL, msdc_sdio_eint_irq,
> +                                               IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +                                               "sdio-eint", host);
> +       } else {
> +               ret = irq;
> +       }
> +
> +       host->eint_irq = irq;

Is it okay if you assign garbage here in case of error?

> +       return ret;

...

> +       host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +       if (IS_ERR(host->pins_eint)) {
> +               dev_dbg(&pdev->dev, "Cannot find pinctrl eint!\n");
> +       } else {
> +               host->pins_dat1 = pinctrl_lookup_state(host->pinctrl, "state_dat1");
> +               if (IS_ERR(host->pins_dat1)) {

> +                       ret = PTR_ERR(host->pins_dat1);
> +                       dev_err(&pdev->dev, "Cannot find pinctrl dat1!\n");

ret = dev_err_probe(...); ?

> +                       goto host_free;
> +               }
> +       }

...

> +       if (!IS_ERR(host->pins_eint)) {

I'm wondering if you can use a pattern "error check first"?

> +               disable_irq(host->irq);
> +               pinctrl_select_state(host->pinctrl, host->pins_eint);
> +               spin_lock_irqsave(&host->lock, flags);
> +               if (host->sdio_irq_cnt == 0) {
> +                       enable_irq(host->eint_irq);
> +                       enable_irq_wake(host->eint_irq);
> +                       host->sdio_irq_cnt++;
> +               }
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +       }

-- 
With Best Regards,
Andy Shevchenko
