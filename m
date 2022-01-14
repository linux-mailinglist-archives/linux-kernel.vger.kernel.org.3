Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F220448E68B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiANIap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:30:45 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:36818 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbiANIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:30:00 -0500
Received: by mail-ua1-f42.google.com with SMTP id r15so15754877uao.3;
        Fri, 14 Jan 2022 00:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coIUzB6ooSMMXusXijGBXbc+2Rfc5lcc+ApCRo1wUfo=;
        b=PlFvfuJJio9IfOytYyW3fte6684nzGdT+Kfw/tOWWIASW93wlAg7FoPve0wEVouIJo
         tGOZFd6zsgQjTpAVhJzXyXh1NjccT8HAkF8HC/WD5ybmJl18J5j/n8F1Zk64B2WWGAba
         V3Fby/0mVcQId52DPe8gi0uOklig2Ps4lo71d6h4w775zubZHbTl7B5LC0Tg5n9dMnMQ
         L6d5ai+meScOXRFR5PlTZ5YztaM8RGwznVyEdhYqzi5j/mbfmeijsbKJF/RFuXfmmkSv
         WD8N7pNGsb1SMnQp1yEbOGHY3/RLOXLHT9R7pRkE+Ug2E5cM72fbGyaMNxMMaseDgnx1
         AihA==
X-Gm-Message-State: AOAM532RKi0a2qmy/9yJgAZ+Wp8bo+dKjWZDh9/cZCm0oFXAhZjm0cJa
        SG/dpjRiogKvI4x18m0+Yb0kci9RADpdDg==
X-Google-Smtp-Source: ABdhPJzAiVYSKnU+OVha1nlMLCRQu8agC6BMaVTJWYlqJqfISfDsgoHF8yWWjs29+pvCsMZdBWgwqA==
X-Received: by 2002:ab0:2752:: with SMTP id c18mr3791332uap.33.1642148998951;
        Fri, 14 Jan 2022 00:29:58 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id s25sm2278156vsk.20.2022.01.14.00.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 00:29:58 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id v192so2391335vkv.4;
        Fri, 14 Jan 2022 00:29:58 -0800 (PST)
X-Received: by 2002:a05:6122:c89:: with SMTP id ba9mr3830615vkb.39.1642148997887;
 Fri, 14 Jan 2022 00:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-3-jaschultz@microsoft.com> <CAMuHMdUPwo7pCSwY8_9xTaDruTHt6d=wHiNHvRmE71k8hWeLBw@mail.gmail.com>
 <87czku4z2i.fsf@kernel.org>
In-Reply-To: <87czku4z2i.fsf@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 09:29:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWEh07zXZZesuY0sksXaa6ptDvv3Fv4UC1RDkf7_KUv8w@mail.gmail.com>
Message-ID: <CAMuHMdWEh07zXZZesuY0sksXaa6ptDvv3Fv4UC1RDkf7_KUv8w@mail.gmail.com>
Subject: Re: [PATCH 2/5] platform: surface: Propagate ACPI Dependency
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Fri, Jan 14, 2022 at 7:21 AM Felipe Balbi <balbi@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Dec 6, 2021 at 4:03 PM Jarrett Schultz <jaschultzms@gmail.com> wrote:
> >> Since the Surface XBL Driver does not depend on ACPI, the
> >> platform/surface directory as a whole no longer depends on ACPI. With
> >> respect to this, the ACPI dependency is moved into each config that depends
> >> on ACPI individually.
> >>
> >> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > Thanks for your patch, which is now commit 272479928172edf0 ("platform:
> > surface: Propagate ACPI Dependency").
> >
> >> --- a/drivers/platform/surface/Kconfig
> >> +++ b/drivers/platform/surface/Kconfig
> >> @@ -5,7 +5,6 @@
> >>
> >>  menuconfig SURFACE_PLATFORMS
> >>         bool "Microsoft Surface Platform-Specific Device Drivers"
> >> -       depends on ACPI
> >>         default y
> >>         help
> >>           Say Y here to get to see options for platform-specific device drivers
> >
> > Without any dependency, all users configuring a kernel are now asked
> > about this. Is there any other platform dependency that can be used
> > instead?
>
> there's probably no symbol that would be true for x86 and arm64 while
> being false for everything else. Any ideas?

depends on ARM64 || X86 || COMPILE_TEST?

> In any case, what's the problem of being asked about a new symbol? That
> happens all the time whenever new drivers are merged, right?

In se there is no problem with being asked about a new symbol.
The problem is the sheer number of symbols, and irrelevant questions
(e.g. this one, on !x86 and !arm64).
Time spent on adding proper dependencies is IMHO well-spent, as it
will save time for everyone who configures his own kernel.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
