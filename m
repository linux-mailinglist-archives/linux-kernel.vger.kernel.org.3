Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81E4CA1B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiCBKFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiCBKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:05:18 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED060AB4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:04:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f37so1847275lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGGCf1t6KZ4yLzYm6kfjSleskg8fXftKyp2MSN7X+GI=;
        b=ot2WEYDUyrXvO7hA2eL1i2/jsYoH1NiwUJRmIqd7iM7OzIhxKOdDc3z+bUpeE6Mwvu
         gDwaBBwuCAvsKGIO41fxyH2PYCuq8/mPJVORAXR0EcjOuy6yBdj7PxpxWhZTJ6gRWewt
         +MkatMJ79g7HEwG5I5YlE86W+X1j7RlQ14ZIoz57AkS7IXEdK5TOy+JPp+uJOrsGSe5/
         L3X2BeYfIu0auAfBa5WAS2tE9MdrRccrsdbViDpY9uBJDJqqTXlFEkGemPMnETKnXayH
         wW+skD5ErSKl5XzbFJep1NAuKQlsOKOoE1pLJMj0VA4t5RKU/3XOKQFr1HUWDRhD/afQ
         HkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGGCf1t6KZ4yLzYm6kfjSleskg8fXftKyp2MSN7X+GI=;
        b=E+wCL5k0UtZfuNqycgRK2ylvOfvC9bB4aMYnYrD1tMoHPrdXMQ14G0tAAG8kSWqpLw
         xIu/Y5FCb8zV9OsH45Amh565TfWmSLF2yz4LaYq5qF2NZoSGfLE0KwmRNKZKXpjtF0fr
         I+n2ycSUdzTZNKFMhXpfJmWYe9VnLeVZ4TxhWt5FP1gZuNAf/tPG15pGwJldjgPNbgn8
         P0WpCxOkpikLo/CMolE1Sdbd5P4sGqVvXFElLhkMstuojQEbWkN2Gnj0PW5EyVDOSdqT
         E40t6TjUGdoBkBtLm7/An7TMhs3Dd197fNYExjUzsj0TnElqNECrYOihn2tXxN7rjU8S
         qyMg==
X-Gm-Message-State: AOAM531Mn8/oCxq10ySQhkA/guK547RW7dDGcP9FOGx86N4ppBdDzWmE
        eaqBn5CdJ8xt+HhIKSvQseqkOD4hCu3LF16+TWajSA==
X-Google-Smtp-Source: ABdhPJyOa+dkkdCyPw8mxpIDiJcZ9NHeddBdPoHR2YLCv4wxRM0ahl8Avuguw3KZnyb306cdXQGjOYvuG6f5hnImFKE=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr18201622lfj.254.1646215469277; Wed, 02
 Mar 2022 02:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20220225125553.1185108-1-benchuanggli@gmail.com>
 <20220225125553.1185108-2-benchuanggli@gmail.com> <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
 <4b35e465-626a-7218-ed9a-4e5cf28c1ccc@intel.com> <CACT4zj9AxpOuDn-1fFAgY7Y-X_w+OHisASpa6tUBHQZuSExjFQ@mail.gmail.com>
In-Reply-To: <CACT4zj9AxpOuDn-1fFAgY7Y-X_w+OHisASpa6tUBHQZuSExjFQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 11:03:52 +0100
Message-ID: <CAPDyKFp-XrLOSUAbsW5JGNCs6aO8Gp1YgmkqiwVpN5byO1XXCQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 03:10, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi,
>
> On Tue, Mar 1, 2022 at 6:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 28/02/2022 19:03, Ulf Hansson wrote:
> > > On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
> > >>
> > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>
> > >> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> > >> gated of upstream port can be enabled.
> > >>
> > >> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
> > >> ---
> > >>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
> > >>  1 file changed, 54 insertions(+)
> > >>
> > >> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > >> index 97035d77c18c..cf99b6af792d 100644
> > >> --- a/drivers/mmc/host/sdhci-pci-gli.c
> > >> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > >> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> > >>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > >>  }
> > >>
> > >> +#ifdef CONFIG_PM
> > >> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> > >> +{
> > >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> > >> +       struct sdhci_host *host = slot->host;
> > >> +       u16 clock;
> > >> +
> > >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > >> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > >> +
> > >> +       return 0;
> > >> +}
> > >> +
> > >> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> > >> +{
> > >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> > >> +       struct sdhci_host *host = slot->host;
> > >> +       ktime_t timeout;
> > >> +       u16 clock;
> > >> +
> > >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > >> +
> > >> +       clock |= SDHCI_CLOCK_PLL_EN;
> > >> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > >> +
> > >> +       timeout = ktime_add_ms(ktime_get(), 150);
> > >> +       while (1) {
> > >> +               bool timedout = ktime_after(ktime_get(), timeout);
> > >> +
> > >> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > >> +               if (clock & SDHCI_CLOCK_INT_STABLE)
> > >> +                       break;
> > >> +               if (timedout) {
> > >> +                       pr_err("%s: PLL clock never stabilised.\n",
> > >> +                              mmc_hostname(host->mmc));
> > >> +                       sdhci_dumpregs(host);
> > >> +                       break;
> > >> +               }
> > >> +               udelay(10);
> > >> +       }
> >
> > Could use something like read_poll_timeout() here e.g.
> >
> >         if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> >                               1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> >                 pr_err("%s: PLL clock never stabilised.\n",
> >                        mmc_hostname(host->mmc));
> >                 sdhci_dumpregs(host);
> >         }
> >
> >
>
> Thanks for the tip. I will prepare the next patch.
>
> > >> +       clock |= SDHCI_CLOCK_CARD_EN;
> > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > >> +
> > >> +       return 0;
> > >> +}
> > >
> > > Both functions above look very similar to what sdhci_set_clock() does.
> > > Can you use that, rather than open coding the above?
> > >
>
> The codes turn on/off the clock but it doesn't change the clock.
> Using sdhci_set_clock()  needs to store the clock value because it
> clears the clock.

Well, in that case at least you can call sdhci_enable_clk() from
gl9763e_runtime_resume(), rather than open coding it (the code looks
like a direct copy of that code). All you need is to give the
sdhci_enable_clk() the correct "clk" as in-parameter.

>
> > > Other than that, I would appreciate it if Adrian could have a look at
> > > this too. For example, I wonder if perhaps
> > > sdhci_runtime_suspend|resume_host() should be called in these paths
> > > too.
> >
> > Assuming the host controller does not lose state information, it should be fine.
> >
>
> Yes, the host always has aux. power and keep state.
>
> Thank you both for your comments.

Okay, thanks for confirming!

[...]

Kind regards
Uffe
