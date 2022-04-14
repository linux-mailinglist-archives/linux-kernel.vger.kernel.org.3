Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2DC501A17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiDNRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbiDNRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:39:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39594DFD72
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:36:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c64so7248203edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6LSgL+JLYAGp+l4yu2Nh28fCa+u8RFJE0TZw9Q53wk=;
        b=G/Eg3nOk8HCQBnHwrmCrnvNukQ4tgDIdrs+WKLqgpcaN5KWFZ6WMG9a8AKDRCCiTiE
         hewSUK1FQR5+TTha+likMiMzDv8u/xGc6E2LqSvKUpCnwtH5uANmfEjtzw44+29Ow2Ji
         Z3o9c5cVrMAov8BEnyodAN3o6+5o9wmuMxCNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6LSgL+JLYAGp+l4yu2Nh28fCa+u8RFJE0TZw9Q53wk=;
        b=ty/UBJExLbAExf4aFMAs+DIyUHd8z6DWo2sd66OPy5WFIzD+g9sBuUtZ5Ha+yqI9tN
         IQvc1GAMMax+8ti8T7ID+vScXHG3HA8emrDpYPKV/GOorH1u1NhXL/TV8M/0C63EPmDC
         fSehHLcQXW5ioK54lZxIwpWMNyRTWAMEOscWcNBzt+pIcci1ryJ2J0yDwC/aCMiLC4/t
         UuxvOnNb/jiq6fNSFeb/64lS6VeF0H+P89IChB9JfV8Z9ym+k0LtSawkU7XowMvgzG6h
         Aq8wpBTY2GeZthaH0fD2XIlBB4nyTKp2San+3tKx58WPQ/4Bjg7mL7xEcY88z20n7jl4
         aO0w==
X-Gm-Message-State: AOAM531yer6mMFHPDOlWWhivWybVTW/VXfYaJCjpDi6wuCFXAUKkfr4u
        KxoKvVMCkVhgkajv/Yht6d0zJ482gwx2QZAJoC0=
X-Google-Smtp-Source: ABdhPJygueIJ0riWiNvdeJO43Sm7yauOFv6BBa6b4JiCJv8H3Wek7wMPkXMrK0LMT2VwRF+TDr4v4g==
X-Received: by 2002:a05:6402:1707:b0:41d:9794:6421 with SMTP id y7-20020a056402170700b0041d97946421mr4168039edu.212.1649957816368;
        Thu, 14 Apr 2022 10:36:56 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm1287809edt.94.2022.04.14.10.36.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 10:36:55 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id g18so7877440wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:36:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1c15:b0:207:849a:648b with SMTP id
 ba21-20020a0560001c1500b00207849a648bmr2776001wrb.513.1649957814133; Thu, 14
 Apr 2022 10:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org> <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org>
In-Reply-To: <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Apr 2022 10:36:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
Message-ID: <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 14, 2022 at 12:10 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/04/2022 23:48, Doug Anderson wrote:
> > I'm actually kinda curious: is there really a good reason for this? I
> > know I haven't been adding things to
> > `Documentation/devicetree/bindings/arm/qcom.yaml` for Qualcomm
> > Chromebooks.  Ironically, it turns out that the script I typically use
> > to invoke checkpatch happens to have "--no-tree" as an argument and
> > that seems to disable this check. Doh!
> >
> > That being said, though, I do wonder a little bit about the value of
> > enumerating the top-level compatible like this in a yaml file.
> > Certainly the yaml schema validation in general can be quite useful,
> > but this top-level listing seems pure overhead. I guess it makes some
> > tools happy, but other than that it seems to provide very little
> > value...
>
> If compatible is not part of ABI, it is allowed to change in whatever
> shape one wishes. In such case, how can anyone (e.g. user-space)
> identify the board? Model name? Also not part of ABI (not documented)...

Hmm, it is a good question. I guess one issue is that the way
Chromebooks interact with the bootloader it's not trivially easy to
enumerate what exactly the compatible will be in this hardcoded list.
It all has to do with the whole "revision" and "sku" scheme the
bootloader on ARM Chromebooks uses. For example, on one Chromebook I
have the bootloader prints out:

Compat preference: google,lazor-rev5-sku6 google,lazor-rev5
google,lazor-sku6 google,lazor

What that means is that:

1. The bootloader will first look for 'google,lazor-rev5-sku6'. If it
finds a dts with that compatible it will pick it.

2. The bootloader will then look for 'google,lazor-rev5'. If it finds
a dts with that compatible it will pick it.

3. The bootloader will then look for 'google,lazor-sku6'. If it finds
a dts with that compatible it will pick it.

4. Finally, the bootloader will look for 'google,lazor'.

There's a method to the madness. Among other things, this allows
revving the board revision for a change to the board even if it
_should_ be invisible to software. The rule is always that the
"newest" device tree that's in Linux is always listed _without_ a
board revision number. An example might help.

a) Assume '-rev5' is the newest revision available. In Linux this
would be the only dts that advertises "google,lazor" (with no -rev).
Previous dts file would advertise "-rev3" or "-rev4" or whatever.

b) We need to spin the board for something that should be invisible to
software. Just in case, HW guys change the board strappings to -rev6.
This works _seamlessly_ because the newest dts file always advertises
just "google,lazor"

c) We spin the board for something that's _not_ invisible. It will be
"-rev7". Now, we go back and add "-rev5" and "-rev6" to the old board
dts file and remove the advertisement for "google,lazor". We create a
new dts file for -rev7 that advertises "google,lazor".

Now we can certainly argue back and forth above the above scheme and
how it's terrible and/or great, but it definitely works pretty well
and it's what we've been doing for a while now. Before that we used to
proactively add a whole bunch of "future" revisions "just in case".
That was definitely worse and had the same problem that we'd have to
shuffle compatibles. See, for instance `rk3288-veyron-jerry.dts`.

One thing we _definitely_ don't want to do is to give HW _any_
incentive to make board spins _without_ changing the revision. HW
sometimes makes spins without first involving software and if it
doesn't boot because they updated the board ID then someone in China
will just put the old ID in and ship it off. That's bad.

--

But I guess this doesn't answer your question: how can userspace
identify what board this is running? I don't have an answer to that,
but I guess I'd say that the top-level "compatible" isn't really it.
If nothing else, I think just from the definition it's not guaranteed
to be right, is it? From the spec: "Specifies a list of platform
architectures with which this platform is compatible." The key thing
is "a list". If this can be a list of things then how can you use it
to uniquely identify what one board you're on? If all of the things
that are different between two boards are things that are probable
(eDP panels, USB devices, PCIe devices) then two very different boards
could have the exact same device tree, right? ...and you could have
one device tree that lists the compatible of both boards?

That all being said, I think that on Chrome OS the userspace tools
_do_ some amount of parsing of the compatible strings here. For
Chromebooks they leverage the fact that they understand the above
scheme and thus can figure things out. I think they also use things
like `/proc/device-tree/firmware/coreboot/board-id` and
`/proc/device-tree/firmware/coreboot/sku-id`. That doesn't seem to be
documented, though. :(

I guess the question is, though, why do you need to know what board you're on?

-Doug
