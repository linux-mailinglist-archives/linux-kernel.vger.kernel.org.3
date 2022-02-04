Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924D64A9FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiBDTWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiBDTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:22:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:22:05 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so5885206oth.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eW3Aghyc05aNjfJC30pjJ1DLt2m35M406+ZpGJdndM=;
        b=JGOvO+iI43HLC0fbyqUqf5DsOgtyHvpRRXHMk1i0yaS0hWkP/AsNC2tTp775Dj9v//
         cX4Wk/lzxkTKzmveQ19zFKe9F7GL8Vqe4rrkOjgmcqSMI9ej2fhoQe2FhneFAQC7QHMY
         oj4mde1gbIvZRMhyEHECFS4voOmtnEAR+PJtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eW3Aghyc05aNjfJC30pjJ1DLt2m35M406+ZpGJdndM=;
        b=KNuI328T7DW0HwBnQRkPYohWu3E3p5+rZrBzp3/lTJe+V3eJWmAJM/Mqp+qh4DZV+a
         DodWYHrGVyrDk0OslehOVvOgzrHuZitMoCCNLgU/oAWa1q6XYjylXT+icVa2yjtzpbTW
         pS5abfbVE/An7MmvGHxPvKwwTln4XV5IE4nptz15/X9y3pkiCD37c2xe4OYjbL1z7EG3
         Q5vSHLesNsOES8c/79fLzc7TJnx994VIQVT9W8CdpL/9FSOP3vCrkAC/fsAXD72qEfRa
         J1zkXYQYePA+p+1fsFmu9f+ypAZjlhHz0BciDs2/mKcMNy8NDCoItwddpNpbV7HHpQl7
         Hkpg==
X-Gm-Message-State: AOAM532wCKCpKEuvfuHXqbvj0Vaf4qxcJiK7Nd0wf3adMOxmMnxGrFCA
        W/5E3HX1fVnK+eiYEARSppyaX3vOe1xkwQ==
X-Google-Smtp-Source: ABdhPJyR96ngp/VOyRlHAENK140arkF5z0RnjJDtbhjTUhv3dpyMLnTJ50KMU1sqsnfJurnLaQVBYA==
X-Received: by 2002:a05:6830:43ab:: with SMTP id s43mr223043otv.118.1644002524245;
        Fri, 04 Feb 2022 11:22:04 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id a15sm1210127oil.13.2022.02.04.11.22.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 11:22:03 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id u13so9655634oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:22:03 -0800 (PST)
X-Received: by 2002:aca:5c82:: with SMTP id q124mr2091947oib.275.1644002522992;
 Fri, 04 Feb 2022 11:22:02 -0800 (PST)
MIME-Version: 1.0
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk> <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk> <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk> <Ye87P19+JOjPEGTY@google.com> <Yf14RJbM10O3RdA+@sirena.org.uk>
In-Reply-To: <Yf14RJbM10O3RdA+@sirena.org.uk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 4 Feb 2022 11:21:51 -0800
X-Gmail-Original-Message-ID: <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
Message-ID: <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
Subject: Re: regmap: mmio: lack of runtime_pm support for debugfs
To:     Mark Brown <broonie@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Feb 4, 2022 at 11:02 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 03:50:23PM -0800, Brian Norris wrote:
>
> > The only 'runtime_pm' flag I'm finding for regmap is for regmap_irq_chip
> > -- there isn't anything useful for other kinds of regmaps (like MMIO).
>
> > If this seems like an expected/useful feature, I'll look at adding it to
> > the generic 'struct regmap_config' / drivers/base/regmap/regmap.c.
>
> > This could be tricky in theory given the atomic context requirements,
> > but in reality, I think it would still be OK: this feature would really
> > be useful _only_ for otherwise-unregulated contexts, like debugfs
> > access (where we can sleep). For all non-debugfs accesses, we expect to
> > already be RPM_ACTIVE, because the driver should already be managing
> > runtime PM.
>
> Are you sure you wouldn't be better off with a cache here, or marking
> the registers as precious so they don't get read (perhaps conditionally
> to allow reading while the device is live)?

We do actually have a cache for the case I care about, but there's
also a debugfs file for bypassing that and...for some reason I'm
dealing with some diagnostic scripts that purposely toggle that. I'm
not sure how wise that is, but in general I like to reduce the number
of ways dumb user space can screw things up. I've even had to tell
people that recursively grepping through sysfs or debugfs is a bad
idea...

The precious_reg() callback is interesting. Maybe I could have that do
a quick pm_runtime check to make a decision. Thanks for the idea.

> The general idea
> expectation with the debugfs is that it shouldn't materially affect the
> device, this would mean that it could cause the power to get bounced on
> which feels like it might lead to surprises.

Yeah, good point.

> If you are sending a patch
> adding support for this it should be debugfs specific, not a general
> flag so it's clear that it's not going to do power management outside of
> debugfs, as you say in the normal case it seems better for the driver to
> do power management.

Another good point. I did poke around a bit on trying to do it
generically, and it looked I'd have to touch a lot of stuff to avoid
sleeping/atomic conflicts, while likely having no real material
benefit (for well-written uses) outside of debugfs.

Anyway, I'll probably just go with precious_reg() as suggested above.

Thanks a lot for the tips,
Brian
