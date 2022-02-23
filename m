Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58F94C185F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiBWQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiBWQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:19:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7681CFD9;
        Wed, 23 Feb 2022 08:18:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so40455147wrg.11;
        Wed, 23 Feb 2022 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vu8Twnocn3vA4ricnLle2PUL2O6gazUeaL13927N0Bw=;
        b=dU+Uq1hgyWoO4vVyQn1ujrktF0A2z0Zg7WmMjPHYBcM7m32p0tLKDSKQUVOjkCMPLd
         NQHbsrDFQJ+vyYL92d2dYicS/odftSePDJWQl66P3pkpro62ARe5Evkii3sEAMhedGz/
         VFdy0DKVRaEzQRiD/Gvgek/8tfHZlcsqxdoTTboE1sZ6EDbkjpUblB+t7bYdi29J4ezG
         kiAJa5BditVgo5ThrGJQRtTECHC3i0GaVzlOEyfeeg0Hn67Nc3paqFSnSd+LK2M61yQa
         Spy4a7vFsxx5Q9z8kV6/13pMYxzPbFFunOBddsseJsE5vcaC5Sdu4ypUcXOJMIql03aX
         XVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vu8Twnocn3vA4ricnLle2PUL2O6gazUeaL13927N0Bw=;
        b=w4GKuCT5HFQzp3e32u30pLvwu0USuzaQSEZST2OwCc/YJrxeiIfL3A/8nYIN6QAA6e
         bsKbX43lTQH1kh0LGM0bpIKekQdalT2f+u24rxiaTI2N9c+9ZxTr5gAbNfWpOARlHwcl
         KXV1o7JuunfBmhehhn0jdo7eK8AZy4SMmf9pu88ArU8uCWWBr62g8WXXUgmv5Oikjbxv
         BY88YbUofy3lPFvTGFaClC+zzxXU6rhlqO0LsEd+BuzE6cYTk/+JSjMfdtLQfYKnYtIU
         4mUG1TQPkgib/LIWJekv5uowjPGxpI0raLIUMh65fnumb3hKVnMjDKlB1NBJMa5hjxiu
         9VTQ==
X-Gm-Message-State: AOAM532HNLvIe4ZXjtijdqMOH3IGsXqQUiYmhSXuVHIvKE+Zz5JeRByf
        1Fs8njflQNxChUpHoA0bYYmtzT9NeNmKPLAheGE=
X-Google-Smtp-Source: ABdhPJxUxsUu4B6LPuO8RFWw7Yn5lu+ezbPGrbFjXiTTcZQRl7UW8msM5NNY5SAhTMaB4e82kLY55STtgN9hvzTG0J0=
X-Received: by 2002:a05:6000:1202:b0:1ed:b03e:69a0 with SMTP id
 e2-20020a056000120200b001edb03e69a0mr275388wrx.93.1645633117146; Wed, 23 Feb
 2022 08:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20220219193957.577054-1-robdclark@gmail.com> <a065a843-e7c3-a75b-aa8e-d4b264146df0@linaro.org>
In-Reply-To: <a065a843-e7c3-a75b-aa8e-d4b264146df0@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 23 Feb 2022 08:18:56 -0800
Message-ID: <CAF6AEGuAq_OT_bFon+WvGr+kU1wA_u=bRirC8BjN=5eYNopiOA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Avoid dirtyfb stalls on video mode displays
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Mark Yacoub <markyacoub@google.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        David Heidelberg <david@ixit.cz>, Xu Wang <vulab@iscas.ac.cn>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:00 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 19/02/2022 22:39, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Someone on IRC once asked an innocent enough sounding question:  Why
> > with xf86-video-modesetting is es2gears limited at 120fps.
> >
> > So I broke out the perfetto tracing mesa MR and took a look.  It turns
> > out the problem was drm_atomic_helper_dirtyfb(), which would end up
> > waiting for vblank.. es2gears would rapidly push two frames to Xorg,
> > which would blit them to screen and in idle hook (I assume) call the
> > DIRTYFB ioctl.  Which in turn would do an atomic update to flush the
> > dirty rects, which would stall until the next vblank.  And then the
> > whole process would repeat.
> >
> > But this is a bit silly, we only need dirtyfb for command mode DSI
> > panels.  So lets just skip it otherwise.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  | 13 +++++
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  |  9 ++++
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c   |  1 +
> >   drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c |  9 ++++
> >   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c  |  1 +
> >   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h  |  1 +
> >   drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c |  8 +++
> >   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c  |  1 +
> >   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h  |  1 +
> >   drivers/gpu/drm/msm/msm_fb.c              | 64 ++++++++++++++++++++++-
> >   drivers/gpu/drm/msm/msm_kms.h             |  2 +
> >   11 files changed, 109 insertions(+), 1 deletion(-)
> >
>
> I have checked your previous dirtyfb patch (and corresponding discussion).
>
> I'm not fond of the idea of acquiring locks, computing the value, then
> releasing the locks and reacquiring the locks again. I understand the
> original needs_dirtyfb approach was frowned upon. Do we have a chance of
> introducing drm_atomic_helper_dirtyfb_unlocked()? Which would perform
> all the steps of the orignal helper, but without locks acquirement (and
> state allocation/freeing)?
>

The locking is really more just to avoid racing state access with
state being free'd.  The sort of race you could have is perhaps
dirtyfb racing with attaching the fb to a cmd mode
plane->crtc->encoder chain.  I think this is relatively harmless since
that act would flush the fb anyways.

But it did give me an idea for a possibly simpler approach.. we might
be able to just keep a refcnt of cmd mode panels the fb is indirectly
attached to, and then msm_framebuffer_dirtyfb() simply has to check if
that count is greater than zero.  If we increment/decrement the count
in fb->prepare()/cleanup() that should also solve the race.

BR,
-R
