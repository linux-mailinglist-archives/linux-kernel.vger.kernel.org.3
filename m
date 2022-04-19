Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4E507207
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353980AbiDSPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354298AbiDSPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:43:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B43BA9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:40:39 -0700 (PDT)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MkEdF-1oMoU03lnd-00kiSf for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022
 17:40:37 +0200
Received: by mail-wr1-f54.google.com with SMTP id w4so22970378wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:40:37 -0700 (PDT)
X-Gm-Message-State: AOAM5323waBhnuy+fNFd9m111wyEUkyiJqah1LbswKqla13g5bpfQnqK
        TB6THLQpVxevAfnfkMAzHM//cG6tFycoxsX6z/U=
X-Google-Smtp-Source: ABdhPJx2j14opnoXVu+zRZ4O7R0W4B6Te+BYkmuTotpIld2KFF5dVZxiMPz0Ry5HHgFRVQndxUG068ioQAMMaGHobtE=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr12156987wru.192.1650382837528; Tue, 19
 Apr 2022 08:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-21-arnd@arndb.de>
 <87o8y0lgs1.fsf@belgarion.home>
In-Reply-To: <87o8y0lgs1.fsf@belgarion.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Apr 2022 17:40:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Rwh-+483nxgWhmst8VdEByb8HCE8H-mEhb=Laq9qc4w@mail.gmail.com>
Message-ID: <CAK8P3a0Rwh-+483nxgWhmst8VdEByb8HCE8H-mEhb=Laq9qc4w@mail.gmail.com>
Subject: Re: [PATCH 21/46] ARM: pxa: spitz: use gpio descriptors for audio
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B4KkuJO4O6p7OV9tY+r5w5ZQaXiO8EgcHvCXb7uRux5s14U8in4
 EyOQyl0VWSOPyzI5Jwfg0HNTTEFV7nYnmdWrhOTIbMCOfF8mdMm8msY/pf43tS+bPioZcnZ
 a9eELn/8HgNN1BWmsOPRirYZjhMKL8hTOeNiVPfw2VExNRVPi2ZWzz0BIxoVaMzgcXPJ4gN
 NRnVG4uuBVlswLaDwRNbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oMNwgFhYYLA=:dz/tndUjM0DwM7UljviixW
 dmzrfmFJnpCHlkO5+7Ht2VTlf4w2ce9MOdZ3c/GzFAEp0ULPah8wK7y0clV4CbGsg7bp63Qfw
 8dyLF2D9vDjqSMcjvPe8VgG4ghfg+35hJMw2G73dyX/lIkfxMnEKjmBAAfOjvBfGDQl06D91g
 18OfHw0SCDxM6UrnkhBwaYPvPo6yCmeLAnj4YIFqE5Q7HiOoY/4UK4ZsgOrcftwu2U/o5qgtP
 f2tu1ui76WU9/55cEmXlt3gjzorO8ACMWvC1NgUG6nhq9FE3kFyjip2jwXQMVbWdAINj2nMzm
 Ez9zNkjhfugtrXw3cWocHK/5ZBI3CXlWwHGzs5u7DLPyHBCmLlDQgt+ZC4RBWmCVwdXXGfXXq
 tp8df2nDpX3S2l0TdOVBkFZVp+w72eUxofzha46S+X0WgDYl9ig139s41T6Od0T8ebHkApMVm
 nM9GdqkrdZ/swEP8VXPDBDLh3g6agw3GXwq8isZkF0gCfLx19pS8N00q6ewksWYNISntikqkE
 f42cCX2x2a1ST16E6ZEqO+KjiAUeOUXhpfZZVGTB3fwxgVIs/h2kgr8+n3Lzysik5r+Q53ub/
 xggqm0TAaxL/H9gJSdGF264bhcdBSM3fhS1yg+sHy6YSxwKCGSmKGX66ZllA57Fmq0qSKgFiv
 goS88iKxB4vxheWcQHUY8lEx17M7j6Q5NUbMgX/IJJokVLwHetX1IlgCWRNIQ+Hf1B2A=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:08 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> > +static struct gpiod_lookup_table akita_audio_gpio_table = {
> > +     .dev_id = "spitz-audio",
> > +     .table = {
> > +             GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
> > +                         "mute-l", GPIO_ACTIVE_HIGH),
> > +             GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
> > +                         "mute-r", GPIO_ACTIVE_HIGH),
> > +             GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_MIC_BIAS - AKITA_IOEXP_GPIO_BASE,
> > +                         "mic", GPIO_ACTIVE_HIGH),
> This last one looks a bit dubious, as it looks like a gpio on a gpio expander,
> could you cross-check that "gpio-pxa" shouldn't be an I2C expander gpio please ?

I'm revisiting this older patch series now, this was clearly a mistake
in my original
version, changed it now to

@@ -982,7 +982,7 @@ static struct gpiod_lookup_table akita_audio_gpio_table = {
                            "mute-l", GPIO_ACTIVE_HIGH),
                GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R -
SPITZ_SCP_GPIO_BASE,
                            "mute-r", GPIO_ACTIVE_HIGH),
-               GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_MIC_BIAS -
AKITA_IOEXP_GPIO_BASE,
+               GPIO_LOOKUP("i2c-max7310", AKITA_GPIO_MIC_BIAS -
AKITA_IOEXP_GPIO_BASE,
                            "mic", GPIO_ACTIVE_HIGH),
                { },
        },

I'm not 100% sure this is the correct name, as I don't fully
understand how i2c device
names are constructed. I see that Linus added a device name in commit
32d1544880aa ("ARM: pxa: Add gpio descriptor lookup tables for MMC CD/WP"),
and I guess I could do the same here, but I think that was only needed
to disambiguate
two instances of the same device in zylonite, which is not needed for spitz.

       Arnd
