Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635E4CAA42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiCBQdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiCBQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:32:55 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B948CD5C3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:32:11 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2db2add4516so24369847b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LO5WlNvmvZK+Oe3F8SgCWtBRKkuwTSqsf3nKZO8NpGw=;
        b=rQ+xoLWBOrUuyyiRpsDclceteFY2IhtdY3S1QgAphXs7eZGBhLd7cqJOWgfohTuywI
         6EtERWFWDRyGoCVOtYlaxp8MvdjrcUEp8Y2ETlw0L/o1L9kh644xH+DMZGJ4Fjv11kla
         lmUdvoHa2QAxTShxhU76evBZUqKBsRHYgntNvBbF2xzbYqOp5/UtdcOAwHiRMpdwnZEH
         HvpQdBSAWpBLOwKhr3NAU1H7eCTNvYh66GHVAyksh9YQmUIF/WJbCtMU32HNCezQFE2K
         P60R4IKI3I8xGibc7EXp+012/DjlxAtFEjY0LOCaO2zB4uRM0d6bxrn2gLN69sZhJmnL
         1qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LO5WlNvmvZK+Oe3F8SgCWtBRKkuwTSqsf3nKZO8NpGw=;
        b=5/JDBTNWZKuE3lhIWANxDznwmDdO8AjiagybQMDLx9qurHm98ywk2I9LUsUxXKkv/8
         lOFYTbSyOsp9DXaZzF4vbzdQkRQ2nHx1nZnb4c+qoe2S8OfEUVlk6ep5r62Q5G1nKfFM
         nnytgFllqKQmnLh4a4uyw1aYFLm8ZbIgpX4vBmuhMRZSKOdUdQiF+x9JyrzDOEWgcLCi
         MU4b5MWppMoyLRkuY2Kz9DONf0RhS5lnd+EGMNaIjI1Y85RJGQUk8bPetNILX728GHr7
         hWAPrLl+lMMS/eQCyE58mQwe8NIneavDzPajS9bzrXzD+yOzPEm0A7e1RE15AAOvUlVo
         mNhg==
X-Gm-Message-State: AOAM530HrUZws6idYhWk1FVO8D9v+DY6m6NbDqtRSEPnHQEMhBQKV8hK
        h6o7Hi9uixL+wjXvnhQyXtR5cb8LINhMuPOHedrmuQ==
X-Google-Smtp-Source: ABdhPJy20CqTfg/b4Kwe/+MSKeEIl2hwemy2gJAakPTfyyyh1giylFzAN+jri1ofxNxyLIjhIrUI9y2yUAVa1c7Mua8=
X-Received: by 2002:a81:188b:0:b0:2db:d9d0:d19 with SMTP id
 133-20020a81188b000000b002dbd9d00d19mr9728621ywy.309.1646238730504; Wed, 02
 Mar 2022 08:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20220225125553.1185108-1-benchuanggli@gmail.com>
 <20220225125553.1185108-2-benchuanggli@gmail.com> <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
 <4b35e465-626a-7218-ed9a-4e5cf28c1ccc@intel.com> <CACT4zj9AxpOuDn-1fFAgY7Y-X_w+OHisASpa6tUBHQZuSExjFQ@mail.gmail.com>
 <CAPDyKFp-XrLOSUAbsW5JGNCs6aO8Gp1YgmkqiwVpN5byO1XXCQ@mail.gmail.com> <CACT4zj_6k=0gNRw=EFHR=9-7fWJ=bT4Q1VsPMWrkVPftjLb=Hw@mail.gmail.com>
In-Reply-To: <CACT4zj_6k=0gNRw=EFHR=9-7fWJ=bT4Q1VsPMWrkVPftjLb=Hw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 17:31:33 +0100
Message-ID: <CAPDyKFoe1BmQBzmd0uXYTdOEZU21wFtUDyU0vAq8+yzqJhKpzA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        SeanHY.Chen@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
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

