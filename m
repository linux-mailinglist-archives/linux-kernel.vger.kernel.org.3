Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94B4E89D5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiC0Ty5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiC0Tyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:54:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E41D0FE;
        Sun, 27 Mar 2022 12:53:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o10so24721784ejd.1;
        Sun, 27 Mar 2022 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42qZRtu1UtNVSI5xiDDh6WeF5hsjjvhvZv4XDkt0Iyk=;
        b=MqGTc3TnybKGlt63n010N1wfyEMbQrxfnZdiTH9QOI5/oF6rzfMUFBtNHcGMKesazi
         ydkLQBrLw7L7IGbfHb4O15EwPkvMdZXiZk3uf1HRqTn0JWz4PcVE74FlmpeYU2oo2h9a
         3dq87Z587SyiNlXsG6dramqiBPSWlpx9vm7l+OcAykMtWfXvbIB0ZOUmT7vBEQ34vLhN
         UykbtbjGwZ1Yy91U0HxkF4hT1+MCsxd5vqCsxm18TvbshiQ8dH7n7Io/V4E/SBhvFj0D
         sC5bdfl0ieOBDD1zNudC0wK2IJf52efdfT/FDYknVrkr9fre93XWSoxzAUIfIDncmrjE
         es0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42qZRtu1UtNVSI5xiDDh6WeF5hsjjvhvZv4XDkt0Iyk=;
        b=umDyWsMOE/SfXZoWM8GSgMYVR3rsjujYrZ4Plq6nYf5h9fDCjf2FA0gJ2Qe5xEncgf
         0qtRMB1w+eOZLmoCV7Hy7RfQgYMDaUZuHy06Meuvajw1ssKtwAjK5RRFozBB1zNqks2I
         MknKjxpTaAd6ipkEvP6RQsDdUV22MoS69OXUhSTo9PJaOYhQ61HDpgbr+pnRpIXVNXxC
         n8pgghJg2ClmQGpHu91CavlNO5RnrL2krXVYoFGpJQUaEN1ux+qeELwO6iaGgpU8nnOz
         nWZmfIuT/fv+epW555QDScJMZ8LxVdJiy+u0rjmC7adRNAR0fbJrjXbIc2t8nCFzk/Z3
         wVGA==
X-Gm-Message-State: AOAM531mkEVnwhxhZgXZ5T+ICMh80iZDPYlp8x+MNZC2d0KujwDa9v5k
        e0Rz0eLhwApRynN3m0tTmRQpEtIQsXpKiZhCvaw=
X-Google-Smtp-Source: ABdhPJyV7GTl3EabNFfV+pDTNcIkDKCB7g176WowEzixsoRDqZRwZEvNsOMFF3wSiPNxEn3+zKfrx0Iin78DcnCSgrA=
X-Received: by 2002:a17:907:9703:b0:6da:6412:508a with SMTP id
 jg3-20020a170907970300b006da6412508amr23775846ejc.77.1648410793887; Sun, 27
 Mar 2022 12:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220310125450.4164164-1-sunsetdzz@gmail.com> <20220320152047.2a04a62e@jic23-huawei>
 <OZ839R.NWJC2LY54LGX@crapouillou.net>
In-Reply-To: <OZ839R.NWJC2LY54LGX@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:52:37 +0300
Message-ID: <CAHp75VdFPfWAbhysdr8gRuJPeGc2O5Vm8W3E6+EQ5kPynVnM-w@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5592r: Fix the missing return value.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Zizhuang Deng <sunsetdzz@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul.cercueil@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:34 AM Paul Cercueil <paul@crapouillou.net> wrote=
:
> Le dim., mars 20 2022 at 15:20:47 +0000, Jonathan Cameron
> <jic23@kernel.org> a =C3=A9crit :
> > On Thu, 10 Mar 2022 20:54:50 +0800
> > Zizhuang Deng <sunsetdzz@gmail.com> wrote:
> >
> >>  The third call to `fwnode_property_read_u32` did not record
> >>  the return value, resulting in `channel_offstate` possibly
> >>  being assigned the wrong value.

> > Definitely rather odd looking and I think your conclusion is correct.
> > +CC Paul for confirmation that this isn't doing something clever..
>
> It's been a while, but I don't think there was anything clever going on
> here - so the patch is fine.

Basically the question here is what value should offstate have when
there is no such property. Currently it's the same value as modes (no
seeing context other than in the patch).

> >>              if (!ret)
> >>                      st->channel_modes[reg] =3D tmp;
> >>
> >>  -           fwnode_property_read_u32(child, "adi,off-state", &tmp);
> >>  +           ret =3D fwnode_property_read_u32(child, "adi,off-state", =
&tmp);
> >>              if (!ret)
> >>                      st->channel_offstate[reg] =3D tmp;


--=20
With Best Regards,
Andy Shevchenko
