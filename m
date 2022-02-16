Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134344B7C09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbiBPAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:41:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243144AbiBPAlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:41:18 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E03F94C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:41:03 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso697026oon.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6kOuJ3sFRAfxlfcJvGvD0WdwWS/gNKzCWsG8Lno9eY=;
        b=iX4gNuGKYZNG9hM1lAyY7Nf/bZLA5KTwEcEMmT3v/Wkao8xyAeGNUtg1UxOYaO42aC
         XZstBpPHLaxU6YJNIWfSub+ULsZeKmX/L7ae/TPdpY5zEOmW7JYZjAIs56FeEgSA/CLE
         wG0hkTYT7TAeJo1PVmmZFXS/PQWpRu2EtuOzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6kOuJ3sFRAfxlfcJvGvD0WdwWS/gNKzCWsG8Lno9eY=;
        b=onZyw0LI9koZF6f1tik1/RTd672g3ji8wncLLEcV4dsPwvpAeNzVvDdDMSqPJHpeUc
         QqrQvq3+tJKimHJLDLSxtYSJX4iIBbJgtHobRGozMeXtay1hSMqR5NZGNrUFdoLoxlJW
         NCXRIKOJsEuANis52xKCeUfTYvbfkrgRtS72LEKxg259SLLYM7SFXyYnUNxD+Aycqktr
         37nFb45Ee2X38KFn7WXhOF/Yu2Elc0tw6kALvsk+ay7FXMv17v/tvpk3kZoJAe2o6AGt
         TDt3Q6fRl/hL9kLrKNhoejucx+cEM2DvWP1e1rRmzK4uQLUNBYFxwPkbc2rfGjs2u11Z
         QkLg==
X-Gm-Message-State: AOAM533DYQ4rs0K+3E9AmsjGS3P7wZajMK4LypqTrdQb7y+0NXisTZnj
        dIDsXnDe69xsB2/XSPuNCFyveaY8DZxgjg==
X-Google-Smtp-Source: ABdhPJyL8AftNftGr+LuQUdrA+hXxGxr0dlBNVZdTGaHIup4R7JXn4LOAjBIPinmrzYttC2FN+FuhA==
X-Received: by 2002:a4a:301c:0:b0:2dc:dcf1:8a62 with SMTP id q28-20020a4a301c000000b002dcdcf18a62mr133667oof.7.1644972062722;
        Tue, 15 Feb 2022 16:41:02 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id y1sm17225052oad.38.2022.02.15.16.41.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 16:41:02 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id x193so909605oix.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:41:01 -0800 (PST)
X-Received: by 2002:a05:6808:1b29:b0:2ce:6ee7:2cc5 with SMTP id
 bx41-20020a0568081b2900b002ce6ee72cc5mr2715980oib.243.1644972061370; Tue, 15
 Feb 2022 16:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20211001144212.v2.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
 <CAD=FV=XU0bYVZk+-jPWZVoODW79QXOJ=NQy+RH=fYyX+LCZb2Q@mail.gmail.com>
 <CA+ASDXPXKVwcZGYoagJYPm4E7DzaJmEVEv2FANhLH-juJw+r+Q@mail.gmail.com> <CAD=FV=VYe1rLKANQ8eom7g8x1v6_s_OYnX819Ax4m7O3UwDHmg@mail.gmail.com>
In-Reply-To: <CAD=FV=VYe1rLKANQ8eom7g8x1v6_s_OYnX819Ax4m7O3UwDHmg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 15 Feb 2022 16:40:49 -0800
X-Gmail-Original-Message-ID: <CA+ASDXO8c4dK31p=kvBABJQsDUs20qVHM6NxYf1JQDCr2oswAw@mail.gmail.com>
Message-ID: <CA+ASDXO8c4dK31p=kvBABJQsDUs20qVHM6NxYf1JQDCr2oswAw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 3:46 PM Doug Anderson <dianders@chromium.org> wrote:
> On Tue, Feb 15, 2022 at 2:52 PM Brian Norris <briannorris@chromium.org> wrote:
> > It still makes me wonder what the point
> > of the /dev/drm_dp_aux<N> interface is though, because it seems like
> > you're pretty much destined to not have reliable operation through
> > that means.
>
> I can't say I have tons of history for those files. I seem to recall
> maybe someone using them to have userspace tweak the embedded
> backlight on some external DP connected panels? I think we also might
> use it in Chrome OS to update the firmware of panels (dunno if
> internal or external) in some cases too? I suspect that it works OK
> for certain situations but it's really not going to work in all
> cases...

Yes, I believe I'm only submitting patches like this because fwupd
apparently likes to indiscriminately whack at dpaux devices:
https://github.com/fwupd/fwupd/tree/main/plugins/synaptics-mst#kernel-dp-aux-interface

That seems like a bad idea.

(We've already disabled that plugin on these systems, but it seems
wise not to leave the stumbling block here for the next time.)

> I suppose this just further proves the point that this is really not a
> great interface to rely on. It's fine for debugging during hardware
> bringup and I guess in limited situations it might be OK, but it's
> really not something we want userspace tweaking with anyway, right? In
> general I expect it's up to the kernel to be controlling peripherals
> on the DP AUX bus. The kernel should have a backlight driver and
> should do the AUX transfers needed. Having userspace in there mucking
> with things is just a bad idea. I mean, userspace also doesn't know
> when a panel has been power cycled and potentially lost any changes
> that they might have written, right?
>
> I sorta suspect that most of the uses of these files are there because
> there wasn't a kernel driver and someone thought that doing it in
> userspace was the way to go?

*shrug* beats me.

Brian
