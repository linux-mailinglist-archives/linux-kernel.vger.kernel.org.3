Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1F48C233
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346655AbiALKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352493AbiALKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:25:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB6C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:25:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x6so6441730lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhrM6Xen3w5qUruPad5ixHkqDWpBwQZqIzJeR1EkW4E=;
        b=RrVI1hzaVukuM5jtpwWPW6kvbDwe97qGvtj8c6Kkh4uL25y89y1eaw4SgLu10ZyFnt
         t59ET0KgYfpVvBwCrIzadJrU99X9i1l2UebcR6QOgdZTvtql7y8pHKh1ZTAm2y7PRZat
         RC+E/JcyRya3YR2Y3FrTzYYmW+EB4PbKmqLtZmWcF9QDqhz1RzY6G+KzJ+Cwiz/jver1
         kSIEZ5PEekwjccgRbPsJRxCojbEoFAmYA5F6UPU2YJKxfgIfQtkNciJPVPoyADPxwQu1
         87HhyXzWf2xjB9fqqkuZwdKuDWcVFc3e9cGVRPH05U5F9h7G/nycnTDCAR7v6PVTHM/u
         Nw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhrM6Xen3w5qUruPad5ixHkqDWpBwQZqIzJeR1EkW4E=;
        b=FuqfUzetZ3D9nea/4slkgVwrXecwHXJHICOCgevjBqfktjpQ8NK7GnTJnDS5U1rNvB
         q00UKCJVxBkOBR/u7boQhF3UPjoy4WQ87pvb6PCpRZnZfloJurHYHAOqzYY2b/ovRJ3J
         YWQqaLqqlWxL/k5Cx89Qfxt5rT/Jwjh4xANNj+1AtShm6NCO5FKTMo5ld7aWEOzxl+mW
         4CAD4TNuXLa6v/FjJmUXeHjtdAK2FfwFGVHK9QCAJdlUkpbXll6lmQXupYRmePiKNp76
         fEqPK4rCGtHOuaQlniXeXFkTeFor4xru6I2SLIkdtvav6TQvsHDFjkA/ReRsXDcqj6YS
         fQtw==
X-Gm-Message-State: AOAM532kVuSHPjKcqqH2BCOVKx8UB4L2HlI1DiOfAR8+mkcE5aW5uy44
        xwV3Xrruu+MKVhoiSaQMTsV0CY0sFtgKWhuZ0MyfuQ==
X-Google-Smtp-Source: ABdhPJzoW2RQRNQJQZl+DxH2f6NELnVGEYgf+jGNvBCSTIRuWkvMAKnEMBSiHeW7eK9vFeSqeaEVLgBU/N//RxMxMUA=
X-Received: by 2002:a2e:947:: with SMTP id 68mr2958964ljj.300.1641983111123;
 Wed, 12 Jan 2022 02:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
 <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
 <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu> <CAPDyKFohOHYu_bdXsAYvDmMLqnGUW=9pG+yJDwP5-db1B6F1Dw@mail.gmail.com>
 <Yd4JdBArPn9rBj5b@errol.ini.cmu.edu>
