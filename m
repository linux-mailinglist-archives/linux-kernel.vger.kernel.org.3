Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337815B12CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIHDHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHDHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:07:40 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E624F01
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:07:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o13so6441685qvw.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 20:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=rcpxruUrHoTh8TAcW7RF0dC7XrP1KKzIwvpxVFtmYc8=;
        b=LP5+muvY3LOkjTMDOBkuwRkTurqFHZMF00aPjJvJO43PDj2qY2TsEwrgd3PSqdboPK
         7SvNW0T+seH8yHaouBSdrOu8sAXK1J8gCmFT0CYrehfwJV8MErscub5mmgwfPrQPL/Gs
         h9Rp67YVKdNxFrcGES+R+7iXwPJEUkmg9NoFMLJRc+8Ifu+oLxlucDiN0nn04ZOGDaPh
         OsJsjQzpgEFgcUE9pVW0JRIRKOAgQBxn0gA8N5F1TSbtqkhqQ7FsALI6YmOfKjaAB/8v
         LH7sGdyYkRsJBCZMwX7TZlf376Tf/tEFTjVBMaNm4ODiS2UkhlcH5f2OIhApLFjNd6/y
         ui+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rcpxruUrHoTh8TAcW7RF0dC7XrP1KKzIwvpxVFtmYc8=;
        b=bKIfQyUVDhntI5nT/11CFCCm437qptrnF3hjIXCRJNWfT/xRTz7mFfba4JE7atYNXm
         WpCVZ7ivvFQAdZx3vsQVsJONIp/IycluP2twlygBNYW6j0BHcL/BVNirhHMyWXH/7ywu
         LZH22ImghIYukF7PJsauTd33qX48w42Qd8ZXRkVIXL70991NwbpC/5phM3N0+PDleC03
         8H4lOoh8yrdCtp5Jotb0wX0V5LMCILUY+i3i0EayOQNxgAePJYNHz0ZiAhjEDpqB+2/m
         WbXCEzlYbGWNCw8eEIU3aJ6n2wW6mxAQxkSJJzVKCZsWVaC4dYCHj7LBdAE5h0NXopTk
         ckMw==
X-Gm-Message-State: ACgBeo1uFQjw5LOjKzWS8M7Gl51VYhH916DE6ChDEoXuX7o5OjzN3giF
        9P98yixxVtX2SXMe1t9VxTckQMyJvDHpHTDNfl9FVA==
X-Google-Smtp-Source: AA6agR71xH9PaBIKksQ9hg1l2Pxx7zEeMO45Khc823haKoJtzYq5BYHnVEQPuCdEjmw49X8iYyh0wanOUeVVrMMgQ8g=
X-Received: by 2002:a05:6214:b27:b0:4a5:e6df:2007 with SMTP id
 w7-20020a0562140b2700b004a5e6df2007mr5808042qvj.96.1662606454657; Wed, 07 Sep
 2022 20:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
 <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
 <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com>
 <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com>
 <CAD=FV=Vg5o-OxyQnemB+XfkGundDA-R31QhkmHJv4RmTMcF2gA@mail.gmail.com>
 <CAD=FV=Vqs+wPsOUgVK9VyzqDHewBR6HyQgcddQpe9Sd6OG6Nuw@mail.gmail.com> <CAMuczyVbLE0mg9K4NNn=epWE9vVJjFbua=7gDtV+xLGqJ1+Jrw@mail.gmail.com>
In-Reply-To: <CAMuczyVbLE0mg9K4NNn=epWE9vVJjFbua=7gDtV+xLGqJ1+Jrw@mail.gmail.com>
From:   Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Date:   Thu, 8 Sep 2022 11:05:03 +0800
Message-ID: <CAB7BMGzBU1K0LPgKozUYaawD7VJ=MvvxXMSHVzrmAV+qsuKD8A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip is functional ready 200ms after the chip reset. The 200ms is
mainly for loading firmware from spi rom.

-Jason


On Thu, Sep 8, 2022 at 8:32 AM Rock Chiu
<rock.chiu@paradetech.corp-partner.google.com> wrote:
>
> + Jason.
>
> -Rock
>
> Doug Anderson <dianders@chromium.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Hi,
> >
> > On Mon, Aug 22, 2022 at 9:33 AM Doug Anderson <dianders@chromium.org> w=
rote:
> > >
> > > Hi,
> > >
> > > On Thu, Aug 18, 2022 at 8:03 AM Doug Anderson <dianders@chromium.org>=
 wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Aug 17, 2022 at 8:22 PM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
> > > > >
> > > > > On Thu, Aug 18, 2022 at 11:19 AM Rock Chiu
> > > > > <rock.chiu@paradetech.corp-partner.google.com> wrote:
> > > > > >
> > > > > > How does T4/T5  impact the real case? We talked previously the =
T4/T5
> > > > > > shouldn't cause user impact.
> > > > > > Do we have testing data from ODM?
> > > > > >
> > > > > Please leave comments below the previous comment's headline.
> > > > >
> > > > > I'm confused. The reason I upstreamed this patch is because this =
is in
> > > > > your application note and you asked us to help upstream it. Now d=
o you
> > > > > mean that we don't need T4 and T5?
> > > >
> > > > I think Rock is asking what problems the extra delay is causing. In
> > > > other words: why do we care about keeping these delays short?
> > > >
> > > > The answer is that it affects boot speed and also resume speed of
> > > > devices. Adding these two delays here means that there's an extra 1=
00
> > > > ms before the user can see something on the screen. That may not se=
em
> > > > like a lot, but those kinds of delays add up quickly. At least on
> > > > Chromebooks, booting quickly is always a big goal.
> > >
> > > While I'm not very happy with this change and I don't really
> > > understand why these delays need to be so long, if folks are really
> > > certain that we need them and can't make them shorter then I guess we
> > > can land it. I'll wait a few more days in case anyone wants to chime
> > > in with their thoughts.
> >
> > I'll continue to grumble, but I did push it.
> >
> > 55453c0914d9 drm/bridge: ps8640: Add double reset T4 and T5 to power-on=
 sequence
> >
> > I pushed to "drm-misc-next" and not "drm-misc-fixes". It doesn't feel
> > massively urgent since apparently we've been without the
> > "double-reset" for years and having the extra bake time feels like the
> > better way to lean.
> >
> > -Doug
