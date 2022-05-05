Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58651B7BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiEEGIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiEEGIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:08:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F8366A5;
        Wed,  4 May 2022 23:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766EA61C03;
        Thu,  5 May 2022 06:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6FEC385BC;
        Thu,  5 May 2022 06:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651730673;
        bh=gGag8LcvVDzOYjY7vVQNICNRVUATqvouUQ3T9qB8Y4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IzeX2fl3N2x2kryaheKunqUXxhYq2EKW3EevzAcRMispu7pOGu+LIVB4gtA4lt47H
         kuw8arO+PfbPq7WQnALg8Llzkb+hKwtvB/sYTsnK/90IacYZCB6DJZ5ZQJOsJ5C1F3
         TeSHzM+uYa+G41zdiYBmFF25L9TEm88hz+cFkf+LED+1kXeRmilzEAvsC7hDnbfjGn
         7+T7Dj+o9VKBm1U6ge16L5XMEd+1ntq34MUjLp9fn2cdJO958LQytdZ8prNLl0PmNR
         JJUBc01v6sbgWXUsh3IWA1bR3+vxPlhbpLgI0/bOseW+q4bkkad+M4ksyG11vuvJyh
         VmRMQT8XoxC+g==
Received: by mail-wm1-f49.google.com with SMTP id q20so2010918wmq.1;
        Wed, 04 May 2022 23:04:33 -0700 (PDT)
X-Gm-Message-State: AOAM532KYwJ4kV4x0ust3FQTY5P7lDLmdAqa0ZHF8tckDNZFQ3EHpIll
        agg4oXhlxqv95Hv8yxNuanYbXaFOameqvZcXfEI=
X-Google-Smtp-Source: ABdhPJxJJBc6IXeb9FDBUjhMgPRC02W3Kaja9XP7Gl4879zHpOvDa2WCA8GypEt4poAHxn+t5qvz/Rnv+5FUxU+6qJI=
X-Received: by 2002:a05:600c:4f0f:b0:394:54c1:f5b3 with SMTP id
 l15-20020a05600c4f0f00b0039454c1f5b3mr3065513wmq.33.1651730671693; Wed, 04
 May 2022 23:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-19-arnd@kernel.org>
 <CACRpkdac8dGKSEmc-HpgooJefrDtiKK+_A1Mv7AJM8yQV9UY-w@mail.gmail.com>
 <CAK8P3a0w3gFzZoBzyRsi1Ta4prESf8Fp0=quAPSKMnaXvbXNTQ@mail.gmail.com> <CACRpkdZNryYkidvdKuT57RM3fz6_X+3oOzF5xaOZd+TyScfUsw@mail.gmail.com>
In-Reply-To: <CACRpkdZNryYkidvdKuT57RM3fz6_X+3oOzF5xaOZd+TyScfUsw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 5 May 2022 08:04:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0y0tVZODpp+GSf0EkMPWbbvMqA-4kNf0NJMc0M2=2WHw@mail.gmail.com>
Message-ID: <CAK8P3a0y0tVZODpp+GSf0EkMPWbbvMqA-4kNf0NJMc0M2=2WHw@mail.gmail.com>
Subject: Re: [PATCH 18/48] ARM: pxa: hx4700: use gpio descriptors for audio
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 11:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 2, 2022 at 9:08 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Sun, May 1, 2022 at 11:41 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > (...)
> > > > +static struct gpiod_lookup_table hx4700_audio_gpio_table = {
> > > > +       .dev_id = "hx4700-audio",
> > > > +       .table = {
> > > > +               GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
> > > > +                           "earphone-ndet", GPIO_ACTIVE_HIGH),
> > >
> > > This looks wrong. The n in nDET in the end of the name of the GPIO line
> > > means active low does it not?
> > >
> > > What I usually do when I see this is to properly set it to
> > > GPIO_ACTIVE_LOW in the descriptor table, then invert the logic
> > > where it's getting used.
> > >
> > > Also rename to earphone-det instead of -ndet
> >
> > Thanks for taking a look! I changed it now, but I don't know if
> > I got the correct number of inversions in the end. How does this look?
>
> Looks wrong, you can just invert the argument to any statement of set_value()
> after tagging respective line as active low. Then gpilob will do a second
> inversion.
>
> > +               GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
> > +                           "earphone-det", GPIO_ACTIVE_LOW),
> > +               GPIO_LOOKUP("gpio-pxa", GPIO107_HX4700_SPK_nSD,
> > +                           "spk-sd", GPIO_ACTIVE_LOW),
>
> So those two have switched polarity.
>
> > @@ -81,14 +79,14 @@ static const struct snd_soc_ops hx4700_ops = {
> >  static int hx4700_spk_power(struct snd_soc_dapm_widget *w,
> >                             struct snd_kcontrol *k, int event)
> >  {
> > -       gpio_set_value(GPIO107_HX4700_SPK_nSD, !!SND_SOC_DAPM_EVENT_ON(event));
> > +       gpiod_set_value(gpiod_spk_sd, !!SND_SOC_DAPM_EVENT_ON(event));
>
> Thus drop one ! in front of the expression, just !SND_SOC_DAPM_EVENT_ON(event)

Ok, done. But I still leave the extra 'invert=1' in hs_jack_pin[], right?

/* Headphones jack detection DAPM pin */
static struct snd_soc_jack_pin hs_jack_pin[] = {
        {
                .pin    = "Headphone Jack",
                .mask   = SND_JACK_HEADPHONE,
        },
        {
                .pin    = "Speaker",
                /* disable speaker when hp jack is inserted */
                .mask   = SND_JACK_HEADPHONE,
                .invert = 1,
        },
};

> > +       gpiod_spk_sd = devm_gpiod_get(&pdev->dev, "spk-sd", GPIOD_OUT_LOW);
>
> These initial values don't seem to be set in the old code you could
> just use GPIOD_ASIS as flag to make sure the new code behaves
> the same.

Ok.

        Arnd
