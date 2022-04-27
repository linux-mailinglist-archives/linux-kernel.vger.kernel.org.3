Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5C5111D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358493AbiD0HCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbiD0HC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:02:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F7186D7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:59:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y21so846705edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bK82D9oiFTeFkJ58x1A+6byrQ5w9F1pcq60Qto3VPFY=;
        b=IOslx8w+I67QW4Gw7u7XjV1f/VZn5ZL68eRvJSzAEdXGT8F1XSKAvRanc/fz1Kflx1
         cq5yW/+4F8v0d1vxx40u5cIg0EFPoTG2XMQfCIjHI2w/9LUch1+2A8IeGwPF0YAEmycy
         GY3/SNPPnb8v+oa87JIJg/gldtpauXUylQzGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK82D9oiFTeFkJ58x1A+6byrQ5w9F1pcq60Qto3VPFY=;
        b=tm5EmsDFGk854Mf/fNM7zgblhb7bcOv3Uaqw+t+SRwpD5Ovrc5q2rh5Il2H5wrbGNC
         08QuM/6kaGgcamfvSkTxlq6xd7VPocAotK0+NjrVkwEON70QP4hjQRDanJD1oiNKlIKZ
         q3I+06YOapQmh52ExpiDsfQAOX0THh27SgZiR0PaMuq4DSbInVQG12l+bZpFBlp0kwmu
         g++KZDZ+qX86HI0R3s6HIrccxOTyPQ0dWt/cieJeWLhnPIhLmLiY75fy/B/dFsofSkRL
         F7S0PAqcbfpk7xOhTRhm/T4SiBMVyyxwdJyCJAdyKrZcByxTkVh9kBT8uhVKks1MGSIP
         qR7g==
X-Gm-Message-State: AOAM532fn3msJo4FIHecLsk9GGbLl+8K2YK5XLemol3uhu2Zc0unHX1T
        5RayvZw18j8n6hC5dKrn44ktJzWU+fSJbBjUljPkfg==
X-Google-Smtp-Source: ABdhPJwChhqWc3Zlm/e181I9ur5sdpaiHGYSj0JhOgOl+NxLqV5Z3fdK4kERVFHsCEXtsJAipshrpvbeGa8UzKrfOh8=
X-Received: by 2002:a05:6402:11cd:b0:425:ee49:58cb with SMTP id
 j13-20020a05640211cd00b00425ee4958cbmr13163292edw.157.1651042755556; Tue, 26
 Apr 2022 23:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org> <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat>
In-Reply-To: <20220421082358.ivpmtak3ednvddrc@houat>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 27 Apr 2022 12:29:04 +0530
Message-ID: <CAMty3ZCLEMv4cqUcUGUAkLtH8tmh1WO582cDjZWynAifZJy=_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Maxime Ripard <maxime@cerno.tech>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
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

On Thu, Apr 21, 2022 at 1:54 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > + Linus
> > + Marek
> > + Laurent
> > + Robert
> >
> > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > bridge")' attempted to simplify the case of expressing a simple panel
> > > under a DSI controller, by assuming that the first non-graph child node
> > > was a panel or bridge.
> > >
> > > Unfortunately for non-trivial cases the first child node might not be a
> > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > DisplayPort, or an opp-table represented before the panel node.
> > >
> > > In these cases the reverted commit prevents the caller from ever finding
> > > a reference to the panel.
> > >
> > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > panel or bridge")', in favor of using an explicit graph reference to the
> > > panel in the trivial case as well.
> >
> > This eventually breaks many child-based devm_drm_of_get_bridge
> > switched drivers.  Do you have any suggestions on how to proceed to
> > succeed in those use cases as well?
>
> I guess we could create a new helper for those, like
> devm_drm_of_get_bridge_with_panel, or something.

I think using the same existing helper and updating child support is
make sense, as there is a possibility to use the same host for child
and OF-graph bindings.

I can see two possible solutions (as of now)

1. adding "dcs-child-type" bindings for child-based panel or bridge
2. iterate child and skip those nodes other than panel or bridge. or
iterate sub-child to find it has a panel or bridge-like aux-bus (which
is indeed hard as this configuration seems not 'standard' i think )

Any inputs?

Thanks,
Jagan.
