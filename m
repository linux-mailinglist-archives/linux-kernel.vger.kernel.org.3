Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28B465233
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbhLAQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351266AbhLAQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:00:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37902C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:57:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so1962758pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMjb22+5HnYiWezXGd8BpfVqKH0j2HDeYCBfIiIkNVo=;
        b=g0HO6kFkgvnmY+B3hcQqit8BWq8G7VNpEMqDmNa4m2h5ZTq4k3zbAfbyMIb8tNOqfF
         yKRc66qz5WN5vu1fKZLMrCM/6zzq/0CRGHBxmgnDztpzKwMB2stVS8gKw6ZA1ea+/U0c
         am5jLOAk+rgOqRqwVCKNN537M7oISzTotwKE2TiRWlR8wuNQaapsS+tMDe8nxYexKXYg
         kYQh+3G+bmg5sBa/bMrkELsHYUBYEvfWHggjqOPHDuA0VZgq0lMUDQtnDy3VBD7yJNP/
         5XHlk6hrPeim0G8j68rkAwKeTJBHnq/VQ2IY17cDHjAQ7cZ22IwOmpNyfttAvSGOTaVM
         e75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMjb22+5HnYiWezXGd8BpfVqKH0j2HDeYCBfIiIkNVo=;
        b=X8u/rgLwAOMk7+PXMbnLYATweDlw2Fu0+c86tD3bENlmxjwrKuVxYuJQdb3p5g+JFk
         bC9H7bx9IBBy29KDAaOzm48RULK/KbImpIPCiC+JWT+6qAoSQd6bXUCbyoXCT+c8fqvT
         P0kFN55xz5VZxBMZD2X/tGTO2YSouuxiVVyWZ+saXQmbHx6qBtNyX2gCvVVBsaESR0AY
         +SHK1iStYzXv8fdk6ISjygddntjmqocefNGWkRK4TyAjsHbjdtaiGlrHweVupbwX4IPZ
         coKqfkCuiBm+uhmZ1EMfWGkuUSh8ZrNRu8b/8vWvXivFGQIXcUrY1YPs7ZnuuNxV48Bu
         8yxg==
X-Gm-Message-State: AOAM530JYa/FC5WPSoYnE2E7nkv102s7g6281B1KWGbk9uRnMO65JpEZ
        dme65mHgE3nsA4Ak/B642Uw2mnh6GTbKSRFGUiw=
X-Google-Smtp-Source: ABdhPJxieeuL5+UhxVUkW3jolN2MUEXlreNEd7Kp4GrdkbFgQEVufS8lZ6H+pIBkHjXWdpFD+6FVSbAnMJWinHt2wd8=
X-Received: by 2002:a17:90a:6487:: with SMTP id h7mr8554432pjj.40.1638374255666;
 Wed, 01 Dec 2021 07:57:35 -0800 (PST)
MIME-Version: 1.0
References: <YaZP2HzTQw1QJxOK@intel.com> <20211201152904.182293-1-zhou1615@umn.edu>
In-Reply-To: <20211201152904.182293-1-zhou1615@umn.edu>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 1 Dec 2021 16:57:24 +0100
Message-ID: <CAMeQTsY0RHJsJzNW-77gK_=WCetvhrUVbF4KA+Qu3uaV1CCR_w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/gma500/cdv: Fix a wild pointer dereference in cdv_intel_dp_get_modes()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 4:29 PM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In cdv_intel_dp_get_modes(), the third return value of
> drm_mode_duplicate() is assigned to mode and used in
> drm_mode_probed_add(). drm_mode_probed_add() passes mode->head to
> list_add_tail(). list_add_tail() will further call __list_add() and
> there is a dereference of mode->head in __list_add(), which could lead
> to a wild pointer dereference on failure of drm_mode_duplicate().
>
> Fix this bug by adding a check of mode.
>
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>

Is it really necessary to explain what the static analyzer does and
that it can be faulty in every single patch?
"This bug was found by a static analyzer" is enough for me.

> Builds with CONFIG_DRM_GMA500=m show no new warnings,
> and our static analyzer no longer warns about this code.

I assume all patches to be at least compile tested before submitted,
so if you didn't actually run this code on hardware it's better to
replace the above with:
"Only compile tested".

-Patrik

>
> Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> Changes in V2:
>   -  Instead of returning -ENOMEM, this patch returns 0
>   -  Use DRM_DEBUG_KMS to report the failure of drm_mode_duplicate()
>
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index ba6ad1466374..bf47db488b7b 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -1773,6 +1773,11 @@ static int cdv_intel_dp_get_modes(struct drm_connector *connector)
>                 if (intel_dp->panel_fixed_mode != NULL) {
>                         struct drm_display_mode *mode;
>                         mode = drm_mode_duplicate(dev, intel_dp->panel_fixed_mode);
> +                       if (!mode) {
> +                               DRM_DEBUG_KMS("Failure in drm_mode_duplicate()\n");
> +                               return 0;
> +                       }
> +
>                         drm_mode_probed_add(connector, mode);
>                         return 1;
>                 }
> --
> 2.25.1
>
