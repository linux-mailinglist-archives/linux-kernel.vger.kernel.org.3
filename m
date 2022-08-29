Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0539C5A5676
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiH2VtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2VtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:49:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04378A6EC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:49:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so11836120edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=queImgxS1otHnjm8zLjKmjWV8pL+QvReDQNcA7QCzFw=;
        b=ftyRU6YyBgapThUUf0clcKhiLDrITpLrd4bDVeOTRjHENdiABDamruN6BTmI9PDIH0
         uf3flFbhyKkvc/w/Ues2oOe0wmNSzhyWcFmS1oUoFHBWa503z0hysdkETpobfQ4ryMHd
         4rOIMewDP9j125rxk/3kLEXWXe7xqQczKPwYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=queImgxS1otHnjm8zLjKmjWV8pL+QvReDQNcA7QCzFw=;
        b=uIZhhJaL83RJwndynnX3LYx8E/JPAY178IeOTMWqWtoSe6wKmLf6JJnsYd/8iL8Lqa
         CHqwxNew7lGT++X0fu+TdWDDoI776Tot0Mr3Xa47bW7NrTaqJctuPiLFpZ5MneiB1X7E
         YbNOXK2vRNQMLpvPvMY5XRAcAZFJeg2ZJUq0TtVkEPCGSuhAHiWLkoVp8GOxjDu85/v7
         Hc0tDAE2IiSD+DSau1qoOWSjLge75adZ6rNxZlAnLhj7ZqoqRVFI4f1AOfdawg0GHoBj
         gyniHri+G2wOW2JgIbgpWHCyVvJ8oO3Gwu//EK3CCexZPTuOq1F8AUNShXdNq/xbqiQd
         3FqQ==
X-Gm-Message-State: ACgBeo3ElDJQDvMynA9Ks6IsiZ2OaH2hHeyHymaYgejcvzS9iTmGzi43
        QTa41Svv3k6bGp7epjy8KbReyuBiff5XaFxK
X-Google-Smtp-Source: AA6agR6TesQ9ie8ZEm9zixExLvMtQhv497TM9za6XoIhf/UeqoEW9qjxAww07Zx2BAtDij1tWcTvFg==
X-Received: by 2002:a05:6402:3203:b0:435:5a48:daa9 with SMTP id g3-20020a056402320300b004355a48daa9mr7946517eda.304.1661809744077;
        Mon, 29 Aug 2022 14:49:04 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906b00c00b0073dd8e5a39fsm4932800ejy.156.2022.08.29.14.49.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 14:49:02 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id d5so4868058wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:49:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id
 f11-20020a05600c4e8b00b003a5f5bf9c5amr8040714wmq.85.1661809740755; Mon, 29
 Aug 2022 14:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
 <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
 <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com>
 <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com> <CAD=FV=Vg5o-OxyQnemB+XfkGundDA-R31QhkmHJv4RmTMcF2gA@mail.gmail.com>
In-Reply-To: <CAD=FV=Vg5o-OxyQnemB+XfkGundDA-R31QhkmHJv4RmTMcF2gA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Aug 2022 14:48:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vqs+wPsOUgVK9VyzqDHewBR6HyQgcddQpe9Sd6OG6Nuw@mail.gmail.com>
Message-ID: <CAD=FV=Vqs+wPsOUgVK9VyzqDHewBR6HyQgcddQpe9Sd6OG6Nuw@mail.gmail.com>
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

On Mon, Aug 22, 2022 at 9:33 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Aug 18, 2022 at 8:03 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 17, 2022 at 8:22 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > On Thu, Aug 18, 2022 at 11:19 AM Rock Chiu
> > > <rock.chiu@paradetech.corp-partner.google.com> wrote:
> > > >
> > > > How does T4/T5  impact the real case? We talked previously the T4/T5
> > > > shouldn't cause user impact.
> > > > Do we have testing data from ODM?
> > > >
> > > Please leave comments below the previous comment's headline.
> > >
> > > I'm confused. The reason I upstreamed this patch is because this is in
> > > your application note and you asked us to help upstream it. Now do you
> > > mean that we don't need T4 and T5?
> >
> > I think Rock is asking what problems the extra delay is causing. In
> > other words: why do we care about keeping these delays short?
> >
> > The answer is that it affects boot speed and also resume speed of
> > devices. Adding these two delays here means that there's an extra 100
> > ms before the user can see something on the screen. That may not seem
> > like a lot, but those kinds of delays add up quickly. At least on
> > Chromebooks, booting quickly is always a big goal.
>
> While I'm not very happy with this change and I don't really
> understand why these delays need to be so long, if folks are really
> certain that we need them and can't make them shorter then I guess we
> can land it. I'll wait a few more days in case anyone wants to chime
> in with their thoughts.

I'll continue to grumble, but I did push it.

55453c0914d9 drm/bridge: ps8640: Add double reset T4 and T5 to power-on sequence

I pushed to "drm-misc-next" and not "drm-misc-fixes". It doesn't feel
massively urgent since apparently we've been without the
"double-reset" for years and having the extra bake time feels like the
better way to lean.

-Doug
