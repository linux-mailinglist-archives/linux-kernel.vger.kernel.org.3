Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEB54F1EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiDDWL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382653AbiDDVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:31:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE515A07
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:15:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id f3so8510207qvz.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McouKnSmKFWKF2SpoB2peGm/9//rXoQgWM99Hh1/NkM=;
        b=M++cEUJlbCPGoHHxmMxvBelMxqgIBsOO1jFQ1hxhkxPZWCi9yjs3IOyz3DUBfIHTby
         hMf7DehfSJgg5MS33J2RzV6Za5Fx8CpIeYOhknWnvbkUyNPUbjCU1EClkx377aee23Ed
         /y2xV0M0VEAKcVJVW4ThuGCUzAzjmK5dWYPIeEid3dAv9np5b1dmU0a7JCY1I2torFM1
         M6nthhJ5f/2xyZRhP6slKdYv7VnlT0ixAW+jcKuz4py1y6qx+s1NzcMzRyRThP0QKRKk
         szde6JHOfXwsnWGShpS3m4bdH2QYtwUy0mKBrdcCSwrjhSMVy+rkK12oEdm0q6uHT0XH
         Y84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McouKnSmKFWKF2SpoB2peGm/9//rXoQgWM99Hh1/NkM=;
        b=zFkCgABqeB2/d6hcF9xUPkkDqGiNvjiCARUc71wCCdfDZC5puuNvGkVuT5kIzC2z5p
         ba3KgwihwB7/wUvNF/8oAKFoP5pN2+N9IuWi5nUtWBgriHcEAm79OmKKQuPn1haN3UHA
         vFvjVg/x4tE+uQpkecPT5xvo12RKwvXL4sE3N6mluNg6LCa3ViXhU/MxnBxpUKnl5cxB
         x68uBqXB77/El+tPE/ayo/aV/tXKCS/symejQJsAltQ81U3wQs4E5W28xs8SDQXgBk+T
         maR9uDbnBAwN59hVeg98CNMxhERUqAvKR5ObOnjhdsdA/dnFzC4fL3EciETtudmRsUdQ
         drFw==
X-Gm-Message-State: AOAM530t/+4RWg353sYWCbsbHwPs8GIDkdbrGuL0LfDG9VthU8/3KG8u
        of6/NfFpEd4+/+F5iyTwn9iDUZzl6Ggy+pcJRg32vQ==
X-Google-Smtp-Source: ABdhPJyqLSrz27bQaT6seA8R1kJrL/P/oL9NsM1rXGrEtJEpPWrptpkqYtU5VF/Yo5B/E+1043jo5A794bfO5ijjnMc=
X-Received: by 2002:ad4:53a4:0:b0:430:1d8c:18ea with SMTP id
 j4-20020ad453a4000000b004301d8c18eamr99107qvv.115.1649106927946; Mon, 04 Apr
 2022 14:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-8-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=V92j=yEoaM4REO6ws=AXpBjM6zWwBtZ8SbPiFd2cu3yw@mail.gmail.com> <MW4PR02MB7186DD14809500D97C3ABDBBE1E59@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB7186DD14809500D97C3ABDBBE1E59@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Apr 2022 00:15:16 +0300
Message-ID: <CAA8EJppB8s=myUG+swLF5vQU+b+mGSjrNsn1-=1cgO9rKXC7Xw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] drm/msm/dp: Support edp/dp without hpd
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
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

On Mon, 4 Apr 2022 at 21:32, Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> Hi Doug,
>
> > On Wed, Mar 30, 2022 at 9:04 AM Sankeerth Billakanti
> > <quic_sbillaka@quicinc.com> wrote:
> > >
> > > Some eDP sinks or platform boards will not support hpd.
> > > This patch adds support for those cases.
> >
> > You could say more, like:
> >
> > If we're not using HPD then _both_ the panel node and the eDP controller
> > node will have "no-hpd". This tells the eDP panel code to hardcode the
> > maximum possible delay for a panel to power up and tells the eDP driver that
> > it should continue to do transfers even if HPD isn't asserted.
> >
>
> Okay. I will add it
>
> >
> > > Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> > > ---
> > >  drivers/gpu/drm/msm/dp/dp_catalog.c | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c
> > > b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > > index 1809ce2..8f1fc71 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > > @@ -244,10 +244,17 @@ void dp_catalog_aux_update_cfg(struct
> > dp_catalog
> > > *dp_catalog)
> > >
> > >  int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog
> > > *dp_catalog)  {
> > > -       u32 state;
> > > +       u32 state, hpd_en;
> > >         struct dp_catalog_private *catalog = container_of(dp_catalog,
> > >                                 struct dp_catalog_private,
> > > dp_catalog);
> > >
> > > +       hpd_en = dp_read_aux(catalog, REG_DP_DP_HPD_CTRL);
> > > +       hpd_en &= DP_DP_HPD_CTRL_HPD_EN;
> > > +
> > > +       /* no-hpd case */
> > > +       if (!hpd_en)
> > > +               return 0;
> > > +
> > >         /* poll for hpd connected status every 2ms and timeout after 500ms */
> > >         return readl_poll_timeout(catalog->io->dp_controller.aux.base +
> > >                                 REG_DP_DP_HPD_INT_STATUS, @@ -586,8
> > > +593,10 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog
> > *dp_catalog)
> > >         reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
> > >         dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
> > >
> > > -       /* Enable HPD */
> > > -       dp_write_aux(catalog, REG_DP_DP_HPD_CTRL,
> > DP_DP_HPD_CTRL_HPD_EN);
> > > +       /* Enable HPD if supported*/
> > > +       if (!of_property_read_bool(catalog->dev->of_node, "no-hpd"))
> >
> > I don't think this is a particularly lightweight operation. It's literally iterating
> > through all of our device tree properties and doing string compares on them.
> > ...but this function is called somewhat often, isn't it? It feels like the kind of
> > thing that should happen at probe time and be stored in a boolean.
> >
> > ...and then you can use that same boolean in
> > dp_catalog_aux_wait_for_hpd_connect_state() rather than reading the
> > register value, right?
> >
> It is called twice for DP. Once while booting through a thread scheduled from kms_obj_init
> and when resuming from PM suspend.
>
> With aux_bus addition, this function will be called thrice for eDP. Once during bootup with
> aux_bus, then from scheduled event from kms_obj_init and pm resume like DP.
>
> I will check if we can use a no-hpd Boolean flag instead.

As the driver has a separate dp_parser code, it might be a good fit to
parse the DT once and then to use boolean flag afterwards.

-- 
With best wishes
Dmitry
