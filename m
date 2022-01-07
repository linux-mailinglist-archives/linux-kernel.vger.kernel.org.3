Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1452C487571
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346683AbiAGKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiAGKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:25:02 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3037C061245;
        Fri,  7 Jan 2022 02:25:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z9so20260481edm.10;
        Fri, 07 Jan 2022 02:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmkH4HduGuDqN56JXHqEKJBLN+FBRsxZyV1qZNn/vGI=;
        b=R+7oVNEt7WbifMQOMsewUjqj9ff3qjy2u35LIVMmh2ObEXcuKRT10Bib026YKKD94C
         dwDcZ1GxbD+MzeOnjuqYyNLHWGWOQ0O+G513GMDgWThNbCgK8BbK+R+gumLxGFlENbN8
         MH2gB/XUv9jvGWtSJef6HH5zkjBCdFxzo5vfjKE1SoXwXEpxk2d8+IlopQAW72PzxIA7
         ppawoDPM7JVi2dgqe2JpQ0IgA8CVrYSjDM/FyZ88l5bziaI7/qBPhjI8wpAFDvcWPXtt
         gJmcGUSCPST/Fl5d8H960+FW9rcNPzFWBbgJE3cVCdLAOE/vs3Em9DIG3eRkMBWPdAl3
         F3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmkH4HduGuDqN56JXHqEKJBLN+FBRsxZyV1qZNn/vGI=;
        b=i6dWYC/rmmpQizd5AaM+zPxriPhGmKWUUO8IGtUmBZ14PZ8nXJA5LdQ9MzZLeVkxpj
         bXiXz+6Keo5Dj2HVAu8hUJRr6tFquT220Aw9fXrIY+ECHHOBYg1rfM2YL+Zu+K3lJ8U9
         /lGFjtVXvZ9eUrl7AeZl9Cr1mOzo5ZaWM+il7owH6hqwgL/laO8m/37IpSIrrgd7tjWF
         XRyfv2dGbpLsuKzIb3uQq+hP6ACf6Emd0nNzqDkAlo2FYfssTW+FOD+zWIemHHyWvslU
         JWxfN34dUBZaBR9HMdNazwqJ3bkKhAyDDLEXW2X+/T4twwq1KYId/W+QK/f7HsR7wZzV
         olXg==
X-Gm-Message-State: AOAM533KYvUZif1mVHiuppEJx07DczxNQEf9JqrS5kUP0B3MrnMAgGZN
        4+5VggW1FLAcK8Wtsc0DJOteRFedOabgOCULR8Gf6M+llCV7mQ==
X-Google-Smtp-Source: ABdhPJwY1QWSUINg7cruSSBn6h8xxuURGw+5jNlvUGuofk536vAhkZSweQDZGB2f5QcjXzDZpjqUzS8UpMZ6glQYs4E=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr58704139edd.29.1641551100325;
 Fri, 07 Jan 2022 02:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20220106174803.1773876-1-gsomlo@gmail.com> <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu> <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
 <YdgSG7t2eG9YzkaG@antec>
In-Reply-To: <YdgSG7t2eG9YzkaG@antec>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Jan 2022 12:24:23 +0200
Message-ID: <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Stafford Horne <shorne@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 12:12 PM Stafford Horne <shorne@gmail.com> wrote:
> On Fri, Jan 07, 2022 at 10:36:12AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:

...

> > Many (most?) blurbs do mention the module name.
>
> I was doubting this as well, but I searched and its true.  The text 'module will
> be called' shows up many times, there is also different text.
>
>  $ grep -r 'module will be called' drivers/ | wc
>    1347    9023   9086
>
>  $ grep -r 'tristate \"' drivers/ | wc
>    7169   47486  521795

Just a side note: `git grep ...` is much faster in the Git trees.

And for this particular case I dare to advertise a script I wrote [1]
to help with recursive searches.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/gl4func.sh

> So maybe >10% have module name in the blurb.  Example:
>
>           To compile this driver as a module, choose M here: the
>           module will be called tifm_sd.



-- 
With Best Regards,
Andy Shevchenko
