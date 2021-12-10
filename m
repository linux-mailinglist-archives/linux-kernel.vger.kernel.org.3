Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEE46F8A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhLJBpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhLJBpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:45:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF59C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 17:41:58 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t19so11350404oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 17:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CAEs6TA9o6xsdCdp2MRvi3WB7zMwWYnia8jBx/umBqs=;
        b=dy3rIqlj8uvzBxhcQD03MQEGT9iCSV29dHj5Ey3cpl0BkhBgxHQFcrOPBPvwRGWJEG
         QuDzh4CPlUK4jhFiKS9pADBoO8aOQSbsfXVlQrwqntPpixr7cwuKCaFtcuO1H+991Hid
         8hLR5aHaCEKX/BmOB9p6/8vIgQBjssvCGSYahyUURzmIDe4aqboHjLcYBITJWLZdYxRi
         FRRXvgj5fW8qZCPiyLjsApkXnfGNxKit0nMVPW82luqBaO9Lpq0BYqWYw9xKiIHBLKF7
         5bNF94kSietC/r1t8Ktl4XUouYu6Wokjei8QFCHTQbDMYg/zl6kwJaFEihy2Y9HIUx2d
         kZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CAEs6TA9o6xsdCdp2MRvi3WB7zMwWYnia8jBx/umBqs=;
        b=vmAzMKO0HWYUepWa6LPQX86Bs5sfMJqM/O4g/hMjOoFlMVHxtjOxKlY0fjTSZCHLJV
         +Ev202lm/3gLeDc+BSsb1OQxZLVQtqgJEIcPiWWybBljPRUaHS+QlNpDywfM3PcqaCCz
         DZRxndv/0A46C30uBmZo5e6CWC/nrbU71sRC+9tjVhS/6XTxtwS8Aq+X4d0FqUcVTQGf
         Imqj+7mx9CGDy6H2AaqkgeY8pVwgYOsLB3gLPj1PBzuNv/w2htHfnA+6n6Ur1rjoO7dE
         6w7zTozQmfc6Tg0L7moEaLtEGlDXzIqSgoNEJfhdzwZi5X43KVsSuMnA9l907ERw4FgV
         E0FQ==
X-Gm-Message-State: AOAM533uliRKRFva0PK6s8shbZS7tYA20q0dBn8Xt4G3Bu8MvzirylzH
        SAAqk0J8H9ksHU8q1P6Uyb+yC8L2GFHmP+i9vQ1EXw==
X-Google-Smtp-Source: ABdhPJwBcRbgcZxhHro1YSDmrt7rzHSafyA3nD3aKcE4a+q4d22XA0r2ItBipMJp1FnUniZp6IqKB/rEgM/fmK1Ki1k=
X-Received: by 2002:aca:120f:: with SMTP id 15mr9624499ois.132.1639100517622;
 Thu, 09 Dec 2021 17:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
 <20211207210823.1975632-6-j.neuschaefer@gmx.net> <CAHp75Vew=M_ofNM5pmeHtTJHXRUbbO4RrtgYAtLBznTBm3CS6Q@mail.gmail.com>
 <YbC6Bv2teZ5CFhFQ@latitude> <20211209082623.GF25091@packtop>
In-Reply-To: <20211209082623.GF25091@packtop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Dec 2021 02:41:45 +0100
Message-ID: <CACRpkdb_zGz4+8R0=ORCbbbVeJVkLqBG2CDXAzi2VAA7-PPZ6A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] pinctrl: nuvoton: Add driver for WPCM450
To:     zweiss@equinix.com
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 9:26 AM Zev Weiss <zweiss@equinix.com> wrote:
> On Wed, Dec 08, 2021 at 05:58:30AM PST, Jonathan Neusch=C3=A4fer wrote:

> >> BIT()
> >
> >I'll use it, but in this case, I think it doesn't simplify much the
> >whole expression all that much. Is there perhaps a macro that
> >constructs a continuous bitmask of N bits, perhaps additionally
> >left-shifted by M bits?
> >
> >Maybe somewhere in the bitmap_* API...
> >
>
> There's GENMASK(), though it takes a high bit and low bit rather than a
> bit position and count, so it'd require a small bit of arithmetic, e.g.
>
>   lastbit =3D gpio->first_irq_bit + gpio->num_irqs - 1;
>   ours =3D GENMASK(lastbit, gpio->first_irq_bit);
>
> or a manual shift:
>
>   ours =3D GENMASK(gpio->num_irqs - 1, 0) << gpio->first_irq_bit;

I think this can be handled with FIELD_PREP() from
<linux/bitfield.h>? Some examples at the top of the
header.

Yours,
Linus Walleij
