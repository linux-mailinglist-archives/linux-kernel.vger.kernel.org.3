Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B335D5B1E52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiIHNPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiIHNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:14:59 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D921B79F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:14:49 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1225219ee46so44288938fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PKx0v8N9YvEdbCnl3VJ9cuH9xcqQx+VnjaIOLPR9Czk=;
        b=ZS/7JbXh65BNH4t6OPVZOW0t4raGc4c7dXcoWt2lmQ6mrH6/aE31PuYG0HeXHOq+Ub
         9oMQP+1k0cZrL/tYzvk2occ2c38JKtrEaRktgSx8eK7puJKnmTWkzu9gxA9uKwjM1im3
         3MqqaMBOgxL3Y6fBoIPlbo4O2GQ1iiTxSaeybjEaxO2d0tpa0XhK1mtdieziqctGY7/C
         6ZXXhX47Y7tPFr1MujrwSnTDmfMTXjURsqzv8PWl+X1kzza1gISo70QeB7Utaq7ZtUU9
         5/ySsPZo6J5vTXXXnUrTugE6VNAoUXY1KuxRk6bPZ/Y3USReD+noLy1OyIiKXOAS49KW
         6YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PKx0v8N9YvEdbCnl3VJ9cuH9xcqQx+VnjaIOLPR9Czk=;
        b=JWr7lFghElzI/VZXWV+8zYC6mGDBuiUeaQ2Rs575uAcJwHpjoitKioLsLQHnOTU6tb
         +4XEtP+W2z2/fMFnN6v0PGeoGo1r2nToZkp2fJSH35Xac2LUqKtZs8Y0mz0q9f0hDeOs
         6xRAyGoGiBwIco/Doq17a46/g1UtlIZvmTllTzYsMzXVhEqxXix8pdrtYZSSvFfn8yiS
         j8O1pItrtbpX2a8+rWoipBkGB6scwpNZadov9l+3U8vrRkzy1tW1MPvUIy6d0k3WYQOq
         UizNRoxtXM3VLKlVQe2Jt+Qm5O1WbLUwG7n28sRJdC3AZl9GbVHVSEIdA7fVLyOuDoX9
         5dNg==
X-Gm-Message-State: ACgBeo1NZ/f20G5DMziB0xbdQxoesNYaVFchEtWWiUNzwbKhmKpowal3
        eyeLy1tkhqkb/CbOYhxqINQ7P8cpGU/gRQbsr7U=
X-Google-Smtp-Source: AA6agR63axWcWuoiPmLdv7JJo8NQ+7t/OC3Va7LB8HTyVVWAvafafRCGevZ5p9xF6ImC115Oou+1v2eU0FXaaNhWTVY=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr335621oae.46.1662642888600; Thu, 08 Sep
 2022 06:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220906195721.143022-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220906195721.143022-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Sep 2022 09:14:37 -0400
Message-ID: <CADnq5_O0W-ipCCy3hsub5GwirjDTM76Xn3kAxgyZT5V+vDguSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use dirty framebuffer helper
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org, Guchun Chen <guchun.chen@amd.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Fernando Ramos <greenfoo@u92.eu>
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

On Tue, Sep 6, 2022 at 3:58 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Currently, we aren't handling DRM_IOCTL_MODE_DIRTYFB. So, use
> drm_atomic_helper_dirtyfb() as the dirty callback in the amdgpu_fb_funcs
> struct.
>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index c20922a5af9f..5b09c8f4fe95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -38,6 +38,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_damage_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_fb_helper.h>
> @@ -496,6 +497,7 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
>  static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>         .destroy = drm_gem_fb_destroy,
>         .create_handle = drm_gem_fb_create_handle,
> +       .dirty = drm_atomic_helper_dirtyfb,
>  };
>
>  uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
> --
> 2.37.2
>
