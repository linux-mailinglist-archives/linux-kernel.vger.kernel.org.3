Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA024C9B02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiCBCLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiCBCLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:11:31 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0CA5B3DA;
        Tue,  1 Mar 2022 18:10:49 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id u61so413596ybi.11;
        Tue, 01 Mar 2022 18:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C60qY1W15wmEGzg0Fz5ufhX0jdSdAi/q3wBV4TnaYjQ=;
        b=S+7owdLkkRm9npwuBQoYTXaNBSfly6aAAo0D34rlrWOfTgJxNLyjHujx32fG9LhDXV
         QEGWN4bBqQR1lQNeerH1wR06cftfZ9OFV5J39/pHt5i+I9wGKuqXTaat1f+NwxRarcfw
         aCI3XnTb7JNju2j0Z2YLw/9vD7xRBV0EiC7pL9VxunydQKJxfK/sgL401ybAww+m7cus
         okfhJVHyHYiK5fHxdOodvS8JC3arL6X1YljlirOP34rEbncpCEyhXNDPtXlPAsFU7DN1
         F+f6eyh4ecYbYRKcsAowISBXscOHsyZPgCow8wSsvaWNa3d1bspiF7bZZuAOCjn93J/V
         6uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C60qY1W15wmEGzg0Fz5ufhX0jdSdAi/q3wBV4TnaYjQ=;
        b=TVVVk+1reo2v/BrgabyZefLPsyHfxnE29dgsuYUzDXFpEjuee9J2FIyfz1WhnyUQY5
         EGcWxNrOOGM7AgpBjM3tgRctgTYEUaJ948MId3NY5ymnPzPblJLMsnFtjz5z/mZh1Noq
         +S9SBqpjOSlOpS52bFWD6rWD6WPhtQhdYfByxksjjBiKHQ4JJeSAYTNWZ/MYzQw993za
         QJ5ndmljMgIyRB2UhmkC48sQKV0eGmwOq10vh3R7ESEc7UzI82zw9MIGtrFjtYdQuRbK
         /tHrZsm/tbSfyxO8X5BNBfRkCm9D+U2Y/7+SxSHDtR/IulbIIup2TbiF1q8gtOtP0IiK
         ur7g==
X-Gm-Message-State: AOAM530UopvYiWxvfpetkIlHtO1L2Vc8gS7ih1zfPE531FzqYhSd4Cd0
        9UfrOIPQuC0QQiZ2TiPmb/SksO8Ina87t604deg=
X-Google-Smtp-Source: ABdhPJysAYqmPDrRSXgywEUWgHLhQEhcXeq5Z4WOZrQs7C7dEnCx1oI9LnvuiBNmZH1e/E+3/0b1cpopto+MCsWzhG8=
X-Received: by 2002:a05:6902:83:b0:61a:709b:d841 with SMTP id
 h3-20020a056902008300b0061a709bd841mr25970895ybs.140.1646187048420; Tue, 01
 Mar 2022 18:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20220225125553.1185108-1-benchuanggli@gmail.com>
 <20220225125553.1185108-2-benchuanggli@gmail.com> <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
 <4b35e465-626a-7218-ed9a-4e5cf28c1ccc@intel.com>
In-Reply-To: <4b35e465-626a-7218-ed9a-4e5cf28c1ccc@intel.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 2 Mar 2022 10:10:37 +0800
Message-ID: <CACT4zj9AxpOuDn-1fFAgY7Y-X_w+OHisASpa6tUBHQZuSExjFQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        SeanHY.Chen@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
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

Hi,

On Tue, Mar 1, 2022 at 6:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/02/2022 19:03, Ulf Hansson wrote:
> > On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
> >>
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> >> gated of upstream port can be enabled.
> >>
> >> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
> >> ---
> >>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 54 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> >> index 97035d77c18c..cf99b6af792d 100644
> >> --- a/drivers/mmc/host/sdhci-pci-gli.c
> >> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> >> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> >>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> >>  }
> >>
> >> +#ifdef CONFIG_PM
> >> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> >> +{
> >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> >> +       struct sdhci_host *host = slot->host;
> >> +       u16 clock;
> >> +
> >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> >> +{
> >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> >> +       struct sdhci_host *host = slot->host;
> >> +       ktime_t timeout;
> >> +       u16 clock;
> >> +
> >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +
> >> +       clock |= SDHCI_CLOCK_PLL_EN;
> >> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> >> +
> >> +       timeout = ktime_add_ms(ktime_get(), 150);
> >> +       while (1) {
> >> +               bool timedout = ktime_after(ktime_get(), timeout);
> >> +
> >> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +               if (clock & SDHCI_CLOCK_INT_STABLE)
> >> +                       break;
> >> +               if (timedout) {
> >> +                       pr_err("%s: PLL clock never stabilised.\n",
> >> +                              mmc_hostname(host->mmc));
> >> +                       sdhci_dumpregs(host);
> >> +                       break;
> >> +               }
> >> +               udelay(10);
> >> +       }
>
> Could use something like read_poll_timeout() here e.g.
>
>         if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
>                               1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
>                 pr_err("%s: PLL clock never stabilised.\n",
>                        mmc_hostname(host->mmc));
>                 sdhci_dumpregs(host);
>         }
>
>

Thanks for the tip. I will prepare the next patch.

> >> +       clock |= SDHCI_CLOCK_CARD_EN;
> >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> >> +
> >> +       return 0;
> >> +}
> >
> > Both functions above look very similar to what sdhci_set_clock() does.
> > Can you use that, rather than open coding the above?
> >

The codes turn on/off the clock but it doesn't change the clock.
Using sdhci_set_clock()  needs to store the clock value because it
clears the clock.

> > Other than that, I would appreciate it if Adrian could have a look at
> > this too. For example, I wonder if perhaps
> > sdhci_runtime_suspend|resume_host() should be called in these paths
> > too.
>
> Assuming the host controller does not lose state information, it should be fine.
>

Yes, the host always has aux. power and keep state.

Thank you both for your comments.

> >
> >> +#endif
> >> +
> >>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> >>  {
> >>         struct pci_dev *pdev = slot->chip->pdev;
> >> @@ -982,6 +1031,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
> >>  #ifdef CONFIG_PM_SLEEP
> >>         .resume         = sdhci_cqhci_gli_resume,
> >>         .suspend        = sdhci_cqhci_gli_suspend,
> >> +#endif
> >> +#ifdef CONFIG_PM
> >> +       .runtime_suspend = gl9763e_runtime_suspend,
> >> +       .runtime_resume  = gl9763e_runtime_resume,
> >> +       .allow_runtime_pm = true,
> >>  #endif
> >>         .add_host       = gl9763e_add_host,
> >>  };
> >> --
> >> 2.35.1
> >>
> >
> > Kind regards
> > Uffe
>

Best regards,
Ben
