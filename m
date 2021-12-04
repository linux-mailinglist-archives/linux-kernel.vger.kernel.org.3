Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019DF46814A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383709AbhLDAdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354465AbhLDAdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:33:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B9C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:30:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso1507164pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4bA6B58sO/DZFiWQPyn2M4tT+W9TdiU/GNQ/jYac3Y=;
        b=dONWm8orH3rHUYSth5Iu/7D5o9GfvJHjytD1XASds1m9DG5Iu2xtV+VIJqFns9+sCW
         gtVXtQ+X75glpuBDyjZuBrz5E2x65R67MRUHyYgMxoRbtj2iT7FB4LVqbxZaCTcsZp/N
         XgqXSY5G2qAHh4XaPeq45yLBcfhCQFiswdF4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4bA6B58sO/DZFiWQPyn2M4tT+W9TdiU/GNQ/jYac3Y=;
        b=XaIozHWgCSvhNW+GR6r8YKtmbESHBnzptimv8mCHnrwx/BhzhHlXYQI0M0abtdKeOP
         WvZjhRP/T+NEihX6HuOtoeKWXk+yYBD2M9Vrv1cLaiJNtk/SEqeWOGr3hvqN0/9ODt9l
         Y9ehS3n3NSTReAZOrnjCtQ2aRWhpvmst2Umqo4j0SKuPSMQyNo+QlZc2fIwkI+B+kmwn
         RGx1QW0xXV9TlCBKF76mcpWjZoSycfU01u9tf6MiABzfS7zOq2kTU5UX40rsaSWifzVl
         cYWu5PsPKQoT6j830ncuwe9IguJ+y799G8KhB8cqap2I+Q6PhMU5puCJ6+fS3NpF7O6x
         uOlg==
X-Gm-Message-State: AOAM533F2vkVOsEtXcGm95kc1eyD/9djt/ZDAkTmYP/WVGiGdv6Ug3P6
        a4pm/eUQcCpeRND8QMm8DEx7rQ==
X-Google-Smtp-Source: ABdhPJy5+D2oCiE3ykyx5Czt8xcCI64YJaODeOVQrz0mW/Nu4udeXpuxcyGClFdtOCvXH6jCy9Bo8w==
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr18109616pjb.31.1638577813403;
        Fri, 03 Dec 2021 16:30:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i67sm4367649pfg.189.2021.12.03.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:30:12 -0800 (PST)
Date:   Fri, 3 Dec 2021 16:30:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/dp: Actually read Adjust Request Post Cursor2
 register
Message-ID: <202112031627.C312CCDD0@keescook>
References: <20211203092517.3592532-1-keescook@chromium.org>
 <Yao3uMmXM+IvrVrF@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yao3uMmXM+IvrVrF@orome.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:28:56PM +0100, Thierry Reding wrote:
> On Fri, Dec 03, 2021 at 01:25:17AM -0800, Kees Cook wrote:
> > The link_status array was not large enough to read the Adjust Request
> > Post Cursor2 register. Adjust the size to include it. Found with a
> > -Warray-bounds build:
> > 
> > drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
> > drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
> >    59 |         return link_status[r - DP_LANE0_1_STATUS];
> >       |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
> >   147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> >       |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: Fix missed array size change in intel_dp_check_mst_status()
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c |  8 ++++----
> >  include/drm/drm_dp_helper.h             | 10 +++++++++-
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> This sounds very familiar and I vaguely recall typing up a patch like
> that a long time ago. But I obviously failed because that never seems
> to have made it upstream.
> 
> Or perhaps I'm misremembering and was thinking about this instead:
> 
> 	https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/338590/

Oh! Yeah, that's the same thing. Looks like that never made its way
upstream. :(

> 
> Bonus points for adding that comment with background information on why
> we need this.

Thanks! Yeah, I needed to really convince myself everything added up and
made sense, and figured I should try to capture that research. ;)

> Reviewed-by: Thierry Reding <treding@nvidia.com>

Thanks!

-Kees

-- 
Kees Cook
