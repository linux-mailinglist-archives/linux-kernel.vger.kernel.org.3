Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569344ED831
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiCaLIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiCaLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:08:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CB20596A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:07:06 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id gh15so19426579qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ldzs2F+pKkHk9BDqjLFNwahVpE2pkUr1lDp8VpHB0F0=;
        b=sxpAq4RyE4MDaDjOhTdULxpJkKhIpld+2IKOfgYrFTJsv161z0NLODgT5cziftMAL/
         34sJikLyLgMJ2yVfrv6jUQYyNt1R8809q8HZUt0PUglCQ5qDQzLjSawn6yBAxe6/pTRd
         uqUXXb5CYlJ3NJlKba1MHQgtqCcrII6M2lRngbtk9mgLNm1SDnNf96ZL1tXLAD1uebqL
         7QfsCF93n58zMXrcICooqJODwjL6pdUVwd3sE5oZL1DbL2Ga172uYdNZ/vBQUb4k0Ro8
         pNUM3ttK9nsS14DaqubkSx2aJVrpihNCt5NgjHUXKhbNmXkHCac3P8SzkuDwGmjcD17z
         3Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ldzs2F+pKkHk9BDqjLFNwahVpE2pkUr1lDp8VpHB0F0=;
        b=p8D+KAqhKzcVmc1q5rVgMom/GCWgWBbvXfjUqfUiQ9nRm7gtEzrShmhqq//5Wl33Tw
         di1iu+3aPNFYGEwNehyccpRhhqtyoQm8f28n8PVbc8JNHOKskQsUoM92Y+vFye6Or8iX
         zt5jLMeuNj3vfFo5BauTrRJxLSfEBIoXgPB9qRKUZhHQARuLmpavom1wKkeOoJhw0qVa
         yM10dlO+S8L6QsyiMZamtQWu2xBdCw4eiyNMrr0rNfCg8GlM1WZ9y8vHWkuBsfTQUmGo
         sF4mLFKKdk7lziLCcm6gLpomIROiJxehbreZKbyNEQo8bnwfL2T7p5T3GOw87E6vPwlA
         YCWQ==
X-Gm-Message-State: AOAM531x8GUyPp3QVxaJ/kMALlSsIzTacM+qGqUVmQxTFbli8nAGTVOQ
        hkro0qZwb1sGo6zKpAaUuJJd2SFKR8CBp6DNTvm1pA==
X-Google-Smtp-Source: ABdhPJysJW04r/FtfLF+DfHPjBtKXZZz0wvOwBbCbh0AUcpnQjKZqUj63zSb3lGB5W34YZecDd6lon6RfoauABQcy+c=
X-Received: by 2002:a05:6214:20e4:b0:441:7bed:5ccd with SMTP id
 4-20020a05621420e400b004417bed5ccdmr30970783qvk.119.1648724825924; Thu, 31
 Mar 2022 04:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-5-git-send-email-quic_sbillaka@quicinc.com>
 <CAA8EJprMvik_6xmGt2oZGpDG9FoMtC_ojuw+oTjPLTck4Hu3WA@mail.gmail.com>
 <MW4PR02MB7186669BA1B19FA4F184B558E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
 <d9ac1cee-d4fc-09ae-b2df-82ae2ecd57fb@linaro.org> <MW4PR02MB71864413E9E3624D2F48F046E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB71864413E9E3624D2F48F046E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Mar 2022 14:06:54 +0300
