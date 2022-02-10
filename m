Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E284B1838
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbiBJWcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:32:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344965AbiBJWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:32:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E891BD9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:32:17 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so4766603oth.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JrHddR19ZD1tkokZWOCBaXxsomwE9JN1w01NkG4YDyU=;
        b=AOxrl24mI7dYWR6YtN6FZh7Gl8Pj9u1/oljFksQs78r7CJZJVslHGJgUXkU3T118zO
         5MabSKCGeA7XPcl6ZBXZ+ckDl4624CJhaTRZIvaYdMPWDswR7kRx2BnBROovCkRS5KAb
         v/dNvZSkxZ4eOyeO8ieSlwckmJ6DsV2Mu0bqephhV80yiUd6PiAibe/CXd0OUMBlSJXl
         fW0se2KH0qWF/80+Qhj3bCRSE2mHsyNIUsnlRC3kFbXUCRtMo/svqx2QM8V09K1Th68f
         qgJgmdXGbHyRfqqNF6jgkASk6+VHUf9/+aNcb/aceiaWgrrgUtF4wgFrBn6OXZl9Ohpv
         Tedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JrHddR19ZD1tkokZWOCBaXxsomwE9JN1w01NkG4YDyU=;
        b=W5VD9Lzc3wGcT3QNSVaHic+HIcxv7PZIbmG0nlzXygWiIp6z6cs5RLWAtZIJGZARD4
         qqSOvlNA23ntJGwfaz9znjGQaV9a8JWHIYoq8+UwmRkLEik8ED3bAa8YyhPaK/ia6/HW
         Ey5HHmzAclUTFoxK90Jl6VNa/oZPyxcWBhiQYl5THvfNvGHpremz21/JAJqV0ZOn1Inc
         mZECx0BWPg3Cl5C/xGuTKVOVOyzj90/0/oHysUzMQ5JG2fVfyRkXngLZ564eDuw4CDGN
         TVx8esZyD2JW68zeUdV6qHjBLwGHKGEqkUiP6u2xJGfHe36KarHTalecYh5hQN+VLLQK
         5Avg==
X-Gm-Message-State: AOAM532VskwYbZyAlHSHZTEpgCpt28woNopuJ1RQ61z/DbjIwo5L7cku
        XytwqunhiZhGgINZyvh9kOnmRg==
X-Google-Smtp-Source: ABdhPJxJ7/q4RbdB3oTSoXedG6ikpzgyv4pQn6CfOszGopvOcDpzuPeg37Y9NWvFxF93GL7eMhYPBg==
X-Received: by 2002:a05:6830:92a:: with SMTP id v42mr3756586ott.48.1644532336413;
        Thu, 10 Feb 2022 14:32:16 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 6sm8819888oig.29.2022.02.10.14.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:32:15 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:34:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/msm/dp: Implement oob_hotplug_event()
Message-ID: <YgWS9iZ+1uJBd9Lj@ripper>
References: <20220208044328.588860-1-bjorn.andersson@linaro.org>
 <20220208044328.588860-2-bjorn.andersson@linaro.org>
 <YgIecy+W/lGzL6ac@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgIecy+W/lGzL6ac@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Feb 23:40 PST 2022, Greg Kroah-Hartman wrote:

> On Mon, Feb 07, 2022 at 08:43:28PM -0800, Bjorn Andersson wrote:
> > The Qualcomm DisplayPort driver contains traces of the necessary
> > plumbing to hook up USB HPD, in the form of the dp_hpd module and the
> > dp_usbpd_cb struct. Use this as basis for implementing the
> > oob_hotplug_event() callback, by amending the dp_hpd module with the
> > missing logic.
> > 
> > Overall the solution is similar to what's done downstream, but upstream
> > all the code to disect the HPD notification lives on the calling side of
> > drm_connector_oob_hotplug_event().
> > 
> > drm_connector_oob_hotplug_event() performs the lookup of the
> > drm_connector based on fwnode, hence the need to assign the fwnode in
> > dp_drm_connector_init().
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c |  8 ++++++++
> >  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
> >  drivers/gpu/drm/msm/dp/dp_drm.c     | 10 ++++++++++
> >  drivers/gpu/drm/msm/dp/dp_hpd.c     | 19 +++++++++++++++++++
> >  drivers/gpu/drm/msm/dp/dp_hpd.h     |  4 ++++
> >  5 files changed, 43 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 7cc4d21f2091..124a2f794382 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -414,6 +414,13 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
> >  	return dp_display_process_hpd_high(dp);
> >  }
> >  
> > +void dp_display_oob_hotplug_event(struct msm_dp *dp_display, bool hpd_state)
> > +{
> > +	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
> > +
> > +	dp->usbpd->oob_event(dp->usbpd, hpd_state);
> > +}
> > +
> >  static int dp_display_usbpd_disconnect_cb(struct device *dev)
> >  {
> >  	struct dp_display_private *dp = dev_get_dp_display_private(dev);
> > @@ -1251,6 +1258,7 @@ static int dp_display_probe(struct platform_device *pdev)
> >  	dp->pdev = pdev;
> >  	dp->name = "drm_dp";
> >  	dp->dp_display.connector_type = desc->connector_type;
> > +	dp->dp_display.dev = &pdev->dev;
> 
> You did not properly reference count this pointer you just saved.  What
> is to keep that pointer from going away without you knowing about it?
> 

The "dp" object only lives while &pdev->dev is alive, both logically and
as its devres allocated on &pdev-dev. So for this reference I don't see
that we should refcount it.

> And you already have a pointer to pdev, why save another one here?
> 

The Qualcomm DisplayPort driver has per-c-file private context structs
and "dp" is one such object. So I simply can't dereference it and get to
pdev from the other c-file in the same driver...

But I only need it in dp_drm.c to during initialization to get a
reference to the associated fwnode, so it seems that I can rework this
and pass the pointer as a parameter to dp_drm_connector_init().

That looks to be cleaner as well.

Thanks,
Bjorn