In-Reply-To: <Yd4JdBArPn9rBj5b@errol.ini.cmu.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jan 2022 11:24:34 +0100
Message-ID: <CAPDyKFq18AWsaWHcEkU6H1Sh4NsqRfUeQhbRz9MorGfnKzxHwQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > [...]
> > > >
> > > > > +
> > > > > +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > > >
> > > > I noticed that you use these hard coded values and don't really care
> > > > to manage voltage changes via ->set_ios().
> > > >
> > > > Rather than doing it like this, I would prefer if you can hook up a
> > > > fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
> > > > to fetch it from here, which will let the mmc core create the
> > > > mmc->ocr_avail mask, based upon the voltage level the regulator
> > > > supports.
> > > >
> > > > This becomes more generic and allows more flexibility for the platform
> > > > configuration.
> > >
> > > The LiteSDCard "hardware" (i.e., *gateware*) does not allow modification
> > > or selection of voltage from the software side. When a CMD8 is issued,
> > > the "voltage supplied" bit pattern is expected to be '0001b', which per
> > > the spec means "2.7-3.6V".
> >
> > If you provide a range (2.7-3.6V), that means that your hardware
> > supports the entire range, not just one single part of it.
>
> The "gateware" (open source migen/verilog at
> https://github.com/enjoy-digital/litesdcard)
> supports any value provided by the underlying FPGA dev board
> (typically 3.3v) -- by not attempting to manage it in any way.
>
> SD media presumably doesn't care as long as voltage is somewhere
> within 2.7-3.6V (at least that's how I read the spec, there's only
> one register value representing anything within that range).
>
> > >
> > > I tried adding this to the overall DTS:
> > >
> > >         vreg_mmc: vreg_mmc_3v {
> > >                 compatible = "regulator-fixed";
> > >                 regulator-min-microvolt = <3300000>;
> > >                 regulator-max-microvolt = <3300000>;
> > >         };
> > >
> > > and then added a reference to it to the LiteSDCard "mmc0" node in DTS,
> > > like so:
> > >
> > >         mmc0: mmc@12005000 {
> > >                 compatible = "litex,mmc";
> > >                 reg = <0x12005000 0x100>,
> > >                         <0x12003800 0x100>,
> > >                         <0x12003000 0x100>,
> > >                         <0x12004800 0x100>,
> > >                         <0x12004000 0x100>;
> > >                 reg-names = "phy", "core", "reader", "writer", "irq";
> > >                 clocks = <&sys_clk>;
> > >                 vmmc-supply = <&vreg_mmc>; /* <-------- HERE !!! */
> > >                 interrupt-parent = <&L1>;
> > >                 interrupts = <4>;
> > >         };
> > >
> > > Finally, I replaced the hardcoded setting of `mmc->ocr_avail` with a
> > > call to `mmc_regulator_get_supply(mmc)`. Now, I get a bunch of timeouts
> > > during attempts to send e.g., CMD8 and CMD55.
> > > (going for 3200000 and 3400000 for min- and max-microvolt, respectively,
> > >  -- or anything else in the allowed 2.7-3.6 range -- doesn't help either).
> > >
> > > I might be doing something subtly wrong in the way I set things up
> > > above, but it feels a bit overengineered, and IMHO fragile.
> >
> > At a quick glance, the above looks correct to me. Maybe there is
> > something wrong with the code in the driver instead?
>
> After some more hacking, I learned that:
>
>         - an additional `regulator-name` line
>           (e.g. `regulator-name = "vreg_mmc";`) is required
>
>         - setting `regulator-always-on;` seems to help reduce attempts
>           by the kernel to "manage" the regulator, but does not appear
>           to be required
>
> In other words:
>
>         ...
>         vreg_mmc: vreg_mmc {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vreg_mmc";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>                 regulator-always-on;
>         };
>         ...
>
> Additionally, CONFIG_REGULATOR=y and CONFIG_REGULATOR_FIXED_VOLTAGE=y
> *MUST* be enabled in the kernel's .config file, to prevent either
> litex_mmc_probe() from being deferred, or mmc_regulator_get_supply()
> from simply returning 0 without having set mmc->ocr_avail to anything
> at all!
>
> Presumably this would also mean either `select REGULATOR_FIXED_VOLTAGE`
> or `depends on REGULATOR_FIXED_VOLTAGE` in the mmc driver's Kconfig
> entry.

Yep, that's correct.

If you don't like to manage that dependency in the Kconfig, an option
is to check if mmc->ocr_avail is zero and if so, we could log a
message *and* assign mmc->ocr_avail a default value.

>
> Predictably, the "regulator-[min|max]-microvolt = <3300000>" setting
> gets us
>
>         ocr_avail == MMC_VDD_32_33 | MMC_VDD_33_34
>
> > >
> > > OTOH, going all out and setting:
> > >
> > >         /* allow for generic 2.7-3.6V range, no software tuning available */
> > >         mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
> > >                          MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
> > >                          MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
> > >
> > > seems to work just fine... :) Please do let me know what you think!
> >
> > No, this isn't the way we want it to work. That's because it means
> > that we would lie to the card about what voltage range the HW actually
> > supports.
> >
> > It's better to let the DTS file give that information about the HW.
>
> I may be needlessly concerned, but it feels a bit weird to me to drag
> in CONFIG_REGULATOR_FIXED_VOLTAGE as an added dependency for what is
> ultimately a roundabout way of setting a constant... :)

The point is, it shouldn't really be a constant set by the driver,
because it would mean initialising a card under potentially wrong
conditions.

However, I am fine assigning it a default value as a fallback and best
effort, if it turns out that DT didn't provide us information about
what the HW is capable of.

>
> Thanks in advance for any additional clue!

Looks like there are two options, just pick one of them, then I am happy. :-)

Kind regards
Uffe
