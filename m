Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF203517B85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiECBNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiECBNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:13:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F1B1117
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:10:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so30753563ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Koda+Kmf6rnMD/zj5Q4WlT42MyjML9+QDJTCHNl5ArY=;
        b=lgXpaChoki38r237kEaHScwsef9q+RhL9t3q/EGcsmq1Nle+XST7WCWWkEQI2W7Gh9
         a875yHgmv5a6UmRrnyGQVo4tIqR3NhkEXHqcM2BwsVfgljT+5wsxZkJ4vDidcBmIQASp
         82E10En8ezVJwvZkCDTTdq1Pn4Hq0PqwzS+9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Koda+Kmf6rnMD/zj5Q4WlT42MyjML9+QDJTCHNl5ArY=;
        b=MStjqw73I5YMxxsn4d4yhC+MQ7hj3EYz7dSxQSr7LEveBfQTvvji6W8Kj2fCszTjlZ
         j7PF7WmXVTp1fR2gt4eMbrhCmH4iyB8ywjFZ+VYWn0l8+2OdooXfxI0OsEQ0F2VLOpn+
         oTRc8HMzveX+N692Lzm1NhayEJkoSWrfxSjhe1Gzi9Uvqni06YrRdl9l0BywmnKHgPi6
         HxNZ01cFz8J1FbW8V1DiUVMFeTLli1VEWx4AFrj45AkAjvudZovSAb/6cZPsrhuUKrab
         N/gL4xiqImViKYVUXj4mbcBeuzVQamaWnuxGBMP462xanaJD7/rUemAAXexVTHcBzyxl
         uRPg==
X-Gm-Message-State: AOAM533CvGsx34WPEyqPKnXmLozHco7/PeDevbA/O4lwNmFKSm0SjWTt
        uNxlKmSBBqi/W3NrlULFd8QSzXdY3eAoFWIs
X-Google-Smtp-Source: ABdhPJxSJDO6lHXS2wrqLJTwkYbX5YRBGZfLVRLp9UxrVthLkqdiIJzUkLUYH+jo/IL9HipkB2czWQ==
X-Received: by 2002:a17:907:6e8b:b0:6f4:7147:a6ac with SMTP id sh11-20020a1709076e8b00b006f47147a6acmr3634730ejc.187.1651540198545;
        Mon, 02 May 2022 18:09:58 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id ec43-20020a0564020d6b00b0042617ba6394sm7268893edb.30.2022.05.02.18.09.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 18:09:57 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so481564wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:09:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr1254978wmq.34.1651540197013; Mon, 02 May
 2022 18:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com> <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
In-Reply-To: <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 May 2022 18:09:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4O397gN7+dMF5gQmdtq59S1TTC-GiSiCDenrSzdpFQg@mail.gmail.com>
Message-ID: <CAD=FV=U4O397gN7+dMF5gQmdtq59S1TTC-GiSiCDenrSzdpFQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
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

On Mon, May 2, 2022 at 1:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Dmitry Torokhov (2022-05-02 10:43:06)
> > On Mon, May 2, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > That goes against the recently landed commit 4352e23a7ff2 ("Input:
> > > cros-ec-keyb - only register keyboard if rows/columns exist") but
> > > perhaps we should just _undo_ that that since it landed pretty
> > > recently and say that the truly supported way to specify that you only
> > > have keyboards/switches is with the compatible.
> > >
> > > What do you think?
> >
> > I am sorry, I am still confused on what exactly we are trying to solve
> > here? Having a device with the new device tree somehow run an older
> > kernel and fail? Why exactly do we care about this case?
>
> Yes, we're trying to solve the problem where a new device tree is used
> with an older kernel because it doesn't have the driver patch to only
> create an input device for the matrix when rows/columns properties are
> present. Otherwise applying that devicetree patch to an older kernel
> will break bisection.

I mean, we can also just say that we don't care about breaking
bisections and just say that the solution we already landed is fine.
It would certainly be less work at this point.

>
> > We have
> > implemented the notion that without rows/columns properties we will
> > not be creating input device for the matrix portion, all older devices
> > should have it defined, so the newer driver is compatible with them...
> >
>
> Agreed, that solves half the problem. This new compatible eases
> integration so that devicetrees can say they're compatible with the old
> binding that _requires_ the rows/column properties. By making the driver
> change we loosened that requirement, but the binding should have been
> making the properties required at the start because it fails to bind
> otherwise.
>
> My interpretation of what Doug is saying is that we should maintain that
> requirement that rows/columns exists if the original compatible
> google,cros-ec-keyb is present and use the new compatible to indicate
> that there are switches. Combining the two compatibles means there's
> switches and a matrix keyboard, having only the switches compatible
> means only switches, and having only the keyboard compatible means only
> matrix keyboard.

That's not quite what I was saying. See my response to patch #2.
