Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557CD489F29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiAJSYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbiAJSYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:24:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A986C06173F;
        Mon, 10 Jan 2022 10:24:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c71so45572041edf.6;
        Mon, 10 Jan 2022 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OBKlMrGeRwIefZjUnO53bTZIl+uI828EXtV9Nyw2sk=;
        b=etturC84fe4kezIFLvLDguzVmw3WtSl1PjQhSslQESVDw15acoPKNOEyn2KDaMzbh0
         eKVXnyMxtUxw1lzjA6bH0ZFmr8JW+CHBmoK3HetA3iYGVhshyWHK1X4vbyZ6dCdMwDs4
         fiDKOcj6jt3eO2eBqSxltrQ8J/Hs6VgiVnPCGN2CQqQp2F7zh+ziQgT2xDv06bbguSOI
         Z6/M29xIJGy4MpKMx+MYSlOKZiaPQ1FPOSOs3VDiJP0jxVhRaQhvbhnoO3mWB73d/Oi9
         UAoJImpUxyeqtPwm93dKmyJOvI6RP6YQcSRkBLRWu8Npbbsx54fh2FyZ91IJXDkFYrTa
         ds0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OBKlMrGeRwIefZjUnO53bTZIl+uI828EXtV9Nyw2sk=;
        b=OGNWmvWbkCLtcT17igyqNv3nRlvaD7FDVUV9hhEBb9z2U8lDjxZuGjgMPcZ54jKPx+
         ffByXdiYlYLgKvOsNySKXkTfIQgravmQcVpPGBN2/oPKGBXUf/eX5tcZMrh9ACW63dRy
         hBMwK35OU5foFcyORMU+I5lsWxPM90BBS5uyZn2qW63teln3WsBC4UKr5zZnN2XZRWSo
         OORek1eMC46sVCurFo0Us8wMe7YbaT8GUvliBSKnRn4qUhMmup2TaHWPBDtC4hCDJCTD
         fro+Enj2sxGOt5w1ISThG0QU8LJzoWXTdm+hnXpBhxgMWesfCPUD1ttrDhp8+txLkrwk
         FkSg==
X-Gm-Message-State: AOAM5332FUBftCa3dRSbp6qrzVucrD3kmUWtTd1Vzbnyvu7zm5Qx5UdQ
        /hY3s/vFoyecMeD67fmjMQiYLDRnrFM46LPgpz2uZANtq2w=
X-Google-Smtp-Source: ABdhPJxDtUnFS0ICcjJjaUcy6GqZkIiQUUUJ1CXLBLx6+TORFdiGKNjZrq2NLGQCVYpdw4GkjRi2LHxnXMFlvgV1yyo=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr639572ejc.497.1641839049368;
 Mon, 10 Jan 2022 10:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
 <20220106062255.3208817-3-cosmin.tanislav@analog.com> <CAHp75Vcq76iaHHp2oXFsaE4d_+EGH87DxQRYu7Ys-adN_4mmUw@mail.gmail.com>
 <953f1539-a4fc-ab8e-bcf9-287ac91ba42b@gmail.com>
In-Reply-To: <953f1539-a4fc-ab8e-bcf9-287ac91ba42b@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jan 2022 20:22:20 +0200
Message-ID: <CAHp75Vc=+378EzDsibOaHRHCUoR8jBLO8ZZgf-G1i6N6Jm-AOg@mail.gmail.com>
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

On Mon, Jan 10, 2022 at 6:55 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> On 1/9/22 14:13, Andy Shevchenko wrote:
> > On Fri, Jan 7, 2022 at 7:34 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:

...

> >> -       status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
> >> +       status &= BIT(real_offset);
> >
> > But this is completely different.
>
> What do you mean by this is completely different?
>
> It was broken before, it is fixed now. Indeed, I'm missing
> the Fixes tag, if that's what you meant.

Yeah, I explained myself below. I think you got the idea.

...

> >> +       bitmap_zero(bits, chip->ngpio);
> >> +
> >>          for_each_set_bit(offset, mask, chip->ngpio) {
> >>                  unsigned int real_offset = st->comp_gpio_offsets[offset];
> >>
> >>                  if (val & BIT(real_offset))
> >> -                       *bits |= offset;
> >> +                       *bits |= BIT(offset);
> >
> > So, how was it working before? If it fixes, it should go with the
> > Fixes tag and before patch 2.
> >
> > On top of that, you may try to see if one of bitmap_*() APIs can be
> > suitable here to perform the above in a more optimal way.
> > (At least this conditional can be replaced with __asign_bit() call,
> > but I think refactoring the entire loop may reveal a better approach)
>
> I can replace the if and bitmap_zero with __assign_bit, as you
> suggested. I'm not familiar with bitmap APIs, do you have a suggestion?

For now I'm lacking any new suggestions. If you don't see any better
approaches, let's go with __assign_bit().

-- 
With Best Regards,
Andy Shevchenko
