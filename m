Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C785030EF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiDOVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353614AbiDOVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:15:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FBDDEBA5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:13:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so17132453ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9/eIOcMzFXFy1UqdC2a9lha39G1K+4P4bzD5ljUCSQ=;
        b=jPU5vA6ZbtcrunKoRNu6bC3vOFR6SeSjDk+VsAVsUKEsIvsHA/5xgsx8E5ayCjXGDF
         J5XGvTMhhe+hbudmYeul0I59PtZnd3nSx5rKQRf4V6GAUbv43ITNf7kY4HhZS4Of8wLj
         tf58+zV5OWz+71wx/OPPt0WNeilQRJX/9GpgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9/eIOcMzFXFy1UqdC2a9lha39G1K+4P4bzD5ljUCSQ=;
        b=0szznEl9CiYHyS97UgYQbnsVEal5DDE1WxUrl6zFBVEsJjfZ7PCyp/RwBF+wAWVGhy
         7rqBPrMr5xkq6Kxu9eQzEuu+detxUcO2BaPUyoYStmQsiujwVirTniz7s4Vzgy23XlPC
         XApJNi85RHrgI/c9ZzoddMW7kTuA1nk58TrU808Myb9sNLX1mVLVMf3my81pl5m9ZWsj
         3RSh0ynlnn+YK+juZRcABz5x3iZ22Xl3kw4q3f1ulatcWKT8tD9bLUwqyibcWWej1uLm
         rrQEW5q42Uv/7Sn7wybxLlmCe7S/RAdrkoWinsBaYxo1o/lY4uLzmsqHPIwkx5t7sVLw
         YIfw==
X-Gm-Message-State: AOAM533blh36VtTyazM0aB3xbmmAerxBFEWDdNtlx2GQQTsRSaxK88iC
        1chvIQyjd1ua5rukwePrqo7iHWTwffXUkw==
X-Google-Smtp-Source: ABdhPJz6uuFiH4amCINm0Y2TQxRRQcrpGiz9Zmg9dsaue1XB6aMs0IWWZV4A6c7ufGfrk25h3ku5kA==
X-Received: by 2002:a17:907:6d20:b0:6e8:bc3c:e11d with SMTP id sa32-20020a1709076d2000b006e8bc3ce11dmr723689ejc.722.1650057207379;
        Fri, 15 Apr 2022 14:13:27 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b00419315cc3e2sm3308866edc.61.2022.04.15.14.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:13:26 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id u3so11897147wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:13:26 -0700 (PDT)
X-Received: by 2002:a5d:47cf:0:b0:207:ac31:c2ce with SMTP id
 o15-20020a5d47cf000000b00207ac31c2cemr599612wrc.422.1650057205965; Fri, 15
 Apr 2022 14:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid> <a9a5dfb7-819b-d3a2-2c47-d5b239d21ad3@linaro.org>
In-Reply-To: <a9a5dfb7-819b-d3a2-2c47-d5b239d21ad3@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Apr 2022 14:13:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKwErpD7iCu+2jFvMutmmmgLUEhAnw8s=27wUxcpF-aQ@mail.gmail.com>
Message-ID: <CAD=FV=WKwErpD7iCu+2jFvMutmmmgLUEhAnw8s=27wUxcpF-aQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] drm/dp: Helpers to make it easier for drivers to
 use DP AUX bus properly
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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

On Thu, Apr 14, 2022 at 5:47 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 09/04/2022 05:36, Douglas Anderson wrote:
> > As talked about in the kerneldoc for "struct dp_aux_ep_client" in this
> > patch and also in the past in commit a1e3667a9835 ("drm/bridge:
> > ti-sn65dsi86: Promote the AUX channel to its own sub-dev"), to use the
> > DP AUX bus properly we really need two "struct device"s. One "struct
> > device" is in charge of providing the DP AUX bus and the other is
> > where we'll try to get a reference to the newly probed endpoint
> > devices.
> >
> > In ti-sn65dsi86 this wasn't too difficult to accomplish. That driver
> > is already broken up into several "struct devices" anyway because it
> > also provides a PWM and some GPIOs. Adding one more wasn't that
> > difficult / ugly.
> >
> > When I tried to do the same solution in parade-ps8640, it felt like I
> > was copying too much boilerplate code. I made the realization that I
> > didn't _really_ need a separate "driver" for each person that wanted
> > to do the same thing. By putting all the "driver" related code in a
> > common place then we could save a bit of hassle. This change
> > effectively adds a new "ep_client" driver that can be used by
> > anyone. The devices instantiated by this driver will just call through
> > to the probe/remove/shutdown calls provided.
> >
> > At the moment, the "ep_client" driver is backed by the Linux auxiliary
> > bus (unfortunate naming--this has nothing to do with DP AUX). I didn't
> > want to expose this to clients, though, so as far as clients are
> > concerned they get a vanilla "struct device".
>
> I have been thinking about your approach for quite some time. I think
> that enforcing a use of auxilliary device is an overkill. What do we
> really need is the the set callbacks in the bus struct or a notifier. We
> have to notify the aux_bus controller side that the client has been
> probed successfully or that the client is going to be removed.

It seems like these new callbacks would be nearly the same as the
probe/remove callbacks in my proposal except:

* They rely on there being exactly 1 AUX device, or we make it a rule
that we wait for all AUX devices to probe (?)

* We need to come up with a system for detecting when everything
probes or is going to be removed, though that's probably not too hard.
I guess the DP AUX bus could just replace the panel's probe function
with its own and essentially "tail patch" it. I guess it could "head
patch" the remove call? ...or is there some better way you were
thinking of knowing when all our children probed?

* The callback on the aux bus controller side would not be able to
DEFER. In other words trying to acquire a reference to the panel can
always be the last thing we do so we know there can be no reasons to
defer after. This should be doable, but at least in the ps8640 case it
will require changing the code a bit. I notice that today it actually
tries to get the panel side _before_ it gets the MIPI side and it
potentially can return -EPROBE_DEFER if it can't find the MIPI side. I
guess I have a niggling feeling that we'll find some reason in the
future that we can't be last, but we can probably ignore that. ;-)

I can switch this all to normal callbacks if that's what everyone
wants, but it doesn't feel significantly cleaner to me and does seem
to have some (small) downsides.


> And this
> approach would make driver's life easier, since e.g. the bus code can
> pm_get the EP device before calling callbacks/notifiers and
> pm_put_autosuspend it afterwards.

Not sure about doing the pm calls on behalf of the EP device. What's
the goal there?
