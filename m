Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D306654FDFD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiFQT5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiFQT5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:57:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B856C2B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:57:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g7so7513426eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38x3epfps0lP0e6upJ7edYx14JD5Ks8hIBXWzOvf/Ko=;
        b=jX3i5+5kyx/7CmnKmahw2M0tEq9PN5ECeFW4UZiVGWMPOGQ2Ts0Ld5bb7b0YoFfkQd
         mBvdoAnSiZguf/k1rTA/hXdrJpvQaZAh2C0DIY78/6bcHDV8dwjma0Idf5hoSnFZxRD/
         4CfD/V1nv8zAKwcSwHJhhUU9iLISVunCieNVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38x3epfps0lP0e6upJ7edYx14JD5Ks8hIBXWzOvf/Ko=;
        b=faL0OWllLkZEh9CgvfEaawTSie4+lv+In34hJjuLZ6+jSYKxR7gIacHumHcYh3hivM
         kf45MJVLf489+A8Hz6kCLhcM7LSr3IXZXrFZ9RHokI8OjMaxDoOsCavdRcRhPyHmSUAt
         1nklPTEQ4Xh4Ifhca8d9GQDAbpiFilhEk/IwXXShGQemS4ykxpJVDTdft7q908dvxe9O
         rnilo/gTRO34HkDiah8t48QNbwjyJu7OPLx8mzHDjA/eNMo/5cgrfIvQuabK7sEjEIRZ
         Rkxc3Rm+HMlfy/cWCYMO2Y174mgfQRrD1IMeGXtnC+E5pEzvAbVlOHA/iRiY1bb1fNwt
         1TYA==
X-Gm-Message-State: AJIora91vmj9YE3z/fnA4KfqHGNo8QbP7CAX7OWeDYc9+1blsar44GeL
        W6jM28DRSyAWaWvbcWLI3srBDDVc21wyu4sMmAg=
X-Google-Smtp-Source: AGRyM1u/Ujqf7XTN6yzxnhC29uySh9xHc9a8HUsnPmCilQo0iBuFrpYnar9U0TZ9/Qe7MTexPCKmHg==
X-Received: by 2002:a05:6402:25c3:b0:434:dfbd:913e with SMTP id x3-20020a05640225c300b00434dfbd913emr14504768edb.27.1655495825568;
        Fri, 17 Jun 2022 12:57:05 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id la12-20020a170907780c00b007081282cbd8sm2516474ejc.76.2022.06.17.12.57.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:57:04 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id g4so6963422wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:57:04 -0700 (PDT)
X-Received: by 2002:a05:6000:1685:b0:218:45f0:5be6 with SMTP id
 y5-20020a056000168500b0021845f05be6mr11122445wrd.301.1655495824252; Fri, 17
 Jun 2022 12:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617111021.v6.1.I9e299d3fa6fbf50df6fc7207050bf5c3a7bf4c61@changeid>
 <CAD=FV=Wp=BMwkbXH+_cHyVP3_0Zh-KXO=N8Y7wg3SktEs7FEXQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wp=BMwkbXH+_cHyVP3_0Zh-KXO=N8Y7wg3SktEs7FEXQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jun 2022 12:56:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WA+_mK9vLth6KkoynjvNMSXX6d8_c1v29pbM8ALp7aVQ@mail.gmail.com>
Message-ID: <CAD=FV=WA+_mK9vLth6KkoynjvNMSXX6d8_c1v29pbM8ALp7aVQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] FROMLIST: arm64: dts: qcom: sc7180-trogdor: Split
 out keyboard node and describe detachables
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 12:47 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jun 17, 2022 at 11:12 AM Joseph S. Barrera III
> <joebar@chromium.org> wrote:
> >
> > From: Stephen Boyd <swboyd@chromium.org>
> >
> > Trogdor devices that have a detachable keyboard still have a
> > non-detachable keyboard input device present because we include the
> > cros-ec-keyboard.dtsi snippet in the top-level sc7180-trogdor.dtsi file
> > that every variant board includes. We do this because the
> > keyboard-controller node also provides some buttons like the power
> > button and volume buttons. Unfortunately, this means we register a
> > keyboard input device that doesn't do anything on boards with a
> > detachable keyboard.
> >
> > Change the node's compatible on detachables to the newly introduced
> > "google,cros-ec-keyb-switches" compatible to indicate that there are
> > only switches and no keyboard to register. Similarly, move the keyboard
> > include that defines the keyboard-controller node out of
> > sc7180-trogdor.dtsi to boards that actually have a keyboard so that the
> > matrix properties are not defined on boards with the switches
> > compatible. Future boards can either use the include approach or the
> > node definition approach to describe a keyboard with possible switches
> > or just some switches.
> >
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > (am from https://lore.kernel.org/r/20220518172525.3319993-1-swboyd@chromium.org)
> >
> >      evtest shows no more cros_ec device
> >
> > Cq-Depend: chromium:3609017
> > Tested-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
>
> It's OK to re-post Stephen's patch with your series, but:
>
> 1. The subject shouldn't have FROMLIST. That's just for patches picked
> back to a Chromium OS kernel.
>
> 2. You shouldn't have "(am from...)". Again, just for patches picked
> back to a Chromium OS kernel.
>
> 3. No Cq-Depend. That's something for patches picked back to a
> Chromium OS kernel.
>
> 4. You should remove tags that were added by the Chromium review
> system, like Stephen's "Tested-by" and my "Reviewed-by".
>
>
> Another alternative is to not post Stephen's patch but add a note that
> your patch should be applied atop his, then point to his. AKA:
>
> https://lore.kernel.org/r/20220518172525.3319993-1-swboyd@chromium.org

A further note is that your series ought to be based on this one:

https://patchwork.kernel.org/project/linux-arm-msm/patch/20220602190621.1646679-1-swboyd@chromium.org/

...but when I apply your patch atop that one I get merge conflicts.

-Doug
