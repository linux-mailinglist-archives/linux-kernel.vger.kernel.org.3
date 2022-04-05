Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75E4F5134
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845423AbiDFByi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiDEPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:01:15 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4981F27B02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:23:49 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-df0940c4eeso14342191fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ScfzVYhoR0LHfyaru7LJ12VrLihpLGnKs+dyoaqZBU=;
        b=bwM7MQ2CaERMuk5JUO51JviRs0GLe4rNKdBujPdlUJBzMHbt83Xm1/BfCx2S/bGpkt
         YAi4FwH9eRFr2dxMt51ZgG7+C31WBhBvTjqU00QRQBbH1NDRlVYSh6TmLsSrrJCiDjkp
         Mw34VPzQNst68DPRw25PP5suiV8z1xnnYlAQA0ZwO7U1/TEZ5jGaoUeG4pC5keRlIxYo
         +/n31B07cpDqvUTsSLHD23wv93GjPx0EqFEwA04V5LEVy7aFc+l7KRDV7XkQtwUs77wD
         yEvxY1cgO1wvyAD4uNRkIBQIDpML2g8ayWb9E1WxSFQJ1NF2wtJYumNNgb5/GIwu8kLy
         SuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ScfzVYhoR0LHfyaru7LJ12VrLihpLGnKs+dyoaqZBU=;
        b=HTWyo1o61FT6vM/KInIYLYDDozHcuXSGc5EUmIwi3Z5SIvcLdv6lL520tiaoZD3jVX
         HeP/QFE3ejQ1lHZkVwfYBm+gEVUfx3IJzH8mJzHXaLw/PO7XZwAqbHzN/NH3swzxpdUd
         Bxo8gIrEaFjourWcDfOS1XaspfLYjf9wNVdCJIggsiS3h/JvqbSnJxw/Q58bnxe2y53O
         LayzslmoDrMQ2aHcieBqWLRk6dYm0yafSHTFXhDQ0O2b2oVCRkAzM97C+404opzysmrp
         zCUuH6XvpoX20GE0jyPeMpq81xneYh46pVF+q3e1VGxhMFmv7zb+7w2Q8BH3rQDZwSWU
         JZMA==
X-Gm-Message-State: AOAM530bmBg8YPSqArt4Youopf4F2fsnGsIS154kFOEtO5Xy8fqJyY2M
        BZRhfrj4y5bCDpeIlUPkb6eNOnDbARdDfspbaUM=
X-Google-Smtp-Source: ABdhPJxsuNcRKCVnvwc6SiCT2E01/8qtrsJ9bRYQ6b3xCmhFmyTyi6bLE+dqO1fRo6Uwjo4tbwo9zjJTJQl8jycO/hg=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1416658oaa.200.1649165029203; Tue, 05
 Apr 2022 06:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220401025930.16365-1-guozhengkui@vivo.com>
In-Reply-To: <20220401025930.16365-1-guozhengkui@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Apr 2022 09:23:38 -0400
Message-ID: <CADnq5_O5K60qP5Khgz7Ja+5yiHHt=juBNBj5o=+AK5CJwyjRRA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: simplify if-if to if-else
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
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

On Thu, Mar 31, 2022 at 11:00 PM Guo Zhengkui <guozhengkui@vivo.com> wrote:
>
> Replace `if (!ret)` with `else` for simplification.
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/gpu/drm/radeon/radeon_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
> index c67b6ddb29a4..e765abcb3b01 100644
> --- a/drivers/gpu/drm/radeon/radeon_pm.c
> +++ b/drivers/gpu/drm/radeon/radeon_pm.c
> @@ -1629,7 +1629,7 @@ int radeon_pm_late_init(struct radeon_device *rdev)
>                         ret = device_create_file(rdev->dev, &dev_attr_power_method);
>                         if (ret)
>                                 DRM_ERROR("failed to create device file for power method\n");
> -                       if (!ret)
> +                       else
>                                 rdev->pm.sysfs_initialized = true;
>                 }
>         }
> --
> 2.20.1
>
