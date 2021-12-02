Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7946613C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356795AbhLBKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbhLBKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:14:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B01C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:11:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b11so19857403pld.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0DvcWJ6BwS4XZAHB+T7IVAgQuaYuZYZpCtQocd1jt8=;
        b=OUNYwyFYjPAZMeMoxdblOxV2NxXq1sfGa2cNnE+bikkMPwgQ0QwelII6Iq9iMeSMZn
         4FxAEAYzK379X96A17FBZXHASpSTr2xSRHwz4fcwhQxi18yx6wGl+PVJGsUSD24ODWc+
         zzGw2AGpJLTiBtltNY0CQy1rBdrgeKG0nw9UAcjiKcQmMkqU6onpvclXWYgbpdpvmQUi
         m23pCEDaxNC+0v1yUyinztlHVgTDABAvKYU8ymg23R0srhSQDeB2YUMIh8ZWEWRo2Eex
         VsOjHIMoOAuGD7CZAARYo/F2zrxJb7FdCFdqoNz7XZRrpBnuAwW3MB8MTbLqSZBOmOQC
         ZAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0DvcWJ6BwS4XZAHB+T7IVAgQuaYuZYZpCtQocd1jt8=;
        b=C9XfRDgjZLm6QhOHiTV0mumdQLZcrOTvzUSLc5/sLA9mUzCHBUbOIWIo6vxOYVassN
         kjOcV2ZtlZTS1e8PKAcux3V5SkhS4XvH5FfYzHKFPKlZ9+W55l+9ypKMmKnFeVHN3vJm
         75SvmPkxsouVfuxXUi0Fm/zgCBRYYeZ45/zSLMNRtruqmknnQQ1evgq+pexP5JLGtUEX
         D9gOK+ANAMmhV1nT5HgOCcxF+rrJCceK/tLY0xQQtTLavCKuHzXu3c2bVaJIusN3G5T2
         Rdk0aRhsNgCfq1WwmrFyfRlXrLiPoZYOZruOLeEj9aIV3dRUSH4WDMHKhW0aMQhvYw4Q
         ZNGg==
X-Gm-Message-State: AOAM5337UZUcoAvwvqDiciZEJ/L7q/AGns/crKwtKB4dJHZ4Qy+Ah4iA
        vItzhqcxBa9y/CU+fm7JpluuCnfYdJL5FuBHEuo=
X-Google-Smtp-Source: ABdhPJyvDJ1NkE4fzQhTVbaMeaTJJ71H/QPrGgNzZ8y16kOvPjgAH+0OCEeAM2I31hS6Lvqf/0RCfOK0WAuB6QLG8Fg=
X-Received: by 2002:a17:90a:6487:: with SMTP id h7mr4915163pjj.40.1638439873589;
 Thu, 02 Dec 2021 02:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20211130132629.130713-1-zhou1615@umn.edu>
In-Reply-To: <20211130132629.130713-1-zhou1615@umn.edu>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 2 Dec 2021 11:11:02 +0100
Message-ID: <CAMeQTsazxeXgOJcuGZhEH5BX5ZzmOgM-NAjLjj9iypNgTqu-dg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500/cdv_intel_lvds: Fix a wild pointer dereference
 in cdv_intel_lvds_get_modes()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 2:26 PM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode and used in drm_mode_probed_add().
> drm_mode_probed_add() passes mode->head to list_add_tail().
> list_add_tail() will further call __list_add() and there is a
> dereference of mode->head in __list_add(), which could lead to a wild
> pointer dereference on failure of drm_mode_duplicate().
>
> Fix this bug by adding a checking of mode
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
> Builds with CONFIG_DRM_GMA500=m show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: 6a227d5fd6c4 ("gma500: Add support for Cedarview")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> index 9e1cdb11023c..56aec41ebb1a 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
> @@ -310,6 +310,9 @@ static int cdv_intel_lvds_get_modes(struct drm_connector *connector)
>         if (mode_dev->panel_fixed_mode != NULL) {
>                 struct drm_display_mode *mode =
>                     drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
> +               if (!mode)
> +                       return -ENOMEM;
> +

Same problem here as in the other patches.

>                 drm_mode_probed_add(connector, mode);
>                 return 1;
>         }
> --
> 2.25.1
>
