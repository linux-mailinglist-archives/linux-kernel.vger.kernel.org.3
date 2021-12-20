Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79E47B024
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbhLTP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbhLTPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:25:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C6C09B11E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:07:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so10989703edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHn9hs89sVWzHh2SxeZRz3wuaNP8dfg8lMqa/q5seRs=;
        b=vgF02nBpQ3V4vsHgN8izdvvyBF59f7lhmGfqzrZJ0Jf1dUy6W16GhEi14bWHcJcIij
         Mcnf2LwTaESVLdVII8c+4NKJmyVpw2xSvmbFxjMEqq6dtP05lE090lUqEBzGEa62BT60
         jKd7VTG+gYNCttakmN/gr/tayyHd7Hvl9o0+crIbPcVNWIdkfOimtePTMyaFcNTy9MWG
         Emc7EbtCEJT6X1Qa2Lr8QanC0fuMegXfnTALjdmapcEFKsUSakKBPt74Bh2Eqnieo4Oo
         S3dZflJkrXwxrASjL/lv4TRzRj8/mL45if+9b9kMA1UycCucLDkk/PacTWR2N988xiGM
         FRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHn9hs89sVWzHh2SxeZRz3wuaNP8dfg8lMqa/q5seRs=;
        b=acec7ieKc2Ox6rUyhXYiXk5iq+GuaEO76rxNehG3tPsemIvfuJVcTm4SWCX3gmwACF
         F13uI+NJZMHsT+61DlwInyCekJWRdWEqxsPyERdhQTxCojv3h1ewYPcp3KpMZ4MJKX+g
         fDSTgdVGQ9bllUhfhBQNlHVQHm21RS24SbjCAJl0N1oeHogPK5+Ql0fYYTr9z9PAOgef
         A94Ew6KUZTnpvRJm8lkAGzKm2fhG//Q281tljk4xji14KGh6xURmC1OkP/Z0uHxeUcD8
         IiLYI1Gtluopp3bx5wzvxjORAb9kv+Jd3vkKKAKGDxzbK5kbOs/L0cv2kdvdSY4GS0W0
         DC7g==
X-Gm-Message-State: AOAM532QfR/59LHc7tweEEkbfejuf90QHWGhDzGxAD8yRhnI5ADfu5e3
        ZLn+9A7TFrNsmj8t6ntOVM3nQPPRa8BmCsY3VqcHcQ==
X-Google-Smtp-Source: ABdhPJzuKAvGN7YAcp5nXrRc+WQPSK8YcFJyMnHXzWvnC4eZi5W05eFHf1c18Qp4YPWMEXc61KRbWMDdYdIc53EOYAM=
X-Received: by 2002:a50:e611:: with SMTP id y17mr16496269edm.270.1640012836555;
 Mon, 20 Dec 2021 07:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <20211213094036.1787950-5-daniel@0x0f.com>
 <CAMRc=Md_2b-sBnPQL-E59byYSv+Z0+d3V8JrbPqpGSMjGS+tgA@mail.gmail.com> <CAFr9PXkkp8B5Vv0eu+2gPF2S4CNaxZDwjPg+UXRgvyUkAZBFpA@mail.gmail.com>
In-Reply-To: <CAFr9PXkkp8B5Vv0eu+2gPF2S4CNaxZDwjPg+UXRgvyUkAZBFpA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Dec 2021 16:07:05 +0100
Message-ID: <CAMRc=MepS1rh13kYGvvsMmAec93fdtSHiddxqO1W4Bg+uy-dNg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: msc313: Add support for SSD201 and SSD202D
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 3:58 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Bartosz,
>
> On Mon, 20 Dec 2021 at 23:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Dec 13, 2021 at 10:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
> > >
> > > This adds GPIO support for the SSD201 and SSD202D chips.
> > >
> > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> >
> > I applied patches 1-3. This triggers a bunch of checkpatch errors.
> > Please address them and resend this single patch.
>
> The warnings about complex macros being wrapped in parentheses when
> the things it's complaining about are defined lists not macros?
> Not going to say I know better than checkpatch but I think the errors
> there are wrong. Putting parentheses around the lists would break the
> arrays they get put into.
>
> Cheers,
>
> Daniel

I took a closer look now and it got even worse. This is some major
obfuscation with those names being defined as macros defining partial
lists...

Anyway, it was already there when you got there so I guess we can
address it separately. Queued for v5.17.

Bart
