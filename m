Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0049996C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455282AbiAXVfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442666AbiAXUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:55:04 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F661C095421
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:59:34 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso7475632otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+lZqp5VkPjN0faGgSSPKZ3zUhREnNDGIkuhzUCrVAU=;
        b=CSAtIjx4L+ZkJciYlaWlmCBX6UHmUCvw1LCMR3LfRIGvEjh3fERyo+hkCxZVzZVBsC
         CgSeSRBEHJ02dBKUqKVxK6XFAAcuOQ4HPqrhCT0oM/R6lZoVCbPvRX8v0CD5P6hmoT/+
         L58y+kpGl8c7DIBbCzp6UolIERAa6i9T8H7vLoRLfxa3bX0GRY3NSj//B756aVhSNbhp
         G3j4knVTvzCoKjLC++e7sAY/UarFC0XGY1l2esyRVCnHuD+dnsdNaC3fDALkIi4oZvL7
         N/XrfocLShB4Ad0AqhzV2I9DzafUi1yimxXNA6kNHy4Wki4vd57iuwzOA1Hc/MXKK3Uo
         3RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+lZqp5VkPjN0faGgSSPKZ3zUhREnNDGIkuhzUCrVAU=;
        b=7y2HVvaPFUDu9/3M81lSU/ygLJ2tiyiTIpfsonte5kAm+Ikv81zQHWujTSY/fNGlHG
         Ps+w5b9VMgYG5U65a9EJTt9a/0blJPVBEsjbLsQzBoGVuPND3w9djPjloZuxsakim0Vd
         d2Yg3kEDZLVbwMinUkU8BsMcBM47ntv9wpfFXiq84IQXn5NBg924F9+BTV4edGwamLDv
         MSK4vqdy7TibT6p1cfiD+4ZQznsNstEt36KcKF10WpDzGyvDq/KqGCd12wymxoGh3K9T
         tf71ee04nIqU/A9cnrQSdvUobX5e/95oG0Fi71IXZNK/nM43NN++HgfX410wX7kTXudx
         7XLw==
X-Gm-Message-State: AOAM531nHsoMtBSTnl4o3z9VhnhCKa/AgMQ7kisUbbTI1XrH2oYMGh2+
        uGuwbrjpH2Q0x8kFYWwyTbGqC18zGZenC7VyY2c=
X-Google-Smtp-Source: ABdhPJyInPhzcrJLNRrdGV5Euq2uJFvwa+CtjDpOWM0SbP+p9pyHaSW7USbPxxFYzNmwKNu6aqwl8ruO9MIIWHs9TGI=
X-Received: by 2002:a05:6830:1d90:: with SMTP id y16mr12820867oti.200.1643054373917;
 Mon, 24 Jan 2022 11:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20220124165732.56587-1-zhou1615@umn.edu>
In-Reply-To: <20220124165732.56587-1-zhou1615@umn.edu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jan 2022 14:59:22 -0500
Message-ID: <CADnq5_P9cnxi27FM6cU1sf1FjkV2sZdHjJciuuDd9ZZ92qyxeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix a NULL pointer dereference in amdgpu_dm_connector_add_common_modes()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     Wayne Lin <Wayne.Lin@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Kangjie Lu <kjlu@umn.edu>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Jude Shih <shenshih@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 24, 2022 at 12:05 PM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In amdgpu_dm_connector_add_common_modes(), amdgpu_dm_create_common_mode()
> is assigned to mode and is passed to drm_mode_probed_add() directly after
> that. drm_mode_probed_add() passes &mode->head to list_add_tail(), and
> there is a dereference of it in list_add_tail() without recoveries, which
> could lead to NULL pointer dereference on failure of
> amdgpu_dm_create_common_mode().
>
> Fix this by adding a NULL check of mode.
>
> This bug was found by a static analyzer.
>
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7f9773f8dab6..9ad94186b146 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8143,6 +8143,9 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
>                 mode = amdgpu_dm_create_common_mode(encoder,
>                                 common_modes[i].name, common_modes[i].w,
>                                 common_modes[i].h);
> +               if (!mode)
> +                       continue;
> +
>                 drm_mode_probed_add(connector, mode);
>                 amdgpu_dm_connector->num_modes++;
>         }
> --
> 2.25.1
>
