Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF74CA45E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiCBMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiCBMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:03:50 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556543ECE;
        Wed,  2 Mar 2022 04:03:06 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d07ae0b1c4so14292447b3.11;
        Wed, 02 Mar 2022 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEc+gL7G0rfMOn0cIRVoJHGoUVkINZBV6EdCwelWeLY=;
        b=qkdK/+ATV/9wPMkziZWYAeiYZo+HGHDpmFAJ/X17ldr3JhIVJXm4Q0mlCj52+oGkmw
         kXJolCgr3pk8tNp2rEzJvQ+Wu4HU8xRzXEXHMu03RYSuJ7JKFqPfbA4XXAQY5uFHgZbd
         d18LgpA4n53BPQqUHocMtmY68PKoG+GIQuoKQf0qhFHMpcw48pOvDv//xl3WrwtvTIr9
         hu3ZMJLO28NyS8E8lvzsI7WQK4UOzxlJdvpQ3fTA7AAkQ4VD0zpsRhccqnztAEpJXdiY
         QEq63PDQ9UCr8Sra5zLEH/nYny0bxQkl3qqhPlilImHqS8o5p8P0QjtJgttb+p6Rygyi
         sT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEc+gL7G0rfMOn0cIRVoJHGoUVkINZBV6EdCwelWeLY=;
        b=kbIM4MRNbbO1ieIREtvT1cXbIaNcD1HYbAXFiTsC1cg1w0aWVwtzNFK4LG9y4bIytU
         6020Y2efMGbZxJLdnFJMO3M+nrJxbklFCOZ3bZp38eUjTVqzR8eH8J3vgcsd2skJyY/n
         wraeHsG+SVXAmAxxH1Z2DP2lwQtrRDyXlefPsIH2CO85t2GFkBGAlCqbWzFoaL3UvX1Q
         o57Ncu9v8my5L9WR7xFKj6vX7DmH8zQnRoVpQ+DmXfaUvfJCkIE1JXQ8NM3HN9Ef41A3
         DcmOVd+pHXeZK/zLl88TO2UjdoGTEDoShpFMya0U5JecI3A76k2GilMxoycQxJ5YYVkX
         Cmaw==
X-Gm-Message-State: AOAM5302Y+9BjjJoIxCZfTyqOh7/JSayhLIkzvpcHZ7edrcnRaDBZtSC
        Fkedy/HJviTeDducUlWiTiNc5MYHBIcbjH75oL0=
X-Google-Smtp-Source: ABdhPJxkmqg+OQb60NqbTgMXL7RTUX1yPYC6XnE92tIAaE7OlMIRWq2UCtYXS0J2bPJsBhsKBFZUqMFi3AZyf3EVGOg=
X-Received: by 2002:a81:8044:0:b0:2db:2d8b:154f with SMTP id
 q65-20020a818044000000b002db2d8b154fmr22960083ywf.191.1646222585705; Wed, 02
 Mar 2022 04:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20220225125553.1185108-1-benchuanggli@gmail.com>
 <20220225125553.1185108-2-benchuanggli@gmail.com> <CAPDyKFq5MdGWefVW6Uwe74Ef5giW+68qRS2hmXNmHLqpfqav8A@mail.gmail.com>
 <4b35e465-626a-7218-ed9a-4e5cf28c1ccc@intel.com> <CACT4zj9AxpOuDn-1fFAgY7Y-X_w+OHisASpa6tUBHQZuSExjFQ@mail.gmail.com>
 <CAPDyKFp-XrLOSUAbsW5JGNCs6aO8Gp1YgmkqiwVpN5byO1XXCQ@mail.gmail.com> <CACT4zj_6k=0gNRw=EFHR=9-7fWJ=bT4Q1VsPMWrkVPftjLb=Hw@mail.gmail.com>
In-Reply-To: <CACT4zj_6k=0gNRw=EFHR=9-7fWJ=bT4Q1VsPMWrkVPftjLb=Hw@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 2 Mar 2022 20:02:54 +0800
Message-ID: <CACT4zj9Gkhpvtqfp19rBteZSdwcbArE8cOYmRYt7AgrsAabSxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
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