Message-ID: <CAA8EJpooNVxOUa20fACGf3rTVcHBvLKP2=7Eb0x8oxxE7f2iGg@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drm/msm/dp: avoid handling masked interrupts
To:     Sankeerth Billakanti <sbillaka@qti.qualcomm.com>
Cc:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 14:05, Sankeerth Billakanti
<sbillaka@qti.qualcomm.com> wrote:
>
> Hi Dmitry,
>
> > On 31/03/2022 08:53, Sankeerth Billakanti (QUIC) wrote:
> > > Hi Dmitry,
> > >
> > >> On Wed, 30 Mar 2022 at 19:03, Sankeerth Billakanti
> > >> <quic_sbillaka@quicinc.com> wrote:
> > >>>
> > >>> The interrupt register will still reflect the connect and disconnect
> > >>> interrupt status without generating an actual HW interrupt.
> > >>> The controller driver should not handle those masked interrupts.
> > >>>
> > >>> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> > >>> ---
> > >>>   drivers/gpu/drm/msm/dp/dp_catalog.c | 5 +++--
> > >>>   1 file changed, 3 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c
> > >>> b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > >>> index 3c16f95..1809ce2 100644
> > >>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> > >>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > >>> @@ -608,13 +608,14 @@ u32 dp_catalog_hpd_get_intr_status(struct
> > >>> dp_catalog *dp_catalog)  {
> > >>>          struct dp_catalog_private *catalog = container_of(dp_catalog,
> > >>>                                  struct dp_catalog_private, dp_catalog);
> > >>> -       int isr = 0;
> > >>> +       int isr, mask;
> > >>>
> > >>>          isr = dp_read_aux(catalog, REG_DP_DP_HPD_INT_STATUS);
> > >>>          dp_write_aux(catalog, REG_DP_DP_HPD_INT_ACK,
> > >>>                                   (isr & DP_DP_HPD_INT_MASK));
> > >>> +       mask = dp_read_aux(catalog, REG_DP_DP_HPD_INT_MASK);
> > >>>
> > >>> -       return isr;
> > >>> +       return isr & (DP_DP_HPD_STATE_STATUS_MASK | mask);
> > >>
> > >> I suspect that the logic is inverted here. Shouldn't it be:
> > >>
> > >> return isr & DP_DP_HPD_STATE_STATUS_MASK & mask;
> > >>
> > >> ?
> > >>
> > >
> > > The value of DP_DP_HPD_STATE_STATUS_MASK is 0xE0000000 and the
> > value
> > > of the read interrupt mask variable could be is 0xF.
> > >
> > > The mask value is indicated via the register, REG_DP_DP_HPD_INT_MASK,
> > bits 3:0.
> > > The HPD status is indicated via a different read-only register
> > REG_DP_DP_HPD_INT_STATUS, bits 31:29.
> >
> > I see. Maybe the following expression would be better?
> >
> > return isr & (mask & ~DP_DP_HPD_INT_MASK);

Ugh, excuse me please. I meant:

return isr & (mask | ~DP_DP_HPD_INT_MASK);

> >
>
> I believe the confusion occurred because the DP_DP_HPD_STATE_STATUS_CONNECTED and others were defined under the same register definition as REG_DP_DP_HPD_INT_MASK
> I will rearrange the definitions below.
>
> #define REG_DP_DP_HPD_INT_MASK          (0x0000000C)
> #define DP_DP_HPD_PLUG_INT_MASK         (0x00000001)
> #define DP_DP_IRQ_HPD_INT_MASK          (0x00000002)
> #define DP_DP_HPD_REPLUG_INT_MASK       (0x00000004)
> #define DP_DP_HPD_UNPLUG_INT_MASK       (0x00000008)
> #define DP_DP_HPD_INT_MASK              (DP_DP_HPD_PLUG_INT_MASK | \
>                                                 DP_DP_IRQ_HPD_INT_MASK | \
>                                                 DP_DP_HPD_REPLUG_INT_MASK | \
>                                                 DP_DP_HPD_UNPLUG_INT_MASK)
>
> Below are status bits from register REG_DP_DP_HPD_INT_STATUS
>
> #define DP_DP_HPD_STATE_STATUS_CONNECTED        (0x40000000)
> #define DP_DP_HPD_STATE_STATUS_PENDING          (0x20000000)
> #define DP_DP_HPD_STATE_STATUS_DISCONNECTED     (0x00000000)
> #define DP_DP_HPD_STATE_STATUS_MASK             (0xE0000000)
>
> DP_DP_HPD_INT_MASK is 0xF and scope of mask variable is also 0xF (bits 3:0), mask & ~DP_DP_HPD_INT_MASK is 0 always.
>
> For DP, we want to enable all interrupts.
> So the programmed mask value is 0xF. We want to return 0x40000001 for connect and 8 for disconnect
>
> For eDP, we want to disable the connect and disconnect interrupts. So, the mask will be 0x6 (i.e. DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK)
> We want to return 0x40000000 (or 0x20000000 based on hpd line status) and 0 for eDP connect and disconnect respectively.
>
> > >
> > > isr & DP_DP_HPD_STATE_STATUS_MASK & mask, will return 0 always.
> > >
> > >>>   }
> > >>>
> > >>>   int dp_catalog_ctrl_get_interrupt(struct dp_catalog *dp_catalog)
> > >>> --
> > >>> 2.7.4
> > >>>
> > >>
> > >>
> > >> --
> > >> With best wishes
> > >> Dmitry
> > >
> > > Thank you,
> > > Sankeerth
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> Thank you,
> Sankeerth



-- 
With best wishes
Dmitry
