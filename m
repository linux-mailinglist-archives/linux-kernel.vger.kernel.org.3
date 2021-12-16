Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C972D4775B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhLPPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhLPPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:20:32 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:20:31 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so29339636otl.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BzROn8ygEIvbgv1YLRyZ5KtKZ741t/BVqbnCoQQpFcI=;
        b=hzrKz0GP7Af08AiTFt6vyTs82/qpYYXkPNcJsIJI5Cs2ooHjlq7z6GFiVWoHUaO4dJ
         809J0cpvrRGNBvLpNhWZ36mIEFtCIlvWUfrCVLpIscPlMfU8PgOKpdn+8xZeKDf5Ult8
         tc/Rx4OBK5bzyo2lQgb39j8rzXManNzeXqRVDcCK7E/rgSoeUuokEI5A0N90opouRAki
         sIbe8GLcaCPGvPQKu+Ju+5tMlrvi0m40UjjuujoS9oyyoF13WAotLpZpHzGjBPb9cvVP
         HaSCBrFMYqy2oxNSfAQQTP4pQUivjXroQeua1IQkWmrZIAW450HcZY+23dZc5YVMiL99
         VruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzROn8ygEIvbgv1YLRyZ5KtKZ741t/BVqbnCoQQpFcI=;
        b=CKZDGFjJyPZ64ucVliI5Pj5xTZWykStiqyTXVS2tFE6oDdJv6xpOJD8aENz4uDvhzb
         zUCJuX3FdwiOK0vWWhpE5VLuCzI6wN0LdfgRTwfz7fLinNr0z/1jWBEMlLfYYNmnVGvC
         9eIvmONIwWTbAo0uUbyGfKr5rAk7eqZcrNMGcZPVy0dRlTsp7Mh7PEiBG+hq7V9Wyj1J
         e5xf+WsHh3HgDOj5p7UBt+S1AU4oEqbdVst6noEwFqfqOyxA9x5jXatRbilRxum+GHbz
         bRK/liLImFMJ0spePOFfqgqSNR3WS3fBUsPtt6C6RX7cuedofM9PDLdjZUG8p+YCspfQ
         NwdA==
X-Gm-Message-State: AOAM530mU1Nz5SysdXfV3BrO5Kgv9F3qb4eePJRJfL4B1bzZ/hQBf3gP
        Q4as5g4tmvNhwQrVSHVLDrSzZ5hxvooD8lyqsEo=
X-Google-Smtp-Source: ABdhPJwic3C3ahfgH+CaAHrVLrjrsIqftmDBpwPvpOxhFIPcFLq3nEH9vzxZr7cRlDsGItxYtVYwg2vDH6jx+kmYxL4=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr13159059oto.357.1639668031273;
 Thu, 16 Dec 2021 07:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20211216075017.73996-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20211216075017.73996-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Dec 2021 10:20:20 -0500
Message-ID: <CADnq5_N4rVUenOBs_oh1_AkyNYcKOKHp_gduiMYq-hGrkyrStw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Dec 16, 2021 at 2:50 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c:744:35-36:
> WARNING comparing pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> index 8f78e62b28b7..48005def1164 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
> @@ -741,7 +741,7 @@ void vg_clk_mgr_construct(
>                                 sizeof(struct watermarks),
>                                 &clk_mgr->smu_wm_set.mc_address.quad_part);
>
> -       if (clk_mgr->smu_wm_set.wm_set == 0) {
> +       if (!clk_mgr->smu_wm_set.wm_set) {
>                 clk_mgr->smu_wm_set.wm_set = &dummy_wms;
>                 clk_mgr->smu_wm_set.mc_address.quad_part = 0;
>         }
> --
> 2.20.1.7.g153144c
>