On Wed, Mar 2, 2022 at 6:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 2 Mar 2022 at 03:10, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 1, 2022 at 6:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >
> > > On 28/02/2022 19:03, Ulf Hansson wrote:
> > > > On Fri, 25 Feb 2022 at 13:56, Ben Chuang <benchuanggli@gmail.com> wrote:
> > > >>
> > > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > >>
> > > >> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> > > >> gated of upstream port can be enabled.
> > > >>
> > > >> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > >> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
> > > >> ---
> > > >>  drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
> > > >>  1 file changed, 54 insertions(+)
> > > >>
> > > >> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > > >> index 97035d77c18c..cf99b6af792d 100644
> > > >> --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > >> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > >> @@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> > > >>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > >>  }
> > > >>
> > > >> +#ifdef CONFIG_PM
> > > >> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> > > >> +{
> > > >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> > > >> +       struct sdhci_host *host = slot->host;
> > > >> +       u16 clock;
> > > >> +
> > > >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > >> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> > > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +       return 0;
> > > >> +}
> > > >> +
> > > >> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> > > >> +{
> > > >> +       struct sdhci_pci_slot *slot = chip->slots[0];
> > > >> +       struct sdhci_host *host = slot->host;
> > > >> +       ktime_t timeout;
> > > >> +       u16 clock;
> > > >> +
> > > >> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +       clock |= SDHCI_CLOCK_PLL_EN;
> > > >> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> > > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +       timeout = ktime_add_ms(ktime_get(), 150);
> > > >> +       while (1) {
> > > >> +               bool timedout = ktime_after(ktime_get(), timeout);
> > > >> +
> > > >> +               clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > >> +               if (clock & SDHCI_CLOCK_INT_STABLE)
> > > >> +                       break;
> > > >> +               if (timedout) {
> > > >> +                       pr_err("%s: PLL clock never stabilised.\n",
> > > >> +                              mmc_hostname(host->mmc));
> > > >> +                       sdhci_dumpregs(host);
> > > >> +                       break;
> > > >> +               }
> > > >> +               udelay(10);
> > > >> +       }
> > >
> > > Could use something like read_poll_timeout() here e.g.
> > >
> > >         if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> > >                               1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> > >                 pr_err("%s: PLL clock never stabilised.\n",
> > >                        mmc_hostname(host->mmc));
> > >                 sdhci_dumpregs(host);
> > >         }
> > >
> > >
> >
> > Thanks for the tip. I will prepare the next patch.
> >
> > > >> +       clock |= SDHCI_CLOCK_CARD_EN;
> > > >> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +       return 0;
> > > >> +}
> > > >
> > > > Both functions above look very similar to what sdhci_set_clock() does.
> > > > Can you use that, rather than open coding the above?
> > > >
> >
> > The codes turn on/off the clock but it doesn't change the clock.
> > Using sdhci_set_clock()  needs to store the clock value because it
> > clears the clock.
>
> Well, in that case at least you can call sdhci_enable_clk() from
> gl9763e_runtime_resume(), rather than open coding it (the code looks
> like a direct copy of that code). All you need is to give the
> sdhci_enable_clk() the correct "clk" as in-parameter.
>

I want to explain a little more,
gl9763e is used as a boot disk controller.
In gl9763e_runtime_suspend(), gl9763e still needs the internal clock
to keep states.
So gl9763e_runtime_suspend() only clears SDHCI_CLOCK_PLL_EN and
SDHCI_CLOCK_CARD_EN.
The SDHCI_CLOCK_INT_EN is still one (1) In runtime suspend,

If using sdhci_enable_clk()  in gl9763e_runtime_resume(), sdhci_enable_clk()
only fills one (1) to this bit (SDHCI_CLOCK_INT_EN) again, it cannot
cause internal stable bit
(SDHCI_CLOCK_INT_STABLE) to one for gl9763e in the first while loop.

> >
> > > > Other than that, I would appreciate it if Adrian could have a look at
> > > > this too. For example, I wonder if perhaps
> > > > sdhci_runtime_suspend|resume_host() should be called in these paths
> > > > too.
> > >
> > > Assuming the host controller does not lose state information, it should be fine.
> > >
> >
> > Yes, the host always has aux. power and keep state.
> >
> > Thank you both for your comments.
>
> Okay, thanks for confirming!
>
> [...]
>
> Kind regards
> Uffe

Best regards,
Ben
