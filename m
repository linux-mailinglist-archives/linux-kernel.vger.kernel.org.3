Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3B493E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbiASQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356144AbiASQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:30:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:30:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v123so6172083wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kcVKA3cO1gMjv5znetYf0gFrDVY8f+ZwutG6o8Ga6LM=;
        b=IhNIoFSrR1xUQmRTkygi8eVtSAV917TMwd/C4acdPt/AnQdQtaHjnZetbdOAic8uPF
         L/OpokHD8oxH6EjUSLalVxIJCo+bnZUouhEpkZSRIw3SARnzK8FHIULZZfqrdFnkeCqZ
         5ZeMF3rY6HjUPY8TK5khep/e4j4CIESxlPbiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kcVKA3cO1gMjv5znetYf0gFrDVY8f+ZwutG6o8Ga6LM=;
        b=lRTOLscVw/30yeRCqorh2qVA26LBM/TsY4MfNIGXlC+y+ItxDQx38tcaqY1kpKBeC/
         NccrqysjQ5s4rkwHap/i2VI0O+xZBT7Le2SIutiiRnpOuCJQ8pJfj+MZ3hIuVN458HuH
         wzPfjsSPvkqHH1yGHhX9uQYmypNhmR05U+xM7BP2ouiXnoWaYCRRceWJK2CYaFHSZGSU
         qxoqai2QhNXyz7o5ENUmhcaiwgkx4YguD45yRhVJDQL+gYFgwgK8u+iMR530M/0WM6MO
         4mKIWIK58eXL3qFK/nQzdhAI9FYCtLt7Jpw1HMkSUbMEqYKzECW+zBKddei/KzfMJNkL
         r9ew==
X-Gm-Message-State: AOAM532VS7I+ek71udpR4M0l9IUcxgrvn2FRfEj7Tzz4R7xAo53Eyhdi
        vEV4oSHK9cNaYNv906fIFiHAdw==
X-Google-Smtp-Source: ABdhPJxtMCdwKeJWfO01Q5W4lZzfQ9YUzdTVJunRD/rLU9x6y6GqnC4P7AYJfyGItM4UOJBUrUvN2A==
X-Received: by 2002:a5d:588d:: with SMTP id n13mr16737444wrf.153.1642609820911;
        Wed, 19 Jan 2022 08:30:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x4sm367217wrp.13.2022.01.19.08.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:30:20 -0800 (PST)
Date:   Wed, 19 Jan 2022 17:30:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Daniel Palmer <daniel@0x0f.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] How to add hardware rotation, scaling etc to a DRM/KMS
 driver
Message-ID: <Yeg8mi0S2ACy9q8O@phenom.ffwll.local>
Mail-Followup-To: Daniel Palmer <daniel@0x0f.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFr9PXnig9YfnwSzMg5UPm3UtAsEAQT_xVheBbLppiU45mc_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXnig9YfnwSzMg5UPm3UtAsEAQT_xVheBbLppiU45mc_QQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:55:22PM +0900, Daniel Palmer wrote:
> Hi all,
> 
> I've copied and pasted my way to mostly working DRM/KMS driver for a
> low cost ARM SoC (Sigmastar SSD202D). The hardware is 2D only.
> 
> One of the devices that uses this SoC has the screen upside down so it
> needs the screen rotated.
> The hardware doesn't have bits that change the scan out direction from
> what I can tell (so it can't mirror/flip while feeding it to the
> screen) but it does have a 2D blitter style block that can take a
> framebuffer and flip/mirror/scale/convert the colour space into
> another buffer.
> 
> My idea was to create a buffer for the rotated image when allocating
> the framebuffer and trigger the hardware to do the conversion each
> vblank or something.
> 
> While reading the discussion about maintaining fbdev I realised maybe
> I should ask instead of wasting too much time on something that's
> wrong.
> 
> I got the feeling that maybe I should just provide an interface to the
> blitter from userspace and userspace should be doing the rotation. I'd
> like to do it in the kernel so stuff like SDL1 apps just work but
> maybe that isn't possible?

panel orientation property is for that stuff:

https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#standard-connector-properties

You need to scroll down to the "panel orientation:" property. And here's
how to quirk this for at least some cases (for dt panels it should be in
the dt):

https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html?highlight=drm_get_panel_orientation_quirk#c.drm_get_panel_orientation_quirk"

fbcon will head this and rotate in sw, as should any competent compositor
in userspace (but some might not, it depends).

Also ping Hans de Geode if you have any questions, he's done this.
-Daniel

> 
> Cheers,
> 
> Daniel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
