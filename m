Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244ED51C98E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385467AbiEETvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385455AbiEETul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98B55E778
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:46:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l18so10637255ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76zX1jgwsT0zasKmYBV09/BTCdCZuPCGb857583dfNA=;
        b=SmHj+rwtIFR4QeyrR8yYTA8Fhs6CJFKqo+ftX7Osrnz35VRHPloLk8g+bvl5qcJWLe
         QOeZk4QXHqs03B12KbbhztbLSNTfpdG3UgGiIYvKI5RxdFPE1OeB1/Brg8CmGwvnsRY7
         JCyVgGU9P2LO+D0gCmzVu3OkT7f+wQXFYa3Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76zX1jgwsT0zasKmYBV09/BTCdCZuPCGb857583dfNA=;
        b=MFklhEBtiGxI7ZUoT9VGHc61qpkuCyUSbTES5x/awUYvdG4NuHTXnxgd1K37PoajPU
         jrGztC3DCRLvV1ReYxcWs7oMMLI5i9OiiRs8upga9laS4DbQnPfoSUAxKdhoQjoAic5g
         75ZvMXMp0DXItU/Bphaa2ZS3Xil6fW1Es7sbeKfZN1i39gOTb25wBWhrAQnwl7689IY0
         e3EThuWz2OBGmJVMboOPrfwVcZAC+VXOgO4f/MjvQ6zNpjSX80vwjdFo7+2Q9DhkqtPh
         xsbamsckbWiJiyotthAtPLu74gjEQhO5jYDuIXESMAlrIAK8h7bAT3o2nNgNsRfBPEP8
         /eQA==
X-Gm-Message-State: AOAM531/u2gksn8Zna4/F/uxLxwAM6Gc7XRZC83bPP+/POUxnxxxZURr
        o/MeVbxRt6HpOj/EAB1uC5q/w6ZKyRvBNj1O/gg=
X-Google-Smtp-Source: ABdhPJz3IuRoDt69Kxp/7j19PJqJb6LBdZMctR0srQ4OiVWFGqTdUqSY+jAIg6xtXagjmXQTd/QCrQ==
X-Received: by 2002:a17:907:9705:b0:6f0:2b25:784e with SMTP id jg5-20020a170907970500b006f02b25784emr27857791ejc.76.1651780015080;
        Thu, 05 May 2022 12:46:55 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090729c600b006f3ef214df6sm1074726ejc.92.2022.05.05.12.46.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 12:46:54 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id v12so7384081wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:46:52 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr22070355wro.679.1651780012333;
 Thu, 05 May 2022 12:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220426114627.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
 <a0342c52-6d39-cf16-632a-f45ff051210c@suse.de>
In-Reply-To: <a0342c52-6d39-cf16-632a-f45ff051210c@suse.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 12:46:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XG1L_cVLQXuxNbOfgFuxYg6jAFW=7To01Eo_0JSA9yqg@mail.gmail.com>
Message-ID: <CAD=FV=XG1L_cVLQXuxNbOfgFuxYg6jAFW=7To01Eo_0JSA9yqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/probe-helper: Add helper for drm_helper_probe_single_connector_modes()
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 5, 2022 at 11:34 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 26.04.22 um 20:46 schrieb Douglas Anderson:
> > The drm_helper_probe_single_connector_modes() is a bit long. Let's
> > break a chunk off to update and validate modes. This helps avoid one
> > goto and also will allow us to more easily call the helper a second
> > time in a future patch without adding looping or another goto.
> >
> > This change is intended to be a no-op change--just code movement.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
>
> > ---
> >
> >   drivers/gpu/drm/drm_probe_helper.c | 105 ++++++++++++++++-------------
> >   1 file changed, 59 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> > index 682359512996..819225629010 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -354,6 +354,61 @@ drm_helper_probe_detect(struct drm_connector *connector,
> >   }
> >   EXPORT_SYMBOL(drm_helper_probe_detect);
> >
> > +static bool _drm_helper_update_and_validate(struct drm_connector *connector,
>
> AFAIK convention is to use two underscores for internal names.

Sure! I'll spin with this.


> > +                                         uint32_t maxX, uint32_t maxY,
> > +                                         struct drm_modeset_acquire_ctx *ctx)
> > +{
> > +     struct drm_device *dev = connector->dev;
> > +     struct drm_display_mode *mode;
> > +     int mode_flags = 0;
> > +     int ret;
> > +
> > +     drm_connector_list_update(connector);
> > +
> > +     if (connector->interlace_allowed)
> > +             mode_flags |= DRM_MODE_FLAG_INTERLACE;
> > +     if (connector->doublescan_allowed)
> > +             mode_flags |= DRM_MODE_FLAG_DBLSCAN;
> > +     if (connector->stereo_allowed)
> > +             mode_flags |= DRM_MODE_FLAG_3D_MASK;
> > +
> > +     list_for_each_entry(mode, &connector->modes, head) {
> > +             if (mode->status != MODE_OK)
> > +                     continue;
> > +
> > +             mode->status = drm_mode_validate_driver(dev, mode);
> > +             if (mode->status != MODE_OK)
> > +                     continue;
> > +
> > +             mode->status = drm_mode_validate_size(mode, maxX, maxY);
> > +             if (mode->status != MODE_OK)
> > +                     continue;
> > +
> > +             mode->status = drm_mode_validate_flag(mode, mode_flags);
> > +             if (mode->status != MODE_OK)
> > +                     continue;
> > +
> > +             ret = drm_mode_validate_pipeline(mode, connector, ctx,
> > +                                              &mode->status);
> > +             if (ret) {
> > +                     drm_dbg_kms(dev,
> > +                                 "drm_mode_validate_pipeline failed: %d\n",
> > +                                 ret);
> > +
> > +                     if (drm_WARN_ON_ONCE(dev, ret != -EDEADLK))
> > +                             mode->status = MODE_ERROR;
> > +                     else
> > +                             return true;
>
> Returning true is non-intuitive. It looks as if we report success when
> it actually signals a retry.
>
> I suggest to return 'ret' here and let the caller decide. On success at
> the end of the function, it would return 0 as usual.

There's a madness to my method. I originally had it returning "ret"
but then I felt like the callers now needed to handle three cases:

a) ret = -EDEADLK
b) ret = 0
c) ret = some other error

In reality _drm_helper_update_and_validate() never returned anything
other than a) or b), so adding the extra error handling for c) seemed
like a waste. ...but it also felt like if it violated the abstraction
of _drm_helper_update_and_validate() returning an error code if I
didn't handle c).

In any case, I'll change it back to an error code. Maybe a compromise would be:

ret = _drm_helper_update_and_validate(...)
if (ret == -EDEADLK) {
  drm_modeset_backoff(...)
  goto retry;
}
WARN_ON(ret);

...so we at least document that ret can only be one of the two values
and we'll get a warning splat if it ever happens, but we don't need to
add complex error handling for a case that the code can't hit. Ah,
looking above I guess that matches what the function does earlier too.

OK, I'll give a few more days for feedback on this series and I'll
spin with the two changes you've requested.

-Doug

-Doug