On Wed, 2 Mar 2022 at 12:56, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi,
>
> On Wed, Mar 2, 2022 at 6:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 2 Mar 2022 at 03:10, Ben Chuang <benchuanggli@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Mar 1, 2022 at 6:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > >
> > > > On 28/02/2022 19:03, Ulf Hansson wrote:
> > > > > On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
> > > > >>
> > > > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > >>
> > > > >> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> > > > >> gated of upstream port can be enabled.
> > > > >>
> > > > >> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > > >> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
> > > > >> ---
> > > > >>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
> > > > >>  1 file changed, 54 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > > > >> index 97035d77c18c..cf99b6af792d 100644
> > > > >> --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > >> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > >> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> > > > >>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > > >>  }
> > > > >>
> > > > >> +#ifdef CONFIG_PM
> > > > >> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> > > > >> +{
> > > > >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> > > > >> +       struct sdhci_host *host = slot->host;
> > > > >> +       u16 clock;
> > > > >> +
> > > > >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > > >> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> > > > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > > > >> +
> > > > >> +       return 0;
> > > > >> +}
> > > > >> +
> > > > >> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> > > > >> +{
> > > > >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> > > > >> +       struct sdhci_host *host = slot->host;
> > > > >> +       ktime_t timeout;
> > > > >> +       u16 clock;
> > > > >> +
> > > > >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > > >> +
> > > > >> +       clock |= SDHCI_CLOCK_PLL_EN;
> > > > >> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> > > > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > > > >> +
> > > > >> +       timeout = ktime_add_ms(ktime_get(), 150);
> > > > >> +       while (1) {
> > > > >> +               bool timedout = ktime_after(ktime_get(), timeout);
> > > > >> +
> > > > >> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > > >> +               if (clock & SDHCI_CLOCK_INT_STABLE)
> > > > >> +                       break;
> > > > >> +               if (timedout) {
> > > > >> +                       pr_err("%s: PLL clock never stabilised.\n",
> > > > >> +                              mmc_hostname(host->mmc));
> > > > >> +                       sdhci_dumpregs(host);
> > > > >> +                       break;
> > > > >> +               }
> > > > >> +               udelay(10);
> > > > >> +       }
> > > >
> > > > Could use something like read_poll_timeout() here e.g.
> > > >
> > > >         if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> > > >                               1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> > > >                 pr_err("%s: PLL clock never stabilised.\n",
> > > >                        mmc_hostname(host->mmc));
> > > >                 sdhci_dumpregs(host);
> > > >         }
> > > >
> > > >
> > >
> > > Thanks for the tip. I will prepare the next patch.
> > >
> > > > >> +       clock |= SDHCI_CLOCK_CARD_EN;
> > > > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > > > >> +
> > > > >> +       return 0;
> > > > >> +}
> > > > >
> > > > > Both functions above look very similar to what sdhci_set_clock() does.
> > > > > Can you use that, rather than open coding the above?
> > > > >
> > >
> > > The codes turn on/off the clock but it doesn't change the clock.
> > > Using sdhci_set_clock()  needs to store the clock value because it
> > > clears the clock.
> >
> > Well, in that case at least you can call sdhci_enable_clk() from
> > gl9763e_runtime_resume(), rather than open coding it (the code looks
> > like a direct copy of that code). All you need is to give the
> > sdhci_enable_clk() the correct "clk" as in-parameter.
> >
>
> I want to explain a little more,
> gl9763e is used as a boot disk controller.
> In gl9763e_runtime_suspend(), gl9763e still needs the internal clock to keep states.
> So gl9763e_runtime_suspend() only clears SDHCI_CLOCK_PLL_EN and SDHCI_CLOCK_CARD_EN.
> The SDHCI_CLOCK_INT_EN is still one (1) In runtime suspend,
>
> If using sdhci_enable_clk()  in gl9763e_runtime_resume(), sdhci_enable_clk()
> only fills one (1) to this bit (SDHCI_CLOCK_INT_EN) again, it cannot cause internal stable bit
> (SDHCI_CLOCK_INT_STABLE) to one for gl9763e in the first while loop.

Okay, I get it now, thanks for clarifying.

In any case, the loop in sdhci_enable_clk() that polls the
SDHCI_CLOCK_CONTROL register to see if the SDHCI_CLOCK_INT_STABLE is
set, could perhaps be split out to a function that you can use here as
well.

[...]

Kind regards
Uffe
