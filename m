Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A15233C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiEKNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiEKNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:16:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9D2EA01
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:16:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ch13so3932882ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKAX1BFitoF5KnIE0atLfue5Z05Vzelo2xc7M7PzQVc=;
        b=Uven7JTz762OOS3tIRaxkeeai+ObuaVDKDLwAeDRBCUN6bYFLFApz3TVF/1+VDO5TY
         IzqFAx87iX/LKixBIaJlt4Iih8fknchC+UWxXykiAGVO+NCAyhNBsyM6Ot9suClErx2v
         i3VjKym9eq6P1dW2YnbQOX6Ny5L5C9mf+cRz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yKAX1BFitoF5KnIE0atLfue5Z05Vzelo2xc7M7PzQVc=;
        b=en2aVjRLFfwD3djwgvHAHxCRtA/2Yg1VRAgTN21f8Hk3hYDDXub119bQtAXf287LNI
         F9BP2894HkmTCgbi/hzx7yNGVnPraPyMS2pceWPuUrijmDmMGDftDLp79u5Y9TnetPPt
         YJKZohA9ABojdAEEDO9clNwJlU0TTeJka4FQ42rYwiVrkcWrg/wBjtk/PEuqxYu1R/nG
         6EswP8ow8+glfw6/9rviJ1C1iEBkUP2aSH2GhHBak2i6bEyXHI0k7/MszT8qfmjiScaK
         QngtVceX8wLxhsld3ucL5pIOmaz/0UYlneowhMWHIIgWqZyva3vM8+4DunbH2LamB8xf
         Y/Xw==
X-Gm-Message-State: AOAM532QFg8EWOYOsXeq7tng0R0Z/zvZNXg08+ZL7LVoUoY4vTSn2K8Y
        2gF/NYAlEd1kgknstIGkyYrGQg==
X-Google-Smtp-Source: ABdhPJyyc2xJQFzy80r3nQdKXjSgniAcs50KbR6WAfiJEpH171gpXCA+L0Q5OZzggqfw/NhHZNKwpA==
X-Received: by 2002:a17:907:6e8b:b0:6fa:82f5:14bd with SMTP id sh11-20020a1709076e8b00b006fa82f514bdmr12877746ejc.182.1652274960045;
        Wed, 11 May 2022 06:16:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id md26-20020a170906ae9a00b006f3ef214e26sm974974ejb.140.2022.05.11.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:15:58 -0700 (PDT)
Date:   Wed, 11 May 2022 15:15:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Message-ID: <Ynu3DJJJV7TaSzfl@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
 <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
 <51254d3d-af8d-61b3-e8a2-8fd0e583e783@suse.de>
 <2c59cd79-76d4-7829-e1db-88bc31396c8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c59cd79-76d4-7829-e1db-88bc31396c8a@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:00:41PM +0200, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On 5/9/22 20:32, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 09.05.22 um 18:33 schrieb Javier Martinez Canillas:
> >> On 5/9/22 17:51, Andrzej Hajda wrote:
> >>
> >> [snip]
> >>
> >>>>>> +
> >>>>> Regarding drm:
> >>>>> What about drm_fb_helper_fini? It calls also framebuffer_release and is
> >>>>> called often from _remove paths (checked intel/radeon/nouveau). I guess
> >>>>> it should be fixed as well. Do you plan to fix it?
> >>>>>
> >>>> I think you are correct. Maybe we need something like the following?
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> >>>> index d265a73313c9..b09598f7af28 100644
> >>>> --- a/drivers/gpu/drm/drm_fb_helper.c
> >>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >>>> @@ -631,7 +631,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
> >>>>           if (info) {
> >>>>                   if (info->cmap.len)
> >>>>                           fb_dealloc_cmap(&info->cmap);
> >>>> -               framebuffer_release(info);
> > 
> > After reviewing that code,  drm_fb_helper_fini() appears to be called 
> > from .fb_destroy (see drm_fbdev_release).  The code is hard to follow 
> > though.  If there another way of releasing the framebuffer here?
> > 
> 
> Andrzej mentioned intel/radeon/nouveau as example, I only looked at i915
> and the call chain is the following as far as I can tell:
> 
> struct pci_driver i915_pci_driver = {
> ...
>         .remove = i915_pci_remove,
> ...
> };
> 
> 
> i915_driver_remove
>   intel_modeset_driver_remove_noirq
>     intel_fbdev_fini
>       intel_fbdev_destroy
>         drm_fb_helper_fini
>           framebuffer_release
>               
> So my underdestanding is that if a program has the emulated fbdev device
> opened and the i915 module is removed, then a use-after-free would be
> triggered on drm_fbdev_fb_destroy() once the program closes the device:
> 
> drm_fbdev_fb_destroy
>   drm_fbdev_release(info->par); <-- info was already freed on .remove

Yeah the old drivers that haven't switched over to the drm_client based
fbdev emulations are all kinds of wrong and release it too early.

Note that they don't use the provided ->remove hook, since that would
result in double-cleanup like you point out. Those old drivers work more
like all the other fbdev drivers where all the cleanup is done in
->remove, and if it's a real hotunplug you just die in fire :-/

Switching them all over to the drm_client based fbdev helpers and
unexporting these old (dangerous!) functions would be really neat. But
it's also a loooooot of work, and generally those big drivers don't get
hotunplugged.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
