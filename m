Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ACF59C436
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiHVQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiHVQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:33:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7B10ED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:33:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n7so4180633ejh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L964RLsTbSL/YL9PBzvH6rCb3tpB0PeNQCbDW7ySaTE=;
        b=SjyUshFDPR1oqOVRkj8XXuuaWCqHmr33hFyVRHUXRZN5I0zh5/gvuKpZwdouMLF7Pk
         Ib1JsTw2UFvz1fSZrlL7Kxf4d71fzDVPQnQj3/hl0GpeMdK7cAqj1pUGZ62ixXve+29W
         IYZ0UEPkSrA3p/C3ElLZgXtPmjvDajKpMr4ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L964RLsTbSL/YL9PBzvH6rCb3tpB0PeNQCbDW7ySaTE=;
        b=a6QFnqIjkAHRv4tYK3xPeTxZVsLQQhIAEBXFjczlaG0Z3qKvA1t8G8wAmdxzN3W54A
         iZ7v+CycSJqFo+eeLGU6q46UeF6ST2eU/z+BSpt9sWVT7j3qHounld7TZtiUBCrD8d4W
         wZ6O/oq2XpkwGq6mNEqPOoL54i/0RiUB7iMvknsUKdCYQJ7oYiESiJKejZTMCtYidgBM
         xaw/tv9UZ4eR99mf9LWkJ3k1ZvPlN56uz6rNERXUcNfjwM1nYi0c5Tg0BeUgD9+lXO/q
         LfqnL1UWd89V7cCMUCU0nE8BQawUtEyktjNGN8J+BV8k2C53V10m/diFnFoDlhMbe3G3
         9oAw==
X-Gm-Message-State: ACgBeo0g2lr09U57864vCjo6k9XBhNPOED/W22Z2A19DFoI7A5os4xhd
        HRS2R2n8AZ+fvQ+vd5iWFh5Y6aLn9Mg+w4gB
X-Google-Smtp-Source: AA6agR7GUPvGOivNYP582Yu2wvC0I1StSFmRDxOEhPsLjwOiNBKR8/qGGDPHfDc49Ohvljd2dwYkew==
X-Received: by 2002:a17:907:3f0c:b0:73d:60fc:6594 with SMTP id hq12-20020a1709073f0c00b0073d60fc6594mr8437425ejc.669.1661185994779;
        Mon, 22 Aug 2022 09:33:14 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906328400b0073ae9ba9ba9sm6478232ejw.9.2022.08.22.09.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:33:13 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id e20so13421391wri.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:33:13 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr11248948wru.405.1661185993008; Mon, 22
 Aug 2022 09:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
 <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
 <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com> <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com>
In-Reply-To: <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Aug 2022 09:33:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vg5o-OxyQnemB+XfkGundDA-R31QhkmHJv4RmTMcF2gA@mail.gmail.com>
Message-ID: <CAD=FV=Vg5o-OxyQnemB+XfkGundDA-R31QhkmHJv4RmTMcF2gA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 18, 2022 at 8:03 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Aug 17, 2022 at 8:22 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Thu, Aug 18, 2022 at 11:19 AM Rock Chiu
> > <rock.chiu@paradetech.corp-partner.google.com> wrote:
> > >
> > > How does T4/T5  impact the real case? We talked previously the T4/T5
> > > shouldn't cause user impact.
> > > Do we have testing data from ODM?
> > >
> > Please leave comments below the previous comment's headline.
> >
> > I'm confused. The reason I upstreamed this patch is because this is in
> > your application note and you asked us to help upstream it. Now do you
> > mean that we don't need T4 and T5?
>
> I think Rock is asking what problems the extra delay is causing. In
> other words: why do we care about keeping these delays short?
>
> The answer is that it affects boot speed and also resume speed of
> devices. Adding these two delays here means that there's an extra 100
> ms before the user can see something on the screen. That may not seem
> like a lot, but those kinds of delays add up quickly. At least on
> Chromebooks, booting quickly is always a big goal.

While I'm not very happy with this change and I don't really
understand why these delays need to be so long, if folks are really
certain that we need them and can't make them shorter then I guess we
can land it. I'll wait a few more days in case anyone wants to chime
in with their thoughts.

-Doug
