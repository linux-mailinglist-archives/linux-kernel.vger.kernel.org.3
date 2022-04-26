Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF850F375
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbiDZIOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbiDZINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:13:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC85F8E6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:10:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j6so573314ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRArT/+HlPHZEaZpdvLJTxIQv1TzHF3bvOW7nBlL+EY=;
        b=cUYA7IL0HDqyYDejIukEKVYEwZ57pTZSJnfsTQz/JDYrIBAfglh3eIP0BQxwj4H09p
         DjEGG74rfqXBfGHefdt/sCbRGNBuMBSONvAwWKxGR1HxEtG60phAE36XvW7aPK/6mjNJ
         HQ29TjZ0NFl6x/UIzhSLw8CTdscfM4EAVK/RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRArT/+HlPHZEaZpdvLJTxIQv1TzHF3bvOW7nBlL+EY=;
        b=X+yN5MXaIsk33FSyw58ckyATwVZphxNfkrScTHIONLk9drh2OLEXj8fv0eNGQNBeQ6
         4t7yPVMtlpUP7ZcgVD7NpmxkZNnMXsfXwCW2EKKARITedPiNKlVBFz4zsrDe7xpJNqm0
         a4DYHzLNnMTM95z/yKpcU17s6ljVoSSvYqZqesHthRynWVWyWB83RbaSDrWlUrMxm2vl
         pnFhLCzKJP/4CUs9F2QD68Va4tNXPQmJSh6vYnaSNCR2WgAQ2kz6rHnUs+rVt245AU0H
         EElE5iC0L3upRq61FHG/oWsxQ1Qe75uFghGR0i8MCfxAo5Vdj/Gpg8UUt6mN09LmSYdG
         mSrg==
X-Gm-Message-State: AOAM530XcGNaYWtE4N1t/e1FPOZFr5p4Xs+2KJTBwEKv0ZKEkyoTwKxw
        H+s34pOjGYQj3RSnY28v15SgfjdYP3P6Ri/J+MsKBw==
X-Google-Smtp-Source: ABdhPJyev1jUqnm0Te3/JU59WbWhM9U+N2eYGYCS0OM1yz4jtK3nhD8ZwQfaytDXk26eSkZ+kYlLddAfzcv1AqcopCw=
X-Received: by 2002:a17:906:1315:b0:6ef:5903:c5d1 with SMTP id
 w21-20020a170906131500b006ef5903c5d1mr19913139ejb.537.1650960641955; Tue, 26
 Apr 2022 01:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org> <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat> <YmEdAVwZuA7Wo1Ch@aptenodytes> <YmelPCcWCCjALtRU@aptenodytes>
In-Reply-To: <YmelPCcWCCjALtRU@aptenodytes>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 26 Apr 2022 13:40:31 +0530
Message-ID: <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:24 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > Hi Maxime,
> >
> > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > + Linus
> > > > + Marek
> > > > + Laurent
> > > > + Robert
> > > >
> > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > > > <bjorn.andersson@linaro.org> wrote:
> > > > >
> > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > > bridge")' attempted to simplify the case of expressing a simple panel
> > > > > under a DSI controller, by assuming that the first non-graph child node
> > > > > was a panel or bridge.
> > > > >
> > > > > Unfortunately for non-trivial cases the first child node might not be a
> > > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > >
> > > > > In these cases the reverted commit prevents the caller from ever finding
> > > > > a reference to the panel.
> > > > >
> > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > > > panel or bridge")', in favor of using an explicit graph reference to the
> > > > > panel in the trivial case as well.
> > > >
> > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > switched drivers.  Do you have any suggestions on how to proceed to
> > > > succeed in those use cases as well?
> > >
> > > I guess we could create a new helper for those, like
> > > devm_drm_of_get_bridge_with_panel, or something.
> >
> > Oh wow I feel stupid for not thinking about that.
> >
> > Yeah I agree that it seems like the best option.
>
> Should I prepare a patch with such a new helper?
>
> The idea would be to keep drm_of_find_panel_or_bridge only for the of graph
> case and add one for the child node case, maybe:
> drm_of_find_child_panel_or_bridge.
>
> I really don't have a clear idea of which driver would need to be switched
> over though. Could someone (Jagan?) let me know where it would be needed?

sun6i_mipi_dsi, exynos_drm_dsi, mcde_dsi (as of now)

>
> Are there cases where we could both expect of graph and child node?
> (i.e. does the new helper also need to try via of graph?)

One finding so far from my side would be if the check iterates the
child and identify the panel or bridge child irrespective of the
position it has and untouched non-trivial child-like dp, opp-table can
help to use same change what we have it before. Still working on
getting a proper check.

Thanks,
Jagan.
