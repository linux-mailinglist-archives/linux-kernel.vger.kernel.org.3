Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D64D24A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 00:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCHXLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 18:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCHXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 18:11:47 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926BD75634
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:10:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id w7so686692lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tclsFaPE34TrWsSULlYvU9YsW3x7Tf6mvtJ/Ff+EAgw=;
        b=YTxtynEturtmQ9+fQ2vk4MLEzSozTMNeDRXaVWblqZvl5cNILUeHdpEsitwfPfNIzn
         uCtJuZ5NsjYf2Ok6NBtbFh9Ma45M5vV4eDFye5M5b2CqwFnkNoA8DFyU50SPmMselqV/
         q/tlUGMcxIMfJNgMyYAgT5U/xKc9hbMGY84CXSrjQz3QPryQGm3EntO5dzCPy4t1eLLM
         PJF3EWLGIRs9IQkx+NbaWBj8+A2ASwVgX7J8o5ZMMpRM0FvqYWU3ThHQDTV7BjFmtynz
         gVx61JpRkMOep1q+pQ1+vJQs7ocgJhkFT/XQnL7qiyo2bgs0+u1VgxYEfGddeAxQFlhp
         Cxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tclsFaPE34TrWsSULlYvU9YsW3x7Tf6mvtJ/Ff+EAgw=;
        b=RkAt3pTbbhpSkEAqkR+YOL32KiO4OD138t6Sj1jplrBUxnOMmHrmSK3qNmf8CSHfbq
         KfrABKRxiFdVJxrcvjorABcx3AfLyMSmKUjKV/VUKrHk7V9lG5EhSNkL53LvnqLqMF0G
         3QCveOPGi67buPm7o4bxQZ8WaaURwmHMKj9n/9DrEVcCV/uZm3L8YJhmD/GC/m+kzZ3a
         +6JbkAyQyu6mXKkUzlZLGUo7kmi5pfEAafMkQiK59gdFVwcpkWyE9yYcCoNDa2DZahnh
         wcqGgAaxBpc5xOBiB9hwTQJwPe7jasw0NgCsqY0KpIt8WMrZFZ1YYue3YZI1PMihMRnQ
         uDtA==
X-Gm-Message-State: AOAM531YLyvUWnPpKc60Mc09xSlHDJQYra4nTIw4dBjllrMw447/VsEy
        ZHqTjhGOBVm7JrL8tduLSq3yoEVFOEpQGENVGfV1Qw==
X-Google-Smtp-Source: ABdhPJx/fglOdwsFUXGzUPIPq1H3ZUZI8HoqBE3Dc7CpwH2vZZ4CHq8MWt1insKPhpHz2VgNI0Ys/4lxjE1mEucfOrE=
X-Received: by 2002:a05:6512:31d4:b0:445:e4ef:c0f8 with SMTP id
 j20-20020a05651231d400b00445e4efc0f8mr12498094lfe.626.1646781042694; Tue, 08
 Mar 2022 15:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20220307181704.149076-1-colin.i.king@gmail.com>
In-Reply-To: <20220307181704.149076-1-colin.i.king@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Mar 2022 15:10:31 -0800
Message-ID: <CAKwvOdkXNGRJkZDd7Cg8jhL9Ex7R+VPYqEEc+VpwDyi9NJKXQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: remove redundant assignment to pointer connector
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, knaerzche@gmail.com,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 10:17 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The pointer connector is being assigned a value that is never read,
> it is being re-assigned in the following statement. The assignment
> is redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/gpu/drm/rockchip/rockchip_rgb.c:153:2: warning: Value stored
> to 'connector' is never read [deadcode.DeadStores]

+ Author & reviewer of:
Fixes: 2e87bf389e13 ("drm/rockchip: add DRM_BRIDGE_ATTACH_NO_CONNECTOR
flag to drm_bridge_attach")

>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> index 2494b079489d..92a727931a49 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> @@ -150,7 +150,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
>         if (ret)
>                 goto err_free_encoder;
>
> -       connector = &rgb->connector;
>         connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
>         if (IS_ERR(connector)) {
>                 DRM_DEV_ERROR(drm_dev->dev,
> --
> 2.35.1
>
>


-- 
Thanks,
~Nick Desaulniers
