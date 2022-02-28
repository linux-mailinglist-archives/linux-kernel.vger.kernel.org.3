Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118FA4C7DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiB1Wuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiB1Wut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:50:49 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDCD149BB3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:50:09 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h126so8725073ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mn4+kgjmXxJgm4OAorwyyF3bOLkF04FkX9ZXLKWpbeA=;
        b=gJRgswjjNSH6d21VIg6gtItUhMur6yQVpp1I2QRW7zF2GWc38ElPLT6vzTxeWIPAUm
         KWbOLCYKEH0ElkFA0D7zSDUy/GZB28/7zFaZvbu34RQ5YmET1J7c7hexvWJufNW0dYVA
         oCp+Ut6Fa/rsYT8VqkTHa7SxGRKh4tAeuQV1EdIRqbIbuTY0B+HjG39VmTl5xfUYdaQx
         PGvwaQtSNCvVK18a8kPxNRid5o5BJUA3JqEM0vpOI2P75GbfuiGWSsUNltvgybBr110+
         kFwdg01f/UzWIBVLsqtUlKCrPelNmTB73hZT7l3JZnDE3AiMxjzxQYG6xldBsmokyEeq
         2Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mn4+kgjmXxJgm4OAorwyyF3bOLkF04FkX9ZXLKWpbeA=;
        b=fnFvcZkWm4rNJ+CmgPiddaKnVRVPKRgxkD3tRy30FVlQ6t4sOyZAXk2RPNH8DpG6a2
         gEIb8aQXJWPdXE2HUkWGg/pAdL2X+r0/TIQUdbmfh2SYPqYyTOy54cSO3nUABfuZPUdf
         7Nc4IQGlihNCp+6LcvvqDyf8eM/9Hkdcgk6JkGtFdlP0ID3XImmkty55/QMP5AiiMqtt
         Yxm+g1bCUuoBNcdyEgDACkTVW4Bu6Cgz6HHbkml2ecN1emcQ8oGpOw2eYKFX2V1sf2v6
         Lz0HKzNMpw29+7ATWYeypEnV2YyHy2NjFUNYwue/82AvWwJ86yc83NYcIe2yCzFc24yR
         lTOg==
X-Gm-Message-State: AOAM530SnttZfCAfaRMXgyX8238kAdVqKMW0RUVLQgqdI3w5Ny1kBaRQ
        kT3Bjzzvu5RF8Z7/HVQI5UCSqHu02plCGREqhEn1nQ==
X-Google-Smtp-Source: ABdhPJxkM+FzfHrMMvSUVMeWBGLePzqxGRlEMtKKuxkgM8AFsPaDCRHlXHILLH4h1xPwfhaxrt9XhPyseCq1GfD+59s=
X-Received: by 2002:a25:aac3:0:b0:624:ab10:49dc with SMTP id
 t61-20020a25aac3000000b00624ab1049dcmr21426486ybi.291.1646088608419; Mon, 28
 Feb 2022 14:50:08 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
 <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
 <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com> <CAHk-=wjNdW6Tdei6+6OJy6jGqY=PCJ2TWFKpV+g0projUC1eag@mail.gmail.com>
In-Reply-To: <CAHk-=wjNdW6Tdei6+6OJy6jGqY=PCJ2TWFKpV+g0projUC1eag@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Feb 2022 23:49:56 +0100
Message-ID: <CACRpkdY-8D8ZYy9VichQmJHTJCSskFs=e0qpbYssf7tED_9dLw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 8:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Well, part of me being confused is that I've literally seen you reply
> with 'patch applied' to the fixes.. Ie:
>
>     https://lore.kernel.org/lkml/CACRpkdZ1nFAmzRvsvKvZ08fsP_MgsnsiNpD7LdRRXUDWtO_w=Q@mail.gmail.com/
>
> but then I didn't get the result.
>
> Afaik, that patch is only relevant if you applied the previous fix
> ("pinctrl-sunxi: use the right offset" or something like that).

Yes this is the issue, reading that patch series does not really make it
clear that it should be applied, also it gets into next through something that
is not my tree so I get a bit confused and feel a bit out of control here.

Anyways I will apply that patch:


> I get the feeling that you didn't realize that this was a 5.17 issue,
> and have maybe applied them to the wrong branch, and they are pending
> for the next merge window.

Indeed.

The Fixes tag on the latter patch refers to another commit
entirely so it was applied on its own merits, for next.

I'll take these two:

pinctrl-sunxi: sunxi_pinctrl_gpio_direction_in/output: use correct offset
pinctrl: sunxi: Use unique lockdep classes for IRQs

and put them into fixes, that should nail it.

Yours,
Linus Walleij
