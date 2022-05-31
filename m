Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C053986A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbiEaVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiEaVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:06:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B7B499
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:06:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h11so19164139eda.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2D0n0MD9FVM5CduT1NCFZoyK1Wf+YfR32ZwltpKGpW0=;
        b=ZQT68xf2h4yPB1aO3z6MMCxjgrGQxzK6GsAwKC4AbtmM7jt7hPu9NP/5/38W/CoGs4
         /U426ZyODXRJ/hIK1zizXSQUiCeTA65NiXm2tba9pIlaxq1ArpOmj55sVibamQlHpil1
         HXArJ8lpnCJ5gJjSUw7JSWNWLGFhmor2Mb+W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2D0n0MD9FVM5CduT1NCFZoyK1Wf+YfR32ZwltpKGpW0=;
        b=cWVkgL16lpp3lDRLOJJdht8Kok1JWUbzVBDDB5E/Py4yHF9reuXf/dJyaCa3/jWQce
         qHOmXG5/Vb0S3mGjHIFbceQN/uaOgRahO/98/ZsetjV2SqBrBtdhSU5K6+3xH1IGUOvV
         mgmS23NHI3gjNEAuv4vBfOtpOm4aFlOe6+lHGRXFmYXCLJAKUWMwOKtCQUmzoqjj2EH2
         dj2+du1Aa8Xw24rGkfzfIRDcl0EEChqpPEZJIPCWBwqEguQTI4nqJgwNsAOi8j0N3TkA
         vexS6tM9ZO7OWJqqkC4bg4AApRGIsOaIt9GVlAO4ZlaRp18R6t1yg4ko6Wy6Dtac63BW
         RBiw==
X-Gm-Message-State: AOAM532K+wav1PpyPuSITpp7X1eVC4JNTJpK5nILBzPs+51XhmeYJLLX
        4A1YvZbHYzl1rSpiC/fJmMJ+R2AEO37+x/Sn
X-Google-Smtp-Source: ABdhPJyJGY00vLHbK1Jz/xbIHAV4J9+uP/DLyU9KbzB4fvVKDWAJMjJTjVQwS+RdKhy2Dq+h+22vIA==
X-Received: by 2002:a05:6402:2753:b0:423:3895:7031 with SMTP id z19-20020a056402275300b0042338957031mr65243982edd.170.1654031207674;
        Tue, 31 May 2022 14:06:47 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id l27-20020a50d6db000000b0042dc25fdf5bsm6083515edj.29.2022.05.31.14.06.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 14:06:46 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso1910621wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:06:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8e:b0:397:73e3:8c83 with SMTP id
 bi14-20020a05600c3d8e00b0039773e38c83mr25043368wmb.29.1654031205884; Tue, 31
 May 2022 14:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
 <20220521091751.opeiqbmc5c2okdq6@houat> <CAD=FV=Wea0LT5umK4Xg87cDikim+dSuyLndfydO3_DnTujZr9Q@mail.gmail.com>
In-Reply-To: <CAD=FV=Wea0LT5umK4Xg87cDikim+dSuyLndfydO3_DnTujZr9Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 31 May 2022 14:06:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqJuPHxm7HYMvyHBL_zC-BBA_f0MBsZX-jHt7Pk9ngsQ@mail.gmail.com>
Message-ID: <CAD=FV=XqJuPHxm7HYMvyHBL_zC-BBA_f0MBsZX-jHt7Pk9ngsQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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

Maxime,

On Mon, May 23, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, May 21, 2022 at 2:17 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Tue, May 10, 2022 at 12:29:43PM -0700, Douglas Anderson wrote:
> > > This adds a devm managed version of drm_bridge_add(). Like other
> > > "devm" function listed in drm_bridge.h, this function takes an
> > > explicit "dev" to use for the lifetime management. A few notes:
> > > * In general we have a "struct device" for bridges that makes a good
> > >   candidate for where the lifetime matches exactly what we want.
> > > * The "bridge->dev->dev" device appears to be the encoder
> > >   device. That's not the right device to use for lifetime management.
> > >
> > > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > If we are to introduce more managed helpers, I think it'd be wiser to
> > introduce them as DRM-managed, and not device managed.
> >
> > Otherwise, you'll end up in a weird state when a device has been removed
> > but the DRM device is still around.
>
> I'm kinda confused. In this case there is no DRM device for the bridge
> and, as per my CL description, "bridge-dev->dev" appears to be the
> encoder device. I wasn't personally involved in discussions about it,
> but I was under the impression that this was expected / normal. Thus
> we can't make this DRM-managed.

Since I didn't hear a reply, I'll assume that my response addressed
your concerns. Assuming I get reviews for the other two patches in
this series I'll plan to land this with Dmitry's review.

-Doug
