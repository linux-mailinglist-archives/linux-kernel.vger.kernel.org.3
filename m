Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0228948758D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbiAGK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:29:38 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:33569 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiAGK31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:29:27 -0500
Received: by mail-ua1-f54.google.com with SMTP id u6so9459499uaq.0;
        Fri, 07 Jan 2022 02:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Io2bK2EB9BrWpLhpSRU2u5xHS0wL/UWmqIaJGQJ1nnU=;
        b=HynvkoVVs8DIjDHaHwje+Kt8nkp/Yo0XbMPpaWZMA7m3oT1YssQzmkHjfzrJ7tI00a
         F38IM45brkv9D01uQa+/1QKfN9UwL40d5P8CKrj6m42OlM4vZ6LUa0fsRQpq2JpBnBhS
         IZe+PNYiJMQ546Y3m42Ew5cUfA6vStw2tp6WKLp9qyPh1zolhFqccTmd3mcvJ1bL9dF8
         R2bn+bG4lnyPl7QpUhTPZEe1dlvxdkbcY0oWhNnf9QIPW4zV93VtF6gNxpDRtuCwP7tZ
         T2tjffiXClegdRAVLyv44gFFdaFWgi5HXwx3P14/StXwWqIqvEzGQPgtCndqNG1X6LXX
         XaSA==
X-Gm-Message-State: AOAM533WpQ5sUB24Ye2O/drWWls4xShjFWaBdfnvd9nlezmkpfEPi1Tj
        Jh8CXwbqXnUKpYVrkw1jhLusvktuTopPgg==
X-Google-Smtp-Source: ABdhPJzCzN5LGUpoo3Y564wS/N/dmHy/og0EyjsSqIWSHCNxbCNjtWuAIhNuSFbdRtiPDdX8gr70AQ==
X-Received: by 2002:ab0:3148:: with SMTP id e8mr21920845uam.62.1641551366198;
        Fri, 07 Jan 2022 02:29:26 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id u7sm2919855vkf.12.2022.01.07.02.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 02:29:24 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id d189so3406508vkg.3;
        Fri, 07 Jan 2022 02:29:24 -0800 (PST)
X-Received: by 2002:ac5:c853:: with SMTP id g19mr23105681vkm.20.1641551364177;
 Fri, 07 Jan 2022 02:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20220106174803.1773876-1-gsomlo@gmail.com> <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu> <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
 <YdgSG7t2eG9YzkaG@antec> <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
In-Reply-To: <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jan 2022 11:29:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU1UqwKzE=tT4fdJb9EjJRJTsG2fGoLrBSOs_K22rY-sQ@mail.gmail.com>
Message-ID: <CAMuHMdU1UqwKzE=tT4fdJb9EjJRJTsG2fGoLrBSOs_K22rY-sQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stafford Horne <shorne@gmail.com>,
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

Hi Andy,

On Fri, Jan 7, 2022 at 11:25 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 7, 2022 at 12:12 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Fri, Jan 07, 2022 at 10:36:12AM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Jan 6, 2022 at 11:50 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
>
> ...
>
> > > Many (most?) blurbs do mention the module name.
> >
> > I was doubting this as well, but I searched and its true.  The text 'module will
> > be called' shows up many times, there is also different text.
> >
> >  $ grep -r 'module will be called' drivers/ | wc
> >    1347    9023   9086
> >
> >  $ grep -r 'tristate \"' drivers/ | wc
> >    7169   47486  521795
>
> Just a side note: `git grep ...` is much faster in the Git trees.

Indeed.

> And for this particular case I dare to advertise a script I wrote [1]
> to help with recursive searches.
>
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/gl4func.sh

Cool!

My fingers are used to type

    git grep -w <pat1> -- $(git grep -lw <pat2> -- ...)

;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
