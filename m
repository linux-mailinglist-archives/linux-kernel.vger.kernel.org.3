Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23E448833D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiAHL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiAHL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:29:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D12C061574;
        Sat,  8 Jan 2022 03:29:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so32344232edd.8;
        Sat, 08 Jan 2022 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GBKJ0A5I0bhF88Zy/1ednkbaWbx1kIE9t9dGEaqgso=;
        b=FAQvWddGDbtVfXSTKqv/I4cS2cM8NkH0EELclVZ22595mxuPNfYzrNweFA9rJ+CiFt
         HChSG2e08pFlEmHQ2/K3CcCFb6GqIzrAfujJ8733CaU50PwTTibYvQrh/oS2OUX7b0g/
         XP48rxhG3s5MIjNB5S0tSbUqc4M+9ZqIVb3nIRKokErlehH7hzRGfjtsIve3UjRbOCbd
         o/kanxyldApuPr4KpAgTbCwo2dtwQnorvvpZH1BAFMAua3RbXHh5nODzIGfPZ5TrXkTN
         WF/0IahSG9Ah1T1ZKoZjGXMZhUrAj57cC4DdySW6uM9BK1H3YxCyim+ZkO0/GMlIT4Ms
         2kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GBKJ0A5I0bhF88Zy/1ednkbaWbx1kIE9t9dGEaqgso=;
        b=LbaRl1J6XWn8Up3uktHCDwsHsbAaFL7swYU28Bq8XqPNzBxE6YIDtjZR5T74EWslpD
         v9sjjndgf5vU0bGy8/ZBw6vSMFp5xmMniMCZoiTY2/JzwBUv1B5GNKrHetK6OdtuQPyQ
         U66BrVINPb1eQXgTFHkBcAoX/fvmtOHz+rpBE0gIZUyKn8wP/4gVK54tVOzkQHPRhvRX
         oiPlCzSrYp0j3wSKIu9CCAAeS2G3n/WWYXtl5kVMPIbITqdQx9aX/Nu0Dqdcw6f2GkXy
         UkUlqmW/TioomgV/aVrABzXGkLkFhGeK64z6WohwjkqNKgS5j4q89LOhKstcObYR27G5
         YV5A==
X-Gm-Message-State: AOAM531pHoKCaVVCEmGBbhHTsYCDxLCX/UsMV6E18tmAqf+K3mcafVL4
        9U5VlVQS8chTOiJFxhCfKu6fUa3b/VWG/CjMCXs=
X-Google-Smtp-Source: ABdhPJwXyRyL1+7AYxidQnqpoWQAfL2jqRFrS06B7xdpsa8+E452fbluaAwqhG5/8gwi/hCEGB46S/IMjtO6d6pdk0o=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr64464838edc.125.1641641381459;
 Sat, 08 Jan 2022 03:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20220107233458.2326512-1-gsomlo@gmail.com> <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com>
 <YdjvlA7rqQoZe44F@errol.ini.cmu.edu> <Ydj3mmdWILBWHkAh@glsvmlin.ini.cmu.edu>
In-Reply-To: <Ydj3mmdWILBWHkAh@glsvmlin.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Jan 2022 13:29:05 +0200
Message-ID: <CAHp75VcsdYtFiPaL-rS-a4t4mBRasatnDLc+7ig0qhZi6U4gsg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgugala@antmicro.com" <kgugala@antmicro.com>,
        "mholenko@antmicro.com" <mholenko@antmicro.com>,
        "krakoczy@antmicro.com" <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        "florent@enjoy-digital.fr" <florent@enjoy-digital.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 4:32 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Fri, Jan 07, 2022 at 08:57:43PM -0500, Gabriel L. Somlo wrote:
> > On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:

...

> > >     +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> > >
> > > Should be devm or you may not use devm at all. See hint in one of the previous
> > > messages in v7 discussion.
> >
> > And here I think I'm in trouble... :)
> >
> > None of the examples retrieved via
> >
> > `git log --no-merges --grep devm_add_action_or_reset`
> >
> > are from "drivers/mmc/host/*", and *all* of the mmc drivers there,
> > including the ones that make extensive use of devm_*, use
> > mmc_alloc_host(), and there doesn't appear to be a devm-ified version
> > of mmc_alloc_host() available! How do they all get away with it?
> >
> > I'm really confused now -- any additional clue(s) much appreciated!
>
> I found drivers/mmc/host/meson-mx-sdhc-mmc.c, which uses
> devm_add_action_or_reset() right after mmc_alloc_host() to enlist the
> subsequent call to mmc_free_host(), see here:
>
> https://github.com/torvalds/linux/blob/master/drivers/mmc/host/meson-mx-sdhc-mmc.c#L791
>
> This would mean that I no longer have to call mmc_free_host(), neither
> on probe()'s error path, nor during remove().
>
> Does that count as canonically correct, or am I still missing
> something?

Yes, this is one of the options you may use.

Since it will be a second (?) driver with the same idea, perhaps in
the future it would make sense to provide devm_mmc_alloc_host() or
analogue (in the latter it means more complex solution like the input
subsystem is using, see devm_input_... API implementations).

-- 
With Best Regards,
Andy Shevchenko
