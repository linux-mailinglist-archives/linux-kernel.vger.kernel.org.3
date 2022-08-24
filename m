Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF959FDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiHXO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiHXO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:58:08 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044090809
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:58:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o3so9184668ilf.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=yF4Z8Wba5KOhLWJ2hFirrTICWXMXcXiCQAsAVYho6bs=;
        b=SDns1Nk4QoTPheeQ1bpwTTyzwsCPkpnhEUdDJ1mLOtNBX5aaBxoN/Pd1JSweF1nXog
         DJd0OqK+z9SN3tXaoigWDHgRkIkvbEq+bygb3E91A/dOfk49qRSp1wuS3phar/YBrnz8
         3SWwE/rsMfEFGfKz5ysQW9BzcVYkjdOGYHTV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=yF4Z8Wba5KOhLWJ2hFirrTICWXMXcXiCQAsAVYho6bs=;
        b=Rf2Oe92Di9YYOYSzVem68+voVf1DKl3uBHroFpO2zk7TTusSUZ2j2+a/qSnD4pTZ8/
         IpyG98reOFSpOmA2TK1+4I0aHKR8rfICqzEh42XTXa5A4AnhWLjwjDgyzJ6vqw9zTpcj
         kk1ep1eDsw5gY9ydwx8olt3MDif11vXiCzKRQBiML75vIxCTQ5hRxAcfv3dTAKmLhKuZ
         KnSbdbG3yGsvqSkCQLpexmmu73reA9uYFYje8txOrrZuMgLiiaZHIOiAnBd19YsL3CJf
         UaCLxbdyiPxylKxg1PmHuiaJIynALqt5F7keVjViKfU1OqQG/lVlB54BmlbTGfiPrWVK
         Iebw==
X-Gm-Message-State: ACgBeo2N26wmkHGvNsn6/bBZpRapzbcfA/TGR3htJKB8VMw5J/W6wsVq
        ulZl1b9t4yKQqk6wLA2juekjqo+7ZYATTi6+ciI=
X-Google-Smtp-Source: AA6agR5ucGBCO17tx1QbkeqrS2CS9EJSFrq3m3N1IMRK6dvMIWiohARjDG7+jFYqMPCjBIVoTZAwaQ==
X-Received: by 2002:a05:6e02:b27:b0:2df:abc0:8a20 with SMTP id e7-20020a056e020b2700b002dfabc08a20mr2363132ilu.291.1661353079919;
        Wed, 24 Aug 2022 07:57:59 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id g20-20020a02c554000000b00344c3583535sm3913115jaj.94.2022.08.24.07.57.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 07:57:58 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id q3so6056722ilc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:57:58 -0700 (PDT)
X-Received: by 2002:a92:60e:0:b0:2e8:f08b:de04 with SMTP id
 x14-20020a92060e000000b002e8f08bde04mr2131199ilg.177.1661353077650; Wed, 24
 Aug 2022 07:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
 <23552842.6Emhk5qWAg@diego> <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
 <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
In-Reply-To: <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Aug 2022 07:57:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
Message-ID: <CAD=FV=U-=2GpQTb0N1p3Qe2TAb=JhyZJw2V8T-qbLs5TYhW7qA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc
 phy on rk3399
To:     Jensen Huang <jensenhuang@friendlyarm.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 8:11 PM Jensen Huang
<jensenhuang@friendlyarm.com> wrote:
>
> Hi,
>
> Sorry for sending an email in HTML format.
>
> I realized that only some devices may be affected, so I considered
> modifying rk3399-nanopi4.dtsi only,
> but other boards without external pull-down should still need this patch.

I guess the other alternative would be to change how the dt property
works. You could say:

1. If `enable-strobe-pulldown` is set then enable the strobe pulldown.

2. If `enable-strobe-pulldown` is not set then don't touch the pin in
the kernel.

3. If someone later needs to explicitly disable the strobe pulldown
they could add a new property like `disable-strobe-pulldown`.


Obviously there are tradeoffs between that and what you've done and
I'm happy to let others make the call of which they'd prefer.


> BR,
> Jensen
>
> On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson <dianders@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> > > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was disabl=
ed
> > > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> > > >
> > > > Tested on NanoPC-T4.
> > > >
> > > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line i=
n dts")
> > > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > >
> > > ok, so this looks like it restores previous functionality.
> > >
> > > I'm just wondering as the "offending" patch is from 2020, why this
> > > only turns up now. Any ideas?
> >
> > Ah, I see. So before the offending patch we used to just leave the
> > pull state at whatever the default was when the kernel was booted.
> > After the offending patch we chose a default.
> >
> > On kevin I see an external pull down on this line. Enabling both the
> > internal and external is probably not a huge deal, it'll just affect
> > the strength of the pull.
> >
> > On bob I _think_ the external pull down is also stuffed.
> >
> > ...so I guess that would explain why it didn't cause a problem for at
> > least those two boards?
> >
> > -Doug
