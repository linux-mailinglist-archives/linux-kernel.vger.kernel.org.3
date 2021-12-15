Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B557475103
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhLOCiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOCiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:38:04 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898FC061574;
        Tue, 14 Dec 2021 18:38:04 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id kj6so3773292qvb.2;
        Tue, 14 Dec 2021 18:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRX4KSRpkz951cRNgWC/Zh6A7MKhtf470MiyyCfCPkI=;
        b=Aw5+XL1niZL3nXdAL/I7GcxjTpxFQNxAMs/SaM//1TxjPaLqyEmzI86of++OTCC2di
         //uGkroUBdUnD8N28TNsF0aMjaT6vf5DUKbx+O9yjoPlwlXOsPGZvmPPoYw1Z110ZKe4
         NJ8PffooJa+YJf6r7EFQo5T6jDyAZPsjOobNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRX4KSRpkz951cRNgWC/Zh6A7MKhtf470MiyyCfCPkI=;
        b=5uKhFIsvh8ycHKVpC8wmyUQAz20A8l+qm+TPOv02APB+tG/aZA90Q6NzwOwECsDkpH
         YWW5wKx8Dhk83+Sp5j+EJv+6OE38ooJVTyR0h/WFLqT3On204PwI3Y5ql/ZTrRbAEsEe
         OKSvK19+YP16vKOSg0XAWlDkoifp2IREjpzP48bpufA8mb9TTaHnxDjcK3c11l9N6/UB
         ZmsKe2ZIVV7H6Aq04YbZRegWF36gg1gwbN7u3805SUn4tyCCIEl23fwl88Ns9+4+IUmR
         lJkS5VZug4t41RkSv78XiiSkAh0nPzuSZRq3GErwGxRNacLk+3gX5kDnJlaBRxX3VcH2
         AxcA==
X-Gm-Message-State: AOAM533sGVjCKWFuiKl0plCqTc62M3dz3dZjt4noz25W4MmHgxsGE3yZ
        nSyeCTeGcbexCjdhrrpJT0lif1TDBjPnzuAleto=
X-Google-Smtp-Source: ABdhPJyP/ptvKFOl4YsddVGK/L0Uh4+0SODOSdyOLoVHED3p2Oq0B1XjTAVlANjOepUgQhwo5JDycFvXJNddiBttYAU=
X-Received: by 2002:a05:6214:2b0b:: with SMTP id jx11mr6103354qvb.130.1639535883329;
 Tue, 14 Dec 2021 18:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20211210145430.3707463-4-gsomlo@gmail.com> <YbYhaAmHsSnLFlZ2@errol.ini.cmu.edu>
In-Reply-To: <YbYhaAmHsSnLFlZ2@errol.ini.cmu.edu>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 15 Dec 2021 02:37:51 +0000
Message-ID: <CACPK8XdP2Zcv4=psoFZGK+pQC514m2wri15vGZS=hWreOWoqTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 at 16:21, Gabriel L. Somlo <gsomlo@gmail.com> wrote:
>
> Hi Joel,
>
> On Fri, Dec 10, 2021 at 09:54:30AM -0500, Gabriel Somlo wrote:
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> >
> > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>


> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5af8494c31b5..c1b66d06d1c9 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1093,3 +1093,12 @@ config MMC_OWL
> >
> >  config MMC_SDHCI_EXTERNAL_DMA
> >       bool
> > +
> > +config MMC_LITEX
> > +     tristate "LiteX MMC Host Controller support"
>
> I remembered I still owe you an answer on whether this was ever
> successfully tested as a module: The answer is *yes* -- if configured
> as a loadable module, it loads OK with modprobe, works fine, and can
> be unloaded (with `modprobe -r`) and re-loaded indefinitely.

Very good.

Thanks for following up on the suggestions I made.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
