Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49FC517B61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiECBMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiECBMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:12:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4837A10
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:09:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so18328838edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GS/UD7rTSn/SrbnLBVwvNdcnYAN1i32IbtuzZWmvMs=;
        b=GjPF8T0LFSfzHmDfzTyaQdTHc7/c7Au3dfdO9t7Jo7HNtVLIYTlK7boOyvbs8TaHWd
         u9Fc4NyJgxlRHYIObzxW3VHsk8uI5SiIRPIDVCqgNVN2nW1uFL7RyBgX5amGCEBX1Dqa
         wMPbnPQOsxEp8F4lvG7gMmlYdyq2+7Bca8HEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GS/UD7rTSn/SrbnLBVwvNdcnYAN1i32IbtuzZWmvMs=;
        b=ItyWNTTUeC9SfAYUIz8xpqLx+JrKZnWK8Gm7sTDb3mdLlHCgI9ftV6MzNK1qy2Hl9u
         9Uv1xajYhJlEl/4KpLepoKhY0O45087PzPU5oeeaTA27+LmGCoQtHbkshncHNdM9TAnc
         R4tgTFqO7AmAky/CtUqJeRNu7JgFlYncMrDzawiChNp6VWnJirWN0n0KuxlDLv20Q6e1
         n0DF7OYnlyyFXVz/Nm3Qq2Et96+zQsh6iUqEJuucsMw1NnX9A+aWt0p7ZlSsdfqMPd/R
         l77cSrHW9Va4KQ7Be+c+xC5PrZK00BSI2RCrqBOYPANuu/JqUEJZI+npoalP9FrW1272
         ofEA==
X-Gm-Message-State: AOAM5325Q6BR4E1D2/SJCv1jwDmMkDkzswlWMkAa3l0JbsbhgFwWMDSz
        d2RPq86Lv8BD6bmPIEQmD5JnKdTFYwJK9QLE
X-Google-Smtp-Source: ABdhPJzje6pl6sHl6BxXgXaNJDOmmqzEylTCuBFzUtNLNh22zeQrZBfP57w28f4Pw+kC0zBCLGdsTw==
X-Received: by 2002:a05:6402:4384:b0:427:b5c0:4bf with SMTP id o4-20020a056402438400b00427b5c004bfmr11072939edc.127.1651540012503;
        Mon, 02 May 2022 18:06:52 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id em20-20020a170907289400b006f3ef214e05sm4087995ejc.107.2022.05.02.18.06.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 18:06:51 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id i5so21456484wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:06:51 -0700 (PDT)
X-Received: by 2002:a5d:6d09:0:b0:20c:53a9:cc30 with SMTP id
 e9-20020a5d6d09000000b0020c53a9cc30mr10094457wrq.513.1651540011049; Mon, 02
 May 2022 18:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-3-swboyd@chromium.org>
 <CAD=FV=WAbfe9BC5QPDezz3FSEwHRFdQeZpARJYT4b9V1rNp_nA@mail.gmail.com> <CAE-0n53x77n2ACuMYsFrdGhSkmO_4f8Uocnb+vKhcgoiY4RPQg@mail.gmail.com>
In-Reply-To: <CAE-0n53x77n2ACuMYsFrdGhSkmO_4f8Uocnb+vKhcgoiY4RPQg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 18:06:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5SeUNAiQi_h8LyUn+7EQG1Sf9N6Nq9HtVnQWqr0Ltsw@mail.gmail.com>
Message-ID: <CAD=FV=W5SeUNAiQi_h8LyUn+7EQG1Sf9N6Nq9HtVnQWqr0Ltsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: cros-ec-keyb - skip keyboard registration
 for switches compatible
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
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

Hi,

On Mon, May 2, 2022 at 3:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2022-05-02 10:02:54)
> > On Fri, Apr 29, 2022 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > > index eef909e52e23..1bbe2987bf52 100644
> > > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > > @@ -536,6 +536,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
> > >         u32 *physmap;
> > >         u32 key_pos;
> > >         unsigned int row, col, scancode, n_physmap;
> > > +       bool register_keyboard;
> > > +
> > > +       /* Skip matrix registration if no keyboard */
> > > +       register_keyboard = device_get_match_data(dev);
> > > +       if (!register_keyboard)
> > > +               return 0;
> > >
> > >         /*
> > >          * No rows and columns? There isn't a matrix but maybe there are
> >
> > As per my comments in patch #1, I wonder if it makes sense to delete
> > the "No rows and columns?" logic and settle on the compatible as the
> > one true way to specify this.
> >
>
> Ok. My only concern is that means we have to check for both compatibles
> which is not really how DT compatible strings work. The compatible
> string usually finds the more specific compatible that is first in the
> list of compatibles in DT. You're essentially proposing that the
> switches compatible could be first or last, the order doesn't matter.

It's not quite what I was proposing. I think my summary really sums it up:

1. If you have a matrix keyboard and maybe also some buttons/switches
then use the compatible: google,cros-ec-keyb

2. If you only have buttons/switches but you want to be compatible
with the old driver in Linux that looked for the compatible
"google,cros-ec-keyb" and required the matrix properties, use the
compatible: "google,cros-ec-keyb-switches", "google,cros-ec-keyb"

3. If you have only buttons/switches and don't need compatibility with
old Linux drivers, use the compatible: "google,cros-ec-keyb-switches"

...but just to say it another way:

* If you have the compatible "google,cros-ec-keyb-switches" I mean to
say that you _only_ have switches and buttons. You'd _never_ have this
compatible string if you truly have a matrix keyboard. If you have
this, it will always be first.

* If you only have switches and buttons but you care about backward
compatibility then you can add a fallback compatible second:
"google,cros-ec-keyb"

* In order for the fallback compatible to be at all useful as a
fallback (it's only useful at all if you're on an old driver), if you
specify it you should pretend that you have matrix properties even
though you don't really have them, just like we used to do.

-Doug
