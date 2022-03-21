Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA14E302A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352273AbiCUSlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352262AbiCUSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:41:43 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC2D9F6F7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:40:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s207so17132650oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dmOvQ46mCjtGBLLol9T8BAHHpl5PuIHQ6rbM4/XPpWY=;
        b=gf93xLWq1SRRwEeFNDc/jQ2J9L5ZY2uDdhJruRdep/V65U1HSr3+SoQa0FvUWsumSR
         2BXG2rd1qFj17Pf1WPzjwRVFnz4sAzaPudShLoN7Qx9LefXdVKWwjbnR5cwa8SbkbjAs
         4xpN2X+ZDC1aHg/apcrFbaHoBnVrICbkXiYDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dmOvQ46mCjtGBLLol9T8BAHHpl5PuIHQ6rbM4/XPpWY=;
        b=ULBSduDWw2T/QhZL2Hr/qvr0uyEqrauO2dRRPAMg/xXhX5j9Qlz3eBUmrhPzTH2r8C
         5jOBU8iZtUUkmjpfalDhcvQaTrPi8UEtK5X5ENP99ZySVHn7iD9iebvAo1zwoo7CM7zS
         y5OvZzwYY3OofRNcvG10m5yoltzi8EVxG+XHBfUfMsTm41ZRPh+4L3cMpk/guFXcWN3f
         u6q4a+LUj/xdWkMXA65YXfPqlHOe27636es3cXMo7u8vD1Nwa5sTduf0cLujN7VuZnbB
         KTtKGh3TCIY4nk3SAM2XGYs4PZO+7sySgol+4e+jG/g9j1B7uxFrmNWkXWTADNaPiP6p
         O1xg==
X-Gm-Message-State: AOAM530oFxDKQkNl17mBWh4sXngT1jjl3uczKZ2OI478F7+UmGuV+R1T
        oL7L1Lv8HeqI+grX8RbXf8fqfOPXTQdcaV5NqD1wx0IeY54=
X-Google-Smtp-Source: ABdhPJzZkterKbexQXTlKdtePkB2cipBfqvcKciOA7QEie/qzOh4Ze0Be7/L1/ZxwmkJarGxb9yskMPb/4PEzChpUoM=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr255999oif.63.1647888016943; Mon, 21 Mar
 2022 11:40:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 19:40:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAE-0n534-bDXrGUPMxs9qb0F26mO7XyegSt+c4GXKR7ywegcqw@mail.gmail.com>
References: <20220318015451.2869388-1-swboyd@chromium.org> <20220318015451.2869388-4-swboyd@chromium.org>
 <CAD=FV=VJFoNgfMUHE5mUY6Uq2Jj5cyQVyW0osUm6jyHRE1no=w@mail.gmail.com>
 <CAE-0n50HcLLUUDgiMc7u4Gx5gb-bcpO22iD9emHrnM8sx8nbOQ@mail.gmail.com>
 <CAD=FV=V9U-zzpYNLKxqg1xh+W-RXLzV6BxaO4ZVF0GVXBVujUQ@mail.gmail.com> <CAE-0n534-bDXrGUPMxs9qb0F26mO7XyegSt+c4GXKR7ywegcqw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 19:40:16 +0100
Message-ID: <CAE-0n501URga+ya37zmWjpZLxMO16CfoLeL2-Ui4qZa1PGK3CQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/chrome: cros_ec_spi: Boot fingerprint
 processor during probe
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-03-18 16:36:32)
> Quoting Doug Anderson (2022-03-18 15:06:59)
> > On Fri, Mar 18, 2022 at 3:01 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > I'd rather not expose regulator control to userspace through some other
> > > sysfs attribute. Instead I'd prefer the flashing logic that twiddles
> > > gpios and power live all in the kernel and have userspace interact with
> > > a character device to program the firmware.
> >
> > Yeah, that would be even better, you're right.
> >
> > Hmmm, so maybe the answer is to just delay adding the regulator until
> > we're actually ready to specify it correctly and have the flashing
> > happen in the kernel?
> >
>
> I can enable it during probe just so that if the BIOS isn't doing it
> we'll have something that works assuming the DT is actually controlling
> the regulator. Or do nothing. It doesn't matter right now.

Thinking about it more there's no point in controlling the supply here
until we support flashing logic in the kernel. Without flashing support
in the kernel and without the BIOS turning on the power we can simply
make the regulator always-on and boot-on with real gpio control and then
it will be turned on during boot, emulating what the BIOS is doing. The
power cycling after flashing the firmware doesn't seem to be necessary
from my testing. And even then, the flashing script could unbind that
regulator driver if it really needed to control the power.
