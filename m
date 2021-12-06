Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28A46A2FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhLFRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhLFRcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:32:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE8AC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:28:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so46550575edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Iwam9ntoKrXXFMW9GBBg/CP2/SJeMa2eol8Tt6Y/4w=;
        b=Sd+DbBx50iRRQDCEahfK/6JoYwkIW3PdLQoaN+VzpC2SB0+lVKLqv+7X5TPeOQDjX4
         xXZb28UYQhfHSN1ztNpmV+MKnyjh5R5gaRAfaWnuTWUUwOaH0h3dkVzroeVXtlgTmXgs
         pxcCogtoYtZgkBfFk4k7L2Y4Kh5AuakypT5UR4DQEzhlp/fTVxC9wKdgffqhEYiKY/GQ
         gYQWTcrf7tski3w4QdbRc3hPIb81CxU41+byZ2jHxSCfVgT6G/jOa7Aw+v5+pKwGOfGl
         ZiOr0pnqHwXYQRVtOv1X20hbypEhzSgiFXoQw6+zwh91goEhayT+AW/fu57OBK4XSXby
         R7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Iwam9ntoKrXXFMW9GBBg/CP2/SJeMa2eol8Tt6Y/4w=;
        b=udvcjSngksaM4g6bafUVMnY7NPBfUgCMVLbhwi3MZsv6K8VGKUUvxoPRn5KmGwE7gn
         OonB715qxgX/zHViVGJMa7DNFuozcb0GmeVJNcwbG66qc8UpSsAcuxbVH7sdbnnq5oHw
         TbI0LIzEw57oSs5criUUUcpIF/XC4zk1duoCAvjFG2SsM0w2ZFkOq8DFOg4GeiIIqcq7
         XOoT+e3wpuw5Ozfnoop/uMhZyyy8Us5CvTMkVZc08sn0gm+jfk+Lem4s139Rsr45rzto
         N2mYSjGcsuEfOmtyY1AhBtp8+m78CIpJy2HDKgwoIk2R+Qo1JwcswWtWpzdnEMYjc0Hg
         Bqhw==
X-Gm-Message-State: AOAM530w8NQ+QdhQD0zI6LUCm3rOcedn3YK+dr/8Z4n0ZMTJSe/rexXo
        MZB7pP3OU6u1rLXtR0avYENwpE8zFhZZEoOLd/w=
X-Google-Smtp-Source: ABdhPJx9/dmmMIp0k2nEWYLkPyQHjbt6A++ofLwsYD9nTGyKv6qQM4UpeYPChbhnOnPF9AqF77qtzNTlFRyRQ7ZtUy4=
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr602667eds.386.1638811723308;
 Mon, 06 Dec 2021 09:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20211205180816.2083864-1-martin.blumenstingl@googlemail.com>
 <20211205180816.2083864-3-martin.blumenstingl@googlemail.com> <1jfsr659v1.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jfsr659v1.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 18:28:32 +0100
Message-ID: <CAFBinCAceRkO86bXfUYnDwup3At9MaN-PnOiLxa-1fYO5SwOQA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/2] ASoC: meson: aiu: Move AIU_I2S_MISC hold
 setting to aiu-fifo-i2s
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Geraldo Nascimento <geraldogabriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Dec 6, 2021 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sun 05 Dec 2021 at 19:08, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > The out-of-tree vendor driver uses the following approach to set the
> > AIU_I2S_MISC register:
> > 1) write AIU_MEM_I2S_START_PTR and AIU_MEM_I2S_RD_PTR
> > 2) configure AIU_I2S_MUTE_SWAP[15:0]
> > 3) write AIU_MEM_I2S_END_PTR
> > 4) set AIU_I2S_MISC[2] to 1 (documented as: "put I2S interface in hold
> >    mode")
> > 5) set AIU_I2S_MISC[4] to 1 (depending on the driver revision it always
> >    stays at 1 while for older drivers this bit is unset in step 4)
> > 6) set AIU_I2S_MISC[2] to 0
> > 7) write AIU_MEM_I2S_MASKS
> > 8) toggle AIU_MEM_I2S_CONTROL[0]
> > 9) toggle AIU_MEM_I2S_BUF_CNTL[0]
> >
> > Additional testing shows that when AIU_I2S_MISC[2] is set to 1 then no
> > interrupts are generated anymore. The way this bit is managed by the
> > vendor driver as well as not getting any interrupts can mean that it's
> > related to the FIFO and not the encoder.
>
> Not necessarily. If the encoder stops pulling data, the FIFO will going
> over the DDR. Since it generates an IRQ after reading N bytes, IRQ would
> stop too. AFAIK, if the pipeline is stalled, the IRQ stops anyway
ah, right. so I think you're right: it can be either way

> ... but this is not really important
I'll remove that section from the description in v2

> >
> > Move setting the AIU_I2S_MISC[2] bit to aiu_fifo_i2s_hw_params() so it
> > closer resembles the flow in the vendor kernel. While here also
> > configure AIU_I2S_MISC[4] (documented as: "force each audio data to
> > left or right according to the bit attached with the audio data")
> > similar to how the vendor driver does this.
>
> I understand the part of HOLD, not about FORCE_LR.
> Is it necessary to fix the problem ? Have you tested without this change
> ?
On my Le Potato board (GXL / S905X) FORCE_LR is either enabled by the
bootloader or being enabled is the default value.
All versions of the vendor driver are also setting it in some way,
including the latest one that I have access to [0].
I prefer to keep this explicit write in for two reasons:
- we're not hit by surprise if some SoC/bootloaders don't set this bit
by default
- the code in the mainline does not skip anything that the vendor driver does

To specifically answer your question: I have not tried whether this
bit needs to be set and if unsetting it manually breaks anything.

> > This fixes the infamous and
> > long-standing "machine gun noise" issue (a buffer underrun issue).
>
> Well done ! It took us a while to nail it, Thanks a lot !!
Thanks - this took a while to figure out but it's great to finally
have it solved!


Best regards,
Martin


[0] https://github.com/khadas/linux/blob/khadas-vims-4.9.y/sound/soc/amlogic/meson/audio_hw.c#L194:L202
