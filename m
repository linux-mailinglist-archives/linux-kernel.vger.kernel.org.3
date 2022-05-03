Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D9518801
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiECPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiECPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:13:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D973AA72
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:09:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so20170393edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW58m2+b9sI8zBQxJJNwiRm2NLx6RkDOvMaweiiKwJI=;
        b=kP0sjsAoi+T8Qd0UDI0pKRBJxpP0ihheGFQgxyMYs9AHtJ6sFLwBIzKvl2ZQUnbF61
         9n91OBEICBk2fREjbLlMG0LW3/mcvUaEjToNI49hAKWzZMxSTcWX8bjxpDW+dzkEKpcP
         63+I/QdvJSIPvl8JSQmUqWaKUnY52tyVnfi3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW58m2+b9sI8zBQxJJNwiRm2NLx6RkDOvMaweiiKwJI=;
        b=fDH43mL0/UC24VD278QvOSBSIxLa7BtHHi2l6vXJU28/TB14bOxpJHfSuyHBSyENzP
         aUt1hXGTvtQw4EKsTUXtD9AzkIhq42XLFVFcxfgo5HSIXtAyIJMF2WMMR+7xw8sLHBJg
         DME/qhPGjKd2aDng1WvDSvZOOqHN80GtXGesMtXYYXQUNuDM5GjQ1ABBg8xyPMkfUDOt
         y81FUzapUCYpOegh03TXTy0OWRGGhAXetuchQp4Ikpm9kk/BHAuC0yw0APrFXJ1t4KPx
         jE2kWdDNAwomZnFVvFrZbN1cd96BGtTmmBNmJniMYqrb3YQJyhUx2QbI9GgtvtOlC4Ss
         wb/Q==
X-Gm-Message-State: AOAM533KblPZe71v9IlUtq8TZHfCo4q2Ql9lX2+Fp5oZcjkGCRAA4Vf8
        XAHMwE4usCn22+d2vT0XVoMZ2JzDKPHppYoa
X-Google-Smtp-Source: ABdhPJwd9di+bQYEuIPxDNNGs0VueC4z7LTkycHtRuMt3ccSbloMqW00UydUVEsjikQw4B0qN4dk0g==
X-Received: by 2002:a05:6402:3695:b0:427:b16e:e1b4 with SMTP id ej21-20020a056402369500b00427b16ee1b4mr15354466edb.117.1651590566041;
        Tue, 03 May 2022 08:09:26 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id de38-20020a1709069be600b006f3ef214dbcsm4684395ejc.34.2022.05.03.08.09.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 08:09:24 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1450241wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:09:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e44:b0:394:46b4:7b0e with SMTP id
 e4-20020a05600c4e4400b0039446b47b0emr3671832wmq.29.1651590563205; Tue, 03 May
 2022 08:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220503042242.3597561-1-swboyd@chromium.org> <20220503042242.3597561-3-swboyd@chromium.org>
In-Reply-To: <20220503042242.3597561-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 08:09:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDHwOeQOFevwH9rfd=UN9OcEoOS=HeydYnNAZMUdCaBQ@mail.gmail.com>
Message-ID: <CAD=FV=XDHwOeQOFevwH9rfd=UN9OcEoOS=HeydYnNAZMUdCaBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Input: cros-ec-keyb - skip keyboard registration
 w/o cros-ec-keyb compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 2, 2022 at 9:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> In commit 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if
> rows/columns exist") we skipped registration of the keyboard if the
> row/columns property didn't exist, but that has a slight problem for
> existing DTBs. The DTBs have the rows/columns properties, so removing
> the properties to indicate only switches exist makes this keyboard
> driver fail to probe, resulting in broken power and volume buttons. Ease
> the migration of existing DTBs by skipping keyboard registration if the
> google,cros-ec-keyb-switches compatible exists.
>
> The end result is that new DTBs can either choose to remove the matrix
> keymap properties or leave them in place and add this new compatible
> indicating the matrix keyboard properties should be ignored. Existing
> DTBs will continue to work, but they will keep registering the keyboard
> that does nothing. To fix that problem we can add this extra compatible
> to existing devicetrees and the keyboard will stop being registered.
> Finally, if google,cros-ec-keyb is missing then this driver won't even
> attempt to register the matrix keyboard. Of course, this driver won't
> probe until this patch is applied in that scenario, but that's OK. This
> last case is likely only going to be used by new devicetrees created
> after this commit.
>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> Fixes: 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if rows/columns exist")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index eef909e52e23..04c550aaf897 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -536,14 +536,11 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
>         u32 *physmap;
>         u32 key_pos;
>         unsigned int row, col, scancode, n_physmap;
> +       bool register_keyboard;
>
> -       /*
> -        * No rows and columns? There isn't a matrix but maybe there are
> -        * switches to register in cros_ec_keyb_register_bs() because
> -        * this is a detachable device.
> -        */
> -       if (!device_property_present(dev, "keypad,num-rows") &&
> -           !device_property_present(dev, "keypad,num-cols"))
> +       /* Skip matrix registration if no keyboard */
> +       register_keyboard = device_get_match_data(dev);
> +       if (!register_keyboard)
>                 return 0;

I'm a little on the fence about the local variable. It could have been
shorter as:

/* Skip matrix registration if no keyboard */
if (!device_get_match_data(dev))

...but I guess the "register_keyboard" maybe makes it more a little
more obvious?

In any case, I'm happy either way:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
