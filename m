Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADE5A2756
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbiHZMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiHZMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:03:56 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C66267E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:03:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3321c2a8d4cso30481327b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=nMtNIpyaxV6n6y1j4kQGb3c6ARKMgnzuDhHNiwEVBA4=;
        b=NDXiZwcPZjtmeIncwlMtPlhsL6rDiS/IDxaxVsoPMFZbAprw6sE4IhTH1pd7ZBiU8n
         Lz+K/SwbUm2CzgbeGFBJ4zLa/SMhAKc70eTfAi9+XBUGZ3DIkJUrmn6yMll46vjB0C6v
         vvp14qIMvKqsiLCGAfO4mGTHJqQOk8t9A+Sdg1RFmsPnJKfYd/L20bU5Q3mTb/sWqyeD
         VnY2tjHPxu7AntPtHTerHp2KDD6id6NEpy6yuKLhuiY+GHebX1xP6F5ripEBeRvOPnf0
         a5Zg2dgJPOPSdBlPgKXMZN60iV52WsjLYLX/F7C2pwCxIPfe75Ff2khcY/rmRoTeLgbM
         +Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=nMtNIpyaxV6n6y1j4kQGb3c6ARKMgnzuDhHNiwEVBA4=;
        b=RgkmHf27mRimT1I8xFJSIuM67N8jgtR+VXixPFrP5KlLf1cS3IEIOpvL/3wVjFKmV/
         6feQpHdxmxRHxIMM5toY8YalbWfT+b4EDVej4ktwilizofRwe++QvHM+Z6lmsHRHZ60r
         ry1GQnXvuJdqGEMj4M7WJR3TZAqZXBAVtHjDikEMx2phXUbi1pZLquaP7kQMETcWoEmH
         BGWxAYKbG7tnAmQw4dlrCDk7Z7ksdhD9NBv+3kiylTGhB12vBk5d2wMXNWSXl3maSIp7
         pDW4qU9AjnBPc9uN9oG2cSrn8pcWip3AeRlGInK8KXnRRMSVPzSdgXIV3Wkr3SWG7QLv
         SwnA==
X-Gm-Message-State: ACgBeo2FvT8VC2jzvrjk/r+9IHf4OPg7SYchfezemzB1hGiuHzbzYxMn
        UphqpVJTqyr2fNf+Mec5c85lMs/rYGeqB52wwknizw==
X-Google-Smtp-Source: AA6agR6GAz4sMztYMnrEfA1yl8CfSLqn+NtlwlcSGb20UhZtyE2nH6eK1+0G+qYfDcSJubGiroR8mCp+hNugAhCXgrI=
X-Received: by 2002:a0d:ea90:0:b0:33d:faad:db54 with SMTP id
 t138-20020a0dea90000000b0033dfaaddb54mr2214939ywe.116.1661515434826; Fri, 26
 Aug 2022 05:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
 <23552842.6Emhk5qWAg@diego> <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com> <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
In-Reply-To: <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
From:   Jensen Huang <jensenhuang@friendlyarm.com>
Date:   Fri, 26 Aug 2022 20:03:43 +0800
Message-ID: <CAMpZ1qGya8zr-QJZHY4OqEg0NLo_db6ttnf6Ai2NHdUL1+6qBw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc
 phy on rk3399
To:     Doug Anderson <dianders@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Brian Norris <briannorris@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks!
I understand that this patch does potentially affect boards with
external pull down.
To avoid this, I will move `enable-strobe-pulldown` to
rk3399-nanopi4.dtsi and send patch v2.


BR,
Jensen

On Wed, Aug 24, 2022 at 10:58 PM Doug Anderson <dianders@chromium.org> wrot=
e:
>
> Hi,
>
> On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
> <jensenhuang@friendlyarm.com> wrote:
> >
> > Hi,
> >
> > Sorry for sending an email in HTML format.
> >
> > I realized that only some devices may be affected, so I considered
> > modifying rk3399-nanopi4.dtsi only,
> > but other boards without external pull-down should still need this patc=
h.
>
> I guess the other alternative would be to change how the dt property
> works. You could say:
>
> 1. If `enable-strobe-pulldown` is set then enable the strobe pulldown.
>
> 2. If `enable-strobe-pulldown` is not set then don't touch the pin in
> the kernel.
>
> 3. If someone later needs to explicitly disable the strobe pulldown
> they could add a new property like `disable-strobe-pulldown`.
>
>
> Obviously there are tradeoffs between that and what you've done and
> I'm happy to let others make the call of which they'd prefer.
>
>
> > BR,
> > Jensen
> >
> > On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson <dianders@chromium.org> =
wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.de> =
wrote:
> > > >
> > > > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> > > > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was disa=
bled
> > > > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> > > > >
> > > > > Tested on NanoPC-T4.
> > > > >
> > > > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line=
 in dts")
> > > > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > > >
> > > > ok, so this looks like it restores previous functionality.
> > > >
> > > > I'm just wondering as the "offending" patch is from 2020, why this
> > > > only turns up now. Any ideas?
> > >
> > > Ah, I see. So before the offending patch we used to just leave the
> > > pull state at whatever the default was when the kernel was booted.
> > > After the offending patch we chose a default.
> > >
> > > On kevin I see an external pull down on this line. Enabling both the
> > > internal and external is probably not a huge deal, it'll just affect
> > > the strength of the pull.
> > >
> > > On bob I _think_ the external pull down is also stuffed.
> > >
> > > ...so I guess that would explain why it didn't cause a problem for at
> > > least those two boards?
> > >
> > > -Doug
