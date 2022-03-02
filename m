Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF994C9ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiCBCER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiCBCEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:04:15 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525932061
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:03:33 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 12so472408oix.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 18:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVhWLewea9Kbp4+jmYh/qLY6kiLHJdrGhuGIPKoejkU=;
        b=j8ELH0UmrgvS6wz6hFWYrb/ptIXj4OGBI3/IaaFFymBS4/SwuKvJkbVHGxtUrDuqNl
         hsRVUnkrI/hS3ZjBNA/xRs6w4ipPsKjosZOLqYfRttj+FFWg6iZAoKACkvXpm4wlE9Nn
         D5bUXfQGOrXXat87sRQg//iOucEnAnZ+EYa0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVhWLewea9Kbp4+jmYh/qLY6kiLHJdrGhuGIPKoejkU=;
        b=bX0wQyUIpOpx5KyZLfCy7p7lPv/7RltgX4OjC++5IwIrQ5hb2Ta6crFA8ujbBit2JY
         ClcsnYl0dhhqc1GBzSr1/GK/UOB6VUvgGtNnJ7EV30eAYPKpST3eRnninEy00zzRxEQg
         uZdXB/0kX/u7G+/0xxL7L3bU/xiOMThNnVhwzGZG//8+TK2SiOD+bp2SVAriTOW5Cg6+
         Pc4131njFH8m+pDH4Kj6FnJZpphAGHA10YnLlurIwmx0RtN9y2LESCOdegoMWgNxh/kt
         nyrughzifC1sINCWevYL4hDmrbJ6Kvi3uHdfumB1MM4RKs+jllvnfgG9yGdfGGjH0zqY
         Y2lQ==
X-Gm-Message-State: AOAM533QxG7RJQbJdU2VirVlHGyBd/CdXrfEuHx5uMgX3hPI3vW35CHC
        RnL1agOoolG/WVJOU7GAnc1HcD21FhXHDg==
X-Google-Smtp-Source: ABdhPJyR/3aZMin/8me4PfLuoSgNPXdManAbQGr2bVT9bRPaGsuCkQxkTDADAmYJQUGZlA6xpiIndA==
X-Received: by 2002:a05:6808:9b8:b0:2d4:cc01:6cad with SMTP id e24-20020a05680809b800b002d4cc016cadmr17106963oig.35.1646186612814;
        Tue, 01 Mar 2022 18:03:32 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id bj27-20020a056808199b00b002d49b02cb41sm8891565oib.22.2022.03.01.18.03.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 18:03:31 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id q5so497051oij.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 18:03:29 -0800 (PST)
X-Received: by 2002:a05:6808:18a3:b0:2d5:7ce7:d456 with SMTP id
 bi35-20020a05680818a300b002d57ce7d456mr17402856oib.77.1646186609133; Tue, 01
 Mar 2022 18:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20220217144136.v3.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
 <20220217144136.v3.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid> <CAD=FV=UudBo7aZqD8oGHAu94LEYovMtFq7hjwOG2_8yxUeNi_w@mail.gmail.com>
In-Reply-To: <CAD=FV=UudBo7aZqD8oGHAu94LEYovMtFq7hjwOG2_8yxUeNi_w@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 1 Mar 2022 18:03:18 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPGpJystb0uFNT8f+FSzERC0-YxVfGLRo-U1uoTRMHY6Q@mail.gmail.com>
Message-ID: <CA+ASDXPGpJystb0uFNT8f+FSzERC0-YxVfGLRo-U1uoTRMHY6Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: analogix_dp: Enable autosuspend
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sean Paul <sean@poorly.run>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 2:10 PM Doug Anderson <dianders@chromium.org> wrote:
> On Thu, Feb 17, 2022 at 2:42 PM Brian Norris <briannorris@chromium.org> wrote:
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -1121,7 +1121,7 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
> >
> >                 pm_runtime_get_sync(dp->dev);
> >                 edid = drm_get_edid(connector, &dp->aux.ddc);
> > -               pm_runtime_put(dp->dev);
> > +               pm_runtime_put_autosuspend(dp->dev);
>
> So I think you can fully get rid of these ones now and rely on the
> ones in the aux transfer, right?

Yep, good catch.

> >                 if (edid) {
> >                         drm_connector_update_edid_property(&dp->connector,
> >                                                            edid);
> > @@ -1642,7 +1642,7 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
> >
> >         ret = analogix_dp_transfer(dp, msg);
> >  out:
> > -       pm_runtime_put(dp->dev);
> > +       pm_runtime_put_autosuspend(dp->dev);
> >
> >         return ret;
> >  }
> > @@ -1775,6 +1775,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
> >         if (ret)
> >                 return ret;
> >
> > +       pm_runtime_use_autosuspend(dp->dev);
> > +       pm_runtime_set_autosuspend_delay(dp->dev, 100);
>
> It's explicitly listed in the Documentation that you need the
> corresponding pm_runtime_dont_use_autosuspend(). Specifically, it
> says:
>
> > Drivers in ->remove() callback should undo the runtime PM changes done
> > in ->probe(). Usually this means calling pm_runtime_disable(),
> > pm_runtime_dont_use_autosuspend() etc.
>
> Not that it's very common to see anyone actually get it right, but I
> seem to remember running into an issue when I didn't do it. I think
> ti-sn65dsi86 still has it wrong since I found out about this later.
> Need to write a patch up for that... Basically you want to put it
> right before the two calls in your driver to pm_runtime_disable().

Ack.

Speaking of API misfeatures that we missed: I've failed to call
pm_runtime_mark_last_busy(). I'll add that in the next rev, for the
cases where we weren't already calling *_put_sync() (i.e., presumably
we don't really care to wait around for autosuspend).

*gripe* What a silly API. *gripe*

Brian
