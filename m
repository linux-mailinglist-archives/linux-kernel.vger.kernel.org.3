Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56599597C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbiHRDW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiHRDWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:22:52 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29C2A9250
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:22:50 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-333a4a5d495so8489817b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=s7mvImdTnwfruiP5+oJRaDpwmZoS0KHLcuR5YtEeEsM=;
        b=oPd61McycJXFEWsy0Q32Of8LSDl1hBJagHFeA/ydpr1gT387O7WCMN+uTShodRE34J
         kuvG/7HvjVjc2HsFHZ3zOGEt2qHg2l5IKeXRzixqS8VlBBSBcO6c/U1VAQo8h8GGJbLj
         tDWyb1Qw5oqy8DqMdB1IkVDlKqqbOAGpWdimg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=s7mvImdTnwfruiP5+oJRaDpwmZoS0KHLcuR5YtEeEsM=;
        b=zpDHt8bidaKC09N5cdjdY9h12+cYkfQkX22CF4eHidEiACjNPY3FlJohsQJfy/H0y8
         deRpIvYUaI9PsSrqnw4ZUlr4+S5UQdGmQ7gbX3xfMJ5JdcnP7+EyfwMFe/wz6Eac5+4i
         tq0q8ynGKGHsh9kKLNsYU2l0O8agCW24BcGjL/7zIInXCSj5mf+1B4PfopLOWSeXD7Kw
         U9h2jPPsBtn+f/G6uk3vDEjQlp+6PgFJViFzuo4ObwCdwtrUuX93MnmkCUubk+79Fy9E
         MH7RfcPe0/xN01gr00IRb9T/3ABL1Qszb2FBRhQCFgMgIBy2RZynVF+vZJXiLsCd56zt
         MLWA==
X-Gm-Message-State: ACgBeo2zRVlBFglDVLYFZas+8qdhJ12G7YM4uqqZiySAmgDOtXDMvV6v
        zx6pMLKsNVJ4ajhD8zNjxHlItTAJv0ttSAbWndW0KQ==
X-Google-Smtp-Source: AA6agR6onGFW/5xXkIYebD3W42xb40G2Vz1jh4mOkiO+Iqqd12Lic/TsE2OKXEjgCOtYH1qyy4ZFZfdqBrzjbIyCJCk=
X-Received: by 2002:a05:6902:90a:b0:683:84f4:245d with SMTP id
 bu10-20020a056902090a00b0068384f4245dmr1074097ybb.584.1660792969806; Wed, 17
 Aug 2022 20:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com> <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
In-Reply-To: <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 18 Aug 2022 11:22:23 +0800
Message-ID: <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:19 AM Rock Chiu
<rock.chiu@paradetech.corp-partner.google.com> wrote:
>
> How does T4/T5  impact the real case? We talked previously the T4/T5
> shouldn't cause user impact.
> Do we have testing data from ODM?
>
Please leave comments below the previous comment's headline.

I'm confused. The reason I upstreamed this patch is because this is in
your application note and you asked us to help upstream it. Now do you
mean that we don't need T4 and T5?

> Rock Chiu
>
> Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Thu, Aug 18, 2022 at 6:54 AM Doug Anderson <dianders@chromium.org> w=
rote:
> > >
> > > Hi,
> > >
> > > On Mon, Aug 15, 2022 at 2:39 AM Hsin-Yi Wang <hsinyi@chromium.org> wr=
ote:
> > > >
> > > > The double reset power-on sequence is a workaround for the hardware
> > > > flaw in some chip that SPI Clock output glitch and cause internal M=
PU
> > > > unable to read firmware correctly. The sequence is suggested in ps8=
640
> > > > application note.
> > > >
> > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > ---
> > > >  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/d=
rm/bridge/parade-ps8640.c
> > > > index 49107a6cdac18..d7483c13c569b 100644
> > > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > @@ -375,6 +375,11 @@ static int __maybe_unused ps8640_resume(struct=
 device *dev)
> > > >         gpiod_set_value(ps_bridge->gpio_reset, 1);
> > > >         usleep_range(2000, 2500);
> > > >         gpiod_set_value(ps_bridge->gpio_reset, 0);
> > > > +       /* Double reset for T4 and T5 */
> > > > +       msleep(50);
> > > > +       gpiod_set_value(ps_bridge->gpio_reset, 1);
> > > > +       msleep(50);
> > > > +       gpiod_set_value(ps_bridge->gpio_reset, 0);
> > >
> > > We really need another 100 ms here? ps8640 is already quite slow at
> > > powering itself up and that has a real user impact. Why was it only
> > > 2.5 ms for the first reset and 50 ms for the second?
> > >
> >
> > The T4 and T5 are required by Parade. I'm wondering if they can
> > shorten the 200ms below:
> >
> > /*
> > * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
> > * this is truly necessary since the MCU will already signal that
> > * things are "good to go" by signaling HPD on "gpio 9". See
> > * _ps8640_wait_hpd_asserted(). For now we'll keep this mystery delay
> > * just in case.
> > */
> > msleep(200);
> >
> > Does this have to wait 200ms? Can it shorten to 100 due to the
> > additional 100ms from T4 and T5?
> >
> > > -Doug
