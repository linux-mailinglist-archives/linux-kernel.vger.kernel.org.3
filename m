Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BEA50C72D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 06:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiDWENX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 00:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDWENN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 00:13:13 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38F1F8EE5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 21:10:16 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l203so349608oif.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 21:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNhoTijYDK5hg3tJxjQgdgbL/kgrcPDOQkgZNKFoLe0=;
        b=hdtSyu9V8DkuUoFOA2YMj1NAwALLRl8/nme92ADOd6vw4uiyPQw2nLnwlWE4hZOTYh
         hMVnDHLTvfUc3WViSmGZpg2u+pUEdcvsCyRqN73T6IzHEHGfA1vTEDiRHBJPN+6XlSrv
         msMrpfZZZUF+GyEAV6/iGHUUspOxCkoTxxTgLKGlzea3b8Ke23TheCXbCJsLEcyEmSAx
         ScCt27p+r7SoHmhvmiiLbK5GcRXCci038RWnzP44TuuwC/pgLF4fgvBbUOcFzAdBcVtl
         NfA6FDVc5YQAbEHs68IP4imFUJETFAHSxXGTUp5cLGJo2EgIWtcozlUiXlg7hCcXLvqZ
         T+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YNhoTijYDK5hg3tJxjQgdgbL/kgrcPDOQkgZNKFoLe0=;
        b=F63mzzCbj3XvxPeMj/kRoZ9jkniudZym+rPwgl4hZNOnqhpbiLjqGH+vt2fG2i6Pki
         PaM7+Rm5bIoZJKxjc0BJAQDNnOpulfp8dVv1r+s1/EqZMYlWEOK8Zr14qGcaSGpoOCPc
         8UNPXeYNp2RAsOsg8mU8pIzOoCATXmEAc7loB8otwqqSQzLcrQNxadMUoyeAmWDyGZ5s
         4UFbVs8rUvxDO/E26DMAnG7i4svqZ+nw+KCga6a3S/hVsc19eDK7MRkKwigWJdmfiRsV
         Lp5FJCEFK0hGUtpLTfOIe9wRFxP3iap/G4CyagYTCTFRNrluddBAu0yoB6YANS0jsf8M
         vhoQ==
X-Gm-Message-State: AOAM532qn/1ycilgslXdxLENI2jVl88cFlOPxj4P3Dt/Nm3pUT0drtBk
        TFu8weyIwp9/MkvV/RzVFq8VzA==
X-Google-Smtp-Source: ABdhPJzEuQC08m6xCkVKR6XsHeSL5p0/ZkR7uRyRVVh9KvlNaDYNcO6f0NhDLqPj0GWi2P4EkbGFgQ==
X-Received: by 2002:a05:6808:1a04:b0:322:7b89:1973 with SMTP id bk4-20020a0568081a0400b003227b891973mr8311352oib.227.1650687016176;
        Fri, 22 Apr 2022 21:10:16 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l10-20020aca3e0a000000b0032258369a5fsm1410185oia.44.2022.04.22.21.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 21:10:15 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:12:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/msm/dp: Implement oob_hotplug_event()
Message-ID: <YmN8oMl7EulvBbEG@ripper>
References: <20220422223225.1297434-1-bjorn.andersson@linaro.org>
 <20220422223225.1297434-2-bjorn.andersson@linaro.org>
 <11a77fd7-d30b-edf6-3570-64d0c2e1764c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a77fd7-d30b-edf6-3570-64d0c2e1764c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Apr 16:07 PDT 2022, Dmitry Baryshkov wrote:
> On 23/04/2022 01:32, Bjorn Andersson wrote:
[..]
> > diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> > index 80f59cf99089..76904b1601b1 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> > @@ -123,6 +123,14 @@ static enum drm_mode_status dp_connector_mode_valid(
> >   	return dp_display_validate_mode(dp_disp, mode->clock);
> >   }
> > +static void dp_oob_hotplug_event(struct drm_connector *connector,
> > +				 enum drm_connector_hpd_state hpd_state)
> > +{
> > +	struct msm_dp *dp_disp = to_dp_connector(connector)->dp_display;
> > +
> > +	dp_display_oob_hotplug_event(dp_disp, hpd_state);
> > +}
> > +
> >   static const struct drm_connector_funcs dp_connector_funcs = {
> >   	.detect = dp_connector_detect,
> >   	.fill_modes = drm_helper_probe_single_connector_modes,
> > @@ -130,6 +138,7 @@ static const struct drm_connector_funcs dp_connector_funcs = {
> >   	.reset = drm_atomic_helper_connector_reset,
> >   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > +	.oob_hotplug_event = dp_oob_hotplug_event,
> 
> We were (are) going to switch dp driver to use drm_bridge_connector (to fix
> support for bridge chains, eDP panels, etc.
> 
> So these changes must be ported to drm_bridge_connector (or we must
> abandon/defer the idea of using the bridge_connector).
> 
> For the oob_hotplug_event() callback proper support might be as simple as
> calling drm_bridge_connector_hpd_cb().
> 

Are you saying that you have code ready and being merged into linux-next
that I should redesign this on top of, or that you're planning to write
some code in the future and DisplayPort support have to wait until then?

> >   };
> >   static const struct drm_connector_helper_funcs dp_connector_helper_funcs = {
> > @@ -160,6 +169,8 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display)
> >   	if (ret)
> >   		return ERR_PTR(ret);
> > +	connector->fwnode = fwnode_handle_get(dev_fwnode(dp_display->dev));
> > +
> 
> This would be much more interesting. Supporting this in a generic way might
> be tricky. But we can still set the fwnode manually from the dp code.
> 

There's a slight mishmash here, because the device used to initialize
the connector is the drm_dev, but we need the actual fwnode of the DP
device associated with the connector.

So I think this is how it needs to be done.

Regards,
Bjorn
