Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD34FBD51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbiDKNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbiDKNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:40:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861521E15
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:38:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g18so5983382ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJY5oOKjorrHxmexlsMH/Hti9QwhC0oVd/Eyc2mbwG0=;
        b=OmKUnwvfhDqcpiaKjTQbI6Qnu8Sf+6VZ9D9C9+11QRZJ8UM4bw5KC4TRF+VX2MyUlF
         tjcQu6vqOm9Z7CfqQs46eZM9lBwaV/9IXtigcyYK6aTz2mXIUEvaBEQKyVtZFvwOhIdC
         Qg5hbGJLnbUj4QPBxZJqO4hZPQyc+NFdJgUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJY5oOKjorrHxmexlsMH/Hti9QwhC0oVd/Eyc2mbwG0=;
        b=fkWSBBfZach5PWIDH1PRLOdBf4P381GGKW43UazBi7e+WN2DYWPsiyad3Rt0aeINBp
         0zSVGOcZIyIKG5nuXscu+1nE3oefysinlj5NzYnOcOksMZSgdqyByop5+3OmLTcA2yzE
         S0xhCqGJ835BAAmV6R9kuyhzin7lTb9oWIP71uGAMwixJdsyurkeKlG5U4vlJmtk89Wk
         Z+JKr1uSZMU2pSwyrdmgY8w5X7NR1Nqtg+PbGkTv2RyP/3WmGFIjBFzcigNm/JdBunSj
         BCv0+Iyb34Nvx6IJR28eYM1c92H/mK0SaTIaD85v+e1mcprELMIzOqYq8NWDd9JaZXJE
         zgkw==
X-Gm-Message-State: AOAM531S/uRuiH/XfnG9Q4ejPf+WLCJs+fuP9fEYXlMjgTiytUbEE+8o
        nw8Vqq8tdNCuZFFwrmVsezCBMy2JgtAJhg==
X-Google-Smtp-Source: ABdhPJwxvnCnArbIARaV3PGor22jHvyjSaiIwSmQgqdrbOQY1B1vcrlQlpoNrrkJNYPcmYjt8ZpkWQ==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr29099045ejx.396.1649684288662;
        Mon, 11 Apr 2022 06:38:08 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm12037526ejb.148.2022.04.11.06.38.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:38:07 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso3463938wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:38:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3ca4:b0:38e:54d0:406d with SMTP id
 bg36-20020a05600c3ca400b0038e54d0406dmr28939846wmb.199.1649684286640; Mon, 11
 Apr 2022 06:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid> <87o818hvcn.fsf@intel.com>
In-Reply-To: <87o818hvcn.fsf@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Apr 2022 06:37:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzp7wm3gs0pROw_e_-61tphTeXD_6wEP1AOs=Kfdgh7A@mail.gmail.com>
Message-ID: <CAD=FV=Uzp7wm3gs0pROw_e_-61tphTeXD_6wEP1AOs=Kfdgh7A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] drm/dp: Helpers to make it easier for drivers to
 use DP AUX bus properly
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
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

On Mon, Apr 11, 2022 at 1:34 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Fri, 08 Apr 2022, Douglas Anderson <dianders@chromium.org> wrote:
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
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> What is an "EP" client or device?

The DP AUX EndPoint (or DP AUX EP) is just the generic name I called
the thing on the other side of the DP AUX bus, AKA the "panel".

The "DP AUX EP client" (ep_client) is the code that needs a reference
to the panel.

I'll beef up the patch description and the comments around the
structure to try to make this clearer.

-Doug
