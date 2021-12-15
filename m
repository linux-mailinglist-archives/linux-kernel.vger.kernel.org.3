Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92D4476598
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhLOWYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhLOWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:24:30 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46243C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:24:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n8so17769325plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ycDsmx3PyCZ6frecumpmSuFIqgxs7vNgPaQ/w3kiJEc=;
        b=DR7M8QbZ1tBnbdUmI6yi7VcT3mNXhvl8LO66qDfb0Jt1VZvST/nR9enfI7qM6YkPCX
         P3dWIwzZSQDuMU45iFz4vsXeSnxV6xjhP2MFIt9SQicS5/xLLAcA4JU2j2YqeUltjs5/
         HNEy0BuooiU7ZULR4tJ3QXZ6tRwyInfC3DA+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ycDsmx3PyCZ6frecumpmSuFIqgxs7vNgPaQ/w3kiJEc=;
        b=x9SKNFyRa4QUlWSh1uYzoo6oxOrgKj4zzEYAT0Y/iNFZ1/cm3NFGUGg/G+jV153DW0
         O228euS9Zkb8tTROFD/wVoa45pepZB/obszqCTkuGPi7CQ0NQ4WqwjqlaH4TMk7N5p2X
         b4VRlCOnNaMZMN3uYxdgNemgad+49Cqh76JrYdBKBAEUYMKVMERevBSdCDo94Zcum5Rm
         QJNHTt9mx4hJLf5YXRRWbbGIBhRBSHmmm2Kk/9ALjAWue3LMcA3r01g19cZah8pS10UO
         gqoFfylo8WvVoNUtpJcBC6C00vtExKKIbHdnPGJ5+CD2TwKZ3nnLPk35nOGbLueby8qu
         ZKSA==
X-Gm-Message-State: AOAM530WsAyyihx1pHRgHofdbvWB5chVe5P9B4CPOx5WnUP/So+AHhiM
        /Wfsj0df3ZzVB7D24TzXbtbeuQ==
X-Google-Smtp-Source: ABdhPJyPaKZPEyh99xkYURqN/PIzlVuqSRGBt2Np9ALE4Ou+FS1gPA5SR9cPXBOtOgKmZVaNLESR0w==
X-Received: by 2002:a17:903:41ca:b0:142:1dff:1cb7 with SMTP id u10-20020a17090341ca00b001421dff1cb7mr12924238ple.37.1639607069738;
        Wed, 15 Dec 2021 14:24:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o4sm6289739pjq.23.2021.12.15.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:24:29 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:24:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/dp: Fix off-by-one in register cache size
Message-ID: <202112151424.A44D2B7A@keescook>
References: <20211203084333.3105038-1-keescook@chromium.org>
 <20211214001849.GA62559@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214001849.GA62559@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 06:18:49PM -0600, Gustavo A. R. Silva wrote:
> On Fri, Dec 03, 2021 at 12:43:33AM -0800, Kees Cook wrote:
> > The pcon_dsc_dpcd array holds 13 registers (0x92 through 0x9E). Fix the
> > math to calculate the max size. Found from a -Warray-bounds build:
> > 
> > drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_pcon_dsc_bpp_incr':
> > drivers/gpu/drm/drm_dp_helper.c:3130:28: error: array subscript 12 is outside array bounds of 'const u8[12]' {aka 'const unsigned char[12]'} [-Werror=array-bounds]
> >  3130 |         buf = pcon_dsc_dpcd[DP_PCON_DSC_BPP_INCR - DP_PCON_DSC_ENCODER];
> >       |               ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/drm_dp_helper.c:3126:39: note: while referencing 'pcon_dsc_dpcd'
> >  3126 | int drm_dp_pcon_dsc_bpp_incr(const u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE])
> >       |                              ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fixes: e2e16da398d9 ("drm/dp_helper: Add support for Configuring DSC for HDMI2.1 Pcon")
> 
> This should be tagged for -stable:
> 
> Cc: stable@vger.kernel.org

Ah yes, thank you! :)

-- 
Kees Cook
