Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7645179B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387887AbiEBWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387857AbiEBWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:06:36 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B110FFF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:02:20 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-ed8a3962f8so5518746fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=DVGl7FkDnsPKOHoFcMwejH9+UyHbejyve2Ejii4IrCM=;
        b=I/045iRJlecCmWvj4tuUqOFvKpEZtT7cA11HAymgVZw3gEMruV1NZCIRvMymbscBeU
         dEht4NLFVxHkpjemr8/2TfL+kpJYJCZ/mOJFXkrSEyLvNv5ad/bKDKESNL8CtWHitgxT
         dMQp7ewk/SoaMMUwrO7Dk03tZsaGBDSALyKwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=DVGl7FkDnsPKOHoFcMwejH9+UyHbejyve2Ejii4IrCM=;
        b=pN1hA/cKMbBfhWB9s76Bmq8tZ0CYE07lrFQ/B9FowisQW4+NayvKCV3FMD/K+Dglsu
         chbK8YHN4xYvaIJifgVDjB44d431uKP8EqgoFaC/MMa2x6hkfaZQ1b6O4mEOQLgQj8g1
         sbPM3ubPnF24WY+5QkBXA/1ZoRi2t+Uzb7/SpM9ybUxJGqx2ZWMYNhJBxTyZ1v6824gk
         P0j1M7VAQQZP3y6YLIgruKfH9z1Yv8Yyy/BwXuNA/RiBnjNZTmrMRFhaeaK8b5FDFZzj
         qIuFu4SEUbnA4pfwbBY8zHFGHBj32Y7h2XIf/hlmlgVG6Z4YBZvqphGKa07+TrhJflns
         hX5w==
X-Gm-Message-State: AOAM530S8uHUarf2GWRKlfrDs3Lu4ynG7r7XsS8Z0ZGMXkslY0BQd197
        WboPmqAcJpOqaxQql5KiMPHJ69+xXZgzmkTa2UEC2g==
X-Google-Smtp-Source: ABdhPJwTpGO9NuC3l5i+OXoQ4kkKceH1oe/oVVNRdXmv8vDT0lPCWjoekl6+gdZaRBMEUORDvFwfxSO+k5mjMswTPT8=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr525995oal.193.1651528939865; Mon, 02 May
 2022 15:02:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 May 2022 15:02:19 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WAbfe9BC5QPDezz3FSEwHRFdQeZpARJYT4b9V1rNp_nA@mail.gmail.com>
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-3-swboyd@chromium.org>
 <CAD=FV=WAbfe9BC5QPDezz3FSEwHRFdQeZpARJYT4b9V1rNp_nA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 2 May 2022 15:02:19 -0700
Message-ID: <CAE-0n53x77n2ACuMYsFrdGhSkmO_4f8Uocnb+vKhcgoiY4RPQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: cros-ec-keyb - skip keyboard registration
 for switches compatible
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
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

Quoting Doug Anderson (2022-05-02 10:02:54)
> On Fri, Apr 29, 2022 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index eef909e52e23..1bbe2987bf52 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -536,6 +536,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
> >         u32 *physmap;
> >         u32 key_pos;
> >         unsigned int row, col, scancode, n_physmap;
> > +       bool register_keyboard;
> > +
> > +       /* Skip matrix registration if no keyboard */
> > +       register_keyboard = device_get_match_data(dev);
> > +       if (!register_keyboard)
> > +               return 0;
> >
> >         /*
> >          * No rows and columns? There isn't a matrix but maybe there are
>
> As per my comments in patch #1, I wonder if it makes sense to delete
> the "No rows and columns?" logic and settle on the compatible as the
> one true way to specify this.
>

Ok. My only concern is that means we have to check for both compatibles
which is not really how DT compatible strings work. The compatible
string usually finds the more specific compatible that is first in the
list of compatibles in DT. You're essentially proposing that the
switches compatible could be first or last, the order doesn't matter.

If that isn't a problem then we can roll in a revert of commit
4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if
rows/columns exist") and leave the rest of this patch alone and it will
implement this logic.
