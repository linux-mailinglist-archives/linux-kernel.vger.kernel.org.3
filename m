Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75161489578
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiAJJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiAJJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:39:47 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4126CC061757;
        Mon, 10 Jan 2022 01:39:47 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id m90so7029482uam.2;
        Mon, 10 Jan 2022 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGrJMU2mwu0fhNFQYYVjFh5GQMFij2+6pzvwpPSmMUg=;
        b=bZyww6cN0axjDXR2tDv6wNDKfXNYWrhvCLxt09BnYp9x2fFM7Z1Wp856Ff4XuEZPwE
         0hL6h81L9nNRXmlcpfHXPYK4/4W5KlNdGw4bmjAyixexEzZYbafhuqrmJfmuUdP+rLV/
         NFvcEoVxtAvFjixht009zeoN/XrBqU7O9g2lr3IqMk9Gg0PMU8dD8dDpXZxfxQPefVAK
         uLDvPsqQJvtcsn0R+QWlPrazd4QgPd6mKt8c8JkyE3KOlvqFNnpIsJAW8fUG26CCFXrJ
         0/+74W7fnX0mr0fKNnJytvuGkDRXbn9yb2NobN+H5wX7Xe/j+z262t864+r62RfTao1O
         g2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGrJMU2mwu0fhNFQYYVjFh5GQMFij2+6pzvwpPSmMUg=;
        b=mDcxfT47ZM072EWJoiyoNfkKf8acEmmYc5runtyhEnMtvrM/fp2LOiiHaohx3WZFr6
         8iI/HAZhJcYYv3ipGoJQEfzvWb3PEljKVp3oxM0HVuyKg3SBrQ2D3gORYl9kC8e8tDRv
         yJ8EiiCm0/yQ9Moq84bZWEE/E+ysoVIs1v4OzzkLUBKFt7Wa7fXA7vaBS4PU/ds1FrCb
         3lo4v0+a3RJntgMD6jZhlSfSNhfrfvbFsQPxA/DBa8GPkT2KQd+spMREXca+y9w9zsJ9
         NqIGAAXy086aQEIgs6Ks6L0r1S+zkbySYMmcw9RpgU1MKW8tcGxN/y8rMo2PN2FmPxfX
         hMrw==
X-Gm-Message-State: AOAM532IW9lRkChAu869YsNkodEidpTXSgCbW8bvJ2VamqZfB8GDZILH
        NK108en48JxBgheaKsKJn8vMFA2vCM635QFBc9M=
X-Google-Smtp-Source: ABdhPJx4+2OwV0Y0Zm3EhlAfuLuJxsdQE/hK2p2Xh7sWMDKPVtYLJq7YsdptYm//WdoGA+x0cCBEiXl+vStV3JOM8hg=
X-Received: by 2002:a05:6102:3ec1:: with SMTP id n1mr3722110vsv.1.1641807581584;
 Mon, 10 Jan 2022 01:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20220110083910.1351020-1-sergio.paracuellos@gmail.com>
 <20220110083910.1351020-4-sergio.paracuellos@gmail.com> <5368e89c391e1329ed2be6496655f1bb50acfd19.camel@pengutronix.de>
In-Reply-To: <5368e89c391e1329ed2be6496655f1bb50acfd19.camel@pengutronix.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 10 Jan 2022 10:39:30 +0100
Message-ID: <CAMhs-H_gjW_6p6yBWf+k2PBym4N+k+rBEXR9S8c13NU-UWD4VQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] clk: ralink: make system controller node a reset provider
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thanks for the review.

On Mon, Jan 10, 2022 at 10:13 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Sergio,
>
> On Mon, 2022-01-10 at 09:39 +0100, Sergio Paracuellos wrote:
> > +static int mt7621_assert_device(struct reset_controller_dev *rcdev,
> > +                             unsigned long id)
> > +{
> > +     struct mt7621_rst *data = to_mt7621_rst(rcdev);
> > +     struct regmap *sysc = data->sysc;
> > +
> > +     if (id == MT7621_RST_SYS)
> > +             return -EINVAL;
>
> Better implement the .of_xlate callback and check there instead.
>
> That way it would fail on reset_control_get() rather than handing out a
> valid reset controller that just doesn't work.

Pretty clear, thanks. Will change this check into '.of_xlate' callback
and remove it from here.

>
> > +
> > +     return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
> > +}
> > +
> > +static int mt7621_deassert_device(struct reset_controller_dev *rcdev,
> > +                               unsigned long id)
> > +{
> > +     struct mt7621_rst *data = to_mt7621_rst(rcdev);
> > +     struct regmap *sysc = data->sysc;
> > +
> > +     if (id == MT7621_RST_SYS)
> > +             return -EINVAL;
>
> Same as above.

Ditto.

>
> > +     return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
> > +}
> > +
> > +static int mt7621_reset_device(struct reset_controller_dev *rcdev,
> > +                            unsigned long id)
> > +{
> > +     int ret;
> > +
> > +     ret = mt7621_assert_device(rcdev, id);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return mt7621_deassert_device(rcdev, id);
> > +}
>
> Is this known to work for all possible users, without delay between
> assert and deassert?

It seems it is. This is based on the original reset implementation for
ralink. See:

https://elixir.bootlin.com/linux/v5.16/source/arch/mips/ralink/reset.c#L55

>
> Are there any users of the reset_control_reset() API at all? This API
> was added for self-clearing reset bits, so if there are no users that
> need to pretend this is a reset pulse at the hardware level (there may
> be), I'd prefer if this was just left out.

I am not following you here. What do you mean?

>
> Apart from this, this looks good to me.

Thanks, I will include of_xlate callback changes and send v7.

>
> regards
> Philipp

Best regards,
    Sergio Paracuellos
