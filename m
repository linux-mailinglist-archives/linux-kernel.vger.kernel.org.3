Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7D5AF45E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIFTXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIFTXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:23:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79DB9E0CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:23:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t7so11902079wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=SvLHu52ca5VzDNJof20flio45GILMdjYNCxZVYNcb4Q=;
        b=S5gmEqExI7UB5Y4m2kgu9WXIs4qY26yzzIKS4Gu0yJN1QOZjVZb5KjorA+BIbcCggl
         w88NOycy1XAbhtQ4CtYV9NBDnwCGK62+VctQMJlvNCH04ZnFLwMNR2edOqUGTOr3fMcd
         EY1al4BsxLycKjGm2WYuYjg7N1OHYlQW4CIfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SvLHu52ca5VzDNJof20flio45GILMdjYNCxZVYNcb4Q=;
        b=CCroZ3JK7isdBE67eaYMMVy8ewj3uPg26bgXYnRPGbgIQfN29qIDRWoUj11gzSRvm2
         NAMzvI8Ce1C4hvfNwgWAkm89TzuqHvxi/kD99htE1lAWK//KO/+0RpqAUPwErYXqdEMw
         DmFTWAuLMJtsIHVPkYp4Ef53k+FxOOVXJbA4B80OuMMODE+/DaHAfJ/YPDZsI/Wh5W/W
         XtvmUW1MYMwyzggr7DpGE3/i3O5HBHOOJaN+ztWvL0jeeqnwuaqjGdz4TsRhZnmG/R28
         RUBs+Nzcd5vADlDHCzRC457D5wrbbqztRvvoAQq9am4lbJiPVbBG2UvUY9cCUBH+zu4b
         p/eQ==
X-Gm-Message-State: ACgBeo150Sj/6uU4XI0l0o2JJ8DRBH7BFkJ505A6vj+6egYF7DXtram0
        zi/plY0Oy9tbzsAK3/eD6pLtSIbuq5tfpQ==
X-Google-Smtp-Source: AA6agR4pzxQa3+NuQFs097yiwIYDxbYIBcU8xjXhX3LyYcXobI+firEFK2Tvy3Wi2g1CnCwXsy52Qg==
X-Received: by 2002:a5d:574e:0:b0:228:6252:38f0 with SMTP id q14-20020a5d574e000000b00228625238f0mr266wrw.436.1662492219089;
        Tue, 06 Sep 2022 12:23:39 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id a1-20020adffac1000000b00226dba960b4sm14096945wrs.3.2022.09.06.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:23:38 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:23:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Prevent modeset helpers to access an uninitialized
 drm_mode_config
Message-ID: <YxeeOJJ17L95LruS@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org
References: <20220724123741.1268536-1-javierm@redhat.com>
 <e6ed25b0-49d2-7e3b-91e5-72e431310610@suse.de>
 <38128880-5b47-7ba0-54f3-97c4d6e04028@redhat.com>
 <e66bc2ab-6495-044f-7e37-892de076095a@suse.de>
 <34162536-6a57-6ff0-e6ab-bfd5fee14451@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34162536-6a57-6ff0-e6ab-bfd5fee14451@redhat.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:28:21AM +0200, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On 7/25/22 09:12, Thomas Zimmermann wrote:
> 
> [...]
> 
> >>>>
> >>>> Let make the DRM core more robust and prevent this to happen, by marking a
> >>>> struct drm_mode_config as initialized during drmm_mode_config_init(). that
> >>>> way helpers can check for it and not attempt to grab uninitialized mutexes.
> >>>
> >>> I disagree. This patch looks like cargo-cult programming and entirely
> >>> arbitrary.  The solution here is to fix drivers.  The actual test to
> >>> perform is to instrument the mutex implementation to detect
> >>> uninitialized mutexes.
> >>>
> >>
> >> While I do agree that drivers should be fixed, IMO we should try to make it
> >> hard for the kernel to crash. We already have checks in other DRM helpers to
> >> avoid accessing uninitialized data, so I don't see why we couldn't do the
> >> same here.
> > 
> > Code should stand on its own merits, instead of doing something because 
> > something else does it. The latter is what is referred to as cargo-cult 
> > programming.
> >
> 
> Yes, I'm familiar with the concept but was thinking about a different paradigm
> when writing this patch that is defensive programming. The question is whether
> makes sense for the DRM core to defense from buggy drivers. My opinion is that
> if possible it should and we should prevent kernel panics at all costs.
> 
> Otherwise, let's say a reboot may crash and never finish unless you have a HW
> watchdog or something to bring the system again into a functional state.
> 
> But I agree that this particular patch is not nice and in fact I considered to
> post it as a RFC at the beginning. 

