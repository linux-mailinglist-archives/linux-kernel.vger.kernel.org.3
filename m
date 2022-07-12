Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64066571F30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiGLP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiGLP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:29:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B59C279
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:29:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x91so10588488ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k82muZrzjaGKL2uu6yggy5IYvpm5UzK+FZ+jRdRGdM8=;
        b=hkePFGV/YsKsbsERnfo1xi4ljiNSPMiSH1x0wvuJij7XQLk0spuiAyQhA+y0wO/vsj
         QLrk4yFVoIlo6h+GbX0ryi1e5oRixZSefL0MVtCkXc0H5UPQNYxIETD4LG+bh5wI8kFY
         rKsaYd/RqmIWFRMha1hrky4815sfu5UO/0y/gZH+2SccqsEEVVDMFLCdl0BsnNsoqld7
         XwpK04pY4Pv8Q3Ruoau6i37C1V51BFmn8860rx9leuFlqustsKQAca5/rPw8jp0w6tWi
         mdgrM4HX/azTWNixKUGWZV2Ii5tDs9JYaxUAWDPcYdjsuE3KXbrKxU6p5ODQeie5jSu+
         PVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k82muZrzjaGKL2uu6yggy5IYvpm5UzK+FZ+jRdRGdM8=;
        b=59tFjkxZjq1q9svEU19hVjIl9azFNl0bqmoLyZ0GgYRmKmeMRyXch/eo+ZRXhC6YZO
         afoVL6sq6pKlnP11o6yM7pfNvwG4fa9PPatUcB/ZoM1VlF+8zqkxqK0514Dk9QvqgJef
         FenyqKZ5i1UQzYYULhkZ2rr+tB5eIzR9kLDHMf44mbH+2NCgK1jUc02xnQoiVBbg72ST
         rm1ovQabMQuNqNyCdkN62pPQ3EFHzWQdGZiJxYKypURi5Lw3pU46Mx6CKK/sMJvC9M6+
         2KVYDc9MZ3UlTKfPus0PCAJ10JIl06f//XMYQIrhV8n6zc6yYfJS5WBf+Y4c11wVaVt5
         WsaA==
X-Gm-Message-State: AJIora9+E1iLU9aEvtMV6t3eJ9aLZdDpFLstp4+XIQHVBkS2n93ofAZ3
        joi21JrMCaEGizBO59YplyCMPFeyfn/hVophPG4=
X-Google-Smtp-Source: AGRyM1tBpI1AolR01rX2cadrBw7SXyoM7JFhOEkfmysmJ47u0+tmXW0I7Cq4OEd2cX/s4+TOzcbehM+auRBDK438igE=
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id
 ef3-20020a05640228c300b0043a6d781b64mr32023086edb.93.1657639783312; Tue, 12
 Jul 2022 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220712113239.132905-1-mwen@igalia.com> <062bf9e7-8903-5635-b681-ff42ea518031@amd.com>
In-Reply-To: <062bf9e7-8903-5635-b681-ff42ea518031@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jul 2022 11:29:31 -0400
Message-ID: <CADnq5_PDpg4XC4kWXo1D05brWjCPWgrjWvWGHWZQzrNZWavybw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: correct check of coverage blend mode
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Melissa Wen <mwen@igalia.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-dev@igalia.com,
        Dan Carpenter <dan.carpenter@oracle.com>, Sungjoon.Kim@amd.com
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

Applied.  Thanks!

Alex

On Tue, Jul 12, 2022 at 9:56 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-07-12 07:32, Melissa Wen wrote:
> > Check the value of per_pixel_alpha to decide whether the Coverage pixel
> > blend mode is applicable or not.
> >
> > Fixes: 76818cdd11a2 ("drm/amd/display: add Coverage blend mode for overlay plane")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Melissa Wen <mwen@igalia.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index de1c139ae279..25cb833b267c 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5486,7 +5486,7 @@ fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> >                       }
> >               }
> >
> > -             if (per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
> > +             if (*per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
> >                       *pre_multiplied_alpha = false;
> >       }
> >
>
