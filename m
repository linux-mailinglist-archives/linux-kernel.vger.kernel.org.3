Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E68488941
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiAIMNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiAIMNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:13:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F2C06173F;
        Sun,  9 Jan 2022 04:13:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b7so13084576edj.9;
        Sun, 09 Jan 2022 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sK4oInq0xLDYMxewrt2fT2vP9aKlihhsJSisYgx7opw=;
        b=dEqWucWMPDGNVTQVqygPiQJyzUf0D+3wTCblnNSLHsaWd82qEgY8euK/ulG1OjqVPO
         G/lvbB9GOHBN5Xp+zxvr3OdYh02y4pcEvNw3D7lS5QbOKBp75JNNHfPTiSOIkChSQgcf
         v7+9mER59DRWoVIhz0WVCk97bTZq/kaQsQXRzryUeY5n04gZucWCYIR2pI9SJyC1ngne
         jZ5ps23XsFP67uQpUIMNQn6NXkF60gD/8bngt0l7GQg8ppNbj6Fxvlgl7ibny3wPlT87
         1R3h7vEN50LI4ylsXGgrHZoAOQS4ivqVpcmtgwzWeA+7m7JNTsCdzt0w7Qz1hEmtfYf1
         RSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sK4oInq0xLDYMxewrt2fT2vP9aKlihhsJSisYgx7opw=;
        b=S0+X2MDLwYk4E0zEwFeLvcLOi/NKp+FmGRwqcSLv55u6X0Zzu4/dJhmAhmf4ZwNUxT
         pJZE06xNxRcKiBhrPt9cm6mVd7cCa33UPGhNhCJXjt7gJ8lICgxSb+/OANzkLQeARaHj
         JfrXNTWU0lnqfuDFdbdzCS1BVi3142WRSoqM6nqXC77TXSRfbwt6XpnqD+Hk6FR75og+
         KvfKESX0fXTZcxZmKpk1zY7sHPyjB8BKgN7SqcB5/lKZmm4uHp/zAdg06MxE9REG0OGE
         cBJcquW0nRhbmdK8Aez/sGthhJwiEeVwtESJygDqDCPDcXmpASjLyGEaTd1bNL0BTO1I
         BACA==
X-Gm-Message-State: AOAM531COKF/0EPeBRKOfReFF6nv3f79CtmAWW/LJQn2hGXiF8nE0Wwp
        UN0UBV69OT3lRJ+Wl7G9J0R9SrSoXQPNdHBONL47nsHLT8k=
X-Google-Smtp-Source: ABdhPJzbjQosZZM6cRFEbrnuG6Cjn4sKjKecg0vm0pzmsUgmcr+giBKuilctffS6vusmHypfj08fspm02eV57G1fUHg=
X-Received: by 2002:a17:906:e0d9:: with SMTP id gl25mr4829498ejb.44.1641730421025;
 Sun, 09 Jan 2022 04:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com> <20220106062255.3208817-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220106062255.3208817-3-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 14:13:05 +0200
Message-ID: <CAHp75Vcq76iaHHp2oXFsaE4d_+EGH87DxQRYu7Ys-adN_4mmUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: addac: ad74413r: correct comparator gpio getters
 mask usage
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 7:34 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> The value of the GPIOs is currently altered using offsets rather
> than masks. Make use the BIT macro to turn the offsets into masks.

of the

...

> -       status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
> +       status &= BIT(real_offset);

But this is completely different.

> +       bitmap_zero(bits, chip->ngpio);
> +
>         for_each_set_bit(offset, mask, chip->ngpio) {
>                 unsigned int real_offset = st->comp_gpio_offsets[offset];
>
>                 if (val & BIT(real_offset))
> -                       *bits |= offset;
> +                       *bits |= BIT(offset);

So, how was it working before? If it fixes, it should go with the
Fixes tag and before patch 2.

>         }

On top of that, you may try to see if one of bitmap_*() APIs can be
suitable here to perform the above in a more optimal way.
(At least this conditional can be replaced with __asign_bit() call,
but I think refactoring the entire loop may reveal a better approach)

-- 
With Best Regards,
Andy Shevchenko