Way late on this, but because it's a bit more fundamental discussions I
figured maybe still useful when I chime in here ...

Imo the fix for this is drmm_ and aggressively removing driver cleanup
code everywhere by using drmm_ and devm_ for everything.

Trying to make these functions robust against arbitrary driver bugs is a
lost play imo, and the fundamental fix is making cleanup code fool proof
by making it all unecessary.

Ideally we'd be able to unexport all the explicit cleanup functions so
that drivers just cannot get anything wrong here. We're a long way from
that world though :-(
-Daniel


>  
> > Doing sanity checks on values is not a problem, but putting flag 
> > variables throughout the code to question other code's state is. That's 
> > not 'The Way of the C.' There's also the problem that a good part of 
> > struct drm_mode_config's initialization is open-coded in drivers. So the 
> > meaning of is_initialized is somewhat fuzzy.
> >
> 
> That is true. It is meant to signal that at least drm_mode_config_init() was
> called by the driver.
> 
> >>
> >> I wrote this patch after fixing a bug in the drm/msm driver [0]. By looking
> >> at how other drivers handled this case, I'm pretty sure that they have the
> >> same problem. A warning is much better than a kernel crash during shutdown.
> >>
> >> [0]: https://patchwork.kernel.org/project/dri-devel/patch/20220724111327.1195693-1-javierm@redhat.com/
> > 
> > I see. I wasn't aware that missing mode_config_init() is a problem. From 
> > the linked URL, I cannot really understand how it's related. msm appears 
> > to be calling drm_mode_config_init(), right? The idiomatic solution 
> > would be to convert msm to managed code. But that's an entirely 
> > different patchset, of course. (I only took a brief look at the link TBH.)
> > 
> 
> The problem as mentioned is that drivers could call the modeset helpers even
> when that init function was never called. In this case due the .bind callback
> not being executed because a probe failed for a driver of a expected sub-device
> failed.
> 
> The .shutdown callback is registered when the platform_driver is registered
> and that happens at module_init(), so the shutdown would be executed regardless
> of the probe (or bind) doing a proper initialization.
> 
> I think we need some way to signal drivers about that. Even better we could use
> it in the core helpers to not attempt to access struct drm_device data if the
> DRM device was not properly initialized.
> 
> Maybe the drm_device .registered field is enough and we could reuse that ?
> 
> > Here's a suggestion on how to construct the mode-config code in order to 
> > make it hard to misuse:  Driver currently open-code the initialization 
> > of many fields in drm_mode_config. Expand the arguments of 
> > drm_mode_config_init() to take the pointer to the drm_mode_config_funcs. 
> > These functions are essential to do anything, so it's a good candidate 
> > for an argument. Drivers are easily converted the the new interface 
> > AFAICT.  After the conversion, add a test to drm_mode_config_reset() 
> > that tests for the funcs to be set.  drm_mode_config_reset() is also 
> > essential during initialization or the driver will fail immediately on 
> > the first modeset operation. That gives a test for an initialized 
> > mode_config without adding extra fields.
> >
> 
> I agree that all these are nice things to do but I can't see how it could help
> in this case. If all these are still done in the .bind callback then it might
> never be executed and the .shutdown callback would still happily call to the
> drm_atomic_helper_shutdown() which will try to grab uninitialized mutexes and
> crash the kernel.
> 
> Yes, I already posted a patch for msm/drm to prevent this but as mentioned a
> lot of drivers still have that issue. We could audit all drivers and fix them
> but I think we need to make the core more robust.
> 
> > As a bit of a sidenote: we should consider making 
> > drm_mode_config_reset() and the reset callbacks return errors. The reset 
> > functions allocate memory for states and if this fails, we have no way 
> > of reporting the failure.
> >
> 
> Yes, agreed.
>  
> > Best regards
> > Thomas
> > 
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
