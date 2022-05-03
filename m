Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61087519253
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbiECXdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiECXda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:33:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FB93E0C9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:29:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x17so32779354lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pb2U3zzfrat2Xd0DhY49bpvdy5b4ExUKudiUVsDW2+w=;
        b=j2Ims4VZpVmii4E0axF1CCzezk8fwHYMt/8idecqKu1txaHoaQXg6+B0OvU5mEDEVw
         UG1+OP9QqPtFm9+LbKBcl8eD52RmqUp6vujaPn7DKSBdvTDvilEqdaCTbgyl8xtbp4+T
         xTEZaTKDLWIFhkzwq/5AsD+3oFVfy3EXQilpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pb2U3zzfrat2Xd0DhY49bpvdy5b4ExUKudiUVsDW2+w=;
        b=0WdE1Zcleg7otMaymtC1wZIutzM+NHdcsXaFze72XW73+uBgyoN/o1F6M77QJVEkw/
         htxzqkyFngAhElGW3q1jOBI390DpFIA3duSNnbc0NIqTyoBOnHcKFN+SViNHA8PlkXbv
         D/XU4tlkgOVZVDw0uzMu9aBGYwAF/ioJAfaGD4r18/l50b38VTlZmiKsZ34wFlA3xfFl
         v57PjMywdIl5zDI5eSAK8dk6zVkke6QeBT4KlyvJ4NPhzeKN74VX/IBjOff8sMmbJu9H
         TUouPBT2Kn8SdUireN5eSxC4s9YRuNWAVDJohPB2lAVd94i08UFl67CDyoiYnStXlvnz
         kXtQ==
X-Gm-Message-State: AOAM5321Aw9q3PhjTxwH0t4ocClHMkpeuW6Kl41Qv4OxFFKEUQtox+wK
        L1tyx0n8HR3IQ+piMH09XYQ0VTv/BW3sydCj
X-Google-Smtp-Source: ABdhPJz6hChzJ1Fbcv+s8SnLZiBhttzFHRNEgQjYOmC8IznyDsfWfKGNJ2m8cOA7asB9ngLjjvxCWw==
X-Received: by 2002:ac2:5285:0:b0:472:54b8:f62e with SMTP id q5-20020ac25285000000b0047254b8f62emr12277858lfm.231.1651620594679;
        Tue, 03 May 2022 16:29:54 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id h11-20020ac25d6b000000b0047255d2112bsm1055345lft.90.2022.05.03.16.29.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 16:29:54 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x33so32839675lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 16:29:54 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr14592104wrr.301.1651620248197; Tue, 03
 May 2022 16:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid>
 <a9a5dfb7-819b-d3a2-2c47-d5b239d21ad3@linaro.org> <CAD=FV=WKwErpD7iCu+2jFvMutmmmgLUEhAnw8s=27wUxcpF-aQ@mail.gmail.com>
 <CAA8EJppOVqaAEVeQY7p0EfCObJxfL591kbaYLYfbgOHHtmfhXw@mail.gmail.com>
 <CAD=FV=UmXzPyVOa-Y0gpY0qcukqW3ge5DBPx6ak88ydEqTsBiQ@mail.gmail.com>
 <ddb8d8fa-89dc-268b-0505-9ee7df8c272e@linaro.org> <CAD=FV=Ur3afHhsXe7a3baWEnD=MFKFeKRbhFU+bt3P67G0MVzQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Ur3afHhsXe7a3baWEnD=MFKFeKRbhFU+bt3P67G0MVzQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 16:23:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSXUB_yQWtCVQuHvnAWvPJDaiCTyc5o5cR3fH78nJ3hA@mail.gmail.com>
Message-ID: <CAD=FV=WSXUB_yQWtCVQuHvnAWvPJDaiCTyc5o5cR3fH78nJ3hA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 4:10 PM Doug Anderson <dianders@chromium.org> wrote:
>
> > > 5. In general I've been asserting that it should be up to the panel to
> > > power things on and drive all AUX transactions. ...but clearly my
> > > model isn't reality. We certainly do AUX transactions from the DP
> > > driver because the DP driver needs to know things about the connected
> > > device, like the number of lanes it has, the version of eDP it
> > > supports, and the available bit rates to name a few. Those things all
> > > work today by relying on the fact that pre-enable powers the panel on.
> > > It's pretty easy to say that reading the EDID (and I guess AUX
> > > backlight) is the odd one out. So right now I guess my model is:
> > >
> > > 5a) If the panel code wants to access the AUX bus it can do so by
> > > powering itself on and then just doing an AUX transaction and assuming
> > > that the provider of the AUX bus can power itself on as needed.
> > >
> > > 5b) If the DP code wants to access the AUX bus it should make sure
> > > that the next bridge's pre_enable() has been called. It can then
> > > assume that the device is powered on until the next bridge's
> > > post_disable() has been called.
> > >
> > > So I guess tl;dr: I'm not really a huge fan of the DP driver powering
> > > the panel on by doing a pm_runtime_get() on it. I'd prefer to keep
> > > with the interface that we have to pre_enable() the panel to turn it
> > > on.
> >
> > Again, thank for the explanation. Your concerns make more sense now.
> > As much as I hate writing docs, maybe we should put at least basic notes
> > (regarding panel requirements) somewhere to the DP/DP AUX documentation?
>
> Sure. I actually don't mind writing docs, but my problem is trying to
> figure out where the heck to put them where someone would actually
> notice them. I could throw a blurb in the kernel doc for `struct
> drm_dp_aux` I guess? How about a deal: if you can tell me where to put
> the above facts (essentially 5a and 5b) then I'm happy to post a patch
> adding them.
>
> Huh, actually, maybe the right place is in the "transfer" function of
> that structure which, as of commit bacbab58f09d ("drm: Mention the
> power state requirement on side-channel operations"), actually has a
> blurb. ...but I don't think the blurb there is totally complete. What
> if I changed it to this:
>
>  * Also note that this callback can be called no matter the
>  * state @dev is in and also no matter what state the panel is
>  * in. It's expected:
>  * - If the @dev providing the AUX bus is currently unpowered then
>  *   it will power itself up for the transfer.
>  * - If the panel is not in a state where it can respond (it's not
>  *   powered or it's in a low power state) then this function will
>  *   fail. Note that if a panel driver is initiating a DP AUX transfer
>  *   it may power itself up however it wants. All other code should
>  *   use the pre_enable() bridge chain (which eventually calls the
>  *   panel prepare function) to power the panel.

I didn't ignore this documentation request. Please take a look here
and see what you think:

https://lore.kernel.org/r/20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid

-Doug
