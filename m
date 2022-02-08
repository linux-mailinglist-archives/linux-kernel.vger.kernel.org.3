Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CF4ADAA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358099AbiBHOAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347474AbiBHOA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:00:29 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF1C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:00:28 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d3so13938959ilr.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IjWPfErVF56gnkl+7MbKURIscJK6+3f2izeud69z0w=;
        b=LUhgR+1eKRyE4/ga2Xet0wuA9pHfUbQXrlc8q5dGINWcVWUon/YfDqW5kgxA6BQgiw
         yO+Fe89vtS5CjphxZIL0HxwBTU4FaKW7Eq5W00ElVcH/6dwzRNpW3UmoP3bWwjY54J+8
         pGR5oA4ZqFNbDeQwmSxOOGcU1QkZWYiyogbhy5A14vEDIJOzBEgvYQmkY5NPe7RNq/6b
         1kuTFem7o3FvSDTYWGOkGHlS3cVDvcrkAj328ZCtHKg7FxY4n5eyG9psp3OxQXUQcL1R
         1PRUQEvZYpvh5NvNa7Kk2dEDY/4SFfg0og7E41jpYIqNKVFVFqoQq+2f2KLv5PIcKNP9
         JtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IjWPfErVF56gnkl+7MbKURIscJK6+3f2izeud69z0w=;
        b=j7HWiJOaYarlO88LknH1d9BZGBOVZ8iRwBcQBg20OPbTLAZR58dGiCzABiXZTGlFgJ
         2OPGI02DVspuWFMwkMZNPne5+neMt/P5LBbR3b2JdrlnDGSAAIiwPJVBCIVWYodcal0W
         vW0A1uRxDO8MovCBns+1Sv17dwVWEiM8eJeBrVIuA+MZUhEetchRwElBDDTdzEadkujb
         L17cDETYAgL+/gmzSOFE2VDIFx7GhL/R3AqyMrDQBSS8kjX1oAc/kidxKDuqkACt7DT5
         /SKIeFGa3revjmAfz3TcW0abY0m8EvGDXVroumC6UakV8mLOtS5xENqp6PC8kIJMxQGl
         aeAQ==
X-Gm-Message-State: AOAM530MXSFg3FHYBSnt2iwtmsmvyWDLnknuKJIqYI5xuk0BvLQUNJdJ
        yQq34+aZ4v69q+paBAGi+qTPC0HnUxTmkhYrIvtx7zv4jyg=
X-Google-Smtp-Source: ABdhPJwHcduOoeSoYhskViqfRoKn2RqgFcKlDQmaTXl3EU2lA9M9MdHU8G995bWx3zivCHUAIzM9wALGHbYFgmye1Oc=
X-Received: by 2002:a05:6e02:1ba2:: with SMTP id n2mr2342739ili.5.1644328827834;
 Tue, 08 Feb 2022 06:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20220203002521.162878-1-cmirabil@redhat.com> <20220203002521.162878-4-cmirabil@redhat.com>
In-Reply-To: <20220203002521.162878-4-cmirabil@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 8 Feb 2022 15:00:16 +0100
Message-ID: <CANiq72kSdjRgBN1D-de9xKQuKRm7XqX6=1tbi61oouMS6KGTbA@mail.gmail.com>
Subject: Re: [PATCH 3/6] drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT
 display driver
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Miguel Ojeda <ojeda@kernel.org>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Daniel Bauman <dbauman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 1:26 AM Charles Mirabile <cmirabil@redhat.com> wrote:
>
> This patch adds the driver for the 8x8 RGB LED matrix display
> on the Sense HAT. It appears as a character device named sense-hat
> in /dev/. That special file is 192 bytes large and contains one byte
> for each color channel of each pixel. The overall layout is:

A general comment about the commit message: I am not sure why the
format of the file is included here -- shouldn't this be placed in
comments in the code or in Documentation? Is it elsewhere in the
series?

>     col 1       col 8
>       |           |
>       v           v
> 0x00: R   . . .   R \
> 0x08: G   . . .   G |> row 1
> 0x10: B   . . .   B /
>       .   .       .
> ...   .     .     .
>       .       .   .
> 0xA8: R   . . .   R \
> 0xB0: G   . . .   G |> row 8
> 0xB8: G   . . .   G /

Do you mean B instead of G in row 8?

By the way, is there a particular reason for this layout vs., say, RGB tuples?

> Each channel may have any value between 0 and 31 (larger values are
> wrapped) and are translated by a gamma table before being send to the
> device to provide a linear experience of brightness (the gamma table
> can be modified or reset using an ioctl call on the file). The constants
> for the ioctl are in the sensehat.h header also added in this patch.

Even though there is a gamma table, it is unclear what the input
encoding is supposed to be. sRGB? Linear sRGB?

In any case, where the gamma tables' values come from? i.e. the
device's datasheet (or sRGB, or a combination of those), or hand-made,
...?

Also, should this conversion be handled by the driver? If yes, why not
use the full range 0..255 as input?

> +       for (i = 0; i < VMEM_SIZE; ++i)
> +               temp[i] = display->gamma[display->vmem[i] & 0x1f];

Please avoid hardcoded constants (and, in particular, this is in hex
while the related constant `GAMMA_SIZE` is in decimal, so it is even
harder to see). Or perhaps use a small helper function or macro.

> +       pos = base + offset;
> +       if (pos < 0 || pos >= VMEM_SIZE)
> +               return -EINVAL;
> +       filp->f_pos = pos;

Please check if one of the generic `llseek`'s would work here (e.g.
`fixed_size_llseek`).

> +       memcpy(sensehat_display->gamma, gamma_presets[lowlight], GAMMA_SIZE);

Here it is confusing which table you are copying due to the `lowlight`
name. I would write `lowlight ? SENSEHAT_GAMMA_LOWLIGHT :
SENSEHAT_GAMMA_DEFAULT` even if it is redundant.

(Given you created an enum for the presets, it may make sense to use
something else than a `bool`, by the way).

Cheers,
Miguel
