Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24CE518D5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiECTrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiECTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:47:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883D35DC5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:43:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m23so23286159ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=84DT2KN71CBoOLaIwfBUH1VIJvywBdMYoVKhebNA7Z0=;
        b=e+2jsHN+LGeoxthUIsOCFTpN/YQD1tLtP5DXh+qPTs7i1ROxuVi1Ik9l9Le5Ad3BEw
         ZkY+XGJkfzyXZtHOt4X3XeSMKy0RejAPjrlNsBVyynuEh4IpJav8ULo1pZO0q7fmC7NW
         5PlZapfM2xTIY/rc03QCq+CdtM6iTB0VRcVwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=84DT2KN71CBoOLaIwfBUH1VIJvywBdMYoVKhebNA7Z0=;
        b=pi9xKuTesNfjtspGqIlUQdTGPQ5ETvzc/grkNNR/zUo8x+Mzz2hr1Wo0HFxBIWJLrl
         PjCbXNOkM62PrWNTPtT8q8Betie4wCkhB4C9YkoioP/FZ/HPQBoFxh9+dqIlp93dRfmq
         ruy2lznlze28JLx/qWEdgxrqCkOYk5oVDLewLcw2lXU8RUge8jGOlySQ2hP4D09dA6Dc
         w5EVG2mV+7VL3FVZ7nCyFHKqtV+HZx4paXuYto5Juw61ob5eesNZPpjdJ+df7bHJZO3D
         QQNEzQP8a4ZR88bscMml2TQbOxN2ND3Q9DcL1D6g4PkFbYAI5pBb9JmGcNn2xOLL/wHw
         TmCg==
X-Gm-Message-State: AOAM532ec9tgiBrYF70l9+sjjSieDmBUb9JTyruWqJXaE0+oogOCL4R2
        F92zoIc8GAItKeU7hRlWDeTJdp+jBRwmPiTMHCuRJw==
X-Google-Smtp-Source: ABdhPJwofoBZ0cGQf5xDbeKBgy5o15kRXzCpmBtVOrHD+O0xJDWsEHSnPVpB62ILYjRFVJ/hKSbrJaoKEAfPlO5SpbU=
X-Received: by 2002:a2e:b8c2:0:b0:250:61c6:8398 with SMTP id
 s2-20020a2eb8c2000000b0025061c68398mr4466282ljp.378.1651607012174; Tue, 03
 May 2022 12:43:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 May 2022 12:43:31 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XDHwOeQOFevwH9rfd=UN9OcEoOS=HeydYnNAZMUdCaBQ@mail.gmail.com>
References: <20220503042242.3597561-1-swboyd@chromium.org> <20220503042242.3597561-3-swboyd@chromium.org>
 <CAD=FV=XDHwOeQOFevwH9rfd=UN9OcEoOS=HeydYnNAZMUdCaBQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 3 May 2022 12:43:31 -0700
Message-ID: <CAE-0n52xsyFPKiFufS=+S5QMqYoLN=2MOZHWJ7E9orJyCs3=ig@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Input: cros-ec-keyb - skip keyboard registration
 w/o cros-ec-keyb compatible
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-05-03 08:09:11)
> On Mon, May 2, 2022 at 9:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index eef909e52e23..04c550aaf897 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -536,14 +536,11 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
> >         u32 *physmap;
> >         u32 key_pos;
> >         unsigned int row, col, scancode, n_physmap;
> > +       bool register_keyboard;
> >
> > -       /*
> > -        * No rows and columns? There isn't a matrix but maybe there are
> > -        * switches to register in cros_ec_keyb_register_bs() because
> > -        * this is a detachable device.
> > -        */
> > -       if (!device_property_present(dev, "keypad,num-rows") &&
> > -           !device_property_present(dev, "keypad,num-cols"))
> > +       /* Skip matrix registration if no keyboard */
> > +       register_keyboard = device_get_match_data(dev);
> > +       if (!register_keyboard)
> >                 return 0;
>
> I'm a little on the fence about the local variable. It could have been
> shorter as:
>
> /* Skip matrix registration if no keyboard */
> if (!device_get_match_data(dev))
>
> ...but I guess the "register_keyboard" maybe makes it more a little
> more obvious?

Yes, the idea is to make it more obvious to the point that the comment
isn't needed. I'll change it to 'has_keyboard' and then drop the
comment!

>
> In any case, I'm happy either way:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
