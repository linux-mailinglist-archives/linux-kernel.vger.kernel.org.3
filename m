Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA133555278
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiFVRe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377535AbiFVRdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:33:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD72C656
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:33:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r20so3999090wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpaCjOapTAdRzLf+qPNGfdtVaNsXQvV0h/9qPiGYMOA=;
        b=ffkFg2lbSb3JovwNfGx8zubU8Dwr+HwSn1U+ippQGAK0MbFuUCFwMj6Q3zcjkVBMJX
         r06VQt8A5L7uBOALduThYx4AbJnjfy/uAvteehzEHk8XIS7JpWonwdwFDL+Pf91iF6FC
         lamNLMveY3aEeIXPeYL9cG3rYD2eb7DABBe4kG/H3Daa53Hg0KM6JkxXkHtiKQzqw4km
         IGReMEivIQV7k7sLscKNP858QT8xEhag4zRzqzl9R/lNA6wYBjS7fcfTIR48kRHzd2sW
         nz+ES14mNwxbUONGki81ysA8iLmMbqVDmy75WyzbjwMLziYaBRLe235vOWsU3gH4nn2m
         8b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpaCjOapTAdRzLf+qPNGfdtVaNsXQvV0h/9qPiGYMOA=;
        b=gp4MFWmoLrz9P6ZS0VzIFUNfDnyTXvZjqET2EP03DX1Q5mfgO6Dbo+zKt9ts7udWZI
         VRnmlzv/0b/8fJCF6geBmBcG8rFO7OWTrj5ZoIxhlrBNH7WC/xlo+iO6MtLL2Gmjk0BW
         TuwiTnELtI5RA19KVfpAJCdxXZCzAQZQ+mIp2BtqjgOi2t4SQK7OZ4cS6OT7SBhhrsv7
         yzsw2jDQVSDLHjn2pqzZ0BR9WDsBHec06OOuU+m0LzMmJQgdpZC4H1Uj7tau+RxWWYDq
         FGBc5kjlknPeSU0mShHQcruaGhSoZrKB4z8AaKprmFwRtN9g0rd786I84+nO4er+ljV0
         cA3w==
X-Gm-Message-State: AJIora9Zer9kU4IlHb22tma8YR+joV/lDaGdTlENm7gn4Y7AuKLswzhr
        NbK9scBYMj2eH7/Jy1i+hBFDBSBUW48IW3waY7bpM9MX0+w=
X-Google-Smtp-Source: AGRyM1uz4RIBAAr9I6m/BSWmy5hlU/Uode9MHQ3l9QxEYbOAEn1AyvqKX6/1vBCiFE69RkoEkU2Z+yxukKJ7svgM5ls=
X-Received: by 2002:adf:eb45:0:b0:21a:efae:4b9f with SMTP id
 u5-20020adfeb45000000b0021aefae4b9fmr4447308wrn.585.1655919225863; Wed, 22
 Jun 2022 10:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220622023855.2970913-1-swboyd@chromium.org> <b133b67f-0d99-af6b-94a5-d5ff4b5752f1@quicinc.com>
In-Reply-To: <b133b67f-0d99-af6b-94a5-d5ff4b5752f1@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Jun 2022 10:33:33 -0700
Message-ID: <CAF6AEGuL0+3162jGb2YLsYoW-fmNsARuKcvE-+d5hRkCiicp4g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Increment vsync_cnt before waking up userspace
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mark Yacoub <markyacoub@chromium.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
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

On Wed, Jun 22, 2022 at 10:24 AM Abhinav Kumar
<quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 6/21/2022 7:38 PM, Stephen Boyd wrote:
> > The 'vsync_cnt' is used to count the number of frames for a crtc.
> > Unfortunately, we increment the count after waking up userspace via
> > dpu_crtc_vblank_callback() calling drm_crtc_handle_vblank().
> > drm_crtc_handle_vblank() wakes up userspace processes that have called
> > drm_wait_vblank_ioctl(), and if that ioctl is expecting the count to
> > increase it won't.
> >
> > Increment the count before calling into the drm APIs so that we don't
> > have to worry about ordering the increment with anything else in drm.
> > This fixes a software video decode test that fails to see frame counts
> > increase on Trogdor boards.
> >
> > Cc: Mark Yacoub <markyacoub@chromium.org>
> > Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
> > Fixes: 885455d6bf82 ("drm/msm: Change dpu_crtc_get_vblank_counter to use vsync count.")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> This is right, we should increment before drm_crtc_handle_vblank() as
> that will query the vblank counter. This also matches what we do
> downstream, hence
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
> One small nit though, shouldnt the fixes tag be
>
> 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")

*Kinda*.. but the sw vblank counter wasn't used for reporting frame nr
to userspace until 885455d6bf82.  You could possibly list both,
perhaps, but 885455d6bf82 is the important one for folks backporting
to stable kernels to be aware of

BR,
-R

>
> This code has been this way since that commit itself.
>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > index 3a462e327e0e..a1b8c4592943 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -1251,12 +1251,13 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
> >       DPU_ATRACE_BEGIN("encoder_vblank_callback");
> >       dpu_enc = to_dpu_encoder_virt(drm_enc);
> >
> > +     atomic_inc(&phy_enc->vsync_cnt);
> > +
> >       spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> >       if (dpu_enc->crtc)
> >               dpu_crtc_vblank_callback(dpu_enc->crtc);
> >       spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
> >
> > -     atomic_inc(&phy_enc->vsync_cnt);
> >       DPU_ATRACE_END("encoder_vblank_callback");
> >   }
> >
> >
> > base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
