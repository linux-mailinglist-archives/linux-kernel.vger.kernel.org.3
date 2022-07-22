Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC157E4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiGVQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:48:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36993C2D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:48:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf4so9567124ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fisLtN+BT8yvjNjBHC8GEVzMGlmsArMjpv7WMGpL1uk=;
        b=hGsxQRAaQ1NlnX6V2KJC5urP5Fisa69TIHv/c7JEryUv+CY0+Rbb4BMqZEfVB+u2nS
         IyUkAm5nmu3nGwemICYDJOBjhpJH/OR3iXElWoEVTyoWXZrfGtsZXmbYJiZ+TwDLDeTU
         +9DLqHj3bSOuUMesZoZg8cWXUSEWtmt+B6YWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fisLtN+BT8yvjNjBHC8GEVzMGlmsArMjpv7WMGpL1uk=;
        b=yfdgv6BtpWAmiLNUrDRiiUfdjbd6AF2mYBu/CyoGoOd5Q+d2/ahSXj14abfIbAE1r/
         mYTuTDhLg4hW82NPSSTCOixQNslk6agcePd8c0/0KnoyGpL/Qs8OAgbNeVI3d501X9NK
         dERDWes1uHGCrviFnzBqyevSyOqnyfz1l7kyNPN4YLzANmkJm9po4pWUBB2t6uJjpji3
         sk/CANtT3P+Hei9IOgCO60/VA4Bg9pFkaJTOLEuilMNP4iv1dgCorBsQhhqTpO3mPY08
         kXF1+MGqVaIsqlg1h991Xe3R5AT+9sxAb7DRJkX4z1+zpaKRmF2VybhChgsMJe5XT0Cn
         Hp+w==
X-Gm-Message-State: AJIora9SuaREzfrKxwtMzjdC9Ek4kCqSX23WIb8wyMMguJN5NJXCpwGn
        IgHQyMdsorqBlkIf2YcJAvNTuv48VkU1hwmd
X-Google-Smtp-Source: AGRyM1vPE3ej7inhhMFRCn+FO0X2/mHVmompoQ4yudJF7Ad0ipdZJUCww3YOEILRyoeFAFt6ayJGJA==
X-Received: by 2002:a17:906:84f0:b0:72b:72b6:c7b2 with SMTP id zp16-20020a17090684f000b0072b72b6c7b2mr600817ejb.642.1658508505551;
        Fri, 22 Jul 2022 09:48:25 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm2212782ejb.147.2022.07.22.09.48.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 09:48:22 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h8so7282161wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:48:21 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr508625wrr.583.1658508501016; Fri, 22
 Jul 2022 09:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220721152314.RFC.1.Ie333b3e4aff6e4a5b58c4aa805e030e561be8773@changeid>
 <269f2610-425b-f296-dcfc-89bdc2e1d587@quicinc.com>
In-Reply-To: <269f2610-425b-f296-dcfc-89bdc2e1d587@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 09:48:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSVXasU5PMR2kL0WQjQ458xDePuTGd1m14_v9JO5B6oA@mail.gmail.com>
Message-ID: <CAD=FV=XSVXasU5PMR2kL0WQjQ458xDePuTGd1m14_v9JO5B6oA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/edid: Make 144 Hz not preferred on Sharp LQ140M1JW46
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 22, 2022 at 9:37 AM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> + sankeerth
>
> Hi Doug
>
> On 7/21/2022 3:23 PM, Douglas Anderson wrote:
> > The Sharp LQ140M1JW46 panel is on the Qualcomm sc7280 CRD reference
> > board. This panel supports 144 Hz and 60 Hz. In the EDID, the 144 Hz
> > mode is listed first and thus is marked preferred. The EDID decode I
> > ran says:
> >
> >    First detailed timing includes the native pixel format and preferred
> >    refresh rate.
> >
> >    ...
> >
> >    Detailed Timing Descriptors:
> >      DTD 1:  1920x1080  143.981 Hz  16:9   166.587 kHz  346.500 MHz
> >                   Hfront   48 Hsync  32 Hback  80 Hpol N
> >                   Vfront    3 Vsync   5 Vback  69 Vpol N
> >      DTD 2:  1920x1080   59.990 Hz  16:9    69.409 kHz  144.370 MHz
> >                   Hfront   48 Hsync  32 Hback  80 Hpol N
> >                   Vfront    3 Vsync   5 Vback  69 Vpol N
> >
> > I'm proposing here that the above is actually a bug and that the 60 Hz
> > mode really should be considered preferred by Linux.
> >
> > The argument here is that this is a laptop panel and on a laptop we
> > know power will always be a concern. Presumably even if someone using
> > this panel wanted to use 144 Hz for some use cases they would only do
> > so dynamically and would still want the default to be 60 Hz.
> >
> > Let's change the default to 60 Hz using a standard quirk.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Yes, we were aware that 144Hz was getting picked. We found that while
> debugging the screen corruption issue.
>
> Well, yes power would be less with 60Hz but so will be the performance.

What performance specifically will be less with 60 Hz? In general the
sc7280 CPU is a bit memory-bandwidth constrained and the LCD refresh
from memory is a non-trivial part of that. Reducing to 60 Hz will
relieve some of the memory bandwidth pressure and will actually allow
tasks on the CPU to run _faster_. I guess the downside is that some
animations might be a little less smooth...


> The test teams have been validating with 144Hz so far so we are checking
> internally with the team whether its OKAY to goto 60Hz now since that
> kind of invalidates the testing they have been doing.

You're worried that the panel itself won't work well at 60 Hz, or
something else about the system won't? The whole system in general
needs to work well with 60 Hz displays and I expect them to be much
more common than 144 Hz displays. Quite honestly if switching to 60 Hz
uncovers a problem that would be a huge benefit of landing this patch
because it would mean we'd find it now rather than down the road when
someone hooks up a different panel.

-Doug
